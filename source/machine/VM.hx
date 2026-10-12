package machine;

class VM {
	private var stack:Array<Int> = [];
	private var ip:Int = 0;

	public function new() {}

	public function run(bytecode:Array<OpCode>):Void {
		ip = 0;
		var running = true;

		while (running && ip < bytecode.length) {
			var instruction = bytecode[ip++];
			switch (instruction) {
				case OP_PUSH(val):
					stack.push(val);

				case OP_ADD:
					var b = stack.pop();
					var a = stack.pop();
					stack.push(a + b);

				case OP_SUB:
					var b = stack.pop();
					var a = stack.pop();
					stack.push(a - b);

				case OP_MUL:
					var b = stack.pop();
					var a = stack.pop();
					stack.push(a * b);

				case OP_DIV:
					var b = stack.pop();
					var a = stack.pop();
					stack.push(Std.int(a / b));

				case OP_PRINT:
					stack.pop();

				case OP_HALT:
					running = false;
			}
		}
	}
}
