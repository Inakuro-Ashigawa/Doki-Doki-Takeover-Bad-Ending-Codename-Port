import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.effects.FlxFlicker;

// diffrent vocals
var YuriVocals:FlxSound;
var SayoriVocals:FlxSound;
var MonikaVocals:FlxSound;
var NatsukiVocals:FlxSound;

var acceptInput:Bool = false;
var select:FlxSprite;
var funnyChar:String = 'protag';
var charList:Array<String> =  ['Yuri', 'Sayori', 'Monika', 'Natsuki'];
var selectGrp:FlxTypedGroup<FlxSprite>;
var selectGrp = new FlxTypedGroup();
var curSelected:Int = 0;
var huehTimer:FlxTimer;

function create(){

camDoki = new FlxCamera();
camDoki.bgColor = 0;
FlxG.cameras.add(camDoki, false);


var bg:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom, -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
bg.alpha = 0;
bg.scrollFactor.set();
bg.cameras = [camDoki];
add(bg);
FlxTween.tween(bg, {alpha: 0.3}, 0.4, {ease: FlxEase.quartInOut});

add(selectGrp);
selectGrp.cameras = [camDoki];
for (i in 0...charList.length)
    {
        var funnyx:Int = 69;

        var funnySprite:FlxSprite = new FlxSprite(funnyx + (i * 294), 164);
        funnySprite.frames = Paths.getSparrowAtlas('extraui/' + charList[i] + 'Card');
        switch(charList[i])
        {
            case 'Natsuki':
                funnySprite.animation.addByPrefix('pop', 'NatCardAnim', 24, false);
            case 'Monika':
                funnySprite.animation.addByPrefix('pop', 'MonikaCardAnim', 24, false);
            case 'Sayori':
                funnySprite.animation.addByPrefix('pop', 'SayoCardAnim', 24, false);
            case 'Yuri':
                funnySprite.animation.addByPrefix('pop', 'YuriCardAnim', 24, false);
        }
        funnySprite.ID = i;
        funnySprite.animation.play('pop');
        funnySprite.antialiasing = Options.Antialiasing;
        selectGrp.add(funnySprite);
    }

    select = new FlxSprite(0, 0).loadGraphic(Paths.image('extraui/selecttext'));
    select.antialiasing = Options.Antialiasing;
    select.scale.set(0.8, 0.8);
    select.updateHitbox();
    select.cameras = [camDoki];
    select.screenCenter(FlxAxes.X);
    select.y = -select.height;
    add(select);

    FlxTween.tween(select, {y: 40}, 0.5, {ease: FlxEase.sineOut});

    huehTimer = new FlxTimer().start(8, function(swagTimer:FlxTimer)
    {
        acceptInput = false;
        charSelected(funnyChar);
    });

    new FlxTimer().start(0.5, function(tmr:FlxTimer)
    {
        acceptInput = true;
    });

}
function postCreate(){

        //diffrent vocals
	YuriVocals = FlxG.sound.play(Paths.sound("you and me/Voices_Yuri"), 1);
	YuriVocals.volume = 0;

    SayoriVocals = FlxG.sound.play(Paths.sound("you and me/Voices_Sayori"), 1);
	SayoriVocals.volume = 0;

    MonikaVocals = FlxG.sound.play(Paths.sound("you and me/Voices_Monika"), 1);
	MonikaVocals.volume = 0;

    NatsukiVocals = FlxG.sound.play(Paths.sound("you and me/Voices_Natsuki"), 1);
	NatsukiVocals.volume = 0;

}
function update(elapsed:Float){
		if (acceptInput)
		{
			if (controls.LEFT_P)
				selectChar('yuri', 0);
			if (controls.DOWN_P)
				selectChar('sayori', 1);
			if (controls.UP_P)
				selectChar('monika', 2);
			if (controls.RIGHT_P)
				selectChar('natsuki', 3);
        }
}
function selectChar(who:String = 'protag', num:Int)
	{
		huehTimer.cancel();
		acceptInput = false;
		funnyChar = who;
		curSelected = num;
		FlxG.sound.play(Paths.sound('confirmMenu'), 1);

		selectGrp.forEach(function(hueh:FlxSprite)
		{
			if (hueh.ID != curSelected)
				FlxTween.tween(hueh, {y: 1280}, 1, {ease: FlxEase.circIn});
			else if (FlxG.save.data.flashing && hueh.ID == curSelected)
				FlxFlicker.flicker(hueh, 1, 0.1, false, false);

		});

		huehTimer = new FlxTimer().start(1, function(swagTimer:FlxTimer)
		{
			charSelected(funnyChar);
		});
	}
function charSelected(?who:String)
    {
        selectGrp.forEach(function(hueh:FlxSprite)
        {
            FlxTween.tween(hueh, {alpha: 0}, 0.5, {ease: FlxEase.circIn, onComplete: function(twn:FlxTween){}});
        });
        FlxTween.tween(select, {alpha: 0}, 1, {ease: FlxEase.linear});
        new FlxTimer().start(0.5, function(tmr:FlxTimer)
        {
            cardSelected(who);

           FlxTween.tween(bg, {alpha: 0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(camDoki, {alpha: 1}, 2, {ease: FlxEase.sineOut});
        });
    }
function cardSelected(who:String)
        {
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                trace(who);
                switch(who)
                {
                    case 'yuri':
                        YuriVocals.volume = 1;
                    case 'natsuki':
                        NatsukiVocals.volume = 1;
                        PlayState.loadSong("you and me", "nat");

                    case 'sayori':
                        SayoriVocals.volume = 1;
                    case 'monika':
                        MonikaVocals.volume = 1; 
                }
                FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.linear});
                FlxTween.tween(iconP2, {alpha: 1}, 1, {ease: FlxEase.linear});
            });
        }