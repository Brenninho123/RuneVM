package machine;

enum OpCode {
	OP_PUSH(value:Int);
	OP_POP;
	OP_ADD;
	OP_SUB;
	OP_MUL;
	OP_DIV;
	OP_MOD;
	OP_STORE(addr:Int);
	OP_LOAD(addr:Int);
	OP_MOV(reg:String, val:Int);
	OP_JMP(target:Int);
	OP_JZ(target:Int);
	OP_JNZ(target:Int);
	OP_HALT;
}
