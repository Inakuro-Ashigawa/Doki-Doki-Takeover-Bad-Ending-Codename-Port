var lib;
var iconP3:HealthIcon;

function postCreate(){   
    add(lib);  
    inst.volume = .3;
     
    iconP3 = new HealthIcon(gf != null && gf.icon!=null?gf.icon:gf.curCharacter, false);
    iconP3.cameras = [camHUD];
	add(iconP3);

    iconP3.alpha = 0.001;
}
function beatHit(){
    iconP3.scale.set(1.2, 1.2);
}
function update(elapsed:Float){
    iconP3.health = iconP2.health;
    iconP3.x = iconP2.x - 70;
    iconP3.y = iconP2.y - 40;
}
function create(){
    lib = strumLines.members[3].characters[0];
    remove(lib);
    wingf.alpha = gf.alpha = winLib.alpha = lib.alpha = 0.001;
    winLib.scrollFactor.set(1,1);
    lib.scrollFactor.set(1,1);
    gf.scrollFactor.set(1,1);
    winLib.scrollFactor.set(1,1);
    winbf.scrollFactor.set(1,1);
    windad.scrollFactor.set(1,1);
    wingf.scrollFactor.set(1,1);
    PlayState.SONG.meta.pause = 'monika';
}
function libdown(){
    FlxTween.tween(lib, {alpha: 1,y:-200}, 2, {ease: FlxEase.sineOut});
    FlxTween.tween(winLib, {alpha: 1,y:-20}, 1.9, {ease: FlxEase.sineOut});
    FlxTween.tween(winbf, {x: 1290}, 1, {ease: FlxEase.sineOut});
    FlxTween.tween(boyfriend, {x: 1420}, 1, {ease: FlxEase.sineOut});
    FlxTween.tween(windad, {x: -356}, 1, {ease: FlxEase.sineOut});
    FlxTween.tween(dad, {x: -278}, 1, {ease: FlxEase.sineOut});
    PlayState.SONG.meta.pause = 'libitina';
}
function libleave(){
    //nun
}
function SayoDown(){
    wingf.alpha = gf.alpha = iconP3.alpha = 1;
    FlxTween.tween(lib, {y:100}, 2, {ease: FlxEase.sineOut});
    FlxTween.tween(winLib, {y: 300}, 1.9, {ease: FlxEase.sineOut});
    FlxTween.tween(gf, {y: 100}, 2, {ease: FlxEase.sineOut});
    FlxTween.tween(wingf, {y:-100}, 1.9, {ease: FlxEase.sineOut});
    PlayState.SONG.meta.pause = 'sayori';
}