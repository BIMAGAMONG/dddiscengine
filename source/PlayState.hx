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

import chapter.*;

class PlayState extends FlxState
{
    var curChapter:Int = 1;
	var curLine:Int = 0;

	var end:Bool = false;

	// background
	var bg:DokiBG;

	// each character is defined here
	var monika:DokiChr;
	var missingchartest:DokiChr;

	// dialogue stuff
	var text:FlxTypeText;
	var textBox:FlxSprite;

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

		textBox = new FlxSprite().loadGraphic(AssetPaths.getUIasset("text" + chapter.ChapterOne.script[curLine][0]));
		textBox.setGraphicSize(Std.int(textBox.width * 1.3));
		textBox.screenCenter();
		textBox.y += 250;
		add(textBox);

		text = new FlxTypeText(240, 500, Std.int(textBox.width), chapter.ChapterOne.script[curLine][1], 32);
		text.setFormat("assets/fonts/RifficFree-Bold.ttf", FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		text.start(0.03, true);
		add(text);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{

		if ((FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) && end == false) {
			if (chapter.ChapterOne.script[curLine][1] == "end" && chapter.ChapterOne.script[curLine][0] == "end") {
				end = true;
				FlxG.switchState(new MenuState());
			}
			else {
				text.resetText(chapter.ChapterOne.script[curLine][1]);
				text.start(0.03);
			}
			
			newLine();
		}
		
		if (FlxG.keys.justPressed.BACKSPACE && end == false) {MenuState.doIntro = false; FlxG.switchState(new MenuState());}

		super.update(elapsed);
	}

	public function newLine()
	{
		curLine += 1;

		remove(textBox);
		textBox.loadGraphic(AssetPaths.getUIasset("text" + chapter.ChapterOne.script[0][0]));
		textBox.setGraphicSize(Std.int(textBox.width * 1.2));
		textBox.screenCenter();
		textBox.y += 250;
		add(textBox);
	}
}
