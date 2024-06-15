import Takeover.BGSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxBackdrop;
var bgDokis:FlxTypedGroup<FlxSprite>;
var bgDokis = new FlxTypedGroup();
var whiteflash:FlxSprite;
var pinkOverlay:FlxSprite;
var blackScreen:FlxSprite;
var blackScreenBG:FlxSprite;
var blackScreentwo:FlxSprite;
var isFestival:Bool = false;
var cancelCameraMove:Bool = false;


function onCameraMove(e) if(cancelCameraMove) e.cancel();

function create(){

    camOverlay = new FlxCamera();
    camOverlay.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camOverlay, false);

    remove(gf);
    remove(dad);
    remove(boyfriend);


    monika = new FlxSprite(320, 173);
    monika.frames = Paths.getSparrowAtlas('bgdoki/monika');
    monika.animation.addByPrefix('bop', 'Moni BG', 24, false);
    monika.animation.play('bop');
    monika.scrollFactor.set(1, 0.9);
    monika.setGraphicSize(Std.int(monika.width * 0.7));
    monika.updateHitbox();


    sayori = new FlxSprite(-49, 247);
    sayori.frames = Paths.getSparrowAtlas('bgdoki/sayori');
    sayori.animation.addByPrefix('bop', 'Sayori BG', 24, false);
    sayori.animation.play('bop');
    sayori.scrollFactor.set(1, 0.9);
    sayori.setGraphicSize(Std.int(sayori.width * 0.7));
    sayori.updateHitbox();

    natsuki = new FlxSprite(1247, 303);
    natsuki.frames = Paths.getSparrowAtlas('bgdoki/natsuki');
    natsuki.animation.addByPrefix('bop', 'Natsu BG', 24, false);
    natsuki.animation.play('bop');
    natsuki.scrollFactor.set(1, 0.9);
    natsuki.setGraphicSize(Std.int(natsuki.width * 0.7));
    natsuki.updateHitbox();

    protag = new FlxSprite(150, 152);
    protag.frames = Paths.getSparrowAtlas('bgdoki/protag');
    protag.animation.addByPrefix('bop', 'Protag-kun BG', 24, false);
    protag.animation.play('bop');
    protag.scrollFactor.set(1, 0.9);
    protag.setGraphicSize(Std.int(protag.width * 0.7));
    protag.updateHitbox();
    
    yuri = new FlxSprite(1044, 178);
    yuri.frames = Paths.getSparrowAtlas('bgdoki/yuri');
    yuri.animation.addByPrefix('bop', 'Yuri BG', 24, false);
    yuri.animation.play('bop');
    yuri.scrollFactor.set(1, 0.9);
    yuri.setGraphicSize(Std.int(yuri.width * 0.7));
    yuri.updateHitbox();

    switch (curSong)
    {
        case 'my confession' | 'obsession':
        {
            vignette = new FlxSprite().loadGraphic(Paths.image('vignette'));
            vignette.antialiasing = Options.antialiasing;
            vignette.scrollFactor.set();
            vignette.alpha = 0.001;

            if (curSong.toLowerCase() != 'obsession')
            {
                vignette.cameras = [camHUD];
                vignette.setGraphicSize(Std.int(vignette.width / defaultHudZoom));
                vignette.updateHitbox();
                vignette.screenCenter();
            }

            staticshock = new FlxSprite();
            staticshock.frames = Paths.getSparrowAtlas('clubroom/staticshock');
            staticshock.antialiasing = Options.antialiasing;
            staticshock.animation.addByPrefix('idle', 'hueh', 24, true);
            staticshock.animation.play('idle');
            staticshock.scrollFactor.set();
            staticshock.alpha = 0.6;
            staticshock.cameras = [camHUD];
            staticshock.updateHitbox();
            staticshock.screenCenter();
        }
        case 'deep breaths':
        {
            sparkleBG = new FlxBackdrop(Paths.image('clubroom/YuriSparkleBG'));
            sparkleBG.scrollFactor.set(0.1, 0);
            sparkleBG.velocity.set(-16, 0);
            sparkleBG.visible = false;
            sparkleBG.setGraphicSize(Std.int(sparkleBG.width / defaultCamZoom));
            sparkleBG.updateHitbox();
            sparkleBG.screenCenter();
            sparkleBG.antialiasing = Options.antialiasing;
            

            sparkleFG = new FlxBackdrop(Paths.image('clubroom/YuriSparkleFG'));
            sparkleFG.scrollFactor.set(0.1, 0);
            sparkleFG.velocity.set(-48, 0);
            sparkleFG.setGraphicSize(Std.int((sparkleFG.width * 1.2) / defaultCamZoom));
            sparkleFG.updateHitbox();
            sparkleFG.screenCenter();
            sparkleFG.antialiasing = Options.antialiasing;


            pinkOverlay = new FlxSprite(-FlxG.width * FlxG.camera.zoom, -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFFF281F2);
            pinkOverlay.alpha = 0.2;
            pinkOverlay.scrollFactor.set();
        }
        case 'constricted':
        {
            vignette = new FlxSprite().loadGraphic(Paths.image('vignette'));
            vignette.antialiasing = Options.antialiasing;
            vignette.scrollFactor.set();
            vignette.cameras = [camHUD];
            vignette.setGraphicSize(Std.int(vignette.width / defaultHudZoom));
            vignette.updateHitbox();
            vignette.screenCenter();
            vignette.alpha = 0.001;

            zippergoo = new FlxSprite(0, 0).loadGraphic(Paths.image('zippergoo'));
            zippergoo.antialiasing = Options.antialiasing;
            zippergoo.scrollFactor.set();
            zippergoo.cameras = [camHUD];
            zippergoo.setGraphicSize(Std.int(FlxG.width / defaultHudZoom));
            zippergoo.updateHitbox();
            zippergoo.screenCenter();
            zippergoo.alpha = 0.001;
        }
}
clubmainlight = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/clublights'));
clubmainlight.scrollFactor.set(1, 1);
clubmainlight.setGraphicSize(Std.int(clubmainlight.width * 1.6));
clubmainlight.updateHitbox();
add(clubmainlight);

