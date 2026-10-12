package machine;

import machine.OpCode;

enum VMState {
	READY;
	RUNNING;
	HALTED;
	ERROR(msg:String);
}

class VM {
	public var stack:Array<Int>;
	public var memory:Map<Int, Int>;
	public var registers:Map<String, Int>;
	public var ip:Int;
	public var state:VMState;
	public var cycles:Int;

	public function new() {
		reset();
	}

	public function reset():Void {
		stack = [];
		memory = new Map<Int, Int>();
		registers = [
			"R0" => 0,
			"R1" => 0,
			"R2" => 0,
			"R3" => 0
		];
		ip = 0;
		state = READY;
		cycles = 0;
	}

	public inline function push(value:Int):Void {
		stack.push(value);
	}

	public inline function pop():Null<Int> {
		return stack.pop();
	}

	public function step(program:Array<OpCode>):Void {
		if (state == HALTED || state.match(ERROR(_))) {
			return;
		}

		if (ip < 0 || ip >= program.length) {
			state = HALTED;
			return;
		}

		state = RUNNING;
		cycles++;

		var instruction:OpCode = program[ip];
		ip++;

		switch (instruction) {
			case OP_PUSH(value):
				push(value);

			case OP_POP:
				if (pop() == null) {
					state = ERROR("Stack underflow on POP instruction");
				}

			case OP_ADD:
				var b:Null<Int> = pop();
				var a:Null<Int> = pop();
				if (a == null || b == null) {
					state = ERROR("Stack underflow on ADD instruction");
				} else {
					push(a + b);
				}

			case OP_SUB:
				var b:Null<Int> = pop();
				var a:Null<Int> = pop();
				if (a == null || b == null) {
					state = ERROR("Stack underflow on SUB instruction");
				} else {
					push(a - b);
				}

			case OP_MUL:
				var b:Null<Int> = pop();
				var a:Null<Int> = pop();
				if (a == null || b == null) {
					state = ERROR("Stack underflow on MUL instruction");
				} else {
					push(a * b);
				}

			case OP_DIV:
				var b:Null<Int> = pop();
				var a:Null<Int> = pop();
				if (a == null || b == null) {
					state = ERROR("Stack underflow on DIV instruction");
				} else if (b == 0) {
					state = ERROR("Division by zero error");
				} else {
					push(Std.int(a / b));
				}

			case OP_MOD:
				var b:Null<Int> = pop();
				var a:Null<Int> = pop();
				if (a == null || b == null) {
					state = ERROR("Stack underflow on MOD instruction");
				} else if (b == 0) {
					state = ERROR("Modulo by zero error");
				} else {
					push(a % b);
				}

			case OP_STORE(addr):
				var val:Null<Int> = pop();
				if (val == null) {
					state = ERROR("Stack underflow on STORE instruction");
				} else {
					memory.set(addr, val);
				}

			case OP_LOAD(addr):
				var val:Int = memory.exists(addr) ? memory.get(addr) : 0;
				push(val);

			case OP_MOV(reg, val):
				if (registers.exists(reg)) {
					registers.set(reg, val);
				} else {
					state = ERROR('Invalid register name: $reg');
				}

			case OP_JMP(target):
				if (target >= 0 && target < program.length) {
					ip = target;
				} else {
					state = ERROR('Jump target out of bounds: $target');
				}

			case OP_JZ(target):
				var cond:Null<Int> = pop();
				if (cond == null) {
					state = ERROR("Stack underflow on JZ instruction");
				} else if (cond == 0) {
					if (target >= 0 && target < program.length) {
						ip = target;
					} else {
						state = ERROR('Jump target out of bounds: $target');
					}
				}

			case OP_JNZ(target):
				var cond:Null<Int> = pop();
				if (cond == null) {
					state = ERROR("Stack underflow on JNZ instruction");
				} else if (cond != 0) {
					if (target >= 0 && target < program.length) {
						ip = target;
					} else {
						state = ERROR('Jump target out of bounds: $target');
					}
				}

			case OP_HALT:
				state = HALTED;
		}
	}

	public function run(program:Array<OpCode>, maxCycles:Int = 10000):Void {
		reset();
		while (state != HALTED && !state.match(ERROR(_)) && cycles < maxCycles) {
			step(program);
		}

		if (cycles >= maxCycles && state == RUNNING) {
			state = ERROR("Execution cycle limit exceeded (infinite loop protection)");
		}
	}
}
