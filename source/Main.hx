package;

import flixel.FlxGame;
import openfl.display.Sprite;
import machine.Init;
import machine.play.PlayState;

#if android
import android.Tools;
import android.Permissions;
#end

class Main extends Sprite {
    public function new() {
        super();

        #if android
        if (Tools.getSDKversion() >= 30) {
            if (!Permissions.getGrantedPermissions().contains(Permissions.MANAGE_EXTERNAL_STORAGE)) {
                Permissions.requestPermission(Permissions.MANAGE_EXTERNAL_STORAGE);
            }
        } else {
            Permissions.requestPermissions([
                Permissions.READ_EXTERNAL_STORAGE,
                Permissions.WRITE_EXTERNAL_STORAGE
            ]);
        }
        #end

        var init = new Init();
        init.start();

        addChild(new FlxGame(0, 0, PlayState));
    }
}
