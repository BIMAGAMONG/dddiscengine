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
import flixel.group.FlxGroup;

import chapter.*;

// this is in charge of the dialogue, to some extent - characters and backgrounds
// PlayState.hx works together with your chapter file
class PlayState extends FlxState
{
	// bg and cg
    var bg:DokiBG;

    public static var monika:DokiChr;
	public static var yuri:DokiChr;
	public static var sayori:DokiChr;
	public static var natsuki:DokiChr;

	// dialogue stuff
	public static var curLine:Int = 0;
	public static var curChapter:Int = 1;

	var text:FlxTypeText;
	var textBox:FlxSprite;

	public static var end:Bool = false;

	override public function create()
	{
		// cgs and bgs in one
		bg = new DokiBG('school');
		add(bg);
		
		// x position, y position, name of the character you want to load, then whether the character is animated or not
		monika = new DokiChr(100, -112, "monika", true);
		monika.scale.set(0.8, 0.8);
		monika.screenCenter();
		monika.alpha = 0;
		add(monika);

		textBox = new FlxSprite().loadGraphic(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(0, 0, curChapter)));
        textBox.setGraphicSize(Std.int(textBox.width * 1.3));
        textBox.screenCenter();
        textBox.y += 250;
        textBox.alpha = 0;
        add(textBox);
    
        text = new FlxTypeText(130, 530, Std.int(FlxG.width * 0.8), AssetPaths.chapterDialogue(0, 1, curChapter), 28, true);
        text.font = "assets/fonts/RifficFree-Bold.ttf";
        text.color = FlxColor.WHITE;
        text.alignment = LEFT;
        text.borderStyle = OUTLINE;
        text.borderSize = 2;
        text.alpha = 0;
        text.start(0.03, true);
        add(text);
    
        FlxTween.tween(textBox, {alpha: 1}, 0.5);
        FlxTween.tween(text, {alpha: 1}, 0.5);

		AssetPaths.chapterCheck(curChapter);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{	
		if (end == false)
		{
			if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE) {
				MenuState.doIntro = false;
				FlxG.switchState(new MenuState());
			}

			if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) {
				newLine();
				AssetPaths.chapterCheck(curChapter);
			}

			if (FlxG.keys.pressed.Z) {
				textBox.alpha = 0;
				text.alpha = 0;
			}
			else if (!FlxG.keys.pressed.Z) {
				textBox.alpha = 1;
				text.alpha = 1;
			}
		}	
		super.update(elapsed);
	}

    public function newLine()
	{
		curLine += 1;
		
		if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == " " && AssetPaths.chapterDialogue(curLine, 1, curChapter) == " ") {
			endGame();
		}
		else if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == "bgchange")
		{
			changeBG(AssetPaths.chapterDialogue(curLine, 1, curChapter));
		}
		else if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == "transition")
		{
			transition(AssetPaths.chapterDialogue(curLine, 1, curChapter));
		}
		else if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == "playsound")
		{
			startSound(AssetPaths.chapterDialogue(curLine, 1, curChapter));
		}
		else if (AssetPaths.chapterDialogue(curLine, 0, curChapter) == "playmusic")
		{
			startMusic(AssetPaths.chapterDialogue(curLine, 1, curChapter));
		}
		else {
			text.resetText(AssetPaths.chapterDialogue(curLine, 1, curChapter));
			text.start(0.03);
	
			if (sys.FileSystem.exists(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(curLine, 0, curChapter))))
			{
				textBox.loadGraphic(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(curLine, 0, curChapter)));
			}
			else {
				textBox.loadGraphic(AssetPaths.getUIasset("textnull"));
			}
		}
	}

	public function changeBG(bgName:String)
	{
		remove(bg);
		bg = new DokiBG(bgName);
		add(bg);
		newLine();
	}

	public function startSound(name:String)
	{
		FlxG.sound.play(AssetPaths.sounds(name));
		newLine();
	}

	public function startMusic(name:String)
	{
		FlxG.sound.playMusic(AssetPaths.sounds(name));
		newLine();
	}
	
	public function transition(type:String)
	{
		FlxTween.tween(text, {alpha: 0}, 0.5);
		FlxTween.tween(textBox, {alpha: 0}, 0.5);

        if (type == "wipeleft" || type == "wiperight")
	    {
            var blackWipe:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.getUIasset("wipe"));
			blackWipe.screenCenter();
			blackWipe.scale.set(1.3, 1);
			add(blackWipe);

			if (type == "wipeleft")
			{
				blackWipe.x -= 1500;
				FlxTween.tween(blackWipe, {x: blackWipe.x + 3000}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
				}});
			}
			else {
				blackWipe.x += 1500;
				FlxTween.tween(blackWipe, {x: blackWipe.x - 3000}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
				}});	
			}
		}
		else if (type == "wipeup" || type == "wipedown")
		{
			var blackWipe:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.getUIasset("wipe"));
			blackWipe.screenCenter();
			blackWipe.scale.set(1, 2);
			blackWipe.angle -= 90;
			add(blackWipe);

			if (type == "wipeup")
			{
				blackWipe.y -= 900;
				FlxTween.tween(blackWipe, {y: blackWipe.y + 1800}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
				}});
			}
			else {
				blackWipe.y += 900;
				FlxTween.tween(blackWipe, {y: blackWipe.y - 1800}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
				}});	
			}
		}

		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			newLine();
		});
	}

	public function endGame()
	{
		end = true;
		FlxTween.tween(textBox, {alpha: 0}, 0.5);
		FlxTween.tween(text, {alpha: 0}, 0.5);
		MenuState.doIntro = true;

		var endGraphic:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.getUIasset("endGraphic"));
		endGraphic.screenCenter();
		endGraphic.alpha = 0;
		add(endGraphic);
		FlxTween.tween(endGraphic, {alpha: 1}, 1);

		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			curChapter = 0;
			curLine = 0;
			FlxG.switchState(new MenuState());
		});
	}
}