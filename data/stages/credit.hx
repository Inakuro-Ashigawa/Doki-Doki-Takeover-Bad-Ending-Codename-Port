import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import StringTools;
public var disableCamMove:Bool = false;
var ColorMaskShader = new CustomShader('ColorMaskShader');
var FishEyeShader  = new CustomShader('fisheye');
var galleryData:Array<String> = CoolUtil.coolTextFile(Paths.txt('stickerData'));
var stickerSprites:FlxTypedGroup<FlxSprite>;
var stickerSprites:FlxSpriteGroup;
var stickerSprites = new FlxTypedGroup();
var stickerData:Array<String> = [];
var boxY:Int = 10;



function create(){


    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camGame2 = new HudCamera(), false);
    camGame2.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camOverlay = new HudCamera(), false);
    camOverlay.bgColor = FlxColor.TRANSPARENT;



    camGame.bgColor = FlxColor.WHITE;

    
    dokiBackdrop = new FlxBackdrop(Paths.image('scrollingBG'));
    dokiBackdrop.scrollFactor.set(0.1, 0.1);
    dokiBackdrop.velocity.set(-10, 0);
    dokiBackdrop.alpha = 0.3;
    //dokiBackdrop.shader = ColorMaskShader;
    //ColorMaskShader = [0xFFFDFFFF, 0xFFFDDBF1];
    add(dokiBackdrop);

    creditsBG = new FlxBackdrop(Paths.image('credits/pocBackground'));
    creditsBG.scrollFactor.set(0.1, 0.1);
    creditsBG.velocity.set(-50, 0);
    creditsBG.shader = FishEyeShader;
    add(creditsBG);

    var scanline:FlxBackdrop = new FlxBackdrop(Paths.image('credits/scanlines'));
    scanline.scrollFactor.set(0.1, 0.1);
    scanline.velocity.set(0, 20);
    add(scanline);

    var gradient:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/gradent'));
    gradient.scrollFactor.set(0.1, 0.1);
    gradient.screenCenter();
    gradient.setGraphicSize(Std.int(gradient.width * 2.6));
    add(gradient);

    //FlxG.camera.addShader(FishEye);

    staticcredits = new FlxSprite(0, 0);
    staticcredits.frames = Paths.getSparrowAtlas('credits/HomeStatic');
    staticcredits.animation.addByPrefix('idle', 'HomeStatic', 24, true);
    staticcredits.animation.play('idle');
    staticcredits.scrollFactor.set();
    staticcredits.alpha = 0.001;
    staticcredits.cameras = [camGame2];
    staticcredits.setGraphicSize(Std.int(staticcredits.width / defaultHudZoom));
    staticcredits.updateHitbox();
    staticcredits.screenCenter();

    senpaiBox = new FlxSprite(190, 1060).loadGraphic(Paths.image('credits/window_bottom_senpai'));
    senpaiBox.scrollFactor.set(1,1);
    senpaiBox.scale.set(1.25, 1.25);
    senpaiBox.updateHitbox();
    senpaiBox.cameras = [camGame2];

    senpaiBoxtop = new FlxSprite(180, 1050).loadGraphic(Paths.image('credits/window_top'));
    senpaiBoxtop.scrollFactor.set(1,1);
    senpaiBoxtop.scale.set(1.25, 1.25);
    senpaiBoxtop.updateHitbox();
    senpaiBoxtop.cameras = [camGame2];


    //p2Box
    p2Box = new FlxSprite(-265, boxY).loadGraphic(Paths.image('credits/window_bottom'));
    p2Box.scrollFactor.set(1,1);
    p2Box.scale.set(1.25, 1.25);
    p2Box.updateHitbox();
    p2Box.cameras = [camGame2];

    p2Boxtop = new FlxSprite(-265, boxY).loadGraphic(Paths.image('credits/window_top'));
    p2Boxtop.scrollFactor.set(1,1);
    p2Boxtop.scale.set(1.25, 1.25);
    p2Boxtop.updateHitbox();
    p2Boxtop.cameras = [camGame2];

    //P1Box
    p1Box = new FlxSprite(669, boxY).loadGraphic(Paths.image('credits/window_bottom_funkin'));
    p1Box.scrollFactor.set(1,1);
    p1Box.scale.set(1.25, 1.25);
    p1Box.updateHitbox();
    p1Box.cameras = [camGame2];

    p1Boxtop = new FlxSprite(665, boxY).loadGraphic(Paths.image('credits/window_top'));
    p1Boxtop.scrollFactor.set(1,1);
    p1Boxtop.scale.set(1.25, 1.25);
    p1Boxtop.updateHitbox();
    p1Boxtop.cameras = [camGame2];

    cursorDDTO = new FlxSprite(500, 1060).loadGraphic(Paths.image('credits/Arrow'));
    cursorDDTO.scrollFactor.set(1,1);
    cursorDDTO.scale.set(0.4, 0.4);
    cursorDDTO.updateHitbox();
    cursorDDTO.scale.set(1, 1);
    cursorDDTO.cameras = [camGame2];

    cg1 = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/DokiTakeoverLogo'));
    cg1.scrollFactor.set(0,0);
    cg1.alpha = 1;
    cg1.cameras = [camGame2];
    cg1.screenCenter();

    cg2 = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/thanksforplaying'));
    cg2.alpha = 0.001;
    cg2.scrollFactor.set(0,0);
    cg2.alpha = 0.001;
    cg2.cameras = [camGame2];

    dad.alpha = 0.001;

}
function postCreate(){
    

    insert(members.indexOf(dad) - 1, p2Box);
    insert(members.indexOf(gf) + 2, p2Boxtop);

    insert(members.indexOf(boyfriend) - 1, p1Box);
    insert(members.indexOf(boyfriend) + 1, p1Boxtop);

    insert(members.indexOf(boyfriend) - 2, senpaiBox);
    insert(members.indexOf(boyfriend) - 1, senpaiBoxtop);

    add(cursorDDTO);

    add(staticcredits);
    add(cg1);

    cg2.setGraphicSize(Std.int(cg2.width / defaultCamZoom));
    cg2.updateHitbox();
    cg2.screenCenter();
    add(cg2);

    stickerSprites = new FlxSpriteGroup();
    stickerSprites.alpha = 0.001;
    add(stickerSprites);
    
		var funX:Int;
		var funY:Int;
		for (i in 0...galleryData.length)
		{
            if (!StringTools.startsWith(galleryData[i], '//')) continue;
			var data:Array<String> = galleryData[i].split('::');
			stickerData.push(data[0]);
		}

		for (i in 0...4)
		{
            switch (i)
			{
				default:
					funX = 0;
					funY = 0;
				case 1:
					funX = 1025;
					funY = 0;
				case 2:
					funX = 0;
					funY = 465;
				case 3:
					funX = 1025;
					funY = 465;
			}
            var sticker = new FlxSprite(funX, funY).loadGraphic(Paths.image('stickies/' +  stickerData[0]));
        }
        
			sticker.scale.set(0.85, 0.85);
			sticker.updateHitbox();
            sticker.scrollFactor.set(0,0);
            sticker.cameras = [camHUD];
            stickerSprites.cameras = [camHUD];
			stickerSprites.add(sticker);
        }
        