deskfront = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/DesksFront'));
deskfront.scrollFactor.set( 1.3, 1);
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

blackScreen = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
    -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
blackScreen.scrollFactor.set();

blackScreenBG = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
    -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
blackScreenBG.alpha = 0.0001;
blackScreenBG.scrollFactor.set();

blackScreentwo = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
    -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
blackScreentwo.scrollFactor.set();


if (curSong.toLowerCase() == 'neet')
{
    bgDokis.alpha = 0.001;

    add(blackScreenBG);

    spotlight = new FlxSprite(-700, -520).loadGraphic(Paths.image('clubroom/NEETspotlight'));
    spotlight.scrollFactor.set(1, 0.9);
    spotlight.setGraphicSize(Std.int(spotlight.width * 1.6));
    spotlight.alpha = 0.001;
    spotlight.updateHitbox();
    add(spotlight);
}

    add(bgDokis);

        if (curSong.toLowerCase() != 'obsession')
        {
            if (isFestival)
            {
                var club:Array= [monika, sayori, natsuki, protag, yuri];
                for (member in club)
                    member.color = 0x828282;
            }

        if (monikaBG){
            bgDokis.add(monika);
        }
        if (sayoriBG)
        {  
            bgDokis.add(sayori);
        }
        if (natsukiBG){
            bgDokis.add(natsuki);
        }
        if (protagBG){
            bgDokis.add(protag);
        }
       if (yuriBG)
            bgDokis.add(yuri);

    }

        switch (dad.curCharacter)
        {
            case "natsuki":
                {
                    sayori.setPosition(-49, 247);
                    yuri.setPosition(1044, 178);
                    protag.setPosition(379, 152);
                    monika.setPosition(1207, 173);
                }
            case "yuri" | "yuri-crazy":
                {
                    sayori.setPosition(-49, 247);
                    natsuki.setPosition(1044, 290);
                    protag.setPosition(379, 152);
                    monika.setPosition(1207, 173);
                }
            case "sayori":
                {
                    yuri.setPosition(-74, 176);
                    natsuki.setPosition(1044, 290);
                    protag.setPosition(379, 152);
                    monika.setPosition(1207, 173);
                }
            case "monika":
                {
                    sayori.setPosition(-49, 247);
                    yuri.setPosition(1044, 178);
                    natsuki.setPosition(1247, 303);
                    protag.setPosition(150, 152);
                }
        }

    }
