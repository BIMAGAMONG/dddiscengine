package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	var framerate:Int = 60; // frames per second lol

	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, MenuState, framerate, framerate, true, false));
	}
}
