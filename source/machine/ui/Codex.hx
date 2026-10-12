package machine.ui;

import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Codex extends FlxGroup {
	public var visible(default, set):Bool = true;

	private var backgroundText:FlxText;
	private var titleText:FlxText;

	public function new(x:Float = 0, y:Float = 0) {
		super();

		titleText = new FlxText(x, y, 400, "RuneVM Codex");
		titleText.setFormat(null, 20, FlxColor.YELLOW, "center");
		add(titleText);

		backgroundText = new FlxText(x, y + 30, 400, "Instruction Reference:\n\nOP_PUSH: Push value to stack\nOP_ADD: Add top two values\nOP_SUB: Subtract top two values\nOP_MUL: Multiply top two values\nOP_DIV: Divide top two values\nOP_HALT: Stop execution");
		backgroundText.setFormat(null, 14, FlxColor.WHITE, "left");
		add(backgroundText);
	}

	private function set_visible(value:Bool):Bool {
		visible = value;
		titleText.visible = value;
		backgroundText.visible = value;
		return value;
	}
}
