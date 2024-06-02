package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import sys.FileSystem;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class ChapterSelect extends FlxSubState
{
    public var chapterGRP:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
    public var stopSpamming:Bool = false;
    public static var typeOfShiz:String = " ";

    // information and data for all the chapters
    // chapter title, chapter description, frame to load, chapter number for PlayState to load the correct .hx file for that chapter
    // then finally, the color of the background
    public static var chapterInfo:Array<Array<Dynamic>> = [
        ["Monika's Introduction" , "Monika introduces you to Doki Doki Disc Engine.", "monika", 1],
        ["Ohayou, Sayori!" , "Sayori hangs out with you.", "sayori", 2],
        ["Book Time with Yuri" , "What do you do when you're shy and lonely? Read!", "yuri", 3],
        ["Natsuki Shenanigans" , "Is manga considered litereture?", "natsuki", 4]
    ];

    // same thing here but for side stories. NOTE: CHAPTER NUMBERS STILL HAVE TO BE DIFFERENT!
    // EG. you can't use chapter number 1 because it's already assigned to Monika's chapter
    public static var sideStoriesInfo:Array<Array<Dynamic>>= [
        ["Bima's Yapping" , "The lead coder has a message for you.....", 5, "null"]
    ];

    var curSelected:Int = 0;
    var hell:Int = 0;

    var chapterTitle:FlxText;
    var chapterDesc:FlxText;

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
                frame.x += hell * 1900;
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
                frame.x += hell * 1900;
                frame.ID = hell;
                chapterGRP.add(frame);
    
                hell += 1;
            }
        }
    
        chapterGRP.scale.set(1.6, 1.6);
        add(chapterGRP);

        chapterTitle = new FlxText(10, 10, 0, "test");
		chapterTitle.setFormat("assets/fonts/pixelFont.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		chapterTitle.size = 60;
        chapterTitle.screenCenter();
        chapterTitle.y -= 300;
        chapterTitle.alpha = 0;
        add(chapterTitle);

        FlxTween.tween(chapterTitle, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(chapterGRP, {"scale.x": 1.0, "scale.y": 1.0}, 0.5, {ease: FlxEase.circOut});

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (typeOfShiz == "start")
        {
            chapterTitle.text = chapterInfo[curSelected][0];
        }
        else {
            chapterTitle.text = sideStoriesInfo[curSelected][0];
        }
        
        chapterTitle.alignment = CENTER;
        chapterTitle.screenCenter(X);

        if (FlxG.keys.justPressed.LEFT && stopSpamming == false) {change(-1);}
        if (FlxG.keys.justPressed.RIGHT && stopSpamming == false) {change(1);}
        if (FlxG.keys.justPressed.BACKSPACE && stopSpamming == false) {
            stopSpamming = true;
            FlxTween.tween(chapterGRP, {"scale.x": 1.6, "scale.y": 1.6}, 0.5, {ease: FlxEase.circOut});
            FlxTween.tween(chapterTitle, {alpha: 0}, 0.5, {ease: FlxEase.circOut});

            new FlxTimer().start(4, function(timer:FlxTimer)
            {
                MenuState.undoTrans();
                close();
            });
        }
    
        super.update(elapsed);
    }

    public function change(change:Int)
    {
        stopSpamming = true;

        if (typeOfShiz == "start")
        {
            if (change == 1 && curSelected != chapterInfo.length - 1) 
            {
                FlxTween.tween(chapterGRP, {x: chapterGRP.x - 1900}, 0.2, {ease: FlxEase.circOut});
            }
            else if (change == -1 && curSelected != 0) 
            {
                FlxTween.tween(chapterGRP, {x: chapterGRP.x + 1900}, 0.2, {ease: FlxEase.circOut});
            }

            curSelected += change;
            if (curSelected < 0) {curSelected = 0;}
            else if (curSelected > chapterGRP.length - 1) {curSelected = chapterGRP.length - 1;}
        }
        else {
            if (change == 1 && curSelected != sideStoriesInfo.length - 1) 
            {
                FlxTween.tween(chapterGRP, {x: chapterGRP.x - 1900}, 0.2, {ease: FlxEase.circOut});
            }
            else if (change == -1 && curSelected != 0) 
            {
                FlxTween.tween(chapterGRP, {x: chapterGRP.x + 1900}, 0.2, {ease: FlxEase.circOut});
            }
            
            curSelected += change;
            if (curSelected < 0) {curSelected = 0;}
            else if (curSelected > sideStoriesInfo.length - 1) {curSelected = sideStoriesInfo.length - 1;}
        }

        new FlxTimer().start(0.2, function(timer:FlxTimer)
        {
            stopSpamming = false;
        });    
    }
}