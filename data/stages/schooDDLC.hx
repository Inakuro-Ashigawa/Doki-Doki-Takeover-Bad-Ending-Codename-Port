var fgTrees:FlxSprite;
var bgSky:FlxSprite;
var bgSchool:FlxSprite;
var bgStreet:FlxSprite;
var bgTrees:FlxSprite;
var redStatic = new FlxSprite();
public var pixelNotesForBF = true;
public var pixelNotesForDad = true;
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

    var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky'));
    bgSky.scrollFactor.set(0.1, 0.1);
    add(bgSky);

    var repositionShit = -200;

    var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool'));
    bgSchool.scrollFactor.set(0.6, 0.90);
    add(bgSchool);

    var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet'));
    bgStreet.scrollFactor.set(0.95, 0.95);
    add(bgStreet);

    var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack'));
    fgTrees.scrollFactor.set(0.9, 0.9);
    add(fgTrees);

    var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);


    var widShit = Std.int(bgSky.width * 6);

    bgSky.setGraphicSize(widShit);
    bgSchool.setGraphicSize(widShit);
    bgStreet.setGraphicSize(widShit);
    bgTrees.setGraphicSize(Std.int(widShit * 1.4));
    fgTrees.setGraphicSize(Std.int(widShit * 0.8));

    fgTrees.updateHitbox();
    bgSky.updateHitbox();
    bgSchool.updateHitbox();
    bgStreet.updateHitbox();
    bgTrees.updateHitbox();

    remove(gf);
    remove(dad);
    remove(boyfriend);


}

function postCreate(){

    evilbg = new FlxSprite(400,100);
    evilbg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
    evilbg.antialiasing = Options.antialiasing;
    evilbg.scrollFactor.set(.8,.9);
    evilbg.antialiasing = false;
    evilbg.animation.addByPrefix('idle', 'background 2 instance 1', 24, true);
    evilbg.animation.play('idle');
    evilbg.scale.set(6,6);
    evilbg.alpha = 0.001;
    add(evilbg);

    redStatic.frames = Paths.getSparrowAtlas('HomeStatic');
    redStatic.cameras = [camHUD];
    redStatic.setGraphicSize(FlxG.width, FlxG.height);
    redStatic.screenCenter();
    redStatic.animation.addByPrefix('static', 'HomeStatic', 24, true);
    redStatic.animation.play('static');
    redStatic.alpha = 0.001;
    add(redStatic);

    add(gf);
    add(boyfriend);
    add(dad);
}

function stepHit(curStep){
  switch (curStep)
    {

        case 1360:
            glitchySchool(1);
        case 1552:
            glitchySchool(0);
    }
}
function glitchySchool(Int)
	{
		glitchEffect();
		switch (Int)
		{
			case 1:
				evilbg.alpha = 1;
			case 0:
				evilbg.alpha = 0;
		}
	}
function glitchEffect() //Might aswell make it universal
{
    
    FlxTween.cancelTweensOf(redStatic);
    redStatic.alpha = 1;
    FlxTween.tween(redStatic, {alpha: 0.0001}, 0.2, {ease: FlxEase.linear});
}