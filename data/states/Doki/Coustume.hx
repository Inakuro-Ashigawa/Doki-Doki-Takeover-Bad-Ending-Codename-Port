import haxe.Json;
import lime.utils.Assets;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.group.FlxGroup.FlxTypedGroup;
import StringTools;

var menuItems:FlxTypedGroup;
var menuItems = new FlxSpriteGroup();

var CostumeData = {
    name: "string",
    spritePos: [0, 0],
    atlas: "string",
    prefix: "string",

    // THESE ARE OPTIONAL, NOT NEEDED TO BE ADDED
    looped: true,
    frames: 0,
    scale: [0, 0]
};

var CostumeCharacter = {
    characters: "string"
};
function setColorUniform(obj:Dynamic, color:Int) {
    obj.value = [(color >> 16 & 0xFF) / 255, (color >> 8 & 0xFF) / 255, (color & 0xFF) / 255];
}
var curSelected:Int = 0;
var costumeSelected:Int = 0;
var hueh:Int = 0;
var chara:FlxSprite;
var grpControls:FlxTypedGroup<FlxText>;
var grpControlshueh:FlxTypedGroup<FlxText>;
var selectingcostume:Bool = false;
var logo:FlxSprite;

var flavorBar:FlxSprite;
var backdrop:FlxBackdrop;
var logoBl:FlxSprite;
var costumeLabel:FlxText;
var controlLabel:FlxText;
var flavorText:FlxText;

var colorTween1:FlxSprite = new FlxSprite(-9000, -9000).makeGraphic(1, 1, 0xFFFDFFFF);
var colorTween2:FlxSprite = new FlxSprite(-9000, -9000).makeGraphic(1, 1, 0xFFFDDBF1);
var colorShader = new CustomShader("ColorMaskShader");
var character:Array<String> = ['bf', 'gf', 'monika', 'sayori', 'natsuki', 'yuri', 'protag'];
var costumeUnlocked:Array<Dynamic> = [
    // Boyfriend
    [
        true, // Uniform, unlocked by default
        true, // Regular, unlocked by default
        true, // Minus, unlocked by default
        true, // Soft, save check for Soft Mod or mirror mode It's complicated with festy costume
        true,// Mr. Cow, save checks for DDLC. If you played this mod and don't have this unlocked then I am extremely dissappointed in you.
        true, // Blue Skies, 90% Accuracy on Your Demise
        true, // HoloFunk, unlocked by clicking on sticker
    ],
    // Girlfriend
    [
        true, // Uniform, unlocked by default
        true, // Regular, unlocked by default
        true, // Minus, unlocked by default
        true,// Soft Pico, save check for Soft Mod or mirror mode It's complicated with festy costume
        true, // Blue Skies, play Love n' Funkin' on Mirror Mode
        true,// HoloFunk, unlocked by clicking on sticker
        true // TBD-tan, beat Libitina
    ],
    // Monika
    [
        true, // Uniform, unlocked by default
        true, // Casual, unlocked by default
        true, // valentine, unlocks if Epiphany with Lyrics is beaten
        true, // Festival, unlocks if Glitcher (Hard) is 90%+ accuracy
        true,
        true,
        true,
    ],
    // Sayori
    [
        true, // Uniform, unlocked by default
        true, // Casual, unlocked by default
        true,
        true,
        true,
        true,
        true,
    ],
    // Natsuki
    [
        true, // Uniform, unlocked by default
        true, // Casual, unlocked by default
        true, // Skater, choose Natsuki on You and Me
        true, // Festival, unlocks if Beathoven (Hard) is 90%+ accuracy
        true,
        true, // Antipathy, unlocked by clicking on artwork
        true
    ],
    // Yuri
    [
        true, // Uniform, unlocked by default
        true, // Casual, unlocked by default
        true,
        true,
        true,
        true,
        true
    ],
    // Protag
    [
        true, // Uniform, unlocked by default
        true, // Casual, unlocked by default
        true,
        true,// Henry, unlocks if Titular is 90%+ accuracy
        true // Blue Skies, fail You and Me by not picking a doki
    ]
];
var costumeJSON = Json.parse(Assets.getText(Paths.json('costumeData')));

