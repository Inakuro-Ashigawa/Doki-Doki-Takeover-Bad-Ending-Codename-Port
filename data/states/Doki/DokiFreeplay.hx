import flixel.FlxG;
import flixel.FlxCamera;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import haxe.Json;
import flixel.effects.FlxFlicker;
import flixel.addons.transition.FlxTransitionableState;

import StringTools;

var songs:Array<SongMetadata> = [];
var menu_character:FlxSprite;
var selector:FlxText;

var acceptInput:Bool = true;

var showPopUp:Bool = false;
var popupType:String = '';
var allBeat:Bool = false;

var curSelected:Int = 0;
var curPage:Int = 0;
var pageFlipped:Bool = false;

var curDifficulty:Int = 1;
var diffType:Int = 0;
var diffselect:Bool = false;
var diff:FlxSprite;
var diffsuffix:String = '';

var scoreText:FlxText;
var lerpScore:Float = 0;
var intendedScore:Float = 0;

var bg:FlxSprite;

var songPlayback:FlxSprite;
var modifierMenu:FlxSprite;
var costumeSelect:FlxSprite;

var grpSongs:FlxTypedGroup;


var curPlaying:Bool = false;

var iconArray:Array<HealthIcon> = [];

var songData:Map<String, Array<SwagSong>> = [];


var singleDiff:Array<String> = [ //Change to multiple difficulties
    'your reality',
    'you and me',
    'takeover medley',
    'libitina',
    'erb'
];

