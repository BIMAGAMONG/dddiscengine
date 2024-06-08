package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import sys.FileSystem;
import flixel.FlxSubState;
import flash.system.System;
import ChapterSelect;

import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.FlxGraphic;
import flixel.addons.transition.TransitionData;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

class MenuState extends FlxState
{	
	// WARNING: IM DECENT AT CODING PLS DON'T SCREAM AT ME ALRIGHT :(

	// this defines the splash messgae itself
	var splashMessage:FlxText;

	// warning screen (required by ip guidelines, do not remove)
	public var warning:FlxSprite;

	// this is the splash logo after you boot the game up
	public var logoSplash:FlxSprite;

	// the spinning thingy behind the options and the logo
	public static var speen:FlxSprite;

	// scrolling circles yay
	public var circles:FlxBackdrop;

	// the logo of the engine :3
	public static var logo:FlxSprite;

	// for the main menu selection
	public var curSelected:Int = 0;
	public static var menuOptions:FlxText;

	// ARROWS
	public static var uparrow:FlxSprite;
	public static var downarrow:FlxSprite;

	public static var introFinished:Bool = false;

	public var optionsArray:Array<String> = ['Start', 'Side Stories', 'Gallery', 'Settings', 'Credits', 'Quit'];

	public var splashTextArray:Array<String> = [
		'Monika is not watching you code, thank me for your security.',
		'PINGAS',
		'Doki Doki Takeover Moment'
	];

	public static var doIntro:Bool = true;
	
