package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

// wanted to make the process of adding a character the same as FNF
// i used the code from FNF as a reference so uh this is pretty much the same as Character.hx
// just with different variable and function names

class DokiChr extends FlxSprite
{
    var texture:FlxAtlasFrames;
	public var character:String = '';
	public var offsetone:Map<String, Array<Dynamic>>;
	public var desiredAnimation:String = "";
	public var hasanims:Bool;

	public function new(x:Float, y:Float, chr:String, isAnimated:Bool)
	{
		super(x, y);

		character = chr;
		offsetone = new Map<String, Array<Dynamic>>();
		hasanims = isAnimated;

		switch (character)
		{
			case "monika":
				texture = AssetPaths.getSpritesheet("monika");
				frames = texture;
	
				animation.addByPrefix("happy", "idle", 24, false);
				animation.addByPrefix("sad", "joysad", 24, false);
	
				createOffset("happy");
				createOffset("sad");
				
				curAnimation("happy");
			default:
				loadGraphic(AssetPaths.getStaticCharacter("char_missing"));
		}
	}

	public function curAnimation(Name:String):Void
	{
		if (hasanims) {
			desiredAnimation = Name;
			var offsettwo = offsetone.get(Name);
			if (offsetone.exists(Name))
			{
				offset.set(offsettwo[0], offsettwo[1]);
			}
			else
			{
				offset.set(0, 0);
			}
		}
	}
	
	public function createOffset(name:String, x:Float = 0, y:Float = 0)
	{
		offsetone[name] = [x, y];
	}

	override function update(elapsed:Float)
	{
		if (hasanims) {animation.play(desiredAnimation);}
		super.update(elapsed);
	}
}
