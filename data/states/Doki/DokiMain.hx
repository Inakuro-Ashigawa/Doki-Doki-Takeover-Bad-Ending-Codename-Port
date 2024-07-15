// "important" imports 
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.MusicBeatState;


//imports
import flixel.FlxG;
import flixel.FlxObject;
import haxe.Json;
import lime.utils.Assets;
import flixel.FlxSprite;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.group.FlxGroup.FlxTypedGroup;

//shaders
var ColorMaskShader = new CustomShader('ColorMaskShader');

//vars
var curSelected:Int = 0;

var show:String = "";
var menuItems:FlxTypedGroup;
var menuItems = new FlxSpriteGroup();
var optionShit:Array<String> = ['story mode', 'freeplay', 'gallery', 'credits', 'options', 'exit'];
var firstStart:Bool = true;
var acceptInput:Bool = true;
var logo:FlxSprite;
var menu_character:FlxSprite;
var shaker:FlxSprite;
var addVally:Bool = false;
var backdrop:FlxBackdrop;
var logoBl:FlxSprite;

var menuCharacterData = {
    name: "string",
    spritePos: [0, 0],
    atlas: "string",
    prefix: "string",

    // THESE ARE OPTIONAL, NOT NEEDED TO BE ADDED
    looped: true,
    frames: 0,
    scale: [0, 0]
};

// reading data is the same way

function setColorUniform(obj:Dynamic, color:Int) {
    obj.value = [(color >> 16 & 0xFF) / 255, (color >> 8 & 0xFF) / 255, (color & 0xFF) / 255];
}

var menuCharJSON = Json.parse(Assets.getText(Paths.json('menuCharacters')));