var cancelCameraMove:Bool = true;


function onCameraMove(e) if(cancelCameraMove) e.cancel();

        
function postUpdate(){


    boyfriend.cameras = [camGame2];
    gf.cameras = [camGame2];
    dad.cameras = [camGame2];
}
function creditsCharSwap(chara:String, ?unhide:Bool)
	{
		var funnycostume:String = 'casual';
		if (unhide)
			dad.alpha = 1;

		switch (chara)
		{
			case 'sayori'|'natsuki'|'yuri'|'protag':
				p2Box.loadGraphic(Paths.image('credits/window_bottom_' + chara));
			case 'monika' | 'monika-pixelnew':
				p2Box.loadGraphic(Paths.image('credits/window_bottom_monika'));
			default:
				p2Box.loadGraphic(Paths.image('credits/window_bottom'));
		}

		if (chara == 'monika-pixelnew')
			funnycostume = 'hueh';

		//addcharacter(chara, 1, false, funnycostume);
		var boxFlash:FlxSprite = new FlxSprite(p2Box.x, p2Box.y).makeGraphic(745, 864, FlxColor.WHITE);
		boxFlash.alpha = 1;
		boxFlash.cameras = [camGame2];
		insert(members.indexOf(p2Boxtop) + 1, boxFlash);
		FlxTween.tween(boxFlash, {alpha: 0.001}, 0.4, {ease: FlxEase.sineOut});
		cursorDDTO.loadGraphic(Paths.image('credits/Arrow'));
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			FlxTween.tween(cursorDDTO, {x: cursorDDTO.x - 120, y: cursorDDTO.y - 700}, 0.5, {ease: FlxEase.sineInOut});
		});
	}
	function prepareCharSwap()
        {
            cursorDDTO.loadGraphic(Paths.image('credits/Arrow_HOLD'));
            cursorDDTO.setPosition(1300, 1080);
            FlxTween.tween(cursorDDTO, {x: 205, y: 415}, 0.6, {ease: FlxEase.sineOut});
        }
    
