import flixel.group.FlxGroup.FlxTypedGroup;
var bgDokis:FlxTypedGroup<FlxSprite>;
var isFestival:Bool = false;

function create(){
    isFestival = true;

    bgDokis = new FlxTypedGroup();

    monika = new FlxSprite(320, 173);
    monika.frames = Paths.getSparrowAtlas('bgdoki/monika');
    monika.animation.addByPrefix('bop', 'Moni BG', 24, false);
    monika.animation.play('bop');
    monika.scrollFactor.set(1, 1);
    monika.setGraphicSize(Std.int(monika.width * 0.7));
    monika.updateHitbox();


    sayori = new FlxSprite(-49, 247);
    sayori.frames = Paths.getSparrowAtlas('bgdoki/sayori');
    sayori.animation.addByPrefix('bop', 'Sayori BG', 24, false);
    sayori.animation.play('bop');
    sayori.scrollFactor.set(1, 1);
    sayori.setGraphicSize(Std.int(sayori.width * 0.7));
    sayori.updateHitbox();

    natsuki = new FlxSprite(1247, 303);
    natsuki.frames = Paths.getSparrowAtlas('bgdoki/natsuki');
    natsuki.animation.addByPrefix('bop', 'Natsu BG', 24, false);
    natsuki.animation.play('bop');
    natsuki.scrollFactor.set(1, 1);
    natsuki.setGraphicSize(Std.int(natsuki.width * 0.7));
    natsuki.updateHitbox();

    protag = new FlxSprite(150, 152);
    protag.frames = Paths.getSparrowAtlas('bgdoki/protag');
    protag.animation.addByPrefix('bop', 'Protag-kun BG', 24, false);
    protag.animation.play('bop');
    protag.scrollFactor.set(1, 1);
    protag.setGraphicSize(Std.int(protag.width * 0.7));
    protag.updateHitbox();
    
    yuri = new FlxSprite(1044, 178);
    yuri.frames = Paths.getSparrowAtlas('bgdoki/yuri');
    yuri.animation.addByPrefix('bop', 'Yuri BG', 24, false);
    yuri.animation.play('bop');
    yuri.scrollFactor.set(1, 1);
    yuri.setGraphicSize(Std.int(yuri.width * 0.7));
    yuri.updateHitbox();

    if (isFestival)
        {
            var club:Array= [monika, sayori, natsuki, protag, yuri, boyfriend, gf,dad];
            for (member in club)
                member.color = 0x828282;
        }

    lights_front = new FlxSprite(-605, 565);
    lights_front.frames = Paths.getSparrowAtlas('festival/lights_front');
    lights_front.animation.addByPrefix('idle', 'lights Front', 24, true);
    lights_front.animation.play('idle');
    lights_front.scrollFactor.set(1.1,0.9);
    lights_front.setGraphicSize(Std.int(lights_front.width * 1.6));

    deskfront = new FlxSprite(-700, -520).loadGraphic(Paths.image('festival/DesksFestival'));
    deskfront.scrollFactor.set(1.3,0.9);
    deskfront.setGraphicSize(Std.int(deskfront.width * 1.6));
    deskfront.updateHitbox();

    closet = new FlxSprite(-700, -520).loadGraphic(Paths.image('festival/FarBack'));
    closet.scrollFactor.set(.9,.9);
    closet.setGraphicSize(Std.int(closet.width * 1.6));
    closet.updateHitbox();
    insert(0,closet);

    clubroom = new FlxSprite(-700, -520).loadGraphic(Paths.image('festival/MainBG'));
    clubroom.scrollFactor.set(1,0.9);
    clubroom.setGraphicSize(Std.int(clubroom.width * 1.6));
    clubroom.updateHitbox();
    insert(1,clubroom);
    
    lights_back = new FlxSprite(390, 179);
    lights_back.scrollFactor.set(1.1,0.9);
    lights_back.frames = Paths.getSparrowAtlas('festival/lights_back');
    lights_back.animation.addByPrefix('idle', 'lights back', 24, true);
    lights_back.animation.play('idle');
    lights_back.setGraphicSize(Std.int(lights_front.width * 1.6));

    banner = new FlxSprite(-700, -520).loadGraphic(Paths.image('festival/FestivalBanner'));
    banner.scrollFactor.set(1,0.9);
    banner.setGraphicSize(Std.int(banner.width * 1.6));
    banner.screenCenter(FlxAxes.X);
    banner.updateHitbox();
    add(banner);

    insert(3,bgDokis);
    if(["crucify (yuri mix)"].contains(curSong)){
        bgDokis.add(sayori);
        bgDokis.add(natsuki);  
        bgDokis.add(monika);  
    }
}
function postCreate(){
    add(deskfront);
}
function beatHit(){  
if (curBeat % 2 == 0){
    if (monika != null)
        monika.animation.play('bop');
    if (protag != null)
        protag.animation.play('bop');
    sayori.animation.play('bop');
    natsuki.animation.play('bop');
    yuri.animation.play('bop');
    }
}