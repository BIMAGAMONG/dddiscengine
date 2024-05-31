package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.text.FlxTypeText;

import chapters.*;

class PlayState extends FlxState
{
    var curChapter:String = "chapter1";

	var bg:DokiBG;

	// each character is defined here
	var monika:DokiChr;
	var missingchartest:DokiChr;

	// dialogue stuff
	var text:FlxTypeText;

	override public function create()
	{
		// the default bg
		bg = new DokiBG('school', true);
		add(bg);

	    // x position, y position, name of the character you want to load 
		monika = new DokiChr(288, -112, "monika", true);
		monika.scale.set(0.8, 0.8);
		monika.screenCenter();
		add(monika);

		missingchartest = new DokiChr(600, -70, "lol", false);
		missingchartest.scale.set(0.8, 0.8);
		add(missingchartest);

		text = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.5), "very big wip", 32);
		text.font = 'Riffic Free Medium';
		text.color = 0xFFFFFFFF;
		text.start(0.03, true);
		add(text);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.BACKSPACE) {MenuState.doIntro = false; FlxG.switchState(new MenuState());}

		super.update(elapsed);
	}
}