function update(){
    if (necksnap){
        gf.danceOnBeat = false;
        gf.playAnim('necksnap');
    }
}
function postCreate(){

if (curSong.toLowerCase() == 'obsession')
    {
        // blackScreenBG
        insert(members.indexOf(gf) + 1, blackScreenBG);
        add(blackScreentwo);
        blackScreentwo.visible = false;
        
    }

    add(gf);
    add(dad);
    add(boyfriend);

    if (curSong.toLowerCase() == !'obsession')
    {
    add(sparkleBG);
    }

    bakaOverlay = new FlxSprite(0, 0);
    bakaOverlay.frames = Paths.getSparrowAtlas('clubroom/BakaBGDoodles');
    bakaOverlay.animation.addByPrefix('normal', 'Normal Overlay', 24, true);
    bakaOverlay.animation.addByPrefix('party rock is', 'Rock Overlay', 24, true);
    bakaOverlay.animation.addByPrefix('FUCK', 'Tank Overlay', 24, true);
    bakaOverlay.animation.play('normal');
    bakaOverlay.scrollFactor.set();
    bakaOverlay.visible = false;
    bakaOverlay.alpha = 0.001;
    bakaOverlay.cameras = [camHUD];
    bakaOverlay.setGraphicSize(Std.int(FlxG.width / defaultHudZoom));
    bakaOverlay.updateHitbox();
    bakaOverlay.screenCenter();
    add(bakaOverlay);

    whiteflash = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFFFDC1FF);
    whiteflash.alpha = 0.0001;
    whiteflash.cameras = [camHUD];
    add(whiteflash);


}
function stepHit(curStep){
    switch (curSong)
    { 
       case 'my confession':
         {
           switch (curStep)
                {
                    case 480:
                        cancelCameraMove = true;
                        camFollow.setPosition(gf.getMidpoint().x, gf.getMidpoint().y - 100);
                        gf.playAnim('countdownThree');
                        FlxTween.tween(FlxG.camera, {zoom: 1}, 0.2);
                    case 484:
                        gf.playAnim('countdownTwo');
                        FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.2);
                    case 488:
                        gf.playAnim('countdownOne');
                        FlxTween.tween(FlxG.camera, {zoom: 1.4}, 0.2);
                    case 492:
                        cancelCameraMove = false;
                        camFollow.setPosition(gf.getMidpoint().x, gf.getMidpoint().y);
                        gf.playAnim('countdownGo');
                        camZooming = true;
                    case 496:
                        gf.dance();
                    case 749:
                        if (FlxG.save.data.sayoricostume == 'grace')
                        {
                            dad.playAnim('nara');
                            dad.specialAnim = true;
                        }
                    case 752:
                        dad.playAnim('nara');
                        sayonara();
                    case 768:
                        FlxG.camera.zoom = 0.75;
                }
            }
        
        case 'obsession':
            switch (curStep)
            {
                case 480:

                    FlxTween.tween(FlxG.camera, {zoom: 1.5}, (Conductor.stepCrochet / 14) / Conductor.playbackSpeed, {ease: FlxEase.linear});

                        staticshock.visible = true;
                        staticshock.alpha = 0;
                        FlxTween.tween(staticshock, {alpha: 1}, (Conductor.stepCrochet / 14) / Conductor.playbackSpeed, {
                            ease: FlxEase.linear,
                            onComplete: function(tween:FlxTween)
                            {
                                staticshock.alpha = 0.1;
                            }
                        });
                case 544:

                    add(whiteflash);
                    add(blackScreen);
                    FlxG.sound.play(Paths.sound('Lights_Shut_off'), 0.7);
                case 552:
                    // shit gets serious
                    yuriGoCrazy();
                case 568:
                    remove(blackScreen);
                    FlxTween.tween(whiteflash, {alpha: 0.15}, 0.75, {ease: FlxEase.sineOut});
                case 848:
                    blackScreentwo.visible = true;
            }
        }
    }
