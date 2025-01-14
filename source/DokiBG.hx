package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

// works exactly the same way as adding a character lol.
class DokiBG extends FlxSprite
{
    var dokiBGNAME:String = "";
    var bgtex:FlxAtlasFrames;
    var hasanims:Bool = false;
    public var desiredAnimation:String = "";

	public function new(name:String)
	{
		super();
        dokiBGNAME = name;
        screenCenter();
		reloadshit(name);
	}

	public function reloadshit(name:String)
	{
		loadGraphic("assets/images/bg_missing");
	}
}