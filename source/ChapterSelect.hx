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
    modname:String,
    chapters:Array<String>
}

class ChapterSelect extends FlxSubState
{
    public var chapterGRP:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
    public var stopSpamming:Bool = false;

    var curSelected:Int = 0;
    var hell:Int = 0;

    var chapterTitle:FlxText;
    var chapterDesc:FlxText;
    var curMod:ChapterData;
    var chapterJson:Array<String>;

    public function new()
    {
        super();
    }

    override public function create():Void
    {
        for (item in 0...Mods.folderList.length)
        {
            curMod = Json.parse(Assets.getText("mods/" + folderList[item] + "/chapters.json"));
            var splitArray:Array<String> = curMod.chapters[item].split(":");
            var frame:FlxSprite = new FlxSprite();
            if (sys.FileSystem.exists('mods/' + curMod + '/images/chapter_select/frame_' + splitArray[2] + '.png')) {
                frame.loadGraphic('mods/' + curMod + '/images/chapter_select/frame_' + splitArray[2] + '.png');
            }
            else {
                frame.loadGraphic(AssetPaths.menuAsset('frame_null'));
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
		chapterTitle.size = 50;
        chapterTitle.screenCenter();
        chapterTitle.y -= 300;
        chapterTitle.alpha = 0;
        add(chapterTitle);

        chapterDesc = new FlxText(10, 10, 0, "");
		chapterDesc.setFormat("assets/fonts/pixelFont.ttf", FlxColor.WHITE, CENTER, OUTLINE, FlxColor.MAGENTA);
		chapterDesc.size = 50;
        chapterDesc.screenCenter();
        chapterDesc.y += 300;
        chapterDesc.alpha = 0;
        add(chapterDesc);

        FlxTween.tween(chapterTitle, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(chapterDesc, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(chapterGRP, {"scale.x": 1.0, "scale.y": 1.0}, 0.5, {ease: FlxEase.circOut});
        change(0);

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
                for (item in 0...Mods.chapterList.length)
                {
                    if (item == curSelected)
                    {
                        var splitArray:Array<String> = Mods.chapterList[item].split(":");
                        PlayState.textFileName = splitArray[3];
                    }
                }
                for (item in 0...Mods.folderList.length)
                {
                    if (item == curSelected)
                    {
                        var splitArray:Array<String> = Mods.folderList[item].split(":");
                        PlayState.modPrefix = splitArray[item];
                    }
                }
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

        for (item in 0...Mods.chapterList.length)
        {
            if (item == curSelected)
            {
                var splitArray:Array<String> = Mods.chapterList[item].split(":");
                chapterTitle.text = splitArray[0];
                chapterDesc.text = splitArray[1];
            }
        }

        chapterTitle.alignment = CENTER;
        chapterTitle.screenCenter(X);
        chapterDesc.alignment = CENTER;
        chapterDesc.screenCenter(X);

        FlxTween.tween(chapterGRP, {x: -(1900 * curSelected)}, 0.2, {ease: FlxEase.circOut});
    }
}