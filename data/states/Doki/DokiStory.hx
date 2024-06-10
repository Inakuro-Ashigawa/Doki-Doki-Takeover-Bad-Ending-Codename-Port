//imports
import Takeover.LangUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.group.FlxGroup;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import StringTools;

//vars
var SaveData = FlxG.save.data;
var scoreText:FlxText;
var acceptInput:Bool = true;
var selectedSomethin:Bool = false;
var diffselect:Bool = false;
var curDifficulty:Int = 1;
var weekNames:Array<String> = [];
var txtWeekTitle:FlxText;
var txtTracklist:FlxText;
var curSelected:Int = 0;
var logo:FlxSprite;
var songlist:FlxSprite;
public static var showPopUp:Bool = false;
public static var popupType:String = 'Prologue';
var allBeat:Bool = false;
var story_cursor:FlxSprite;
var story_sidestories:FlxSprite;
var backdrop:FlxBackdrop;
var logoBl:FlxSprite;
var diff:FlxSprite;

//arrays
var weekData:Array<Dynamic> = [
    ['High School Conflict', 'Bara No Yume', 'Your Demise', 'Your Reality'],
    ['Rain Clouds', 'My Confession'],
    ['My Sweets', 'Baka'],
    ['Deep Breaths', 'Obsession'],
    ['Reconciliation'],
    ['Crucify (Yuri Mix)', 'Beathoven (Natsuki Mix)', "It's Complicated (Sayori Mix)", 'Glitcher (Monika Mix)'],
    ['Hot Air Balloon', 'Shrinking Violet', 'Joyride', 'Our Harmony'],
    ['NEET', 'You and Me', 'Takeover Medley'],
    ['Love n\' Funkin\'', 'Constricted', 'Catfight', 'Wilted']
];
//Ima make my life easier by being lazy
var icons:Array<Array<Dynamic>> = [	//internal file name, unlock condition, posX, posY
    ['Prologue', true, 394, 199],
    ['Sayori', SaveData.beatPrologue, 612, 199],
    ['Natsuki', SaveData.beatSayori, 832, 199],
    ['Yuri', SaveData.beatNatsuki, 1052, 199],
    ['Monika', SaveData.beatYuri, 394, 369],
    ['Festival', SaveData.beatMonika, 612, 369],
    ['Encore', SaveData.beatFestival, 832, 369],
    ['Protag', SaveData.beatEncore, 1052, 369],
    ['sideStories', SaveData.beatProtag, 0, 0]
];
//sprite groups
var grpSprites:FlxTypedGroup<FlxSprite>;
var grpSprites = new FlxTypedGroup();


