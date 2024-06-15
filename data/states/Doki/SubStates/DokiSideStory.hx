//imports
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.effects.FlxFlicker;

//vars

var songData:Array<Array<Dynamic>> = [
    // internal name, song name, posX, posY
    ['lovenfunkin', 'Love n Funkin', 305, 64],
    ['zipper', 'Constricted', 662, 64],
    ['catfight', 'Catfight', 305, 266],
    ['wilted', 'Wilted', 662, 266],
    ['meta', 'Libitina', 303, 463]
];
public var acceptInput:Bool = false;
var cursor:FlxSprite;
var curSelected:Int = 0;
var diffSelect:Bool = false;
var diffText:FlxText;
var curDifficulty:Int = 1;
var curSong:String = "";
var selectGrp:FlxTypedGroup<FlxSprite>;
var selectGrp = new FlxTypedGroup();

function create(){

    SubStateOpen = true;
    
    var background:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFF38CC5);
    background.alpha = 0.4;
    add(background);

    var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('dokistory/sidestories/sidestoriesmenu'));
    add(menuBG);

    add(selectGrp);

    for (i in 0...songData.length)
    {
        var sideIcon:FlxSprite = new FlxSprite(songData[i][2], songData[i][3]).loadGraphic(Paths.image('dokistory/sidestories/sidestory_' + songData[i][0]));
        sideIcon.ID = i;
        selectGrp.add(sideIcon);
    }

    cursor = new FlxSprite().loadGraphic(Paths.image('dokistory/sidestories/cursorsidestories'));
    add(cursor);

    new FlxTimer().start(0.1, function(tmr:FlxTimer)
    {
        acceptInput = true;
    });
}

function update(elapsed:Float)
{
    if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            close();
        }

        if (controls.LEFT_P)
            changeItem(-1);
        if (controls.RIGHT_P)
            changeItem(1);

        if (controls.UP_P)
            changeItem(-2);
        if (controls.DOWN_P)
            changeItem(2);

}
function changeItem(amt:Int = 0)
	{
		var prevselected:Int = curSelected;
		curSelected += amt;
        curSelected = FlxMath.wrap(curSelected + amt, 0, songData.length-1);

		if (prevselected != curSelected)
			FlxG.sound.play(Paths.sound('scrollMenu'));

		if (curSelected == 5 && prevselected != 4)
			curSelected = 4;


		curSong = songData[curSelected][1];
		cursor.x = songData[curSelected][2];
		cursor.y = songData[curSelected][3];

		if (songData[curSelected][0] == 'meta')
			cursor.loadGraphic(Paths.image('dokistory/sidestories/cursorsidestories_meta'));
		else
			cursor.loadGraphic(Paths.image('dokistory/sidestories/cursorsidestories'));
	}
