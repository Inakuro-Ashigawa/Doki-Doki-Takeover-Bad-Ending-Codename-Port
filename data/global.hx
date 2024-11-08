import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import lime.graphics.Image;

public static var SaveData = FlxG.save.data;

static var redirectStates:Map<FlxState, String> = [
    TitleState => "Doki/DokiTitle",
    MainMenuState =>  "Doki/DokiMain",
    StoryMenuState  =>  "Doki/DokiStory2",
];

function preStateSwitch() {
    FlxG.mouse.useSystemCursor = false;
    cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor"));
	FlxG.mouse.load(cursorShit.pixels);
	FlxG.mouse.visible = true;

    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
function update(elapsed){
    if (FlxG.keys.pressed.M){
        trace('Story Mode Progress Reset!');
        SaveData.beatPrologue = null;
        SaveData.beatSayori = null;
        SaveData.beatNatsuki = null;
        SaveData.beatYuri = null;
        SaveData.beatMonika = null;
        SaveData.beatFestival = null;
        SaveData.beatEncore = null;
        SaveData.beatProtag = null;
        SaveData.checkAllSongsBeaten = null
    }
}

function new() {
    if (SaveData.beatPrologue == null)  SaveData.beatPrologue = false;
    if (SaveData.beatSayori == null)  SaveData.beatSayori = false;
    if (SaveData.beatNatsuki == null)  SaveData.beatNatsuki = false;
    if (SaveData.beatYuri == null)  SaveData.beatYuri = false;
    if (SaveData.beatMonika == null)  SaveData.beatMonika = false;
    if (SaveData.beatFestival == null)  SaveData.beatFestival = false;
    if (SaveData.beatEncore == null)  SaveData.beatEncore = false;
    if (SaveData.beatProtag == null)  SaveData.beatProtag = false;
    if (SaveData.checkAllSongsBeaten == null) SaveData.checkAllSongsBeaten = false;

    Lib.application.onExit.add(function(i:Int) {
        FlxG.save.flush();
        trace("Saving Mod Progress...");
    });
     
}