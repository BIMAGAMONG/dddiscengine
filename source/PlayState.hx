package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import sys.FileSystem;

class PlayState extends FlxState
{
	var bg:FlxSprite;

	// each character is defined here
	var character1:DokiChr;

	override public function create()
	{
		bg = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic('assets/images/bg/school.png');
		bg.screenCenter();
		add(bg);

	    // x position, y position, name of the character you want to load 
		character1 = new DokiChr(FlxG.width / 2, FlxG.height / 2, "monika");
		add(character1);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.BACK) {FlxG.switchState(new MenuState());}
		super.update(elapsed);
	}
}
