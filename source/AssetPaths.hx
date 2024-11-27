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

    // loading general things
    inline static public function getGeneralSpritesheet(key:String)
    {
        return FlxAtlasFrames.fromSparrow('assets/images/$key.png', 'assets/images/$key.xml');
    }

    inline static public function image(key:String)
    {
        return getPath('images/$key.png');
    }

    // when you want to load an asset for a menu (animated)
    inline static public function getMenusSpritesheet(key:String)
    {
        return FlxAtlasFrames.fromSparrow('assets/images/menus/$key.png', 'assets/images/menus/$key.xml');
    }

        // when you want to load an asset for a menu (normal)
    inline static public function menuAsset(key:String)
    {
        return 'assets/images/menus/$key.png';
    }

    // these ones is for PlayState if you want to load a non-bg/character image    
    inline static public function getUIasset(key:String)
    {
        return getPath('images/ui/$key.png');
    }

    inline static public function getUISpritesheet(key:String)
    {
         return FlxAtlasFrames.fromSparrow('assets/images/ui/$key.png', 'assets/images/ui/$key.xml');
    }
        
    // loading animated characters/backgrounds
	inline static public function getSpritesheet(key:String)
    {
        return FlxAtlasFrames.fromSparrow('assets/images/characters/$key.png', 'assets/images/characters/$key.xml');
    }

	inline static public function getBGSpritesheet(key:String)
    {
         return FlxAtlasFrames.fromSparrow('assets/images/bg/$key.png', 'assets/images/bg/$key.xml');
    }

    // loading normal BGs and Characters
    inline static public function dokiBG(key:String)
	{
		return getPath('images/bg/$key.png');
	}

    inline static public function getStaticCharacter(key:String)
    {
        return getPath('images/characters/$key.png');
    }

    // self explanatory
    inline static public function sounds(key:String)
    {
        return getPath('sounds/$key.ogg');
    }

    inline static public function music(key:String)
    {
        return getPath('music/$key.ogg');
    }
}
