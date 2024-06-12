var option = FlxG.save.data;

function postCreate(){
}
function onCountdown(event) {
if (option.gfCountdown){
    switch(event.swagCounter) {
        case 0:
            curCameraTarget = 0;
            camera.zoom += 0.06;
            gf.playAnim('countdownThree', true); 

        case 1: 
            curCameraTarget = 1;
            camera.zoom += 0.06; 
            gf.playAnim('countdownTwo', true); 

        case 2:
            camera.zoom += 0.06; 
            gf.playAnim('countdownOne', true); 

        case 3: 
            FlxTween.tween(camera, {zoom: defaultCamZoom}, 1.2); // for zoom back to their default camZoom
            gf.playAnim('countdownGo', true); 
            camHUD.flash(FlxColor.WHITE, 0.25);
    }
 }
}