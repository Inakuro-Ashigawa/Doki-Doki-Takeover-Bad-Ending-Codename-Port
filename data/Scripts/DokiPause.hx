//imports
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import PlayState;

//vars
var pauseCam = new FlxCamera();
var grpMenuShit:FlxTypedGroup;
var grpMenuShit = new FlxSpriteGroup();

var menuItems:Array<String>;
var pauseOG:Array<String> = [
    "Resume",
    "Restart Song",
    "Practice Mode",
    "Exit to Menu"
];
var difficultyChoices:Array<String> = ["Easy", "Normal", "Hard", "Back"];
var curSelected:Int = 0;

var curCharacter:Int = 0;
var deathInfo:Array<String> = ["Deleted", "Blue balled", "Pastad"];

var pauseMusic:FlxSound;

var levelInfo:FlxText;
var levelDifficulty:FlxText;
var deathText:FlxText;
var practiceText:FlxText;
var speedText:FlxText;
var globalSongOffset:FlxText;
var perSongOffset:FlxText;

var canPress:Bool = true;

var bg:FlxSprite;
var logo:FlxSprite;
var logoBl:FlxSprite;

var pauseArt:FlxSprite;

var isLibitina:Bool = false;
var isVallHallA:Bool = false;
var funni:Bool = false;

var itmColor:FlxColor = 0xFFFF7CFF;
var selColor:FlxColor = 0xFFFFCFFF;
var levelInfo:FlxText = new FlxText(20, 50, 0, PlayState.SONG.meta.displayName, 32);
var deathText:FlxText = new FlxText(20, 50, 0, "Blue balled: " + PlayState.deathCounter, 32);
var pauseTxt:FlxText = new FlxText(20, 50, 0, PlayState.difficulty, 32);
//not used...yet
//var botplayTxt:FlxText = new FlxText(20, 50, 0, "Botplay = " +  FlxG.save.data.botplayOption, 32);

