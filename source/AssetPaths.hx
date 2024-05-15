package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

@:build(flixel.system.FlxAssets.buildFileReferences("assets", true))

class AssetPaths
{
    static function getPath(file:String)
    {        
        return getStuffFromPath(file);
    }

    inline static function getStuffFromPath(file:String)
    {
        return 'assets/$file';
    }

    // loading the spritesheets
	inline static public function getSpritesheet(key:String)
    {
        return FlxAtlasFrames.fromSparrow('assets/images/characters/$key.png', 'assets/images/characters/$key.xml');
    }

    // loading a background
    inline static public function dokiBG(key:String)
	{
		return getPath('images/bg/$key.png');
	}

    // loading a general image
    inline static public function image(key:String)
    {
        return getPath('images/$key.png');
    }

    // loading an image from the 'menus' directory
    inline static public function menuAsset(key:String)
    {
        return getPath('images/menus/$key.png');
    }

    inline static public function sounds(key:String)
    {
        return getPath('sounds/$key.ogg');
    }

    inline static public function music(key:String)
    {
        return getPath('music/$key.ogg');
    }
}
