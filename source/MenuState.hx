package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
//import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import sys.FileSystem;

class MenuState extends FlxState
{	
	// WARNING: I SUCK AT CODING DON'T SCREAM AT ME ALRIGHT :(
	// this is a randomizer for the splash messages, it picks a value between 1 to 6 and the value determines the splash message.
	// not the best way but why the fuck not
	var splashMessageRandomizer:Int = FlxG.random.int(1, 6);

	// this defines the splash messgae itself
	var splashMessage:FlxText;

	// this is the splash logo after you boot the game up
	public var logoSplash:FlxSprite;

	// White background because uh because black bg sucks
	var whiteBg:FlxSprite;

	// the spinning thingy behind the options and the logo
	public var speen:FlxSprite;

	// scrolling circles yay
	public var circles:FlxBackdrop;

	// the logo of the engine :3
	public var logo:FlxSprite;

	// for the main menu selection
	public var curSelected:Int = 1;
	public var menuOptions:FlxText;

	// ARROWS
	public var uparrow:FlxSprite;
	public var downarrow:FlxSprite;

	// Credits pop-up thingy
	public var creditsPopUp:FlxSprite;

	override public function create()
	{
		FlxG.sound.playMusic("assets/music/mainmenu.ogg");

		if (FlxG.sound.music == null)
			{
				FlxG.sound.playMusic("assets/music/mainmenu.ogg");
			}

		creditsPopUp = new FlxSprite(1200, 10);
		creditsPopUp.loadGraphic("assets/images/ui/credits.png");
		creditsPopUp.setGraphicSize(Std.int(creditsPopUp.width / 1.5));
		creditsPopUp.alpha = 1;

		menuOptions = new FlxText(-200, 436, 0, "");
		menuOptions.setFormat("assets/fonts/RifficFree-Bold.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		menuOptions.color = FlxColor.WHITE;
		menuOptions.size = 70;
		menuOptions.alpha = 1;

		uparrow = new FlxSprite(menuOptions.x - 300, 200);
		uparrow.loadGraphic('assets/images/main_menu/arrow.png');
		uparrow.setGraphicSize(Std.int(uparrow.width / 7));

		downarrow = new FlxSprite(menuOptions.x - 300, 260);
		downarrow.loadGraphic('assets/images/main_menu/arrow.png');
		downarrow.setGraphicSize(Std.int(downarrow.width / 7));
		downarrow.angle = 180;

		logo = new FlxSprite(-500, -100);
		logo.loadGraphic('assets/images/main_menu/discEngineLogo.png');
		logo.setGraphicSize(Std.int(logo.width * 0.5));

		whiteBg = new FlxSprite(100, 100);
		whiteBg.makeGraphic(1280, 720, FlxColor.WHITE);
		whiteBg.screenCenter();

		circles = new FlxBackdrop(XY, 250, 250);
		circles.loadGraphic('assets/images/main_menu/menu_circle.png');
		circles.updateHitbox();
		circles.alpha = 0;
		circles.setGraphicSize(Std.int(circles.width * 0.2));
		circles.screenCenter(X);

		splashMessage = new FlxText(100, 330, 0, "");
		splashMessage.setFormat("assets/fonts/RifficFree-Bold.ttf", FlxColor.BLACK, CENTER);
		splashMessage.color = FlxColor.BLACK;
		splashMessage.size = 25;
		splashMessage.alpha = 0;

		logoSplash = new FlxSprite(100, 100);
		logoSplash.loadGraphic("assets/images/main_menu/splashLogo.png");
		logoSplash.screenCenter();
		logoSplash.alpha = 0;

		speen = new FlxSprite(100, 100);
		speen.loadGraphic("assets/images/main_menu/selectionPlate.png");
		speen.screenCenter();
		speen.x -= 1220;

		switch (splashMessageRandomizer)
		{
			case 1:
				splashMessage.text = 'A new generation of DDLC Modding...';
			case 2:
				splashMessage.text = 'This is a Mod Template. Nothing to do with Serenity Forge or Dan Salvato.';
			case 3:
				splashMessage.text = 'Play the original game: Doki Doki Literature Club!';
			case 4:
				splashMessage.text = 'HaxeFlixel for the win!';
			case 5:
				splashMessage.text = 'Monika is not watching you code, thank me for your security.';
			case 6:
				splashMessage.text = 'What will it take, just to find that special day?';
		}

		// so many stuff fr
		add(whiteBg);
		add(circles);
		add(speen);
		add(logo);
		add(splashMessage);
		add(logoSplash);
		add(menuOptions);
		add(uparrow);
		add(downarrow);
		add(creditsPopUp);

		FlxTween.tween(logoSplash, {alpha: 1}, 1);

		new FlxTimer().start(2, function(timer:FlxTimer)
		{
			FlxTween.tween(logoSplash, {alpha: 0}, 1);
		});

		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			FlxTween.tween(splashMessage, {alpha: 1}, 1);
			new FlxTimer().start(2, function(timer:FlxTimer)
			{
				FlxTween.tween(splashMessage, {alpha: 0}, 1);
			});
		});

