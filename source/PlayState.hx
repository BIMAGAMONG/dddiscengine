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
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera;

import chapter.*;

// this is in charge of the dialogue, to some extent - characters and backgrounds
// PlayState.hx works together with your chapter file
class PlayState extends FlxState
{
	// bg and cg
    var bg:DokiBG;

	public var charGroup:FlxTypedGroup<DokiChr> = new FlxTypedGroup<DokiChr>();
    public static var monika:DokiChr;
	public static var yuri:DokiChr;
	public static var sayori:DokiChr;
	public static var natsuki:DokiChr;

	// dialogue stuff
	public static var curLine:Int = 0;
	public static var curChapter:Int = 1;

	var text:FlxTypeText;
	var textBox:FlxSprite;
	var pauseButton:FlxSprite;

	public static var end:Bool = false;
	public static var block:Bool = false;

	override public function create()
	{
		curLine = 0;
		end = false;

		// cgs and bgs in one
		bg = new DokiBG('school');
		add(bg);
		
		// x position, y position, name of the character you want to load, then whether the character is animated or not
		monika = new DokiChr(100, -112, "monika", true);
		monika.scale.set(0.8, 0.8);
		monika.screenCenter();
		monika.alpha = 0;
		monika.identifier = "m";

		sayori = new DokiChr(100, 0, "sayori", true);
		sayori.scale.set(0.8, 0.8);
		sayori.screenCenter();
		sayori.alpha = 0;
		sayori.identifier = "s";

		textBox = new FlxSprite().loadGraphic(AssetPaths.getUIasset("text" + AssetPaths.chapterDialogue(0, 0, curChapter)));
        textBox.setGraphicSize(Std.int(textBox.width * 1.3));
        textBox.screenCenter();
        textBox.y += 250;
        textBox.alpha = 0;
    
        text = new FlxTypeText(130, 530, Std.int(FlxG.width * 0.8), AssetPaths.chapterDialogue(0, 1, curChapter), 28, true);
        text.font = "assets/fonts/RifficFree-Bold.ttf";
        text.color = FlxColor.WHITE;
        text.alignment = LEFT;
        text.borderStyle = OUTLINE;
        text.borderSize = 2;
        text.alpha = 0;
        text.start(0.03, true);

		pauseButton = new FlxSprite(1170, 5);
		pauseButton.frames = AssetPaths.getUISpritesheet('pause');
		pauseButton.scale.set(0.2, 0.2);
		pauseButton.animation.addByPrefix('idle', 'pause.png', 24, false);
		pauseButton.animation.addByPrefix('sel', 'pauseSelected.png', 24, false);
		pauseButton.animation.play('idle');
		pauseButton.updateHitbox();

		/* This is used for the multiple purposes, eg. adding only the characters that appear in a chapter.
		*  Monika's Introduction has just Monika in it, so there is absolutely no point in adding the rest of the dokis.
		*  OR maybe to start with a different background, OR make a character play a specific animation at the start.
		*  (there's a lot of possibilities)!
		* 
		*  P E R F O R M A N C E
		*/
		switch (curChapter)
		{
			case 1:
				monika.entranceType("swipeFromL");
				charGroup.add(monika);
			case 2:
				changeBG("schoolglitch", true);
				sayori.entranceType("swipeFromD");
				charGroup.add(sayori);
		}

		add(charGroup);
		add(textBox);
		add(text);
		add(pauseButton);

		FlxTween.tween(textBox, {alpha: 1}, 0.5);
        FlxTween.tween(text, {alpha: 1}, 0.5);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{	
		if (!end)
		{
			if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE) {
				MenuState.doIntro = false;
				FlxG.switchState(new MenuState());
			}

			if (block == false)
		    {
				if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) {
					newLine();
				}
			}

			if (FlxG.keys.pressed.Z) {
				textBox.alpha = 0;
				text.alpha = 0;
			}
			else if (!FlxG.keys.pressed.Z) {
				textBox.alpha = 1;
				text.alpha = 1;
			}

			if (FlxG.mouse.overlaps(pauseButton) || FlxG.keys.pressed.ESCAPE)
			{
                pauseButton.animation.play('sel');
			}
			else
			{
				pauseButton.animation.play('idle');
			}
		}	