	override public function create()
	{
		persistentUpdate = true;
		FlxG.mouse.visible = true;

		if (FlxG.save.data.firstTime == null || FlxG.save.data.firstTime == true)
		{
            FlxG.save.data.firstTime = true;
		}

		if (FlxG.save.data.firstTime == false)
		{
			if (FlxG.sound.music == null)
			{
				FlxG.sound.playMusic(AssetPaths.music("mainmenu"));
			}
		}

		var number:Int = FlxG.random.int(0, 2);

		warning = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(AssetPaths.menuAsset('main_menu/warning'));
		warning.setGraphicSize(Std.int(warning.width * 0.9));
		warning.alpha = 0;
		warning.screenCenter();

		splashMessage = new FlxText(100, 330, 0, "");
		splashMessage.setFormat("assets/fonts/RifficFree-Bold.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		splashMessage.size = 27;
		splashMessage.alpha = 0;
		splashMessage.text = splashTextArray[number];

		logoSplash = new FlxSprite(100, 100).loadGraphic(AssetPaths.menuAsset('main_menu/splashLogo'));
		logoSplash.screenCenter();
		logoSplash.alpha = 0;

		menuOptions = new FlxText(-200, 436, 0, "");
		menuOptions.setFormat("assets/fonts/RifficFree-Bold.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		menuOptions.size = 70;

		uparrow = new FlxSprite(menuOptions.x - 300, 200);
		uparrow.loadGraphic(AssetPaths.menuAsset('main_menu/arrow'));
		uparrow.setGraphicSize(Std.int(uparrow.width / 7));
		uparrow.alpha = 0;

		downarrow = new FlxSprite(menuOptions.x - 300, 260);
		downarrow.loadGraphic(AssetPaths.menuAsset('main_menu/arrow'));
		downarrow.setGraphicSize(Std.int(downarrow.width / 7));
		downarrow.angle = 180;

		logo = new FlxSprite(-500, -100);
		logo.loadGraphic(AssetPaths.menuAsset('main_menu/discEngineLogo'));
		logo.setGraphicSize(Std.int(logo.width * 0.5));

		speen = new FlxSprite(100, 100);
		speen.loadGraphic(AssetPaths.menuAsset('main_menu/selectionPlate'));
		speen.screenCenter();
		speen.x -= 1220;

		circles = new FlxBackdrop(XY, 0, 0);
		circles.loadGraphic(AssetPaths.menuAsset('main_menu/menu_circle'));
		circles.updateHitbox();
		circles.setGraphicSize(Std.int(circles.width * 0.2));
		circles.screenCenter(X);
		circles.alpha = 0;

		add(circles);
		add(speen);
		add(logo);
		add(menuOptions);
		add(uparrow);
		add(downarrow);
		add(splashMessage);
		add(logoSplash);
		add(warning);

		super.create();

		if (doIntro == true) {
			if (FlxG.save.data.firstTime == true)
			{
				FlxTween.tween(warning, {alpha: 1}, 3);
				FlxG.save.data.firstTime = false;
				FlxG.save.flush();
				new FlxTimer().start(7, function(timer:FlxTimer)
					{
						if (FlxG.sound.music == null)
						{
							FlxG.sound.playMusic(AssetPaths.music("mainmenu"));
						}
						startIntro();
					});
			}
			else {
				startIntro();
			}
		}
		else {
			initiateMainMenu();
		}
	}

	override public function update(elapsed:Float)
	{
		speen.screenCenter(Y);
		circles.velocity.x = 10;
		circles.velocity.y = 25;

		menuOptions.text = optionsArray[curSelected];

		if (introFinished) {
			speen.angle += elapsed * 15;

		    if (FlxG.keys.justPressed.UP || FlxG.mouse.wheel > 0) {curSelected -= 1;}

		    if (FlxG.keys.justPressed.DOWN || FlxG.mouse.wheel < 0) {curSelected += 1;}

			if (curSelected < 0) {curSelected = 0;}

			if (curSelected > optionsArray.length - 1) {curSelected = optionsArray.length - 1;}

			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed && FlxG.mouse.overlaps(menuOptions))
			{
				introFinished = false;
				
				switch(menuOptions.text)
				{
					case 'Start':
						ChapterSelect.typeOfShiz = "start";
						transition();
					case 'Side Stories':
						ChapterSelect.typeOfShiz = "side-stories";
						transition();
					case 'Gallery':
						trace("SIDE STORIES");
					case 'Settings':
						trace("OPTIONS");
					case 'Credits':
						trace("CREDITS");
					case 'Quit':
						System.exit(0);
				}
			}

		    switch (curSelected)
		    {
			    case 0:
				    uparrow.alpha = 0;
			    case 5:
				    downarrow.alpha = 0;
				default:
					uparrow.alpha = 1;
					downarrow.alpha = 1;
		    }

			if (FlxG.mouse.overlaps(menuOptions)) {
				menuOptions.color = FlxColor.YELLOW;
			}
			else {
				menuOptions.color = FlxColor.WHITE;
			}
	    }

		super.update(elapsed);
	}

	public function startIntro()
	{
		remove(warning);
		circles.alpha = 1;

		// the logo fades in
		FlxTween.tween(logoSplash, {alpha: 1}, 1);

		// the logo fades out
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
				initiateMainMenu();
			});
		});
	}

	public function initiateMainMenu()
	{
		circles.alpha = 1;
		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			remove(logoSplash);
			remove(splashMessage);
		});

		// all the main menu shit comes in
		new FlxTimer().start(2.5, function(timer:FlxTimer)
		{
			FlxTween.tween(speen, {x: -600, y: -100}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(logo, {x: -50, y: -100}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(menuOptions, {x: 100, y: 436}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(uparrow, {x: -200, y: 200}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(downarrow, {x: -200, y: 260}, 2, {ease: FlxEase.circOut, onComplete:
			    function (twn:FlxTween)
				{
					introFinished = true;
				}
			});
		});
	}

	public function transition()
	{
		FlxTween.tween(speen, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(menuOptions, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(logo, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(uparrow, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(downarrow, {alpha: 0}, 0.5, {ease: FlxEase.circOut});

		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			openSubState(new ChapterSelect());
		});
	}

	public static function undoTrans()
	{
		FlxTween.tween(speen, {alpha: 1}, 0.2, {ease: FlxEase.circOut});
		FlxTween.tween(menuOptions, {alpha: 1}, 0.2, {ease: FlxEase.circOut});
		FlxTween.tween(logo, {alpha: 1}, 0.2, {ease: FlxEase.circOut});
		FlxTween.tween(uparrow, {alpha: 1}, 0.2, {ease: FlxEase.circOut});
		FlxTween.tween(downarrow, {alpha: 1}, 0.2, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
			{
				introFinished = true;
			}
		});
	}
}