		new FlxTimer().start(7, function(timer:FlxTimer)
		{
			FlxTween.tween(circles, {alpha: 1}, 1);
			FlxTween.tween(speen, {x: -600, y: -100}, 4, {ease: FlxEase.circOut});
			FlxTween.tween(logo, {x: -50, y: -100}, 4, {ease: FlxEase.circOut});
			FlxTween.tween(menuOptions, {x: 100, y: 436}, 4, {ease: FlxEase.circOut});
			FlxTween.tween(uparrow, {x: -200, y: 200}, 4, {ease: FlxEase.circOut});
			FlxTween.tween(downarrow, {x: -200, y: 260}, 4, {ease: FlxEase.circOut});
		});

		super.create();
	}

	override public function update(elapsed:Float)
	{
		speen.screenCenter(Y);
		speen.angle += elapsed * 15;

		creditsPopUp.screenCenter(Y);

		circles.velocity.x = 10;
		circles.velocity.y = 25;

		if (FlxG.keys.justPressed.UP)
		{
			curSelected -= 1;

			if (curSelected == 0)
			{
				curSelected = 1;
			}
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			curSelected += 1;

			if (curSelected == 6)
			{
				curSelected = 5;
			}
		}

		if (FlxG.keys.justPressed.ENTER && curSelected == 1)
		{
			trace("START");
		}
		else if (FlxG.keys.justPressed.ENTER && curSelected == 2)
		{
			trace("SIDE STORIES");
		}
		else if (FlxG.keys.justPressed.ENTER && curSelected == 3)
		{
			trace("OPTIONS");
		}
		else if (FlxG.keys.justPressed.ENTER && curSelected == 4)
		{
			FlxTween.tween(creditsPopUp, {x: 500, y: 10}, 2, {ease: FlxEase.circOut});
			trace("CREDITS");
		}
		else if (FlxG.keys.justPressed.ENTER && curSelected == 5)
		{
			trace("QUIT GAME");
			System.exit(0);
		}

		switch (curSelected)
		{
			case 1:
				menuOptions.text = 'Start';
				uparrow.alpha = 0;
				creditsPopUp.x = 1300;
			case 2:
				menuOptions.text = 'Side Stories';
				uparrow.alpha = 1;
				creditsPopUp.x = 1300;
			case 3:
				menuOptions.text = 'Options';
				creditsPopUp.x = 1300;
			case 4:
				menuOptions.text = 'Credits';
				downarrow.alpha = 1;
				creditsPopUp.alpha = 1;
			case 5:
				menuOptions.text = 'Quit Game';
				downarrow.alpha = 0;
				creditsPopUp.x = 1300;
		}

		super.update(elapsed);
	}
}
