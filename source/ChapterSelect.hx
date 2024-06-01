package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import sys.FileSystem;
import flixel.FlxSubState;

class ChapterSelect extends FlxSubState
{
    public var chapterGRP:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
    public var stopSpamming:Bool = false;
    public static var typeOfShiz:String = " ";

    // information and data for all the chapters
    // chapter title, chapter description, frame to load, chapter number for PlayState to load the correct .hx file for that chapter
    public var chapterInfo:Array<Array<Dynamic>> = [
        ["Monika's Introduction" , "Monika introduces you to Doki Doki Disc Engine.", "monika", 1],
        ["Ohayou Sayori!" , "Sayori hangs out with you.", "sayori", 2],
        ["Book Time with Yuri" , "What do you do when you're shy and lonely? Read!", "yuri", 3],
        ["Natsuki Shenanigans" , "Is manga considered litereture?", "natsuki", 4]
    ];

    // same thing here but for side stories. NOTE: CHAPTER NUMBERS STILL HAVE TO BE DIFFERENT!
    // EG. you can't use chapter number 1 because it's already assigned to Monika's chapter
    public var sideStoriesInfo:Array<Array<Dynamic>>= [
        ["Bima's Yapping" , "The lead coder has a message for you.....", 5]
    ];

    var curSelected:Int = 0;
    var hell:Int = 0;

    public function new()
    {
        super();
    }

    override public function create():Void
    {
        if (typeOfShiz == "start")
        {
            for (item in 0...chapterInfo.length)
            {
                var frame:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.menuAsset('chapter_select/frame_' + chapterInfo[hell][2]));
                if (sys.FileSystem.exists(AssetPaths.menuAsset('chapter_select/frame_' + chapterInfo[hell][2])))
                {
                   frame.loadGraphic(AssetPaths.menuAsset('chapter_select/frame_' + chapterInfo[hell][2]));
                }
                else {
                    frame.loadGraphic(AssetPaths.menuAsset('chapter_select/frame_null'));
                }
                frame.screenCenter();
                frame.x += hell * 1280;
                frame.ID = hell;
                chapterGRP.add(frame);
    
                hell += 1;
            }
        }
        else {
            for (item in 0...sideStoriesInfo.length)
            {
                var frame:FlxSprite = new FlxSprite();
                if (sys.FileSystem.exists(AssetPaths.menuAsset('chapter_select/frame_' + sideStoriesInfo[hell][2])))
                {
                   frame.loadGraphic(AssetPaths.menuAsset('chapter_select/frame_' + sideStoriesInfo[hell][2]));
                }
                else {
                    frame.loadGraphic(AssetPaths.menuAsset('chapter_select/frame_null'));
                }
                frame.screenCenter();
                frame.x += hell * 1280;
                frame.ID = hell;
                chapterGRP.add(frame);
    
                hell += 1;
            }
        }
    
        add(chapterGRP);
        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.LEFT) {curSelected -= 1;}
        if (FlxG.keys.justPressed.RIGHT) {curSelected += 1;}
        if (FlxG.keys.justPressed.BACKSPACE) {
            MenuState.undoTrans();
            close();
        }
    
        super.update(elapsed);
    }
}