package;

import flixel.FlxGame;
import openfl.display.Sprite;
import machine.Init;
import machine.play.PlayState;

#if android
import android.os.Build;
import android.os.Environment;
import android.Permissions;
#end

class Main extends Sprite {
    public function new() {
        super();

        #if android
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                Environment.requestManageAllFilesAccessPermission();
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