function beatHit(curBeat){
    
if (curBeat % 2 == 0)
    {
            if (monika != null)
                monika.animation.play('bop');
            if (protag != null)
                protag.animation.play('bop');
            sayori.animation.play('bop');
            natsuki.animation.play('bop');
            yuri.animation.play('bop');
    }
    switch (curSong)
    { 
       case 'my sweets':
        {
            switch (curBeat)
            {
                case 260:
                    dad.playAnim('hmmph');
            }
        }
        case 'baka':
        {
        switch (curBeat)
            {
            case 16:

                    bakaOverlay.visible = true;
                    FlxTween.tween(bakaOverlay, {alpha: 1}, 2, {ease: FlxEase.sineIn});
            case 32:
                if (bakaOverlay != null) {
                    bakaOverlay.animation.play('party rock is', true);
                    defaultCamZoom = 1.2;
                    camGame.shake(0.002, 2);
                }
                else
                {
                    whiteflash.alpha = 1;
                    FlxTween.tween(whiteflash, {alpha: 0.001}, 0.2, {ease: FlxEase.sineOut});
                }
            case 40:
                cancelCameraMove = true;
                camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
            case 48:
                cancelCameraMove = false;
                FlxTween.tween(FlxG.camera, {zoom: 0.95}, 1, {
                    ease: FlxEase.sineOut,
                    onComplete: function(tween:FlxTween)
                    {
                        defaultCamZoom = 0.95;
                    }
                });
            case 112 | 264:
                if (bakaOverlay != null) FlxTween.tween(bakaOverlay, {alpha: 0}, 2, {ease: FlxEase.sineOut});
            case 144:
                if (bakaOverlay != null)
                {
                    bakaOverlay.animation.play('normal', true);
                    FlxTween.tween(bakaOverlay, {alpha: 1}, 2, {ease: FlxEase.sineIn});
                }
            }
        }

    case 'deep breaths':
        switch (curBeat)
        {
            case 104:
                sparkleBG.visible = true;
                add(sparkleFG);
                add(pinkOverlay);
            case 200:
                FlxTween.tween(sparkleBG, {alpha: 0}, 1, {ease: FlxEase.sineOut});
                FlxTween.tween(sparkleFG, {alpha: 0}, 1, {ease: FlxEase.sineOut});
                FlxTween.tween(pinkOverlay, {alpha: 0}, 1, {ease: FlxEase.sineOut});
            case 232:
                sparkleBG.alpha = 1;
                sparkleFG.alpha = 1;
                pinkOverlay.alpha = 0.2;
            case 288:
                FlxTween.tween(sparkleBG, {alpha: 0}, 2, {ease: FlxEase.sineOut});
                FlxTween.tween(sparkleFG, {alpha: 0}, 2, {ease: FlxEase.sineOut});
                FlxTween.tween(pinkOverlay, {alpha: 0}, 2, {ease: FlxEase.sineOut});
        }
     } 
   }
 

function sayonara()
	{
        camZooming = false;
		staticshock.visible = true;
		FlxTween.tween(FlxG.camera, {zoom: 2}, 0.1);

		if (vignette != null)
		{
			add(vignette);
			vignette.alpha = 0.2;
		}
	}

    function yuriGoCrazy()
        {
            // yooo she gon da crazyy
            yuriGoneCrazy = true;
    
            // visual setup
            defaultCamZoom = 1.4;
            camZooming = true;
            cancelCameraMove = true;
            blackScreenBG.alpha = 0.8;
            remove(deskfront);
    
            // character setup
            boyfriend.x = dad.x + 250;
            necksnap = true;
            // vignette + camera setup
            if (vignette != null)
            {
                add(vignette);
                vignette.alpha = 0.6;
            }
    
            camFollow.setPosition((dad.getMidpoint().x + boyfriend.getMidpoint().x) / 1.8, dad.getMidpoint().y - 350);
        }
    