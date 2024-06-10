//imports
import flixel.addons.display.FlxBackdrop;
//vars
var posX:Int = -155;
var posY:Int = -795;
var scale:Float = 1.2;
var cancelCameraMove:Bool = false;
var dokiBackdrop:FlxBackdrop;


function postCreate(){
    healthBar.createFilledBar(FlxColor.fromRGB(175, 83, 65), FlxColor.fromRGB(175, 83, 65));
    healthBar.updateFilledBar();
    healthBar.updateBar();

    iconP2.alpha = 0;
    add(boyfriend);
    add(dad);
}
function create(){
    
    var sky = new FlxSprite(posX, posY).loadGraphic(Paths.image('stages/ynm/skybox'));
    sky.setGraphicSize(Std.int(sky.width * scale));
    sky.scrollFactor.set(.2,.2);
    sky.updateHitbox();
    add(sky);

    var bg3 = new FlxSprite(posX, posY).loadGraphic(Paths.image('stages/ynm/bg3'));
    bg3.scrollFactor.set(.5,.5);
    bg3.setGraphicSize(Std.int(bg3.width * scale));
    bg3.updateHitbox();
    add(bg3);

    var bg2 = new FlxSprite(posX, posY).loadGraphic(Paths.image('stages/ynm/bg2'));
    bg2.scrollFactor.set(.8,.8);
    bg2.setGraphicSize(Std.int(bg2.width * scale));
    bg2.updateHitbox();
    add(bg2);

    var bg = new FlxSprite(posX, posY).loadGraphic(Paths.image('stages/ynm/bg'));
    bg.scrollFactor.set(.9,.9);
    bg.setGraphicSize(Std.int(bg.width * scale));
    bg.updateHitbox();
    add(bg);
    dad.y -= 35;

    dokiBackdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    dokiBackdrop.velocity.set(-40, -40);
    dokiBackdrop.alpha = 0.001;
    add(dokiBackdrop);

    remove(boyfriend);
    remove(dad);
}

function stepHit(curStep){
  switch (curStep)
    {
    case 0:
        iconP1.alpha = 0.001;
        healthBar.alpha = 0.001;
        healthBarBG.alpha = 0.001;
        DokiTxt.alpha = 0.001;

        camFollow.x = 589;
        camFollow.y = -3004;
        cancelCameraMove = false;
    case 240:
        FlxTween.tween(iconP1, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
        FlxTween.tween(healthBar, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
        FlxTween.tween(healthBarBG, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
        FlxTween.tween(DokiTxt, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
    case 248:
        blackBars(true);
        cancelCameraMove = false;
        FlxTween.tween(camFollow, {y: 326}, 3, {
            ease: FlxEase.linear,
            onComplete: function(twn:FlxTween)
            {
                cancelCameraMove = true;
            }
        });
    case 520:
        defaultCamZoom = 1.1;
    case 784:
        FlxTween.tween(dokiBackdrop, {alpha: 1}, 1, {ease: FlxEase.sineIn});
    case 1060:
        defaultCamZoom = 0.9;
        FlxTween.tween(dokiBackdrop, {alpha: 0}, 1, {ease: FlxEase.sineIn});
    case 1122:
        blackBars(false);
        cancelCameraMove = false;
        FlxTween.tween(camFollow, {y: -3404, x: 589}, 5, {ease: FlxEase.linear});
    case 1134:
        FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.sineOut});
    case 1156:
        openSubState(new ModSubState('Doki/SubStates/DokiCards'));
        //_loadsong("You and Me", "nat");
    }
}
function onCameraMove(e)
    if(cancelCameraMove)
        e.cancel();