var multiDiff:Array<String> = [
    'epiphany',
    'baka',
    'shrinking violet',
    'love n funkin'
];
function loadDiff(diff:Int, name:String, array:Array<SwagSong>){
}
function create(){
    FlxG.camera.bgColor = FlxColor.BLACK;

    if (!FlxG.sound.music.playing && !SaveData.cacheSong)
    {
        FlxG.sound.playMusic(Paths.music('freakyMenu'));
        Conductor.changeBPM(120);
    }
    if (pageFlipped)
        FlxG.sound.play(Paths.sound('flip_page'));

    var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplay/Page' + (curPage + 1)));
    trace(initSonglist);

    for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			var meta = new SongMetadata(data[0], Std.parseInt(data[2]), data[1]);

			if (meta.songName.toLowerCase() == 'erb') // accessible through easter egg only
				continue;

			if (meta.songName.toLowerCase() == 'drinks on me' && !SaveData.beatVA11HallA)
				continue;

			var diffs = [];
			loadDiff(0, meta.songName, diffs);
			loadDiff(1, meta.songName, diffs);
			loadDiff(2, meta.songName, diffs);
			songData.set(meta.songName, diffs);

			if ((Std.parseInt(data[2]) <= SaveData.weekUnlocked - 1) || (Std.parseInt(data[2]) == 1))
				songs.push(meta);
		}
        bg = new FlxSprite().loadGraphic(Paths.image('freeplay/freeplaybook' + (curPage + 1)));
		add(bg);

        for (i in 0...songs.length)
            {
                var icon:HealthIcon = new HealthIcon(songs[i].songCharacter, false, false);
                iconArray.push(icon);
                icon.x = 1060;
                icon.y = 550;
                icon.scale.set(1.6, 1.6);
                icon.angle = 30;
    
                if ((curPage == 1 && !SaveData.beatEncore)
                    || (curPage == 3 && !SaveData.beatEpiphany)
                    || curPage == 4)
                {
                }
                else
                {
                    add(icon);
                }
            }

            grpSongs = new FlxTypedGroup();
            add(grpSongs);

            scoreText = new FlxText(442, 56, 0, "", 8);
            scoreText.setFormat(Paths.font("halogen"), 29, FlxColor.BLACK, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
            add(scoreText);
    
            if (curPage == 4)
            {
                scoreText.x = 360;
                scoreText.setFormat(Paths.font("grotesk"), 29, 0xFF821F8E, "LEFT");
            }
            menu_character = new FlxSprite(40, 490);
            if (curPage != 3)
            {
                menu_character.frames = Paths.getSparrowAtlas('freeplay/chibidorks');
                menu_character.animation.addByPrefix('idle', 'FreeplayChibiIdle', 24, false);
                menu_character.animation.addByPrefix('pop_off', 'FreeplayChibiCheer', 24, false);
            }
            else
            {
                menu_character.x += 40;
                menu_character.frames = Paths.getSparrowAtlas('freeplay/moni');
                menu_character.animation.addByPrefix('idle', 'FreeplayChibiEpiphanyIdle', 24, false);
                menu_character.animation.addByPrefix('pop_off', 'FreeplayChibiEpiphanyCheer', 24, false);
            }
            menu_character.scale.set(1.1, 1.1);
            menu_character.updateHitbox();
            menu_character.animation.play('idle');
    
            if (curPage != 4)
                add(menu_character);

            diff = new FlxSprite(453, 580);
            diff.frames = Paths.getSparrowAtlas('dokistory/difficulties');
            diff.animation.addByPrefix('regular', 'diff_reg', 24);
            diff.animation.addByPrefix('lyrics', 'diff_lyrics', 24);
            diff.animation.addByPrefix('alt', 'diff_alt', 24);
            diff.updateHitbox();
            diff.visible = false;
            add(diff);

            for (i in 0...songs.length)
            {
                var metadata:Song.SwagMetadata = null;
                var songName = songs[i].songName;
                var songFolderPath:String = "songs/" + songs[i].songName.toLowerCase();
                var metadataFilePath:String = songFolderPath + "/charts/hard"+ ".json";

                metadata = Json.parse(Assets.getText(metadataFilePath));
            
            var songText:FlxText = new FlxText(442, 116 + (i * 47.5), 500, songs[i].songName, 9);
            scoreText.setFormat(Paths.font("halogen.otf"), 29, FlxColor.BLACK, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
			songText.borderColor = 0xFFFF7FEE;
			songText.ID = i;
            songText.antialiasing = true;
			grpSongs.add(songText);

			if (curPage == 3)
			{
				songText.x = 588;
				songText.y = 395;
			}
			else if (curPage == 4)
			{
				songText.x = 588;
				songText.y = 360;
			}
            if (curPage == 1 && !SaveData.beatEncore)
            {
            }
            else
            {
                changeItem(0);
                changeDiff(0);
            }
        }
		songPlayback = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/extra/preview'));
		songPlayback.setGraphicSize(Std.int(songPlayback.width * 0.6));
		songPlayback.updateHitbox();
		songPlayback.x = (FlxG.width - songPlayback.width) - 10;
		songPlayback.y += 10;

		if (!SaveData.cacheSong)
		{
			add(songPlayback);
		}

		modifierMenu = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/extra/modifiers'));
		modifierMenu.setGraphicSize(Std.int(modifierMenu.width * 0.6));
		modifierMenu.updateHitbox();
		modifierMenu.x = (FlxG.width - modifierMenu.width) - 10;
		modifierMenu.y += modifierMenu.height + 10;
		add(modifierMenu);

		if (SaveData.cacheSong)
			modifierMenu.y -= modifierMenu.height;

		costumeSelect = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/extra/costume'));
		costumeSelect.setGraphicSize(Std.int(costumeSelect.width * 0.6));
		costumeSelect.updateHitbox();
		costumeSelect.x = (FlxG.width - costumeSelect.width) - 10;
		costumeSelect.y += modifierMenu.y + modifierMenu.height + 10;
        add(costumeSelect); 

    }
function getSongData(songName:String, diff:Int)
	{
		var suffixChanged = false;

		if (!multiDiff.contains(songName.toLowerCase()))
			diff = 1;


		if (suffixChanged)
			diffsuffix = "-alt";
	}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
var selectedSomethin:Bool = false;

function update(elapsed){
    if (controls.UP_P && !diffselect && (curPage != 3 && curPage != 4))
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(-1);
        }
        if (controls.DOWN_P && !diffselect && (curPage != 3 && curPage != 4))
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(1);
        }
        if (FlxG.keys.justPressed.SPACE && !selectedSomethin && !SaveData.cacheSong)
            playSong();

        if (controls.LEFT_P && diffselect)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDiff(-1);
        }
        if (controls.LEFT_P && !diffselect)
            changePageHotkey(-1, false);

        if (controls.RIGHT_P && !diffselect)
            changePageHotkey(1, false);

        if (controls.RIGHT_P && diffselect)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDiff(1);
        }

        if (FlxG.keys.justPressed.F7 && SaveData.unlockedEpiphany)
            loadSong(true);

        if (controls.ACCEPT && songs.length >= 1)
        {
            selectSong();
        }
        if (controls.BACK) FlxG.switchState(new MainMenuState());

}
function loadSong(isCharting:Bool = false){
    PlayState.isStoryMode = false;
    canControl = false;
    var songLowercase:String = songs[curSelected].songName.toLowerCase();
    PlayState.loadSong(songLowercase, "hard");
    new FlxTimer().start(1, function(tmr:FlxTimer) { 
        FlxG.switchState(new PlayState()); 
    });
}

function startsong(){
    pageFlipped = false;
    selectedSomethin = true;
    FlxG.sound.play(Paths.sound('confirmMenu'));
    menu_character.y -= 31;
    menu_character.animation.play('pop_off');
    grpSongs.forEach(function(spr:FlxSprite)
    {
        if (curSelected != spr.ID)
        {
            FlxTween.tween(spr, {alpha: 0}, 1.3, {
                ease: FlxEase.quadOut,
                onComplete: function(twn:FlxTween)
                {
                    spr.kill();
                }
            });
        }
        else
        {
            if (SaveData.flashing)
            {
                FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                {
                    loadSong();
                });
            }
            else
            {
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    loadSong();
                });
            }
        }
    });
}
function selectSong(){
		if (diffselect && multiDiff.contains(songs[curSelected].songName.toLowerCase()))
		{
			if (diffType == 1)
				curDifficulty = 1;

			startsong();
			return;
		}

		if (multiDiff.contains(songs[curSelected].songName.toLowerCase()))
		{
			switch (songs[curSelected].songName.toLowerCase())
			{
				case 'epiphany':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					diffType = 0;
					diff.visible = true;
					diffselect = true;
				case 'baka' | 'shrinking violet' | 'love n funkin':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					diffType = 1;
					diff.visible = true;
					diffselect = true;
				default:
					startsong();
			}
		}
		else
		{
			curDifficulty = 1;
			if (songs[curSelected].songName.toLowerCase() == 'catfight')
				openSubState(new CatfightPopup('freeplay'));
			else
				startsong();
		}
	}

