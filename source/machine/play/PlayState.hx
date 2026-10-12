package machine.play;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import machine.OpCode;
import machine.VM;

class PlayState extends FlxState {
	private var vm:VM;
	private var tvScreen:FlxSprite;
	private var screenText:FlxText;

	override public function create():Void {
		super.create();

		var screenWidth:Int = 800;
		var screenHeight:Int = 500;
		var screenX:Float = (FlxG.width - screenWidth) / 2;
		var screenY:Float = (FlxG.height - screenHeight) / 2;

		var border:FlxSprite = new FlxSprite(screenX - 20, screenY - 20);
		border.makeGraphic(screenWidth + 40, screenHeight + 40, FlxColor.fromRGB(40, 40, 45));
		add(border);

		tvScreen = new FlxSprite(screenX, screenY);
		tvScreen.makeGraphic(screenWidth, screenHeight, FlxColor.fromRGB(10, 25, 15));
		add(tvScreen);

		screenText = new FlxText(screenX + 20, screenY + 20, screenWidth - 40, "");
		screenText.setFormat(null, 18, FlxColor.fromRGB(50, 255, 100), "left");
		add(screenText);

		vm = new VM();

		var program:Array<OpCode> = [
			OP_PUSH(10),
			OP_PUSH(20),
			OP_ADD,
			OP_PUSH(5),
			OP_MUL,
			OP_HALT
		];

		screenText.text = "RuneVM v1.0.0\nInitializing stack simulation...\n\nExecuting Bytecode:\n";

		for (i in 0...program.length) {
			screenText.text += '  [IP: $i] ' + Std.string(program[i]) + "\n";
		}

		vm.run(program);

		screenText.text += "\nExecution halted successfully.\nStack Result: Ready.";
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
