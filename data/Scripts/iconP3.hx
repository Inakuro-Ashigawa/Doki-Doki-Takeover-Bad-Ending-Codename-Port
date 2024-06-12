static var isPlayer:Bool = true;

static var iconP3:HealthIcon;

static var doGlitchIconEffect = true;

function postCreate(){    
    iconP3 = new HealthIcon(gf != null && gf.icon!=null?gf.icon:gf.curCharacter, isPlayer);
    iconP3.cameras = [camHUD];
	insert(members.indexOf(iconP1)+1, iconP3);

    if (curSong == "retcon" || curSong == "my-amazing-world"){
        iconP3.setPosition(iconP1.x-20, iconP1.y+20);

        iconP3.scale.set(0.8, 0.8);
    } else {
        iconP3.setPosition(iconP1.x+350, iconP1.y);
    }
    iconP3.scale.set(0.7, 0.7);
}
function beatHit(){
    iconP3.scale.set(1.2, 1.2);
}
function update(elapsed:Float){
    iconP3.health = isPlayer? iconP1.health : iconP2.health;

    if (isPlayer){
        if (healthBar.percent < 20){
            if (Options.gameplayShaders && doGlitchIconEffect) 
                boyfriend.shader = invert;
                gf.shader = invert;
                iconP3.shader = glitches;
        } else {
            boyfriend.shader = null;
            gf.shader = null;
            iconP3.shader = null;
        }
    } else {
        if (healthBar.percent > 80){
            if (Options.gameplayShaders && doGlitchIconEffect) 
            boyfriend.shader = invert;
            gf.shader = invert;
            iconP3.shader = glitches;
        } else {
            boyfriend.shader = null;
            gf.shader = null;
            iconP3.shader = null;
        }
    }
}