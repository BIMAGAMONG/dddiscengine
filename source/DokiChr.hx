package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

// wanted to make the process of adding a character the same as FNF.
// i used the code from FNF as a reference so uh this is pretty much the same as Character.hx
class DokiChr extends FlxSprite
{
    var texture:FlxAtlasFrames;
	public var character:String = '';

	public function new(x:Float, y:Float, chr:String)
	{
		super(x, y);

		character = chr;

		switch (character)
		{
            case "monika":
				texture = AssetPaths.getSpritesheet("monika");
				frames = texture;

				animation.addByPrefix("happy", "idle", 24, false);
			default:
				texture = AssetPaths.getSpritesheet("char_missing");
				frames = texture;

				animation.addByPrefix("idle", "idle", 24, false);
		}

	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function playAnimation(name:String)
	{
		animation.play(name);
	}
}