function create(){


    backdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    backdrop.velocity.set(-10, 0);
    backdrop.antialiasing = Options.Antialiasing;
    backdrop.shader = new CustomShader("ColorMaskShader");
    setColorUniform(backdrop.shader.data.color1, 0xFFFDEBF7);
    setColorUniform(backdrop.shader.data.color2, 0xFFFDDBF1);
    add(backdrop);
    

    var jsonFound:Bool = true;
    var twenty:Array<String> = ['together1', 'yuri', 'natsuki', 'sayori', 'pixelmonika', 'senpai'];
    var ten:Array<String> = ['sunnat', 'yuritabi', 'minusmonikapixel', 'yuriken', 'sayominus', 'cyrixstatic', 'zipori', 'nathaachama'];
    var two:Array<String> = ['fumo'];

    if (FlxG.save.data.beatFestival)
        twenty.push('protag');

    if (FlxG.save.data.beatMonika)
    {
        ten.push('deeppoems');
        ten.push('akimonika');
        ten.push('indiehorror');
    }

    var random:Float =  FlxG.random.float(0, 1);
    
    if (random < 0.60) // 60% chance
        show = selectMenuCharacter(twenty);
    else if (random >= 0.60 && random < 0.98) // 38% chance
        show = selectMenuCharacter(ten);
    else // 2% chance 
        show = selectMenuCharacter(two);

    for (char in menuCharJSON.characters)
        {
            if (char.name == show)
            {
                // Found the character in the menuCharacter.json file
                trace('found' + show + 'with' + random);
                menu_character = new FlxSprite(char.spritePos[0], char.spritePos[1]);
                menu_character.frames = Paths.getSparrowAtlas(char.atlas);
                if (char.scale != null)
                    menu_character.scale.set(char.scale[0], char.scale[1]);
                menu_character.animation.addByPrefix('play', char.prefix, 
                    (char.frames != null ? char.frames : 24), (char.looped != null ? char.looped : false));
                // Break the for loop so we can move on from this lol
                break;
            }
        }


    if (menu_character == null)
    {
        // Just gotta use the default together asset if that for-loop doesn't work
        trace("For loop didn't work. Oh well!");
        menu_character = new FlxSprite(490, 50);
        menu_character.frames = Paths.getSparrowAtlas("menucharacters/dokitogetheralt");
        menu_character.scale.set(0.77, 0.77);
        menu_character.animation.addByPrefix('play', "Doki together club", 21, false);
    }
    menu_character.antialiasing = Options.Antialiasing;
    menu_character.updateHitbox();
    menu_character.animation.play('play');
    add(menu_character);

    logo = new FlxSprite(-260, 0).loadGraphic(Paths.image('Credits_LeftSide'));
    logo.antialiasing = Options.Antialiasing;
    add(logo);
    if (firstStart)
        FlxTween.tween(logo, {x: -60}, 1.2, {
            ease: FlxEase.elasticOut,
            onComplete: function(flxTween:FlxTween)
            {
                firstStart = false;
                changeItem();
            }
        });
    else
        logo.x = -60;

    logoBl = new FlxSprite(-160, -40);
    logoBl.frames = Paths.getSparrowAtlas('DDLCStart_Screen_Assets');
    logoBl.antialiasing = Options.Antialiasing;
    logoBl.scale.set(0.5, 0.5);
    logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
    logoBl.animation.play('bump');
    logoBl.updateHitbox();
    add(logoBl);
    if (firstStart)
        FlxTween.tween(logoBl, {x: 40}, 1.2, {
            ease: FlxEase.elasticOut,
            onComplete: function(flxTween:FlxTween)
            {
                firstStart = false;
                changeItem();
            }
        });
    else
        logoBl.x = 40;


    add(menuItems);

    for (i in 0...optionShit.length)
    {
        var menuItem:FlxText = new FlxText(-350, 370 + (i * 50), 0, optionShit[i]);
        menuItem.setFormat(Paths.font("riffic.ttf"), 27, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        //menuItem.setFormat(Paths.font("riffic"), 27, FlxColor.WHITE, "left");
        menuItem.antialiasing = Options.Antialiasing;
        menuItem.ID = i;
        menuItems.add(menuItem);

        if (firstStart)
            FlxTween.tween(menuItem, {x: 50}, 1.2 + (i * 0.2), {
                ease: FlxEase.elasticOut,
                onComplete: function(flxTween:FlxTween)
                {
                    firstStart = false;
                    changeItem();
                }
            });
        else
            menuItem.x = 50;

        // Add menu item into mouse manager, so it can be selected by cursor
    }

    shaker = new FlxSprite(1132, 538);
    shaker.frames = Paths.getSparrowAtlas("shaker");
    shaker.animation.addByPrefix('play', "Shaker", 21, false);
    shaker.antialiasing = Options.Antialiasing;
    shaker.animation.play('play');
    if (addVally)
        add(shaker);



    changeItem(0);

}

function update(elapsed:Float){
    if (FlxG.sound.music.volume < 0.8)
        FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

    if (controls.UP_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(-1);
        }
            
    if (controls.DOWN_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(1);
        }	
    if (controls.ACCEPT)
        {
            goToState();
        }	

    if (FlxG.keys.justPressed.SEVEN) {
        openSubState(new EditorPicker());
        persistentUpdate = false;
        persistentDraw = true;
    }
    if (FlxG.keys.justPressed.FOUR){
        FlxG.switchState(new ModState("Doki/Coustume"));
    }
    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
}
function changeItem(huh:Int = 0)
	{
		//curSelected += huh;
        curSelected = FlxMath.wrap(curSelected + huh, 0, optionShit.length-1);
        

		menuItems.forEach(function(txt:FlxText)
		{
			if (txt.ID == curSelected)
                
                txt.setFormat(Paths.font("riffic.ttf"), 27, 0xFFFFCFFF, "LEFT");
			else
                txt.setFormat(Paths.font("riffic.ttf"), 27, 0xFFFF7CFF, "LEFT");
		});
	}
function selectThing()
        {
            acceptInput = false;
            selectedSomethin = true;
            FlxG.sound.play(Paths.sound('confirmMenu'));
    
            menuItems.forEach(function(txt:FlxText)
            {
                if (curSelected != txt.ID)
                {
                    FlxTween.tween(txt, {alpha: 0}, 1.3, {
                        ease: FlxEase.quadOut,
                        onComplete: function(twn:FlxTween)
                        {
                            txt.kill();
                        }
                    });
                }
                else
                {
                    if (FlxG.save.data.flashing)
                    {
                        FlxFlicker.flicker(txt, 1, 0.06, false, false, function(flick:FlxFlicker)
                        {
                            goToState();
                        });
                    }
                    else
                    {
                        new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            goToState();
                        });
                    }
                }
            });
        }

function goToState()
    {
        var daChoice:String = optionShit[curSelected];

        switch (daChoice)
        {
            case 'story mode':
                FlxG.switchState(new StoryMenuState());
                trace("Story Menu Selected");
            case 'freeplay':
                FlxG.switchState(new FreeplayState());
                trace("Freeplay Menu Selected");
            case 'credits':
                FlxG.switchState(new CreditsState());
                trace("Credits Menu Selected");
            case 'gallery':
                FlxG.switchState(new ModState("GalleryArtState"));
                trace("La Galeria Selected");
            case 'options':
                FlxG.switchState(new OptionsMenu());
            case 'exit':
                //openSubState(new CloseGameSubState());
        }
    }
function beatHit()
{
    logoBl.animation.play('bump', true);

    if (!menu_character.animation.curAnim.looped && curBeat % 2 == 0)
        menu_character.animation.play('play', true);

    if (shaker != null)
        shaker.animation.play('play');
}
function selectMenuCharacter(array:Array<String>):String
	{
		var index:Int = 0;
		if (array.length >= 2)
         index = array[FlxG.random.float(array.length)];

		var char:String = '';
		switch (array[index])
		{
			default:
				char = array[index];
			case 'together1':
				if (FlxG.save.data.beatMonika)
					char = 'together';
			case 'pixelmonika':
				if (FlxG.save.data.beatMonika)
					char = 'monika';
		}

		// Just in case I messed something up
		if (char == '')
		{
			if (FlxG.save.data.beatMonika) char = 'together';
			else char = 'together1';
			return char;
		}

		return char;
	}