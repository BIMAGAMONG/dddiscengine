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
import sys.FileSystem;
import flixel.FlxSubState;

import chapter.*;

class PlayState extends FlxState
{
	public static var curLine:Int = 0;
	public static var curChapter:Int = 1;

	// background
	public static var bg:DokiBG;

	// each character is defined here
	public static var monika:DokiChr;

	// dialogue stuff
	public static var text:FlxTypeText;
	public static var textBox:FlxSprite;

	var end:Bool = false;

	override public function create()
	{
		// the default bg
		bg = new DokiBG('school', false);
		add(bg);

	    // x position, y position, name of the character you want to load 
		monika = new DokiChr(288, -112, "monika", true);
		monika.scale.set(0.8, 0.8);
		monika.screenCenter();
		add(monika);

		textBox = new FlxSprite().loadGraphic(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(0, 0, curChapter)));
		textBox.setGraphicSize(Std.int(textBox.width * 1.3));
		textBox.screenCenter();
		textBox.y += 250;
		textBox.alpha = 0;
		add(textBox);

		text = new FlxTypeText(125, 530, Std.int(FlxG.width * 0.8), AssetPaths.chapterDialogue(0, 1, curChapter), 28, true);
		text.font = "assets/fonts/RifficFree-Bold.ttf";
		text.color = FlxColor.WHITE;
		text.alignment = LEFT;
		text.borderStyle = OUTLINE;
		text.borderSize = 2;
		text.alpha = 0;
		text.start(0.03, true);
		add(text);

		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			FlxTween.tween(textBox, {alpha: 1}, 0.5);
			FlxTween.tween(text, {alpha: 1}, 0.5);
		});
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if ((FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) && end == false) {
            newLine();
			checkLine();
		}
		
		if (FlxG.keys.justPressed.BACKSPACE && end == false) {
			MenuState.doIntro = false;
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}

	public function newLine()
	{
		curLine += 1;

		text.resetText(AssetPaths.chapterDialogue(curLine, 1, curChapter));
		text.start(0.03);

		if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == " " && AssetPaths.chapterDialogue(curLine, 1, curChapter) == " ") {
			end = true;
			FlxTween.tween(textBox, {alpha: 0}, 0.5);
			FlxTween.tween(text, {alpha: 0}, 0.5);

			new FlxTimer().start(1, function(timer:FlxTimer)
			{
				FlxG.switchState(new MenuState());
			});
		}
		else {
			if (sys.FileSystem.exists(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(0, 0, curChapter))))
			{
				textBox.loadGraphic(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(0, 0, curChapter)));
			}
			else {
				textBox.loadGraphic(AssetPaths.getUIasset("textnull"));
			}
		}
	}

	public function checkLine()
	{
		// in charge of bg changes, also used to change expressions
		if (curChapter == 1)
		{
			switch (curLine)
		    {
				case 8:
					remove(bg);
					bg = new DokiBG('schoolglitch', true);
					add(bg);
			}
		}
	}
}
