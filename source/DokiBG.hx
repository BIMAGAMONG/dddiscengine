package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

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

        // only up to one animation
        switch (dokiBGNAME) {
            case 'school':
                loadGraphic(AssetPaths.dokiBG(dokiBGNAME));
            case 'schoolglitch':
                hasanims = true;
                bgtex = AssetPaths.getBGSpritesheet(dokiBGNAME);
                frames = bgtex;
                animation.addByPrefix("schoolglitch", "schoolglitch", 16, false);
                curAnimation('schoolglitch');
            default:
                loadGraphic(AssetPaths.dokiBG("bg_missing"));
        }

        screenCenter();
	}

    public function curAnimation(Name:String):Void
    {
        if (hasanims) {desiredAnimation = Name;}
    }
    
    override function update(elapsed:Float)
    {
        if (hasanims) {animation.play(desiredAnimation);}
        super.update(elapsed);
    }

}