function postCreate(){
}
function create(event){
    event.cancel();

    event.music = "PauseMusic";


    FlxG.cameras.add(pauseCam, false);

	pauseCam.bgColor = 0x88000000;
    pauseCam.alpha = 1;
    
    isLibitina = PlayState.SONG.meta.displayName == 'libitina';
    isVallHallA = PlayState.SONG.meta.displayName == 'drinks on me';

    Funni =  PlayState.SONG.meta.displayName == 'Suffering Siblings';

    bg = new FlxSprite(-FlxG.width * FlxG.camera.zoom,-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    bg.alpha = 0;
    bg.cameras = [pauseCam];
    bg.scrollFactor.set();
    add(bg);

    if (PlayState.isStoryMode)
        pauseOG = ["Resume", "Restart Song", "Exit to Menu"];

    menuItems = pauseOG;


    pauseArt = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('pause/' + PlayState.SONG.meta.pause));
    pauseArt.antialiasing = Options.Antialiasing;
    pauseArt.cameras = [pauseCam];
    add(pauseArt);

    if (isLibitina)
        pauseArt.x = -pauseArt.width;

    FlxTween.tween(pauseArt, {x: FlxG.width - pauseArt.width}, 1.2, {
        ease: FlxEase.quartInOut,
        startDelay: 0.2
    });

    if (Funni){
    FlxTween.tween(pauseArt, {x: FlxG.width - pauseArt.width - 100}, 1.2, {
        ease: FlxEase.quartInOut,
        startDelay: 0.2
    });

    FlxTween.tween(pauseArt, {alpha: 1}, 1.2, {
        ease: FlxEase.quartInOut,
        startDelay: 0.2
    });
        pauseArt.y += 150;
        pauseArt.x + 250;
        pauseArt.alpha = 0.0001;
    }

    levelInfo.text = PlayState.SONG.meta.displayName;
    levelInfo.antialiasing = Options.Antialiasing;
    levelInfo.scrollFactor.set();
    levelInfo.cameras = [pauseCam];
    levelInfo.setFormat(Paths.font("riffic.ttf"), 32, FlxColor.WHITE, "RIGHT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    levelInfo.borderSize = 1.9;
    levelInfo.updateHitbox();
    add(levelInfo);

    deathText.antialiasing = Options.Antialiasing;
    deathText.scrollFactor.set();
    deathText.setFormat(Paths.font("riffic.ttf"), 32, FlxColor.WHITE, "RIGHT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    deathText.borderSize = 1.9;
    deathText.cameras = [pauseCam];
    deathText.updateHitbox();

    if (PlayState.SONG.meta.displayName!= 'credits')
        add(deathText);

    pauseTxt.antialiasing = Options.Antialiasing;
    pauseTxt.scrollFactor.set();
    pauseTxt.setFormat(Paths.font("riffic.ttf"), 32, FlxColor.WHITE, "RIGHT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    pauseTxt.borderSize = 1.9;
    pauseTxt.cameras = [pauseCam];
    pauseTxt.updateHitbox();
    pauseTxt.screenCenter();
    add(pauseTxt);


    levelInfo.alpha = 0;
    deathText.alpha = 0;
    pauseTxt.alpha = 0;

    deathText.x = FlxG.width - (deathText.width + 20);
    levelInfo.x = FlxG.width - (levelInfo.width + 20);
    pauseTxt.x = FlxG.width - (pauseTxt.width + 20);

    FlxTween.tween(bg, {alpha: 0.6}, 1.3, {ease: FlxEase.quartInOut, type: 4});
    FlxTween.tween(levelInfo, {alpha: 1, y: 20 + -2}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
    FlxTween.tween(pauseTxt, {alpha: 1, y: deathText.y + 40}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
    FlxTween.tween(deathText, {alpha: 1, y: deathText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});

    
    if (isLibitina && PlayState.isStoryMode)
		{
			pauseArt.visible = false;
			levelInfo.visible = false;
		}

		logo = new FlxSprite(-260, 0).loadGraphic(Paths.image('Credits_LeftSide'));
		logo.antialiasing = Options.Antialiasing;
        logo.cameras = [pauseCam];
		add(logo);

		FlxTween.tween(logo, {x: -60}, 1.2, {
			ease: FlxEase.elasticOut
		});

		logoBl = new FlxSprite(-160, -40);
		logoBl.frames = Paths.getSparrowAtlas('DDLCStart_Screen_Assets');
		logoBl.antialiasing = Options.Antialiasing;
        logoBl.cameras = [pauseCam];
		logoBl.scale.set(0.5, 0.5);
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, true);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		add(logoBl);

		FlxTween.tween(logoBl, {x: 40}, 1.2, {
			ease: FlxEase.elasticOut
		});

        add(grpMenuShit);

		var textX:Int = 50;
		if (isVallHallA) textX += 25;

        for (i in 0...menuItems.length)
            {
                var songText:FlxText = new FlxText(-350, 370 + (i * 70), 0, menuItems[i].toLowerCase());
                songText.setFormat(Paths.font("Journal.ttf"), 27, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                songText.antialiasing = Options.antialiasing;
                songText.cameras = [pauseCam];
                songText.ID = i;
                grpMenuShit.add(songText);
    
                FlxTween.tween(songText, {x: textX}, 1.2 + (i * 0.2), {
                    ease: FlxEase.elasticOut
                });
            }
            changeSelection();
            cameras = [pauseCam];     
}
function update(elapsed:Float)
	{
        var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var leftP = FlxG.keys.pressed.SHIFT ? controls.LEFT : controls.LEFT_P;
		var rightP = FlxG.keys.pressed.SHIFT ? controls.RIGHT : controls.RIGHT_P;
		var accepted = controls.ACCEPT;
		var reset = controls.RESET;


        if (upP)
			changeSelection(-1);
		if (downP)
			changeSelection(1);

        if (accepted && canPress)
            {
                var daSelected:String = menuItems[curSelected];
    
                switch (daSelected)
                {
                    case "Resume":
                        close();
                    case "Restart Song":
                        parentDisabler.reset();
                        PlayState.instance.registerSmoothTransition();
                        FlxG.resetState();
                    case "Practice Mode":
                        FlxG.save.data.botplayOption = !FlxG.save.data.botplayOption;
                   case "Exit to Menu":
                    CoolUtil.playMenuSong();
                    FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
                }
            }
        }
        
    function changeSelection(change:Int = 0)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);
        
            curSelected = FlxMath.wrap(curSelected + change, 0, menuItems.length-1);
 
            grpMenuShit.forEach(function(txt:FlxText)
            {
                if (isLibitina)
                {
                    if (txt.ID == curSelected)
                        txt.setFormat(Paths.font("dos.ttf"), 27, FlxColor.WHITE, "LEFT");
                    else
 
                        txt.setFormat(Paths.font("dos.ttf"), 27, itmColor, "LEFT");
                }
                else if (isVallHallA)
                {
                    if (txt.ID == curSelected)
                        txt.setFormat(Paths.font("waifu.ttf"), 32, itmColor, "LEFT");

                    else
                        txt.setFormat(Paths.font("waifu.ttf"), 32, FlxColor.WHITE, "LEFT");
                }
                else
                {
                    if (txt.ID == curSelected)
                        txt.setFormat(Paths.font("riffic.ttf"), 40, selColor, "LEFT");
                    else
                        txt.setFormat(Paths.font("riffic.ttf"), 40, itmColor, "LEFT");
                }
            });
        }

    function regenMenu()
        {
            while (grpMenuShit.members.length > 0)
            {
                grpMenuShit.remove(grpMenuShit.members[0], true);
            }
    
            for (i in 0...menuItems.length)
            {
                var songText:FlxText = new FlxText(50, 370 + (i * 50), 0, menuItems[i]);
                songText.setFormat(Paths.font("riffic.ttf"), 27, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, 0xFFFF7CFF);
                songText.antialiasing = Options.Antialiasing;
                songText.ID = i;
                grpMenuShit.add(songText);
            }
    
            if (isLibitina)
            {
                grpMenuShit.forEach(function(txt:FlxText)
                {
                    txt.setBorderStyle(OUTLINE, FlxColor.WHITE, 1.25);
    
                    if (txt.ID == curSelected)
                        txt.setFormat(Paths.font("dos.ttf"), 27, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                    else
                        txt.setFormat(Paths.font("dos.ttf"), 27, itmColor, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                });
            }
            else if (isVallHallA)
            {
                grpMenuShit.forEach(function(txt:FlxText)
                {
                    txt.x += 25;
                    txt.y -= 75;
    
                    txt.setBorderStyle(OUTLINE, FlxColor.BLACK, 0);
                    txt.antialiasing = false;
    
                    if (txt.ID == curSelected)
                        txt.setFormat(Paths.font("waifu.ttf"), 32, itmColor, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                    else
                        txt.setFormat(Paths.font("waifu.ttf"), 32, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                });
            }
    
            curSelected = 0;
            changeSelection();
        }
    
function destroy() {
    FlxG.cameras.remove(cameras);
}
