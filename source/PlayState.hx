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
	// note to self: center of the screen is 288, -112
	var bg:DokiBG;

	// each character is defined here
	var monika:DokiChr;
	var missingchartest:DokiChr;

	override public function create()
	{
		bg = new DokiBG('schoolglitch', true);
		add(bg);

	    // x position, y position, name of the character you want to load 
		monika = new DokiChr(288, -112, "monika", true);
		monika.scale.set(0.8, 0.8);
		monika.screenCenter();
		add(monika);

		missingchartest = new DokiChr(200, -70, "lol", false);
		missingchartest.scale.set(0.8, 0.8);
		add(missingchartest);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.BACKSPACE) {MenuState.doIntro = false; FlxG.switchState(new MenuState());}

		super.update(elapsed);
	}
}