function create(){

    allBeat = SaveData.checkAllSongsBeaten;
    SaveData.beatPrologue = false;
    SaveData.beatMonika = false;
for (i in 1...weekData.length + 1)
    weekNames.push('week' + i, 'story');



if (!FlxG.sound.music.playing)
    {
        FlxG.sound.playMusic(Paths.music('freakyMenu'));
        Conductor.changeBPM(120);
    }

    persistentUpdate = persistentDraw = true;


    backdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    backdrop.velocity.set(-40, -40);
    add(backdrop);

    logo = new FlxSprite(-60, 0).loadGraphic(Paths.image('Credits_LeftSide'));
    add(logo);

    songlist = new FlxSprite(-60, 0).loadGraphic(Paths.image('dokistory/song_list_lazy_smile'));
    add(songlist);

    logoBl = new FlxSprite(40, -40);
    logoBl.frames = Paths.getSparrowAtlas('DDLCStart_Screen_Assets');
    logoBl.scale.set(0.5, 0.5);
    logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
    logoBl.animation.play('bump');
    logoBl.updateHitbox();
    add(logoBl);

    txtWeekTitle = new FlxText(FlxG.width * 0.05, 0, 1000, "", 5);
    txtWeekTitle.setFormat(Paths.font("riffic.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFF860B0);
    txtWeekTitle.scale.set(1.2, 1.2);
    txtWeekTitle.updateHitbox();
    txtWeekTitle.x = 224;
    txtWeekTitle.y = 150;
    add(txtWeekTitle);

    txtTracklist = new FlxText(FlxG.width * 0.01, 50, 1000, "", 5);
    txtTracklist.setFormat(Paths.font("riffic.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFFFB9DD);
    txtTracklist.scale.set(.8, .8);
    txtTracklist.y += -2;
    txtTracklist.updateHitbox();
    txtTracklist.x = -230;
    txtTracklist.y = 400;
    add(txtTracklist);

    add(grpSprites);
    for (i in 0...icons.length)
		{
			if (i == 8)
				continue;

			var dirstuff:String = 'dokistory/' + icons[i][0] + 'Week';
			var story_icon:FlxSprite = new FlxSprite(icons[i][2], icons[i][3]);
			if (!icons[i][1])
				dirstuff = 'dokistory/LockedWeek';

			story_icon.frames = Paths.getSparrowAtlas(dirstuff);
			story_icon.scale.set(0.5, 0.5);
			story_icon.animation.addByPrefix('idle', 'idle', 20);
			story_icon.animation.play('idle');
			story_icon.updateHitbox();
			story_icon.ID = i;
			grpSprites.add(story_icon);
       }
       story_sidestories = new FlxSprite(395, 542);
       story_sidestories.frames = Paths.getSparrowAtlas('dokistory/SideStories');
       story_sidestories.animation.addByPrefix('idle', 'Side Stories0', 20);
       story_sidestories.animation.addByPrefix('selected', 'Side Stories Selected', 20, false);
       story_sidestories.animation.addByPrefix('highlighted', 'Side Stories highlighted', 20);
       story_sidestories.animation.play('idle');
       story_sidestories.ID = 8; // I'm gonna go ahead and force this ID rq
       story_sidestories.visible = false;
       add(story_sidestories);

       story_cursor = new FlxSprite(icons[curSelected][2], icons[curSelected][3]).loadGraphic(Paths.image('dokistory/cursor'));
       add(story_cursor);

       changeItem();
       updateText();
       unlockedWeeks();
       updateSelected();
}
function update(elapsed:Float){

    if (FlxG.sound.music.volume < 0.8)
        FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

    //idk what this does 

    if (FlxG.keys.pressed.CONTROL && (FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L))
		{
			trace('txtTracklist ' + txtTracklist.x + " X " + txtTracklist.y + ' y');
			if (FlxG.keys.pressed.I)
				txtTracklist.y += -10;
			else if (FlxG.keys.pressed.K)
				txtTracklist.y += 10;
			if (FlxG.keys.pressed.J)
				txtTracklist.x += -10;
			else if (FlxG.keys.pressed.L)
				txtTracklist.x += 10;

			trace('txtWeekTitle ' + txtWeekTitle.x + " X " + txtWeekTitle.y + ' y');
			if (FlxG.keys.pressed.I)
				txtWeekTitle.y += -10;
			else if (FlxG.keys.pressed.K)
				txtWeekTitle.y += 10;
			if (FlxG.keys.pressed.J)
				txtWeekTitle.x += -10;
			else if (FlxG.keys.pressed.L)
				txtWeekTitle.x += 10;
		}
    if (controls.LEFT_P)
        changeItem(4);
    if (controls.RIGHT_P)
        changeItem(-4);

    if (!selectedSomethin && acceptInput)
		{
    if (controls.BACK)
        {
            acceptInput = false;
            FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxG.switchState(new MainMenuState());
        }
        
        if (controls.ACCEPT)
            selectThing();
    }

    if (FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;
}

function selectThing()
	{
		if (curSelected == 8 && icons[curSelected][1])
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			openSubState(new DokiSideStory());
		}
		else if (icons[curSelected][1])
		{
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			goToState();
		}
	}

function goToState(){

    PlayState.storyPlaylist = weekData[curSelected];
    PlayState.storyDifficulty = curDifficulty;
    PlayState.isStoryMode = true;
    selectedSomethin = true;
    diffselect = false;

    switch (curSelected)
		{
			case 8:
				story_sidestories.y = 513;
				story_sidestories.animation.play('selected');
			default:
				grpSprites.forEach(function(hueh:FlxSprite)
				{
					if (curSelected == hueh.ID)
						FlxFlicker.flicker(hueh, 1, 0.06, false, false);
				});

				story_cursor.visible = false;
		}

        PlayState.loadWeek({
            name: "week1",
            id: "week1",
            sprite: null,
            chars: [null, null, null],
            songs: [for (song in weekData[curSelected]) {name: song, hide: false}],
            difficulties: ['hard']
        }, "hard");
        new FlxTimer().start(2, function(tmr:FlxTimer)
            {
                switch (curSelected)
                {
                    default:
                    FlxG.switchState(new PlayState());
                    new FlxTimer().start(2, function() {FlxG.switchState(new PlayState());});
                }
            });
            
}

function changeItem(huh:Int = 0)
	{
		var prevselected:Int = curSelected;
		curSelected += huh;

        curSelected = FlxMath.wrap(curSelected + huh, 0, icons.length-1);

		if (prevselected != curSelected)
			FlxG.sound.play(Paths.sound('scrollMenu'));

		if (!SaveData.beatFestival)
		{
          

			if (curSelected == 8)//Just incase this code breaks
				curSelected = 0;
		}
		else
		{
			// attempts to loop back into the bottom row
			if (curSelected == -4)
				curSelected = 8;
			if (curSelected == -3)
				curSelected = 8;
			if (curSelected == -2)
				curSelected = 8;
			if (curSelected == -1)
				curSelected = 8;

			// attempts to loop back into the top row
			if (curSelected == 9)
				curSelected = 8;
			if (curSelected == 10)
				curSelected = 8;
			if (curSelected == 11)
				curSelected = 8;

			if (curSelected >= 12)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = 12 - 1;
		}

		updateText();
		updateSelected();

		switch (curSelected)
		{
			case 5:
				txtWeekTitle.visible = SaveData.beatMonika;
				txtTracklist.visible = SaveData.beatFestival;
			case 6:
				txtWeekTitle.visible = SaveData.beatFestival;
				txtTracklist.visible = SaveData.beatEncore;
			case 7:
				txtWeekTitle.visible = SaveData.beatEncore;
				txtTracklist.visible = SaveData.beatProtag;
			case 9:
				txtWeekTitle.visible = false;
				txtTracklist.visible = false;
			default:
				trace(icons[curSelected][1]);
				txtWeekTitle.visible = icons[curSelected][1];
				txtTracklist.visible = icons[curSelected][1];
		}
		
	}

function updateSelected()
{
for (icon in grpSprites.members)
{
    if (icon.ID == curSelected)
    {
        icon.animation.play('idle');
        continue;
    }

    icon.animation.stop();
    icon.animation.frameIndex = -1;
}

if (curSelected != 8 && story_sidestories != null)
{
    story_sidestories.animation.play('idle');
    story_sidestories.animation.stop();
    story_cursor.visible = true;
}
else if(curSelected == 8 && story_sidestories != null)
{
    story_sidestories.animation.play('highlighted');
    story_cursor.visible = false;
}

story_cursor.setPosition(icons[curSelected][2], icons[curSelected][3]);
}

function unlockedWeeks()
{
if (SaveData.beatPrologue)
{
    SaveData.weekUnlocked = 2;
}
if (SaveData.beatSayori)
{
    SaveData.weekUnlocked = 3;
}
if (SaveData.beatNatsuki)
{
    SaveData.weekUnlocked = 4;
}
if (SaveData.beatYuri)
{
    SaveData.weekUnlocked = 5;
}
if (SaveData.beatMonika)
{
    SaveData.weekUnlocked = 6;
}
if (SaveData.beatFestival)
{
    SaveData.unlockedEpiphany = true;
    SaveData.weekUnlocked = 7;
}
if (SaveData.beatEncore)
{
    SaveData.weekUnlocked = 8;
}
if (SaveData.beatProtag)
{
    story_sidestories.visible = true;
    SaveData.weekUnlocked = 9;

}
if (SaveData.beatSide)
{
    SaveData.weekUnlocked = 10;
}
// are we doin one for side stories too?
// kinda
}
function updateText()
{
txtTracklist.text = "\n";
var stringThing:Array<String> = weekData[curSelected];

for (i in stringThing)
{
    if (i.toLowerCase() == "takeover medley")
        continue;

    if (i.toLowerCase() == "your reality" && !SaveData.beatPrologue)
        continue;

    txtTracklist.text += "\n" + i.split(" (")[0];
}

txtWeekTitle.text = weekNames[curSelected].toUpperCase();
txtTracklist.text = txtTracklist.text.toUpperCase();

txtTracklist.text += "\n";
}

function beatHit()
{
logoBl.animation.play('bump', true);
}
