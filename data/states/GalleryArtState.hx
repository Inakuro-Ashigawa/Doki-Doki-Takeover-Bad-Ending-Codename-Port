//imports
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import StringTools;
//vars
var curSelected:Int = 0;
var backdrop:FlxBackdrop;
var gradient:FlxSprite;
var switchState:FlxSprite;
var artwork:FlxSprite;
var authorText:FlxText;
var galleryData:Array<String> = Assets.getText(Paths.txt('galleryData'));
var artworkData:Array<String> = [];
var authorData:Array<String> = [];
var urlData:Array<String> = [];
var dontSpam:Bool = false;

function create(){
    FlxG.sound.playMusic(Paths.music('sayoc'));
    Conductor.changeBPM(110);

    persistentUpdate = persistentDraw = true;

    for (i in 0...galleryData.length)
    {
        if (!StringTools.startsWith(galleryData[i], '//')) continue;
        var data:Array<String> = galleryData[galleryData.length].split('::');

        artworkData.push(data[0]);
        authorData.push(data[1].replace("\\n", "\n"));
        urlData.push(data[2]);
    }

    backdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    backdrop.velocity.set(-16, 0);
    backdrop.scale.set(0.5, 0.5);
    backdrop.antialiasing = Options.Antialiasing;
    add(backdrop);

    gradient = new FlxSprite(0, 0).loadGraphic(Paths.image('gradient'));
    gradient.antialiasing = Options.Antialiasing;
    gradient.color = 0xFF46114A;
    add(gradient);
    
    artwork = new FlxSprite(0, 0).loadGraphic(Paths.image('Fumo'));
    artwork.antialiasing = Options.Antialiasing;
    add(artwork);

    switchState = new FlxSprite(0, 0).loadGraphic(Paths.image('sticker'));
    switchState.setGraphicSize(Std.int(switchState.width * 0.5));
    switchState.updateHitbox();
    switchState.x = (FlxG.width - switchState.width) - 10;
    switchState.y += 10;
    switchState.antialiasing = Options.Antialiasing;
    add(switchState);

    authorText = new FlxText(0, 0, 0, "", 8);
    authorText.antialiasing = Options.Antialiasing;
    add(authorText);

    changeItem();
}
function update(elapsed:Float)
	{
		if (FlxG.sound.music != null && FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxG.switchState(new MainMenuState());
		}

		if (controls.LEFT_P)
			changeItem(-1);

		if (controls.RIGHT_P)
			changeItem(1);

		if (controls.ACCEPT)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			CoolUtil.openURL(urlData[curSelected]);
		}

		if (FlxG.mouse.overlaps(artwork) && FlxG.mouse.pressed && artworkData[curSelected].contains('antipathy') && !dontSpam)
		{
			FlxG.camera.fade(FlxColor.WHITE, 1, true, true);
			FlxG.sound.play(Paths.sound('antipathyUnlock'));
			SaveData.unlockAntipathyCostume = true;
			dontSpam = true;
		}

		if (FlxG.keys.justPressed.S)
			MusicBeatState.switchState(new GalleryStickerState());

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

	}
function changeItem(huh:Int = 0)
{
    FlxG.sound.play(Paths.sound('scrollMenu'));

    curSelected += huh;

    if (curSelected >= galleryData.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = galleryData.length - 1;

    artwork.loadGraphic(Paths.image('gallery/' + artworkData[curSelected]));
    artwork.setGraphicSize(0, Std.int(FlxG.height * 0.8));
    artwork.updateHitbox();

    if (artwork.width > FlxG.width)
        artwork.setGraphicSize(Std.int(FlxG.width * 0.9));

    artwork.updateHitbox();
    artwork.screenCenter();
    artwork.y -= 30;

    authorText.text = authorData[curSelected] + '\n';
    authorText.screenCenter();
    authorText.y = artwork.y + artwork.height + 15;

    dontSpam = false;
}
function beatHit(){}