function create(){
    FlxG.sound.playMusic(Paths.music('disco'), 0.4);
    Conductor.changeBPM(124);




    trace("Costume JSON cannot be found. \n" + costumeJSON);

    backdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    backdrop.velocity.set(-40, -40);
    backdrop.antialiasing = Options.Antialiasing;
    backdrop.shader = new CustomShader("ColorMaskShader");
    setColorUniform(backdrop.shader.data.color1, 0xFFFDEBF7);
    setColorUniform(backdrop.shader.data.color2, 0xFFFDDBF1);
    add(backdrop);

    chara = new FlxSprite(522, 9).loadGraphic(Paths.image('costume/bf'));
    chara.scale.set(0.7, 0.7);
    chara.updateHitbox();
    add(chara);

    flavorBar = new FlxSprite(0, 605).makeGraphic(1280, 63, 0xFFFF8ED0);
    flavorBar.alpha = 0.4;
    flavorBar.screenCenter(FlxAxes.X);
    flavorBar.scrollFactor.set();
    flavorBar.visible = false;
    add(flavorBar);

    flavorText = new FlxText(354, 608, 933, "I'm a test, this is for scale!", 40);
    flavorText.scrollFactor.set(0, 0);
    flavorText.setFormat(Paths.font("riffic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    flavorText.borderSize = 2;
    flavorText.borderQuality = 1;
    flavorText.visible = false;
    add(flavorText);

    logo = new FlxSprite(-60, 0).loadGraphic(Paths.image('Credits_LeftSide'));
    add(logo);

    logoBl = new FlxSprite(40, -40);
    logoBl.frames = Paths.getSparrowAtlas('DDLCStart_Screen_Assets');
    logoBl.scale.set(0.5, 0.5);
    logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
    logoBl.animation.play('bump');
    logoBl.updateHitbox();
    add(logoBl);

    grpControls = new FlxTypedGroup();
    add(grpControls);

    for (i in 0...costumeJSON.list.length)
		{
			var id:String = costumeJSON.list[i].id;

			controlLabel = new FlxText(60, (40 * i) + 370, 0, id, 3);
            controlLabel.setFormat(Paths.font("riffic.ttf"), 38, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, 0xFFFF7CFF);
			controlLabel.scale.set(0.7, 0.7);
			controlLabel.updateHitbox();
            controlLabel.antialiasing = true;
			controlLabel.ID = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

    changeItem();

}
function changeItem(huh:Int = 0){
    FlxG.sound.play(Paths.sound('scrollMenu'));

    curSelected = FlxMath.wrap(curSelected + huh, 0, character.length-1);

    var daChoice:String = character[curSelected];

    if (!selectingcostume)
    {
        chara.color = 0xFFFFFF;
        loadcharacter(daChoice);
    }

    grpControls.forEach(function(txt:FlxText)
    {
        if (txt.ID == curSelected)
            txt.setFormat(Paths.font("riffic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFFFCFFF);

        else
            txt.setFormat(Paths.font("riffic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFFF7CFF);
    });
}
function changecostume(huh:Int = 0, goingforward:Bool = true)
	{
		var daChoice:String = character[curSelected];
        var daSelection = costumeJSON.list[curSelected];
		FlxG.sound.play(Paths.sound('scrollMenu'));
		costumeSelected += huh;


        curSelected = FlxMath.wrap(costumeSelected + hueh, 0,  daSelection.costumes.length-1);


		// Checking for data string value
        var selection = costumeJSON.list[curSelected].costumes[costumeSelected];
		if (selection.data == '')
			loadcharacter(daChoice, 'hueh')
		else
			loadcharacter(daChoice, selection.data);

		if (costumeUnlocked[curSelected][costumeSelected])
			chara.color = 0xFFFFFF;
		else
			chara.color = 0x000000;

		if (grpControlshueh != null)
		{
			grpControlshueh.forEach(function(txt:FlxText)
			{
                if (txt.ID == costumeSelected)
                    txt.setFormat(Paths.font("riffic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFFFCFFF);
        
                else
                    txt.setFormat(Paths.font("riffic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFFFF7CFF);
			});
		}
	}

function loadcharacter(char:String, ?costume:String, ?forceColor:FlxColor = 0xFFFDDBF1)
{
    //I'm pissed, gotta throw this here too cause offsets break due to the costumeoverride being blank
    //trace(costume);
    var charCostume:String = costume;
    if (charCostume == '' || charCostume == null)
    {
        switch (char)
        {
            case 'protag':
                charCostume = SaveData.protagcostume;
            case 'monika':
                charCostume = SaveData.monikacostume;
            case "yuri":
                charCostume = SaveData.yuricostume;
            case 'sayori':
                charCostume = SaveData.sayoricostume;
            case 'natsuki':
                charCostume = SaveData.natsukicostume;
            case 'gf':
                charCostume = SaveData.gfcostume;
            case 'bf':
                charCostume = SaveData.bfcostume;
        }
    }

    var barColor:FlxColor = forceColor;

    if (costumeJSON.list[curSelected].costumes[costumeSelected].color != null && forceColor == 0xFFFDDBF1)
        barColor = FlxColor.fromString(costumeJSON.list[curSelected].costumes[costumeSelected].color);

    var goku:FlxColor = FlxColor(200,30, 100);

    if (charCostume != null && charCostume != 'hueh' && charCostume != '')
        chara.loadGraphic(Paths.image('costume/' + char + '-' + charCostume));
    else
        chara.loadGraphic(Paths.image('costume/' + char));

    if (costumeUnlocked[curSelected][costumeSelected])
    {
        // JSON array is always ordered, so should be fine
        var nameText:String = costumeJSON.list[curSelected].costumes[costumeSelected].name;
        var descText:String = costumeJSON.list[curSelected].costumes[costumeSelected].desc;

        // Descriptions for hidden costumes
        switch (char)
        {
            case 'natsuki':
            {
                switch (charCostume)
                {
                    case 'buff':
                        nameText = 'nameBuff';
                        descText = 'descBuff_NA';
                }
            }
            case 'bf':
            {
                switch (charCostume)
                {
                    case 'sutazu':
                        nameText = 'nameSutazu';
                        descText = 'descSutazu';
                }
            }
            case 'gf':
            {
                switch (charCostume)
                {
                    case 'sayo':
                        nameText = 'charSayo';
                        descText = 'descSayoGF';
                }
            }
            case 'sayori':
            {
                switch (charCostume)
                {
                    case 'minus':
                        nameText = 'nameMinus';
                        descText = 'descMinus_SA';
                }
            }
            case 'protag':
            {
                switch (charCostume)
                {
                    case 'fanon':
                        nameText = 'nameFanon';
                        descText = 'descFanon';
                }
            }
            flavorText.text = descText;
        }

        if (grpControlshueh != null && grpControlshueh.members[costumeSelected].text != nameText)
            grpControlshueh.members[costumeSelected].text = nameText;

        flavorText.text = descText;
    }
    else
    {
        var text:String = '';

        // Checking unlock value if its null or not
        if (costumeJSON.list[curSelected].costumes[costumeSelected].unlock != null)
            text = costumeJSON.list[curSelected].costumes[costumeSelected].unlock;
        else
            text = "Unlocked by default.";

        flavorText.text = 'cmnLock' + ": " + text;
    }
}
function costumeselect(goku:Bool)
	{
		var daChoice:String = character[curSelected];

		if (goku)
		{
			flavorText.visible = true;
			flavorBar.visible = true;

			FlxG.sound.play(Paths.sound('confirmMenu'));

			var daSelection = costumeJSON.list[curSelected];
			trace(daSelection);

			grpControlshueh = new FlxTypedGroup();
			add(grpControlshueh);

			for (i in 0...daSelection.costumes.length)
			{
				hueh = daSelection.costumes.length;

				if (costumeUnlocked[curSelected][i])
				{
					var label:String = daSelection.costumes[i].name;
					costumeLabel = new FlxText(60, (40 * i) + 370, 0, label, 3);
				}
				else
				costumeLabel = new FlxText(60, (40 * i) + 370, 0, "???", 3);

                costumeLabel.setFormat(Paths.font("riffic.ttf"), 38, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, 0xFFFF7CFF);
				costumeLabel.scale.set(0.7, 0.7);
				costumeLabel.updateHitbox();
				costumeLabel.ID = i;
				grpControlshueh.add(costumeLabel);

			}

			costumeSelected = 0;
			selectingcostume = true;
			grpControls.visible = false;

			changecostume();
		}
		else
		{
			flavorText.visible = false;
			flavorBar.visible = false;
			remove(grpControlshueh);
			costumeSelected = 0;
			selectingcostume = false;
			grpControls.visible = true;

			chara.color = 0xFFFFFF;
			loadcharacter(daChoice);
		}
	}


function update(elapsed){

 if (FlxG.mouse.pressed && !selectingcostume)
    {
        trace(flavorText.x + " and " + flavorText.y);
        flavorText.x = (FlxG.mouse.x - flavorText.width / 2);
        flavorText.y = (FlxG.mouse.y - flavorText.height);
    }

    if (FlxG.mouse.pressed && selectingcostume)
    {
        trace(chara.x + " and " + chara.y);
        chara.x = (FlxG.mouse.x - chara.width / 2);
        chara.y = (FlxG.mouse.y - chara.height);
    }


    if (controls.UP_P && !selectingcostume)
    {
        changeItem(-1);
    }

    if (controls.DOWN_P && !selectingcostume)
    {
        changeItem(1);
    }

    if (controls.DOWN_P && selectingcostume)
    {
        changecostume(1, true);
    }

    if (controls.UP_P && selectingcostume)
    {
        changecostume(-1, false);
    }
    if (controls.BACK && !selectingcostume)
    {
        selectedSomethin = true;
        FlxG.sound.music.stop();
        FlxG.switchState(new MainMenuState());
        FlxG.sound.play(Paths.sound('cancelMenu'));
    }
    if (controls.BACK && selectingcostume)
    {
        FlxG.sound.play(Paths.sound('cancelMenu'));
        costumeselect(false);
        
        // Initial bug is that, if you have a selected character, but
        // try to select a locked character, and then hit ESC, the
        // selected character is rendered black
        // This fix should hopefully resolve it.

        if (chara.color == 0x000000)
            chara.color = 0xFFFFFF;
    }
    if (controls.ACCEPT)
        if (!selectingcostume)
            costumeselect(true);
        else
            savecostume();
}
function savecostume()
{
    var daChoice:String = character[curSelected];
    var colorthingie:FlxColor = 0xFFFDDBF1;

    // For a better way of getting data value
    var selection = costumeJSON.list[curSelected].costumes[costumeSelected];
    if (costumeUnlocked[curSelected][costumeSelected])
    {
        switch (curSelected)
        {
            case 6:
                SaveData.protagcostume = selection.data;

                if (costumeSelected == 0 && FlxG.keys.pressed.B)
                    SaveData.protagcostume = "fanon";
            case 5:
                SaveData.yuricostume = selection.data;
            case 4:
                SaveData.natsukicostume = selection.data;

                if (costumeSelected == 0 && FlxG.keys.pressed.B)
                    SaveData.natsukicostume = "buff";
            case 3:
                SaveData.sayoricostume = selection.data;

                if (costumeSelected == 0 && FlxG.keys.pressed.B)
                    SaveData.sayoricostume = "minus";
            case 2:
                SaveData.monikacostume = selection.data;

                if (costumeSelected == 1 && (controls.LEFT || controls.RIGHT))
                    SaveData.monikacostume = "casuallong";
            case 1:
                SaveData.gfcostume = selection.data;
                
                if (costumeSelected == 0 && FlxG.keys.pressed.B && SaveData.beatCatfight)
                {
                    colorthingie = 0xFF94D9FA;
                    SaveData.gfcostume = "sayo";
                }
                    
                if (costumeSelected == 1 && (controls.LEFT || controls.RIGHT))
                    SaveData.gfcostume = "christmas";
            default:
                SaveData.bfcostume = selection.data;

                // Variations
                if (costumeSelected == 0 && FlxG.keys.pressed.B)
                {
                    colorthingie = 0xFFFFADD7;
                    SaveData.bfcostume = "sutazu";
                }
                if (costumeSelected == 1 && (controls.LEFT || controls.RIGHT))
                    SaveData.bfcostume = "christmas";
                if (costumeSelected == 2 && controls.LEFT)
                {
                    colorthingie = 0xFFF8F4C1;
                    SaveData.bfcostume = "minus-yellow";
                }
                if (costumeSelected == 2 && controls.RIGHT)
                {
                    colorthingie = 0xFFBFE6FF;
                    SaveData.bfcostume = "minus-mean";
                }
                if (costumeSelected == 3 && (controls.LEFT || controls.RIGHT))
                    SaveData.bfcostume = "soft-classic";
                if (costumeSelected == 6 && (controls.LEFT || controls.RIGHT))
                    SaveData.bfcostume = "aloe-classic";
        }
        chara.color = 0xFFFFFF;
        loadcharacter(daChoice, colorthingie);

        if (daChoice == "natsuki" && costumeSelected == 0 && SaveData.natsukicostume == "buff")
            FlxG.sound.play(Paths.sound('buff'));
        else
            FlxG.sound.play(Paths.sound('confirmMenu'));
    }
}
function beatHit(){
    logoBl.animation.play('bump', true);
}