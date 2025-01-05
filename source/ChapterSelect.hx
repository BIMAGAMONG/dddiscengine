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
import Mods;
import openfl.Lib;
import haxe.Json;
import lime.utils.Assets;
import Frame;
using StringTools;

class ChapterSelect extends FlxSubState
{
    public var chapterGRP:FlxTypedSpriteGroup<Frame> = new FlxTypedSpriteGroup<Frame>();
    public var stopSpamming:Bool = false;

    var curSelected:Int = 0;
    var hell:Int = 0;

    var chapterTitle:FlxText;
    var chapterDesc:FlxText;

    // loading the mod folder shiz
    var curMod:ChapterData;
    var chapterJson:Array<String>;

    public function new()
    {
        super();
    }

    override public function create():Void
    {
        for (daMod in 0...Mods.folderList.length)
        {
            curMod = Json.parse(Assets.getText("mods/" + Mods.folderList[daMod] + "/chapters.json"));
            trace("CURRENT MOD LOADED: " + Mods.folderList[daMod]);

            for (item in 0...curMod.chapters.length)
            {
                var splitArrayLoading:Array<String> = curMod.chapters[item].split(":");
                var path:String = 'mods/' + Mods.folderList[daMod] + '/images/chapter_select/frame_' + splitArrayLoading[2] + '.png';

                trace("CURRENT MOD CHAPTERS: " + curMod.chapters);
                trace("LOADING FRAME: " + path);

                var frame:Frame = new Frame();
                if (sys.FileSystem.exists(path)) {frame.loadGraphic(path);}
                else {frame.loadGraphic(AssetPaths.menuAsset('frame_null'));}
                frame.screenCenter();
                frame.x += hell * 1900;
                frame.ID = hell;
                frame.modOrigin = curMod.chapters[item] + ":" + Mods.folderList[daMod];
                chapterGRP.add(frame);
                hell += 1;
            }
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
                FlxTween.tween(chapterDesc, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
    
                new FlxTimer().start(1, function(timer:FlxTimer)
                {
                    MenuState.undoTrans();
                    close();
                });
            }
    
            if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed) {
                stopSpamming = true;
                for (item in chapterGRP.members)
                {
                    if (item.ID == curSelected)
                    {
                        var grabChapterData:Array<String> = item.modOrigin.split(":");
                        PlayState.textFileName = grabChapterData[3]; 
                        PlayState.modPrefix = grabChapterData[4];
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