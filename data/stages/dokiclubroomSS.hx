
var flickerTween:Array<FlxTween> = [];
var flickerTween2:Array<FlxTween> = [];
var light = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/light'));

function create(){

    flickerTween = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
	flickerTween.active = true;

	flickerTween2 = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
	flickerTween2.active = true;

    strumLines.members[0].characters[0].x = -140;
    camOverlay = new FlxCamera();
    camOverlay.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camOverlay, false);

    remove(gf);
    remove(dad);
    remove(boyfriend);
    
    deskfront = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/DesksFront'));
    deskfront.scrollFactor.set(1.3, 1);
    deskfront.setGraphicSize(Std.int(deskfront.width * 1.6));
    deskfront.updateHitbox();

    closet = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/DDLCfarbg'));
    closet.scrollFactor.set(0.9, 1);
    closet.setGraphicSize(Std.int(closet.width * 1.6));
    closet.updateHitbox();
    add(closet);

    clubroom = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/DDLCbg'));
    clubroom.scrollFactor.set(1, 1);
    clubroom.setGraphicSize(Std.int(clubroom.width * 1.6));
    clubroom.updateHitbox();
    add(clubroom);

    dark = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/dark'));
    dark.scrollFactor.set(1, 1);
    dark.setGraphicSize(Std.int(dark.width * 1.7));
    dark.updateHitbox();
    dark.screenCenter();

    light.scrollFactor.set(1, 1);
    light.setGraphicSize(Std.int(light.width * 1.7));
    light.updateHitbox();
    light.screenCenter();


    bulb = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/bulb'));
    bulb.scrollFactor.set(1, 1);
    bulb.setGraphicSize(Std.int(bulb.width * 1.7));
    bulb.updateHitbox();   
    bulb.screenCenter();
}

function postCreate(){
    remove(strumLines.members[3].characters[0]);
    add(strumLines.members[3].characters[0]);
    add(gf);
    add(dad);
    add(boyfriend);
    add(deskfront);
    add(dark);
    add(light);
    add(bulb);
}

function update(elapsed) {
        light.angle = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0) * 5;
        dark.angle = light.angle;
        bulb.angle = light.angle;
}
function stepHit(curStep){
    switch (curStep)
    {
        case 1:
            blackBars(true);
        case 128:
            blackBars(false);
        case 768:
            blackBars(true);
        case 1024:
            blackBars(false);
        case 1408:
            blackBars(true);
        case 1664:
            blackBars(false);
        case 1696:
            blackBars(true);
        case 1952:
            blackBars(false);
        case 2464:
            blackBars(true);
        case 2720:
            blackBars(false);
        case 2976:
            blackBars(true);
        case 3104:
            blackBars(false);
        }
    }