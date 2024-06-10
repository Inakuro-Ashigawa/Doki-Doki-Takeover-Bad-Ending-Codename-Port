import flixel.addons.display.FlxBackdrop;
var blackScreen:FlxSprite;
var redStatic = new FlxSprite();
public var pixelNotesForBF = true;
public var pixelNotesForDad = true;
var stageVER:Int = 0;
var stageFront = new FlxSprite(50,-200).loadGraphic(Paths.image('weeb/FinaleFG'));
var bg = new FlxSprite(100,-200).loadGraphic(Paths.image('weeb/FinaleBG_2'));
var space = new FlxBackdrop(Paths.image('weeb/FinaleBG_1'));
public var pixelSplashes = true;
public var enablePixelUI = true;
public var enablePixelGameOver = true;
public var enableCameraHacks = Options.week6PixelPerfect;
public var enablePauseMenu = true;
public var isSpooky = false;
static var daPixelZoom = 6;
var aberration:CustomShader = null;

function onNoteCreation(event) {
	if (event.note.strumLine == playerStrums && !pixelNotesForBF) return;
	if (event.note.strumLine == cpuStrums && !pixelNotesForDad) return;

	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/score/pixelUI/NOTE_assetsENDS'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('game/score/pixelUI/NOTE_assets'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(daPixelZoom, daPixelZoom);
	note.updateHitbox();
}

function onPostNoteCreation(event) {
	var splashes = event.note;
	if (pixelSplashes)
		splashes.splash = "Doki-pixel";
}

function onStrumCreation(event) {
	if (event.player == 1 && !pixelNotesForBF) return;
	if (event.player == 0 && !pixelNotesForDad) return;

	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/score/pixelUI/NOTE_assets'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.scale.set(daPixelZoom, daPixelZoom);
	strum.updateHitbox();
}

function create(){
Pixle = true;

space = new FlxBackdrop(Paths.image('weeb/FinaleBG_1'));
space.scrollFactor.set(0.1, 0.1);
space.velocity.set(-10, 0);
space.scale.set(1.65, 1.65);
space.alpha = 0.01;
add(space);


bg.antialiasing = false;
bg.scrollFactor.set(0.4, 0.6);
bg.scale.set(2.3, 2.3);
bg.alpha = 0.01;
add(bg);

stageFront.antialiasing = false;
space.scrollFactor.set(1, 1);
stageFront.scale.set(1.5, 1.5);
stageFront.alpha = 0.01;
add(stageFront);


evilbg = new FlxSprite(400,100);
evilbg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
evilbg.antialiasing = Options.antialiasing;
evilbg.scrollFactor.set(.8,.9);
evilbg.antialiasing = false;
evilbg.animation.addByPrefix('idle', 'background 2 instance 1', 24, true);
evilbg.animation.play('idle');
evilbg.scale.set(6,6);
evilbg.alpha = 1;
add(evilbg);

remove(boyfriend);
remove(dad);

blackScreen = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
    -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
blackScreen.scrollFactor.set();

}

function postCreate(){

redStatic.frames = Paths.getSparrowAtlas('HomeStatic');
redStatic.cameras = [camHUD];
redStatic.setGraphicSize(FlxG.width, FlxG.height);
redStatic.screenCenter();
redStatic.animation.addByPrefix('static', 'HomeStatic', 24, true);
redStatic.animation.play('static');
redStatic.alpha = 0.001;
add(redStatic);

add(boyfriend);
add(dad);

add(blackScreen);
blackScreen.alpha = 0.0001;
}
function stepHit(curStep){
    switch (curStep)
    {
        case 1:
        if (blackScreen != null) FlxTween.tween(blackScreen, {alpha: 0.001}, 0.1, {ease: FlxEase.sineOut});
        case 264:
            blackScreen.alpha = 1;
        case 328:
            blackScreen.alpha = 0.001;
            evilswap(1);
        case 585:
            defaultCamZoom = 1.3;
            evilswap(2);
        case 616:
            defaultCamZoom = 1;
        case 648:
            defaultCamZoom = 1.3;
        case 680:
            defaultCamZoom = 1;
        case 712:
            defaultCamZoom = 1.3;
        case 744:
            defaultCamZoom = 1;
        case 776:
            defaultCamZoom = 1.3;
        case 808:
            defaultCamZoom = 1;
        case 840:
            evilswap(0);
        case 1608:
            defaultCamZoom = 1.3;
        case 1640:
            defaultCamZoom = 1;
            evilswap(1);
        case 1864:
            FlxTween.tween(blackScreen, {alpha: 1}, 1.5, {ease: FlxEase.sineOut});
    }
}
function evilswap(Int)
	{
		switch (Int)
		{	
			case 0:
				FlxTween.cancelTweensOf(redStatic);
				redStatic.alpha = 1;
				FlxTween.tween(redStatic, {alpha: 0.0001}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){}});

				stageVER = 0;
				defaultCamZoom = 1.05;
				evilbg.alpha = 1;
				stageFront.alpha = 0;
				bg.alpha = 0;
				space.alpha = 0;

                dad.x = 200;
                dad.y = 250;
                boyfriend.x = 1000;
                boyfriend.y = 500;
			case 1:
				FlxTween.cancelTweensOf(redStatic);
				redStatic.alpha = 1;
				FlxTween.tween(redStatic, {alpha: 0.0001}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){}});

				stageVER = 1;
				//addcharacter("monika-angry", 1);

				defaultCamZoom = 0.9;
				evilbg.alpha = 0;
				stageFront.alpha = 1;
				bg.alpha = 1;
				space.alpha = 1;

                
                dad.x = 300;
                dad.y = 20;
                boyfriend.x = 1000;
                boyfriend.y = 300;

			case 2:
		}
	}
function update(elapsed:Float){
}