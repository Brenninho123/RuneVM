package machine.play;

import flixel.FlxState;
import machine.VM;
import machine.OpCode;

class PlayState extends FlxState {
    private var vm:VM;

    override public function create():Void {
        super.create();

        vm = new VM();

        var program:Array<OpCode> = [
            OP_PUSH(10),
            OP_PUSH(20),
            OP_ADD,
            OP_HALT
        ];

        vm.run(program);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }
}
