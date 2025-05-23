package;
import Sys;
import sys.FileSystem;
import haxe.Json;
import lime.utils.Assets;
import flixel.util.FlxArrayUtil;

typedef ChapterData =
{
    modname:String,
	chapters:Array<String>
}

class Mods
{
    public static var chapterList:Array<String> = [];
    public static var folderList:Array<String> = [];

    public static function loadMods()
    {
        chapterList = [];
        folderList = sys.FileSystem.readDirectory("mods");

        if (folderList != [])
        {
            for (item in 0...folderList.length)
            {
                var jsonFile:ChapterData = Json.parse(Assets.getText("mods/" + folderList[item] + "/chapters.json"));
                for (chapter in 0...jsonFile.chapters.length)
                {
                    chapterList.push(jsonFile.chapters[chapter]);
                }
            }
        }
        trace("Mods loaded: " + folderList);
        trace("Chapters loaded: " + chapterList);
    }
}