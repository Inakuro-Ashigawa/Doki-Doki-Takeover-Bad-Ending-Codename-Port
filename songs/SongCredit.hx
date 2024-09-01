import flixel.text.FlxTextBorderStyle;

var defaultIcon: String = 'mic';
var defaultArtist: String = 'Kawaii Sprite';
var defaultTimer: Float = 3;
var defaultStep: Array<Float> = [1, 5];
var defaultBeat: Array<Float> = [1, 2.5];

var songTag:String;
var songIcon:String;
var songArtist:String;
var showTimer:Bool;
var timerData:Float;
var showStep:Bool;
var stepData:Array<Float>;
var showBeat:Bool;
var beatData:Array<Float>;
var metaName:FlxText;
var metaArtist:FlxText;
var metaIcon:FlxSprite;
var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;

function create(){
    var metaData = true;
    var hasMeta = true;

    var isPixelStage = PlayState.isPixelStage;
    var stageUI = PlayState.stageUI;
    var isPixel = isPixelStage || stageUI == 'pixel';

    if (hasMeta) {
        songTag = PlayState.SONG.meta.displayName;
        songIcon = "mic";
        songArtist = PlayState.SONG.meta.defaultArtist;

        showTimer = PlayState.SONG.meta.time;
        timerData = PlayState.SONG.meta.defaulttime;

        showStep = PlayState.SONG.meta.showStep;
        stepData = PlayState.SONG.meta.defaultStep;

        showBeat = PlayState.SONG.meta.showBeat;
        beatData = PlayState.SONG.meta.defaultBeat;
    } else {
        songTag = songName;
        songIcon = defaultIcon;
        songArtist = defaultArtist;

        showTimer = false;
        timerData = defaultTimer;

        showStep = false;
        stepData = defaultStep;

        showBeat = false;
        beatData = defaultBeat;
    }

    metaName = new FlxText(1900, 20, 0, "", 36);
    metaName.setFormat(Paths.font("vcr.ttf"), 36, colouredBar, "right");
    metaName.borderStyle = FlxTextBorderStyle.OUTLINE;
    metaName.borderColor = FlxColor.BLACK;
    metaName.text = songTag;
    metaName.scrollFactor.set();
    metaName.cameras = [camHUD];
    metaName.antialiasing = !isPixel;

    if (songIcon != 'None') {
        createIcon('metaIcon', songIcon);
        metaIcon.scale.set(0.35, 0.35);
        metaIcon.alpha = 1;
        setPosition(metaIcon, FlxG.width - (metaName.width) + 470, 15 - (metaIcon.height / 2) + 16);
        metaIcon.cameras = [camHUD];
    }

    metaArtist = new FlxText(-328, 38, 0, "", 20);
    metaArtist.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "right");
    metaArtist.borderStyle = FlxTextBorderStyle.OUTLINE;
    metaArtist.borderColor = FlxColor.BLACK;
    metaArtist.alpha = 1;
    metaArtist.text = songArtist;
    metaArtist.cameras = [camHUD];
    metaArtist.scrollFactor.set();
    metaArtist.antialiasing = !isPixel;

    add(metaName);
    if (songIcon != 'None') add(metaIcon);
    add(metaArtist);
}
function onSongStart(){
    tweenIn();  

    new FlxTimer().start(3, function(tmr:FlxTimer) {
        tweenOut();
    });
}
function tweenIn(){
    FlxTween.tween(metaName, {alpha: 1, x: 1000}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
    FlxTween.tween(metaIcon, {alpha: 1, x: 900}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
    FlxTween.tween(metaArtist, {alpha: 1, x: 200}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.4});
}

function tweenOut(){
    FlxTween.tween(metaName, {alpha: 0, x: 0}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
    if (songIcon != 'None') {
        FlxTween.tween(metaIcon, {alpha: 0, x: 0 - (metaIcon.height / 2) + 6}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
    }
    FlxTween.tween(metaArtist, {alpha: 0, x: 38}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
}

function setPosition(tag: FlxObject, x: Float, y: Float){
    x = x != null ? x : tag.x;
    y = y != null ? y : tag.y;
    tag.x = x;
    tag.y = y;
}

function setTextFormat(tag: FlxText, font: String, size: Int, color: Int, alignment: String){
    tag.setFormat(font, size, color, alignment);
}

function createIcon(tag: String, icon: String, crop: Bool = false){
    metaIcon = new FlxSprite().loadGraphic(Paths.image('icons/' + icon));
}