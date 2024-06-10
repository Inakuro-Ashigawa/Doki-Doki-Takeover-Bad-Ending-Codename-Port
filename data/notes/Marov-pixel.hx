static var daPixelZoom = 6;

/*
function onNoteCreation(e) {
switch (e.noteType) {
    case "Marov-pixel":

        var note = event.note;
        note.loadGraphic(Paths.image('game/score/pixelUI/NOTE_assets'), true, 17, 17);
		note.animation.add("scroll", [8 + event.strumID]);
        note.scale.set(daPixelZoom, daPixelZoom);
        note.updateHitbox();
 }
}
 */

function onPlayerMiss(e) {
	if (e.noteType == "Marov-pixel") {
		e.cancel();
		deleteNote(e.note);
	}
}