		super.update(elapsed);
	}

    public function newLine()
	{	
		curLine += 1;

		switch (AssetPaths.chapterDialogue(curLine, 0, curChapter))
		{
			// SHIT FOR CHARACTERS
			case 'playAnim':
				charAnim(AssetPaths.chapterDialogue(curLine, 1, curChapter), AssetPaths.chapterDialogue(curLine, 2, curChapter));
			case 'rotate':
				charRotate(Std.parseFloat(AssetPaths.chapterDialogue(curLine, 1, curChapter)), Std.parseFloat(AssetPaths.chapterDialogue(curLine, 2, curChapter)), AssetPaths.chapterDialogue(curLine, 3, curChapter));
			case 'moveOnAxis':
				charMoveOnAxis(AssetPaths.chapterDialogue(curLine, 1, curChapter), Std.parseFloat(AssetPaths.chapterDialogue(curLine, 2, curChapter)), Std.parseFloat(AssetPaths.chapterDialogue(curLine, 3, curChapter)), AssetPaths.chapterDialogue(curLine, 4, curChapter));
				newLine();
			case 'move':
				charMove(Std.parseFloat(AssetPaths.chapterDialogue(curLine, 1, curChapter)), Std.parseFloat(AssetPaths.chapterDialogue(curLine, 2, curChapter)), Std.parseFloat(AssetPaths.chapterDialogue(curLine, 3, curChapter)), AssetPaths.chapterDialogue(curLine, 4, curChapter));

			// other shit
            case 'bgchange':
				changeBG(AssetPaths.chapterDialogue(curLine, 1, curChapter));
			case 'transition':
				block = true;
				transition(AssetPaths.chapterDialogue(curLine, 1, curChapter));
			case 'playsound':
				startSound(AssetPaths.chapterDialogue(curLine, 1, curChapter));
			case 'playmusic':
				startMusic(AssetPaths.chapterDialogue(curLine, 1, curChapter));
			case 'end':
				block = true;
				endGame();
			default:
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

	public function changeBG(bgName:String, ?isFromStart:Bool)
	{
		remove(bg);
		bg = new DokiBG(bgName);
		add(bg);
		if (!isFromStart)
		{
			newLine();
		}
	}

	public function startSound(name:String, ?isFromStart:Bool)
	{
		FlxG.sound.play(AssetPaths.sounds(name));
		if (!isFromStart)
		{
			newLine();
		}
	}

	public function startMusic(name:String, ?isFromStart:Bool)
	{
		FlxG.sound.playMusic(AssetPaths.sounds(name));
	    if (!isFromStart)
		{
			newLine();
		}
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
					block = false;
				}});
			}
			else {
				blackWipe.x += 1500;
				FlxTween.tween(blackWipe, {x: blackWipe.x - 3000}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
					block = false;
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
					block = false;
				}});
			}
			else {
				blackWipe.y += 900;
				FlxTween.tween(blackWipe, {y: blackWipe.y - 1800}, 2, {onComplete: function(twn:FlxTween){
					remove(blackWipe);
					FlxTween.tween(text, {alpha: 1}, 0.5);
					FlxTween.tween(textBox, {alpha: 1}, 0.5);
					block = false;
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

	public function charAnim(animName:String, character:String)
	{
		for (item in charGroup.members)
		{
			if (character == item.identifier)
			{
				item.curAnimation(animName);
			}
		}
		newLine();
	}

	public function charRotate(targetAngle:Float, timeTaken:Float, character:String)
	{
	    for (item in charGroup.members)
		{
			if (character == item.identifier)
			{
				item.rotate(targetAngle, timeTaken);
			}
		}
		newLine();
	}

	public function charMoveOnAxis(axis:String, position:Float, time:Float, character:String)
	{
        for (item in charGroup.members)
		{
			if (character == item.identifier)
			{
				switch (axis)
				{
					case "x":
						item.moveX(position, time);
					case "y":
						item.moveY(position, time);
				}
			}
		}
	}

	public function charMove(positionX:Float, positionY:Float, time:Float, character:String)
	{
        for (item in charGroup.members)
		{
			if (character == item.identifier)
			{
				item.moveTo(positionX, positionY, time);
			}
		}
	}
}