package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


// this is the most horrible way to code characters
class DokiChr extends FlxSprite
{
    var texture:FlxAtlasFrames;
	public var character:String = '';
	public var offsetone:Map<String, Array<Dynamic>>;
	public var desiredAnimation:String = "";
	public var hasanims:Bool;
	public var identifier:String = "null";

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
				identifier = "m";
	
				animation.addByPrefix("happy", "idle", 24, false);
				animation.addByPrefix("sad", "joysad", 24, false);
	
				createOffset("happy");
				createOffset("sad");
				
				curAnimation("happy");

			case "sayori":
				texture = AssetPaths.getSpritesheet("sayori_assets");
				frames = texture;
				identifier = "s";
	
				animation.addByPrefix("happy", "say", 24, false);
	
				createOffset("happy");
				
				curAnimation("happy");
			default:
				loadGraphic(AssetPaths.getStaticCharacter("char_missing"));
		}
	}

	public function moveTo(xPos:Float, yPos:Float, ?time:Float)
	{
		if (time == null)
		{
			time = 1;
		}

        FlxTween.tween(this, {x: xPos, y: yPos}, time);
	}

	public function moveX(xPos:Float, ?time:Float)
	{
		if (time == null)
		{
			time = 1;
		}
	
		FlxTween.tween(this, {x: xPos}, time);
	}

	public function moveY(yPos:Float, ?time:Float)
	{
		if (time == null)
		{
			time = 1;
		}
		
		FlxTween.tween(this, {y: yPos}, time);
	}

	public function opacity(opacity:Float, ?time:Float)
	{
		if (time == null)
		{
			time = 1;
		}

		FlxTween.tween(this, {alpha: opacity}, time);
	}

	public function rotate(toAngle:Float, ?time:Float)
	{
		if (time == null)
		{
			time = 1;
		}

		FlxTween.angle(this, this.angle, toAngle, time);
	}

	public function entranceType(type:String, ?time:Float)
	{
		if (time == null)
		{
			time = 0.5;
		}

		FlxTween.tween(this, {alpha: 1}, time);

		switch (type)
		{
			case "swipeFromL":
				x -= 100;
				FlxTween.tween(this, {x: x + 100}, time);
			case "swipeFromR":
				x += 100;
				FlxTween.tween(this, {x: x - 100}, time);
			case "swipeFromU":
				y -= 100;
				FlxTween.tween(this, {y: y + 100}, time);
			case "swipeFromD":
				y += 100;
				FlxTween.tween(this, {x: y - 100}, time);
		}
	}

	public function exitType(type:String, ?time:Float)
	{
		if (time == null)
		{
			time = 0.5;
		}
	
		FlxTween.tween(this, {alpha: 0}, time);
	
		switch (type)
		{
			case "swipeToL":
				FlxTween.tween(this, {x: x + 100}, time);
			case "swipeToR":
				FlxTween.tween(this, {x: x - 100}, time);
			case "swipeToU":
				FlxTween.tween(this, {y: y + 100}, time);
			case "swipeToD":
				FlxTween.tween(this, {x: y - 100}, time);
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
