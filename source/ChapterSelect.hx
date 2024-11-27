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

import openfl.Lib;
import haxe.Json;
import lime.utils.Assets;
using StringTools;

typedef ChapterData =
{
	chapters:Array<String>
}

class ChapterSelect extends FlxSubState
{
    
    public var chapterGRP:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
    public var stopSpamming:Bool = false;

    // all data from chapters.json is pushed in here
    var chapter:ChapterData;
    var chapterInfo:Array<String> = [];

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
        chapter = Json.parse(Assets.getText("assets/data/chapters.json"));
        chapterInfo = chapter.chapters;

        for (item in 0...chapterInfo.length)
        {
            var splitArray:Array<String> = chapterInfo[hell].split(":");

            var frame:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.menuAsset('chapter_select/frame_' + splitArray[2]));
            if (sys.FileSystem.exists(AssetPaths.menuAsset('chapter_select/frame_' + splitArray[2])))
            {
                frame.loadGraphic(AssetPaths.menuAsset('chapter_select/frame_' + splitArray[2]));
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
        chapterGRP.scale.set(1.6, 1.6);
        add(chapterGRP);

        chapterTitle = new FlxText(10, 10, 0, "");
		chapterTitle.setFormat("assets/fonts/pixelFont.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		chapterTitle.size = 60;
        chapterTitle.screenCenter();
        chapterTitle.y -= 300;
        chapterTitle.alpha = 0;
        add(chapterTitle);

        chapterDesc = new FlxText(10, 10, 0, "");
		chapterDesc.setFormat("assets/fonts/pixelFont.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		chapterDesc.size = 60;
        chapterDesc.screenCenter();
        chapterDesc.y += 300;
        chapterDesc.alpha = 0;
        add(chapterDesc);

        FlxTween.tween(chapterTitle, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(chapterDesc, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(chapterGRP, {"scale.x": 1.0, "scale.y": 1.0}, 0.5, {ease: FlxEase.circOut});

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (!stopSpamming)
        {
            if (FlxG.keys.justPressed.LEFT) {change(-1);}
            if (FlxG.keys.justPressed.RIGHT) {change(1);}
            if (FlxG.keys.justPressed.BACKSPACE) {
                stopSpamming = true;
                FlxTween.tween(chapterGRP, {"scale.x": 1.6, "scale.y": 1.6}, 0.5, {ease: FlxEase.circOut});
                FlxTween.tween(chapterTitle, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
    
                new FlxTimer().start(4, function(timer:FlxTimer)
                {
                    MenuState.undoTrans();
                    close();
                });
            }
    
            if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed) {
                stopSpamming = true;
                var splitArray:Array<String> = chapterInfo[curSelected].split(":");
                PlayState.textFileName = splitArray[3];
                FlxG.switchState(new PlayState());
            }
        }
    
        super.update(elapsed);
    }

    public function change(change:Int)
    {
        curSelected += change;
        if (curSelected < 0) {curSelected = 0;}
        else if (curSelected > chapterGRP.length - 1) {curSelected = chapterGRP.length - 1;}

        var splitArray:Array<String> = chapterInfo[curSelected].split(":");
        chapterTitle.text = splitArray[0];
        chapterDesc.text = splitArray[1];

        chapterTitle.alignment = CENTER;
        chapterTitle.screenCenter(X);
        chapterDesc.alignment = CENTER;
        chapterDesc.screenCenter(X);

        FlxTween.tween(chapterGRP, {x: -(1900 * curSelected)}, 0.2, {ease: FlxEase.circOut});
    }
}