//imports
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;

//vars
public var option = FlxG.save.data;
var blackbarTop = new FlxSprite(0, -102).loadGraphic(Paths.image('TightBars'));
var blackbarBottom = new FlxSprite(0, 822).loadGraphic(Paths.image('TightBars'));
public var DokiTxt:FlxText;
public var DokiTxtTween:FlxTween;
public var sicks:Int = 0;
public var goods:Int = 0;
public var bads:Int = 0;
public var shits:Int = 0;
public var Pixle:Bool = false;
public var ratingFC:String = "FC";
var ratingStuff:Array<Dynamic> = [
    ['AHH SUCKS.', 0.2], //From 0% to 19%
    ['BAKA', 0.4], //From 20% to 39%
    ['Not Cute', 0.5], //From 40% to 49%
    ['BAKA', 0.6], //From 50% to 59%
    ['Just MC?', 0.69], //From 60% to 68%
    ['SENPAI', 0.7], //69%
    ['DOKI', 0.8], //From 70% to 79%
    ['DOKI DOKI', 0.9], //From 80% to 89%
    ['Just ' + option.bestGirl, 1], //From 90% to 99%
    ['Way Past Cool', 1] //The value on this one isn't used actually, since Perfect is always "1"
];

function create(){
PauseSubState.script = 'data/scripts/DokiPause';
}

function postCreate() {

camBars = new FlxCamera();
camBars.bgColor = 0;
FlxG.cameras.remove(camHUD, false);
FlxG.cameras.add(camBars, false);
FlxG.cameras.add(camHUD, false);

DokiTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | breaks: 0 | Rating: ?");
//DokiTxt = new FlxText(0, healthBarBG.y + 40, "Score: 0 Misses: 0  Rating: ?" , 20);
DokiTxt.setFormat(Paths.font("Journal.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
DokiTxt.borderSize = 1.25;
DokiTxt.cameras = [camHUD];
DokiTxt.antialiasing = true;
DokiTxt.scrollFactor.set();
DokiTxt.screenCenter(FlxAxes.X);

remove(scoreTxt);
remove(missesTxt);
remove(accuracyTxt);

add(DokiTxt);

blackbarTop.alpha = 0.001;
blackbarTop.scrollFactor.set(0,0);
blackbarTop.cameras = [camBars];
add(blackbarTop);

blackbarBottom.alpha = 0.001;
blackbarBottom.scrollFactor.set(0,0);
blackbarBottom.cameras = [camBars];
add(blackbarBottom);	

if (Pixle)
DokiTxt.antialiasing = false;
DokiTxt.setFormat(Paths.font("LanaPixel.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
}
function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC(accuracy:Float, misses:Int):String {
    // this sucks but idk how to make it better lol
    if (misses == 0) {
        if (accuracy == 1.0) ratingFC = "SFC";
        else if (accuracy >= 0.99) ratingFC = "GFC";
        else ratingFC = "FC";
    }
    if (misses > 0) {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
}
function update(elapsed:float){

    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    getRatingFC(accuracy, misses);

    if (songScore > 0 || acc > 0 || misses > 0)  DokiTxt.text = "Score: " + songScore + " | breaks: " + misses +  " | Rating: " + rating + " (" + acc + "%)" + " - " + ratingFC;
    } 

function onPlayerHit(event) {
    if (event.note.isSustainNote) return;

    if(DokiTxtTween != null) DokiTxtTween.cancel();
    DokiTxt.scale.x = DokiTxt.scale.y = 1.075;
    DokiTxtTween = FlxTween.tween(DokiTxt.scale, {x: 1, y: 1}, 0.2, {onComplete: function(twn:FlxTween) {DokiTxtTween = null;}});

    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }

    ratingFC = 'Clear';

    if(misses < 1) {
		if (bads > 0 || shits > 0) ratingFC = 'FC';
		else if (goods > 0) ratingFC = 'GFC';
		else if (sicks > 0) ratingFC = 'SFC';
	}
	else if (misses < 10) ratingFC = 'SDCB';
}

function onNoteCreation(event:NoteCreationEvent) {
    event.note.splash = "Doki";
}
public function blackBars(inorout:Bool)
	{
		if (inorout)
		{
			blackbarTop.alpha = 1;
			blackbarBottom.alpha = 1;

			FlxTween.tween(blackbarBottom, {y: 628}, 1.2, {ease: FlxEase.sineOut});
			FlxTween.tween(blackbarTop, {y: 0}, 1.2, {ease: FlxEase.sineOut});
		}
		else
		{
			FlxTween.tween(blackbarBottom, {y: 822}, 1.2, {ease: FlxEase.sineIn});
			FlxTween.tween(blackbarTop, {y: -102}, 1.2, {ease: FlxEase.sineIn});

			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				blackbarTop.alpha = 0.001;
				blackbarBottom.alpha = 0.001;
			});
		}
	}
