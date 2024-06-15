var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "duet notes":
        gf.playAnim("sing" + singDir[note.direction], true);
        dad.playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();
        note.healthGain += 0.002;
    }
}