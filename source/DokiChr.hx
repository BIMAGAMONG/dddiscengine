package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

class DokiChr extends FlxSprite
{
    var texture:FlxAtlasFrames;

	public function new(x:Float, y:Float, chr:String)
	{
		super(x, y);

		switch (chr)
		{
            case "monika":
				texture = FlxAtlasFrames.fromSparrow('assets/images/characters/monika.png', 'assets/images/characters/monika.xml');
				animation.addByPrefix("idle", "idle", 24, false);

				animation.play("idle");
			default:
				texture = FlxAtlasFrames.fromSparrow('assets/images/characters/char_missing.png', 'assets/images/characters/char_missing.xml');
				animation.addByPrefix("idle", "idle", 24, false);

				animation.play("idle");
		}

	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
