import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;

//Sprite Groups
var grpPopups:FlxTypedGroup<FlxSprite>;
var grpPopups = new FlxTypedGroup();
//videos
var rainBG = new FlxVideoSprite();
var crackBG = new FlxVideoSprite();
var testVMLE = new FlxVideoSprite();

//vars
var blackScreen:FlxSprite;
var fishy = new CustomShader('FishEyeShader');
var inverty = new CustomShader('InvertShader');
defaultCamZoom = 1;

function create(){
    splash = false;
    player.cpu = true;
    
    remove(boyfriend);

    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camGame2 = new HudCamera(), false);
    camGame2.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camOverlay = new HudCamera(), false);
    camOverlay.bgColor = FlxColor.TRANSPARENT;


    rainBG.load(Assets.getPath(Paths.file("videos/rain.mp4")));  
    rainBG.scrollFactor.set();
    rainBG.setGraphicSize(Std.int(rainBG.width / defaultCamZoom));
    rainBG.updateHitbox();
    rainBG.cameras = [camGame2];
    add(rainBG);
    rainBG.play();

    deskBG1 = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/introdesk'));
    deskBG1.antialiasing = Options.antialiasing;
    deskBG1.scrollFactor.set(0,0);
    deskBG1.cameras = [camGame2];
    deskBG1.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    deskBG1.updateHitbox();
    deskBG1.screenCenter();
    add(deskBG1);

    deskBG2 = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/introscreen'));
    deskBG2.antialiasing = Options.antialiasing;
    deskBG2.scrollFactor.set(0,0);
    deskBG2.cameras = [camGame2];
    deskBG2.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    deskBG2.updateHitbox();
    deskBG2.screenCenter();
    deskBG2.alpha = 0.00000001;
    add(deskBG2);

    cursorDDTO = new FlxSprite(800,730).loadGraphic(Paths.image('libitina/mousecursor'));
    cursorDDTO.antialiasing = Options.antialiasing;
    cursorDDTO.scrollFactor.set(0,0);
    cursorDDTO.setGraphicSize(Std.int(cursorDDTO.width / defaultCamZoom));
    cursorDDTO.updateHitbox();
    cursorDDTO.cameras = [camGame2];
    cursorDDTO.alpha = 0.00000001;
    add(cursorDDTO);

    extractPopup = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/extracting'));
    extractPopup.antialiasing = Options.antialiasing;
    extractPopup.scrollFactor.set(0,0);
    extractPopup.setGraphicSize(Std.int(extractPopup.width / defaultCamZoom));
    extractPopup.updateHitbox();
    extractPopup.screenCenter();
    extractPopup.cameras = [camGame2];
    extractPopup.alpha = 0.00000001;
    add(extractPopup);

    testVMLE.load(Assets.getPath(Paths.file("videos/testVM.mp4")));  
    testVMLE.scrollFactor.set();
    testVMLE.setGraphicSize(Std.int(testVMLE.width / defaultCamZoom));
    testVMLE.updateHitbox();
    testVMLE.alpha = 0.00000001;
    add(testVMLE);

    libiWindow = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/bigWindow'));
    libiWindow.setGraphicSize(Std.int(libiWindow.width / defaultCamZoom));
    libiWindow.scrollFactor.set(0,0);
    libiWindow.updateHitbox();
    libiWindow.screenCenter();
    libiWindow.cameras = [camGame2];
    libiWindow.alpha = 0.00000001;
    add(libiWindow);


    libHando = new FlxSprite();
    libHando.frames = Paths.getSparrowAtlas('libitina/Hando');
    libHando.animation.addByPrefix('idle', 'HandoAnim', 24, false);
    libHando.setGraphicSize(Std.int((libHando.width * 1.5) / defaultCamZoom));
    libHando.updateHitbox();
    libHando.screenCenter();
    libHando.scrollFactor.set(0.3,0.3);
    libHando.cameras = [camGame2];
    libHando.alpha = 0.00000001;
    add(libHando);

    deskBG2Overlay = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/lightoverlay'));
    deskBG2Overlay.setGraphicSize(Std.int((FlxG.width * 1.2) / defaultCamZoom));
    deskBG2Overlay.updateHitbox();
    deskBG2Overlay.screenCenter();
    deskBG2Overlay.scrollFactor.set(0,0);
    deskBG2Overlay.cameras = [camOverlay];
    deskBG2Overlay.alpha = 0.00000001;
    add(deskBG2Overlay);

    libAwaken = new FlxSprite(0,0);
    libAwaken.frames = Paths.getSparrowAtlas('libitina/SheAwakens');
    libAwaken.animation.addByPrefix('idle', 'SheAwakens', 24, false);
    libAwaken.setGraphicSize(Std.int((libAwaken.width * 1.1) / defaultCamZoom));
    libAwaken.scrollFactor.set(0,0);
    libAwaken.updateHitbox();
    libAwaken.screenCenter();
    libAwaken.cameras = [camGame2];
    libAwaken.alpha = 0.00000001;
    add(libAwaken);

    blackScreen = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
        -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackScreen.scrollFactor.set();
    blackScreen.cameras = [camHUD];
    add(blackScreen);
    
    ghostBG = new FlxBackdrop(Paths.image('libitina/ghostbg'));
    ghostBG.setPosition(0, -200);
    ghostBG.scrollFactor.set(0.3, 0.3);
    ghostBG.velocity.set(-40, 0);
    ghostBG.setGraphicSize(Std.int((FlxG.width * 1.5) / defaultCamZoom));
    ghostBG.updateHitbox();
    ghostBG.alpha = 0.00000001;
    add(ghostBG);

    eyeBG = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/eyebg'));
    eyeBG.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    eyeBG.updateHitbox();
    eyeBG.scrollFactor.set(0,0);
    eyeBG.screenCenter();
    eyeBG.alpha = 0.00000001;
    add(eyeBG);

    eyeMidwayBG = new FlxSprite(0,0);
    eyeMidwayBG.setGraphicSize(Std.int((FlxG.width * 1.1) / defaultCamZoom));
    eyeMidwayBG.frames = Paths.getSparrowAtlas('libitina/EyeMidwayBG');
    eyeMidwayBG.animation.addByPrefix('idle', 'MidwayBG', 24, false);
    eyeMidwayBG.scrollFactor.set(.3,.3);
    eyeMidwayBG.updateHitbox();
    eyeMidwayBG.screenCenter();
    eyeMidwayBG.cameras = [camGame2];

    eyeShadow = new FlxSprite(0,0).loadGraphic(Paths.image('libitina/eyeShadow'));
    eyeShadow.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    eyeShadow.updateHitbox();
    eyeShadow.screenCenter();
    eyeShadow.scrollFactor.set(0,0);
    eyeShadow.cameras = [camGame2];

    infoBG = new FlxSprite(0,0);
    infoBG.frames = Paths.getSparrowAtlas('libitina/InfoMidwayBG');
    infoBG.animation.addByPrefix('idle', 'InfoBG', 24, false);
    infoBG.animation.play('idle');
    infoBG.setGraphicSize(Std.int((FlxG.width * 1.1) / defaultCamZoom));
    infoBG.updateHitbox();
    infoBG.screenCenter();
    infoBG.scrollFactor.set(.3,.3);
    infoBG.alpha = 0.00000001;
    add(infoBG);

    infoBG2 = new FlxSprite(0,0);
    infoBG2.frames = Paths.getSparrowAtlas('libitina/InfoMidwayBGInvert');
    infoBG2.animation.addByPrefix('idle', 'InfoBG', 24, false);
    infoBG2.animation.play('idle');
    infoBG2.setGraphicSize(Std.int((FlxG.width * 1.1) / defaultCamZoom));
    infoBG2.updateHitbox();
    infoBG2.screenCenter();
    infoBG2.scrollFactor.set(.3,.3);
    infoBG2.alpha = 0.00000001;
    add(infoBG2);

    crackBG.load(Assets.getPath(Paths.file("videos/crackBG.mp4")));  
    //crackBG.scrollFactor.set(0.3, 0.3);
    crackBG.setGraphicSize(Std.int(crackBG.width / defaultCamZoom));
    crackBG.updateHitbox();
    //crackBG.screenCenter();
    crackBG.alpha = 0.00000001;
    add(crackBG);
    crackBG.play();

    staticshock = new FlxSprite();
    staticshock.frames = Paths.getSparrowAtlas('HomeStatic');
    staticshock.animation.addByPrefix('idle', 'HomeStatic', 24, true);
    staticshock.animation.play('idle');
    staticshock.scrollFactor.set();
    staticshock.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    staticshock.updateHitbox();
    staticshock.screenCenter();
    staticshock.cameras = [camGame2];
    staticshock.alpha = 0.00000001;

    libFinaleBG = new FlxSprite();
    libFinaleBG.loadGraphic(Paths.image('libitina/finale/FinaleBG'));
    libFinaleBG.scrollFactor.set(0,0);
    libFinaleBG.setGraphicSize(Std.int(libFinaleBG.width / defaultCamZoom));
    libFinaleBG.updateHitbox();
    libFinaleBG.cameras = [camGame2];
    libFinaleBG.alpha = 0.000001;
    add(libFinaleBG);

    libGhost = new FlxSprite(160, 710);
    libGhost.setGraphicSize(Std.int(libGhost.width / defaultCamZoom));
    libGhost.frames = Paths.getSparrowAtlas('libitina/finale/LibiFinaleDramatic');
    libGhost.animation.addByPrefix('idle', 'LibiFinale', 24, true);
    libGhost.animation.play('idle');
    libGhost.scrollFactor.set(0.3, 0.3);
    libGhost.updateHitbox();
    libGhost.cameras = [camGame2];
    libGhost.alpha = 0.000001;
    add(libGhost);

    
    libParty = new FlxSprite(-80, -460);
    libParty.loadGraphic(Paths.image('libitina/finale/GOONS1'));
    libParty.setGraphicSize(Std.int(libParty.width / defaultCamZoom));
    libParty.updateHitbox();
    libParty.scrollFactor.set(0, 0);
    libParty.cameras = [camGame2];
    libParty.alpha = 0.000001;
    add(libParty);

    libRockIs = new FlxSprite(140, -460);
    libRockIs.loadGraphic(Paths.image('libitina/finale/GOONS2'));
    libRockIs.setGraphicSize(Std.int(libRockIs.width / defaultCamZoom));
    libRockIs.updateHitbox();
    libRockIs.cameras = [camGame2];
    libRockIs.scrollFactor.set(0, 0);
    libRockIs.alpha = 0.000001;
    add(libRockIs);

    libFinale = new FlxSprite(0,0);
    libFinale.loadGraphic(Paths.image('libitina/finale/Finale2'));
    libFinale.scrollFactor.set(0, 0);
    libFinale.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    libFinale.updateHitbox();
    libFinale.cameras = [camGame2];
    libFinale.alpha = 0.0000001;
    add(libFinale);

    libFinaleEyes = new FlxSprite(0,0);
    libFinaleEyes.scrollFactor.set(0, 0);
    libFinaleEyes.frames = Paths.getSparrowAtlas('libitina/finale/ShesWatching');
    libFinaleEyes.animation.addByPrefix('idle', 'ShesWatching', 24, true);
    libFinaleEyes.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    libFinaleEyes.updateHitbox();
    libFinaleEyes.screenCenter();
    libFinaleEyes.alpha = 0.0000001;
    add(libFinaleEyes);

    libFinaleOverlay = new FlxSprite(0,0);
    libFinaleOverlay.scrollFactor.set(0, 0);
    libFinaleOverlay.frames = Paths.getSparrowAtlas('libitina/finale/ShesWatching');
    libFinaleOverlay.animation.addByPrefix('idle', 'ShesWatching', 24, true);
    libFinaleOverlay.setGraphicSize(Std.int(FlxG.width / defaultCamZoom));
    libFinaleOverlay.updateHitbox();
    libFinaleOverlay.cameras = [camGame2];
    libFinaleOverlay.alpha = 0.000001;
    add(libFinaleOverlay);
    
    libVignette = new FlxSprite();
    libVignette.loadGraphic(Paths.image('libitina/vignette'));
    libVignette.setGraphicSize(Std.int(libVignette.width / defaultCamZoom));
    libVignette.updateHitbox();
    libVignette.scrollFactor.set(0,0);
    libVignette.cameras = [camGame2];
    
}

