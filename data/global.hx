import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import lime.graphics.Image;

public var SaveData = FlxG.save.data;
public var isStoryMode:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    TitleState => "Doki/DokiTitle",
    MainMenuState =>  "Doki/DokiMain",
    StoryMenuState  =>  "Doki/DokiStory",
];

Lib.application.onExit.add(function(i:Int) {
    FlxG.save.flush();
    //SaveData.weekUnlocked = weeks;
    trace("Saving Mod Progress...");
});

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

cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor"));
FlxG.mouse.load(cursorShit.pixels);