function stepHit(curStep){
    switch (curStep)
    {
    case 48:
        FlxTween.tween(cg1, {alpha: 0.001}, 1, {
            ease: FlxEase.sineOut,
            onComplete: function(tween:FlxTween)
            {
                cg1.loadGraphic(Paths.image('credits/CreditsShit2'));
                cg1.screenCenter();
            }
        });
    case 54:
        FlxTween.tween(camHUD, {alpha: 1}, 2, {ease: FlxEase.sineOut});
        FlxTween.tween(camFollow, {y: 460}, 2, {ease: FlxEase.sineOut});
    case 66 | 450 | 834 | 1218 | 1606 | 1866:
        prepareCharSwap();
    case 76:
        creditsCharSwap("monika-pixelnew", true);
        summmonStickies(true, 8);
    case 208 | 464 | 592 | 720 | 848 | 976 | 1104 | 1300 | 1744 | 1880 | 2008 | 2072 | 2136 | 2200:
        summmonStickies(true, 8);
        case 239:
            defaultCamZoom = 0.5;
            // Worst thing known to man right now

            FlxTween.tween(p2Box, {x: p2Box.x - 200}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(p2Boxtop, {x: p2Boxtop.x - 200}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(dad, {x: dad.x - 200}, 2, {ease: FlxEase.sineOut});

            FlxTween.tween(p1Box, {x: p1Box.x + 200}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(p1Boxtop, {x: p1Boxtop.x + 200}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(boyfriend, {x: boyfriend.x + 200}, 2, {ease: FlxEase.sineOut});

            cursorDDTO.setPosition(500, 1060);
            FlxTween.tween(senpaiBox, {y: senpaiBox.y - 900}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(senpaiBoxtop, {y: senpaiBoxtop.y - 900}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(cursorDDTO, {y: cursorDDTO.y - 900 + 10}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(gf, {y: gf.y - 900}, 2, {ease: FlxEase.sineOut});
        case 336:
            summmonStickies(true, 8);
        case 440:
            FlxTween.tween(senpaiBox, {y: senpaiBox.y - 1600}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(senpaiBoxtop, {y: senpaiBoxtop.y - 1600}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(cursorDDTO, {y: cursorDDTO.y - 1600 + 10}, 2, {ease: FlxEase.sineOut});
            FlxTween.tween(gf, {y: gf.y - 1600}, 2, {ease: FlxEase.sineOut});
        case 460:
            //forcedPause = 'sayori';
            defaultCamZoom = 0.5;
            creditsCharSwap("sayori");
            senpaiBox.visible = false;
            senpaiBoxtop.visible = false;
            gf.visible = false;
        case 844:
            forcedPause = 'natsuki';
            creditsCharSwap("natsuki");
        case 1228:
            forcedPause = 'yuri';
            creditsCharSwap("yuri");
            summmonStickies(true, 8);
        case 1392:
            FlxTween.tween(staticcredits, {alpha: 1}, 5, {ease: FlxEase.sineOut});
        case 1488:
            staticcredits.alpha = 0.0001;
            dad.alpha = 1;
            extrachar1.alpha = 0;
            creditsCharSwap("yuri");
            summmonStickies(true, 8);
    }
}

function summmonStickies(?fadeOut:Bool, ?startDelayDur:Float = 0.5)
	{
			stickerSprites.alpha = 1;
			for (item in stickerSprites.members)
			{
				if (stickerData.length <= 0)
					trace('We somehow ran out of stickers!');

				var rand:Int = FlxG.random.int(0, stickerData.length - 1);
                var rand:String = stickerData[FlxG.random.int(0, stickerData.length - 1)];
				var stike:String = stickerData[rand];

				if (stickerData[rand] == null && rand >= stickerData.length)
				{
					rand -= 1;
					stike = stickerData[rand];
				}

				if (stike != null)
					trace('This Sticker exists ' + stike);
				else //FIX FOUND
					trace('This Sticker doesnt exists ' + stickerData.length + ' which number' + rand);

				item.loadGraphic(Paths.image('stickies/' + rand));
				stickerData.remove(rand);
				item.scale.set(1, 1);
				FlxTween.tween(item.scale, {"x": 0.85, "y": 0.85}, 0.1, {});
			}
			if (fadeOut)
				FlxTween.tween(stickerSprites, {alpha: 0.001}, 1, {startDelay: startDelayDur});
		}