var cancelCameraMove:Bool = true;


function onCameraMove(e) if(cancelCameraMove) e.cancel();
function onSongStart(){
    camHUD.alpha = 0.0001;      
    camFollow.x = 100;
    camFollow.y = 300;
}
function postCreate(){
for (i in playerStrums.members) 
 i.alpha = 0.00001;
for (i in cpuStrums.members) 
    i.alpha = 0.00001;
add(grpPopups);
add(boyfriend);

dad.alpha = 0.0001;
gf.alpha = 0.0001;
iconP2.alpha = 0;

}
var libPopupTypes:Array<Array<String>> = [
    [
        "Binary",
        "Error",
        "Unauthorized",
        "Unknown",
        "Unspecified"
    ],
    [
        "Access",
        "Corrupted"
    ]
];

function libPopup(X:Float = 0, Y:Float = 0, Scale:Float = 1, Type:String = 'Unspecified', Style:String = '', ?Delay:Float = 0, ?Random:Bool = true)
{
        if (Random)
        {
            var popupArray:Array<String> = libPopupTypes[Style == 'red' ? 1 : 0];

            // Randomize the types, while excluding whatever was the past type
            // so as not to repeat the same type
            curDokiLight = FlxG.random.int(0, popupArray.length - 1, [pastDokiLight]);
            pastDokiLight = curDokiLight;

            Type = popupArray[curDokiLight];
        }

        new FlxTimer().start(Delay, function(tmr:FlxTimer)
        {
            var eye = new FlxSprite(X, Y);
            eye.frames = Paths.getSparrowAtlas('libitina/popups/' + Type);
            eye.animation.addByPrefix('idle', 'PopupAnim', 24, false);
            eye.animation.play('idle');
            eye.scrollFactor.set(0, 0);
            eye.cameras = [camGame2];
            grpPopups.add(eye);

            new FlxTimer().start(3.4, function(tmr:FlxTimer)
            {
                grpPopups.remove(eye);
                eye.destroy();
            });
        });
    }

