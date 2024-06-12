
public var disableCamMove:Bool = false;
public var colouredBarG = (gf != null && gf.xml != null && gf.xml.exists("color")) ? CoolUtil.getColorFromDynamic(gf.xml.get("color")) : 0xFFFFFFFF;
public var colouredBarB = (boyfriend != null && boyfriend.xml != null && boyfriend.xml.exists("color")) ? CoolUtil.getColorFromDynamic(boyfriend.xml.get("color")) : 0xFFFFFFFF;

var angleCamVar:Float = 0;
function postUpdate(elapsed){
    // the movement will speeded up if you set the 'camera.followLerp' above 0.04
    var angleLerp:Float = FlxMath.bound(FlxMath.bound(elapsed * 2.4 / 0.4, 0, 1) + camera.followLerp * 1 / 5, 0, 1);

    if (curCameraTarget == null || curCameraTarget == -1 || disableCamMove) return;
        switch (strumLines.members[curCameraTarget].characters[0].getAnimName()) {
            case "singLEFT", "singLEFT-alt": 
                camFollow.x -= 20;
                angleCamVar = -20/50;
            case "singDOWN", "singDOWN-alt": 
                camFollow.y += 120;
            case "singUP", "singUP-alt": 
                camFollow.y -= 120;
            case "singRIGHT", "singRIGHT-alt": 
                camFollow.x += 20;
                angleCamVar = 20/50;
    }
    if (angleCamVar != 0) angleCamVar = (lerp(angleCamVar, 0, angleLerp));
    camera.angle = (lerp(camera.angle, 0 + angleCamVar, angleLerp));
}

function onSongStart(){
    DokiTxt.color = colouredBarB;
	curCameraTarget = -1;
	camFollow.x = 650;
	camFollow.y -= 100;
	defaultCamZoom = 0.8;
    camHUD.alpha = 0;

	camera.zoom = 0.7;

	camera.flash(FlxColor.BLACK, 10);
}

function onPlayerHit(note:NoteHitEvent) {

    var curNotes = note.noteType;

    switch(curNotes){
        case "GF Sing":
            DokiTxt.color = colouredBarG;

        case null | "":
            DokiTxt.color = colouredBarB;
    }

}