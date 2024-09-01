var dadZoom:Float = 0.625;
var bfZoom:Float = 1;

function create(): Void {
    deskfront = new FlxSprite(-350, -410).loadGraphic(Paths.image('clubroom/DesksFront'));
    deskfront.scrollFactor.set(1.3, 1);
    deskfront.setGraphicSize(Std.int(deskfront.width * 1.6));
    deskfront.updateHitbox();
    add(deskfront);
}

function update(elapsed: Float){
    switch (curCameraTarget) {
        case 0:
            defaultCamZoom = dadZoom;
        case 1:
            defaultCamZoom = bfZoom;
    }
}

function changeZooms(){
    dadZoom = 1.2;
}