function libShader(show:Bool = true, old:Bool = false){
    if (show)
        {
            FlxG.camera.addShader(fishy);
            FlxG.camGame2.addShader(fishy);
        }
        else
        {

            FlxG.camera.addShader(fishy);
            FlxG.camGame2.removeShader(fishy);
        }

}

function stepHit(curStep)
    switch (curStep)
    {
        case 16:
            FlxTween.tween(blackScreen, {alpha: 0.001}, 2, {ease: FlxEase.sineOut});
        case 68:
            FlxTween.tween(deskBG2, {alpha: 1}, 0.25, {
                ease: FlxEase.sineIn,
                onComplete: function(tween:FlxTween)
                {
                    deskBG1.alpha = 0.00000001;
                    rainBG.alpha = 0.00000001;
                }
            });
        case 72:
            FlxTween.tween(FlxG.camera, {zoom: 1.5}, 2.25, {ease: FlxEase.quadIn});
            FlxTween.tween(camGame2, {zoom: 1.5}, 2.25, {ease: FlxEase.quadIn});
            defaultCamZoom = 1.5;
        case 94:
            cursorDDTO.alpha = 1;
            FlxTween.tween(cursorDDTO, {x: 660, y: 400}, 0.9, {ease: FlxEase.quadOut});
        case 110:
            cursorDDTO.scale.set(0.9, 0.9);
        case 111:
            cursorDDTO.scale.set(1, 1);
        case 112:
            extractPopup.alpha = 1;
            extractPopup.scale.set();
            FlxTween.tween(extractPopup.scale, {"x": 1, "y": 1}, 0.2, {ease: FlxEase.quadOut});
        case 114:
            FlxTween.tween(cursorDDTO, {alpha: 0.001}, 0.3, {ease: FlxEase.sineIn});
        case 120:
            FlxTween.tween(deskBG2, {alpha: 0.001}, 0.3125, {ease: FlxEase.sineIn});
        case 126:
            libShader();
        case 127:
            testVMLE.play();

        case 128:
            libShader(false);
            FlxG.camera.zoom = 1;
            camGame2.zoom = 1;
            defaultCamZoom = 1;

            camGame2.fade(FlxColor.WHITE, 0.2, true);
            deskBG2.alpha = 0.00000001;
            extractPopup.alpha = 0.00000001;
            deskBG2Overlay.alpha = 0.15;
            camHUD.alpha = 1;


            testVMLE.alpha = 1;
        case 160 | 224 | 288 | 480 | 576 | 688 | 800 | 896 | 1024:
            libPopup(526, FlxG.random.int(88, 442), FlxG.random.int(0.9, 1.1), FlxG.random.int(0, 2));
            libPopup(808, FlxG.random.int(88, 442), FlxG.random.int(0.9, 1.1), FlxG.random.int(0, 2));
            libPopup(184, FlxG.random.int(88, 442), FlxG.random.int(0.9, 1.1), FlxG.random.int(0, 2));
        case 352:
            libiWindow.alpha = 1;
            libiWindow.scale.set();
            FlxTween.tween(libiWindow.scale, {"x": 1.1, "y": 1.1}, 0.2, {ease: FlxEase.quadOut});
        case 364:
            libHando.alpha = 1;
            libHando.animation.play('idle', true);
        case 368:

            FlxTween.tween(iconP1, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
            FlxTween.tween(healthBar, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
            FlxTween.tween(healthBarBG, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});
            FlxTween.tween(scoreTxt, {alpha: 1}, 0.5, {ease: FlxEase.sineIn});

            for (i in 0...4)
            {
                FlxTween.tween(playerStrums.members[i], {y: playerStrums.members[i].y + 10, alpha: 1}, 1,
                    {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
            }
        case 384:
            libHando.alpha = 0.00000001;
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            libiWindow.scale.set(1, 1);
            boyfriend.setPosition(170, -50);
            boyfriend.cameras = [camGame2];
            boyfriend.alpha = 1;
            camZooming = true;

            remove(grpPopups);
            insert(members.indexOf(boyfriend) + 1, grpPopups);
        case 520 | 1169 | 1181 | 1186 | 1197 | 1568 | 1968 | 2800 | 2864 | 2928:
            libShader();
        case 544 | 1172 | 1184 | 1189 | 1576 | 2816 | 2880 | 2944 | 3666:
            libShader(false);
        case 624:
            testVMLE.alpha = 0.00000001;
            libiWindow.alpha = 0.00000001;
            boyfriend.alpha = 0.00000001;
            deskBG2Overlay.alpha = 0.00000001;
            grpPopups.visible = false;
            libAwaken.alpha = 1;
            libAwaken.animation.play('idle', true);
        case 640:
            boyfriend.x + 600;
            testVMLE.alpha = 1;
            boyfriend.alpha = 1;
            deskBG2Overlay.alpha = 0.15;
            grpPopups.visible = true;
            libAwaken.alpha = 0.00000001;
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            //addcharacter('ghost-sketch', 0);
            boyfriend.cameras = [camGame2];

            remove(grpPopups);
            insert(members.indexOf(boyfriend) + 1, grpPopups);

            add(libVignette);
        case 1152:
            FlxTween.tween(testVMLE, {alpha: 0.001}, 1, {ease: FlxEase.sineOut});
        case 1200:
            libShader(false);
            FlxTween.tween(deskBG2Overlay, {alpha: 0.001},1 , {ease: FlxEase.linear});
            camGame2.fade(FlxColor.WHITE, 1, false);
        case 1216:
            //addcharacter('ghost', 0);
            boyfriend.cameras = [camGame2];

            ghostBG.alpha = 1;
            camGame2.fade(FlxColor.WHITE, 0.2, true);

            remove(grpPopups);
            insert(members.indexOf(boyfriend) + 1, grpPopups);

            remove(libVignette);
            add(libVignette);
        case 1712:
            ghostBG.alpha = 0.00000001;
            libVignette.alpha = 0.00000001;
            staticshock.alpha = 1;
            add(staticshock);
        case 1728:

            FlxG.camera.addShader(fishy);
            eyeBG.alpha = 1;
            insert(members.indexOf(boyfriend) + 1, eyeShadow);
            insert(members.indexOf(libVignette), eyeMidwayBG);

            libVignette.alpha = 1;
            staticshock.alpha = 0.00000001;
        case 1984:
            libShader(false);
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            boyfriend.shader = inverty; // this doesn't have shader check on purpose
            libFinaleOverlay.alpha = 0.00000001;
            eyeBG.alpha = 0.00000001;
            eyeShadow.alpha = 0.00000001;
            eyeMidwayBG.alpha = 0.00000001;
            infoBG.alpha = 1;
        case 2240:
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            boyfriend.shader = null; // this doesn't have shader check on purpose
            infoBG.alpha = 0.00000001;
            infoBG2.alpha = 1;
        case 2480:
            camGame2.fade(FlxColor.BLACK, 0, false);
        case 2496:
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            infoBG2.alpha = 0.00000001;
            crackBG.alpha = 1;

            libVignette.loadGraphic(Paths.image('libitina/vignetteend'));
        case 2752 | 2817 | 2881 | 2945 | 2960 | 2972 | 2974 | 2976 | 2978 | 2980 | 2981 | 2982 | 2983 | 2984 | 2985 | 2986 | 2987 | 2988 | 2889 | 2890 | 2891 | 2892 | 2893:
            // this code looks so fucking ugly
            libPopup(FlxG.random.int(386, 666), FlxG.random.int(68, 482), FlxG.random.int(0.95, 1.25), '', 'red', FlxG.random.int());
            libPopup(FlxG.random.int(668, 948), FlxG.random.int(68, 482), FlxG.random.int(0.95, 1.25), '', 'red', FlxG.random.int());
            libPopup(FlxG.random.int(44, 324), FlxG.random.int(68, 482), FlxG.random.int(0.95, 1.25), '', 'red', FlxG.random.int());
        case 2994:
            libiWindow.loadGraphic(Paths.image('libitina/granted'));
            libiWindow.screenCenter();
            libiWindow.alpha = 1;
            libiWindow.scale.set();
            FlxTween.tween(libiWindow.scale, {"x": 1, "y": 1}, 0.2, {ease: FlxEase.quadOut});

            remove(libiWindow);
            insert(members.indexOf(boyfriend) + 69, libiWindow);
        case 3008:
            camGame2.fade(FlxColor.WHITE, 0, false);
            boyfriend.alpha = 0.00000001;
            libiWindow.alpha = 0.00000001;
            crackBG.alpha = 0.00000001;

            camZooming = false;
            FlxG.camera.zoom = defaultCamZoom;
            camGame2.zoom = defaultCamZoom;
            camHUD.zoom = defaultHudZoom;

            libVignette.loadGraphic(Paths.image('libitina/vignette'));
            libFinaleBG.alpha = 1;
            libGhost.alpha = 1;

            remove(grpPopups);
        case 3020:
            camGame2.fade(FlxColor.WHITE, 2, true);
        case 3060:
            FlxTween.tween(libFinaleBG, {y: libFinaleBG.y - 560}, 6, {ease: FlxEase.sineInOut});
            FlxTween.tween(libGhost, {y: libGhost.y - 580}, 5, {ease: FlxEase.sineInOut, startDelay: 1.1});
        case 3584:
            camGame2.fade(FlxColor.WHITE, 0.2, true);
            libParty.alpha = 1;
            libRockIs.alpha = 1;
        case 3624:
            FlxTween.tween(libFinale, {alpha: 1}, 0.35, {
                ease: FlxEase.sineIn,
                onComplete: function(tween:FlxTween)
                {
                    libFinaleBG.alpha = 0.00000001;
                    libGhost.alpha = 0.00000001;
                    libParty.alpha = 0.00000001;
                    libRockIs.alpha = 0.00000001;
                }
            });
        case 3646 | 3682 | 3688 | 3710:
            libShader(true, false);
        case 3648:
            // I would've used the switch case but then it wouldn't run the loadGraphic stuff
            libShader(false);
            libFinale.loadGraphic(Paths.image('libitina/finale/Finale3'));
        case 3664:
            libShader(true, false);
            libFinaleOverlay.alpha = 1;
        case 3684:
            libShader(false);
            libFinale.loadGraphic(Paths.image('libitina/finale/Finale4'));
        case 3692:
            libShader(false);

            libFinaleOverlay.setGraphicSize(Std.int(FlxG.width * 0.86 / defaultCamZoom));
            libFinaleOverlay.screenCenter();

            deskBG2.loadGraphic(Paths.image('libitina/outroscreen'));
            camHUD.alpha = 0.00000001;
            libFinale.alpha = 0.00000001;
            deskBG2.alpha = 1;
        case 3711:
            rainBG.bitmap.time = 0;
        case 3712:
            camGame2.zoom = 1.4;
            FlxTween.tween(camGame2, {zoom: 1}, 2.5, {ease: FlxEase.sineInOut});

            libShader(false);
            deskBG1.loadGraphic(Paths.image('libitina/outrodesk'));
            deskBG1.alpha = 1;
            rainBG.alpha = 1;

            deskBG2.alpha = 0.00000001;
            libFinaleOverlay.alpha = 0.00000001;
        case 3760:
            camGame2.fade(FlxColor.WHITE, 0.3, true);
            camHUD.alpha = 0.00000001;
            deskBG1.alpha = 0.00000001;
            rainBG.alpha = 0.00000001;
    }
    
public var disableCamMove:Bool = false;
function (){
}
