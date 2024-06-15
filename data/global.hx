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
	FlxG.mouse.visible = true;

    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
function update(elapsed){
	cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor"));
	FlxG.mouse.load(cursorShit.pixels);
}
if (FlxG.keys.pressed.M)
    trace('Story Mode Progress Reset!');
    FlxG.save.data.beatPrologue = null;
    FlxG.save.data.beatSayori = null;
    FlxG.save.data.beatNatsuki = null;
    FlxG.save.data.beatYuri = null;
    FlxG.save.data.beatMonika = null;
    FlxG.save.data.beatFestival = null;
    FlxG.save.data.beatEncore = null;
    FlxG.save.data.beatProtag = null;

function new() {
    if (FlxG.save.data.beatPrologue == null)  FlxG.save.data.beatPrologue = false;
    if (FlxG.save.data.beatSayori == null)  FlxG.save.data.beatSayori = false;
    if (FlxG.save.data.beatNatsuki == null)  FlxG.save.data.beatNatsuki = false;
    if (FlxG.save.data.beatYuri == null)  FlxG.save.data.beatYuri = false;
    if (FlxG.save.data.beatMonika == null)  FlxG.save.data.beatMonika = false;
    if (FlxG.save.data.beatFestival == null)  FlxG.save.data.beatFestival = false;
    if (FlxG.save.data.beatEncore == null)  FlxG.save.data.beatEncore = false;
    if (FlxG.save.data.beatProtag == null)  FlxG.save.data.beatProtag = false;

    Lib.application.onExit.add(function(i:Int) {
        FlxG.save.flush();
        trace("Saving Mod Progress...");
    });
     
}