function playSong(){
	FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), SaveData.cacheSong ? 0 : 1);
}
function changeDiff(change:Int = 0):Void{
    diffsuffix = '';
    curDifficulty += change;

    if (curDifficulty <= 0)
        curDifficulty = 2;
    if (curDifficulty > 2)
        curDifficulty = 1;

    switch (curDifficulty)
    {
        case 2:
            trace('hard');
            diff.animation.play((diffType == 0 ? 'lyrics' : 'alt'));
            if (diffType == 1) diffsuffix = '-alt';
        case 1:
            trace('normal');
            diff.animation.play('regular');
    }

    getSongData(songs[curSelected].songName + diffsuffix, curDifficulty);
}
function changeItem(huh:Int = 0) {
    curSelected += huh;

    if (curSelected >= songs.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = songs.length - 1;

    curDifficulty = 1;
    changeDiff();

    // Update song data based on the new selection
    var songName = songs[curSelected].songName;
    var songFolderPath:String = "songs/" + songName.toLowerCase();
    var metadataFilePath:String = songFolderPath + "/charts/hard.json";

    try {
        var metadata = Json.parse(Assets.getText(metadataFilePath));
        songData.set(songName, [/* Update with new difficulty data */]);
    } catch (e:Dynamic) {
        trace("Error loading metadata: " + e);
    }

    // Other update logic...

    if (SaveData.cacheSong) {
        if (FlxG.sound.music != null) {
            FlxG.sound.music.stop();
            FlxG.sound.music.destroy();
            FlxG.sound.music = null;
        }

        playSong();
    }

    // Update icons and text formatting
    for (i in 0...iconArray.length) {
        iconArray[i].alpha = (i == curSelected) ? 1 : 0;
    }

    for (item in grpSongs.members) {
        if (item.ID != curSelected)
            item.setFormat(Paths.font("halogen.otf"), 29, 0x00FF7FEE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        else
            item.setFormat(Paths.font("halogen.otf"), 40, 0xFFFF7FEE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    }
}
import haxe.ds.StringMap;

function updateSongs():Void {
    // Clear previous song data
    songs = [];
    
    var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplay/Page' + (curPage + 1)));
    trace(initSonglist);

    for (i in 0...initSonglist.length) {
        var data:Array<String> = initSonglist[i].split(':');
        var meta = new SongMetadata(data[0], Std.parseInt(data[2]), data[1]);

        if (meta.songName.toLowerCase() == 'erb') continue;
        if (meta.songName.toLowerCase() == 'drinks on me' && !SaveData.beatVA11HallA) continue;

        var diffs = [];
        loadDiff(0, meta.songName, diffs);
        loadDiff(1, meta.songName, diffs);
        loadDiff(2, meta.songName, diffs);
        songData.set(meta.songName, diffs);

        if ((Std.parseInt(data[2]) <= SaveData.weekUnlocked - 1) || (Std.parseInt(data[2]) == 1)) {
            songs.push(meta);
        }
    }
    
    changeItem(0);
}

function updateDisplay(){
    grpSongs.clear();
    iconArray = [];

    for (i in 0...songs.length) {
        var icon:HealthIcon = new HealthIcon(songs[i].songCharacter, false, false);
        iconArray.push(icon);
        icon.x = 1060;
        icon.y = 550;
        icon.scale.set(1.6, 1.6);
        icon.angle = 30;

        if ((curPage == 1 && !SaveData.beatEncore) || (curPage == 3 && !SaveData.beatEpiphany) || curPage == 4) {
        } else {
            add(icon);
        }

        var songText:FlxText = new FlxText(442, 116 + (i * 47.5), 500, songs[i].songName, 9);
        songText.setFormat(Paths.font("halogen.otf"), 29, FlxColor.BLACK, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        songText.borderColor = 0xFFFF7FEE;
        songText.ID = i;
        songText.antialiasing = true;
        grpSongs.add(songText);
    }
}

function changePage(huh:Int = 0){
    pageFlipped = true;
    curSelected = 0;
    curPage += huh;
    
    if (curPage >= 4)
        curPage = 0;
    if (curPage < -1)
        curPage = 4 - 1;

    bg.loadGraphic(Paths.image('freeplay/freeplaybook' + (curPage + 1)));
    updateSongs(); 


    changeItem(0);
    updateDisplay();

}
function changePageHotkey(page:Int, directPage:Bool = true){
    if (directPage)
    {
        pageFlipped = true;
        curSelected = 0;
        curPage = page;
    }
    else
        changePage(page);
}