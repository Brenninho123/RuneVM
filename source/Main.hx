package;

import flixel.FlxGame;
import openfl.display.Sprite;
import machine.Init;
import machine.play.PlayState;

class Main extends Sprite {
    public function new() {
        super();

        var init = new Init();
        init.start();

        addChild(new FlxGame(0, 0, PlayState));
    }
}
