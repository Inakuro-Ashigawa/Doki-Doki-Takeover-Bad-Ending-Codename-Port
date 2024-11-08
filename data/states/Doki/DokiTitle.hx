//imports
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;

//shaders
var ColorMaskShader = new CustomShader('ColorMaskShader');

//vars
var initialized:Bool = false;
var blackScreen:FlxSprite;
var credGroup:FlxSpriteGroup;
var credTextShit:Alphabet;
var textGroup:FlxSpriteGroup;
var moniSpr:FlxSprite;
var tbdSpr:FlxSprite;
var doki:FlxSprite;
var curWacky:Array<String> = [];
var wackyImage:FlxSprite;

//vars part 2
var dokiApp:FlxSprite;
var bottom:Int;
var top:Int;
var logoBl:FlxSprite;
var gfDance:FlxSprite;
var backdrop:FlxBackdrop;
var creditsBG:FlxBackdrop;
var scanline:FlxBackdrop;
var gradient:FlxSprite;
var danceLeft:Bool = false;
var titleText:FlxSprite;

function setColorUniform(obj:Dynamic, color:Int) {
    obj.value = [(color >> 16 & 0xFF) / 255, (color >> 8 & 0xFF) / 255, (color & 0xFF) / 255];
}

function create(){
    startIntro();
}
function startIntro(){
	if (!initialized){
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
		Conductor.changeBPM(120);
		FlxG.sound.music.fadeIn(2, 0, 0.7);
	}

	backdrop = new FlxBackdrop(Paths.image('scrollingBG'));
	backdrop.velocity.set(-10, 0);
	backdrop.antialiasing = Options.Antialiasing;
	backdrop.shader = new CustomShader("ColorMaskShader");
	setColorUniform(backdrop.shader.data.color1, 0xFFFDEBF7);
	setColorUniform(backdrop.shader.data.color2, 0xFFFDDBF1);
	add(backdrop);

	creditsBG = new FlxBackdrop(Paths.image('credits/pocBackground'));
	creditsBG.velocity.set(-50, 0);
	creditsBG.antialiasing = Options.Antialiasing;
	add(creditsBG);

	var scanline:FlxBackdrop = new FlxBackdrop(Paths.image('credits/scanlines'));
	scanline.velocity.set(0, 20);
	scanline.antialiasing = Options.Antialiasing;
	add(scanline);

	var gradient:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/gradent'));
	gradient.antialiasing = Options.Antialiasing;
	gradient.scrollFactor.set(0.1, 0.1);
	gradient.screenCenter();
	gradient.setGraphicSize(Std.int(gradient.width * 1.4));
	add(gradient);

	logoBl = new FlxSprite(-40, -12);
	logoBl.frames = Paths.getSparrowAtlas('menus/title/Start_Screen_AssetsPlus');
	logoBl.antialiasing = Options.Antialiasing;
	logoBl.setGraphicSize(Std.int(logoBl.width * 0.8));
	logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
	logoBl.updateHitbox();

	gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
	gfDance.frames = Paths.getSparrowAtlas('menus/title/gfDanceTitle');
	gfDance.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
	gfDance.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	gfDance.antialiasing = Options.Antialiasing;
	add(gfDance);
	add(logoBl);

	titleText = new FlxSprite(170, FlxG.height * 0.8);
	titleText.frames = Paths.getSparrowAtlas('menus/title/titleEnter');
	titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
	titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
	titleText.antialiasing = Options.Antialiasing;
	titleText.animation.play('idle');
	titleText.updateHitbox();
	add(titleText);

	credGroup = new FlxGroup();
	add(credGroup);
	textGroup = new FlxSpriteGroup();

	blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	credGroup.add(blackScreen);

	credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
	credTextShit.screenCenter();

	credTextShit.visible = false;

	// Put whatever hueh you want in the array
	var huehArray:Array<String> = ['TBDHueh', 'NatHueh', 'SayoHueh', 'YuriHueh', 'MoniHueh', 'ProtagHueh'];
	var hueh:String = huehArray[FlxG.random.int(0, huehArray.length - 1)];

	// hueh = 'TBDHueh'; // Forced hueh string
	moniSpr = new FlxSprite(0, FlxG.height * .7).loadGraphic(Paths.image('menus/title/hueh/' + hueh));
	moniSpr.visible = false;
	moniSpr.setGraphicSize(Std.int(moniSpr.width * 1.2));
	moniSpr.updateHitbox();
	moniSpr.screenCenter(FlxAxes.X);
	moniSpr.antialiasing = Options.Antialiasing;
	add(moniSpr);

	tbdSpr = new FlxSprite(0, FlxG.height * .45).loadGraphic(Paths.image('menus/title/TBDLogo'));
	tbdSpr.visible = false;
	tbdSpr.setGraphicSize(Std.int(tbdSpr.width * 0.9));
	tbdSpr.updateHitbox();
	tbdSpr.screenCenter(FlxAxes.X);
	tbdSpr.antialiasing = Options.Antialiasing;
	add(tbdSpr);

	//Handling doki stuff
	dokiApp = new FlxSprite(0, 0);

	// Before, Natsuki had a 4/5 chance of appearing.
	// Totally not fair!
	// [Pop up string, Bottom, Top]
	var dokiArray:Array = [
		['NatsukiPopup', 770, 270], 
		['SayoriPopup', 770, 270],  
		['YuriPopup', 770, 240]
	];

	if (FlxG.save.data.beatYuri)
		dokiArray.push(['MonikaPopup', 770, 180]);

	if (FlxG.save.data.beatProtag)
		dokiArray.push(['ProtagPopup', 770, 170]);

	// The selected doki
	var selected:String = FlxG.random.int(0, dokiArray.length - 1);

	// selected = 0 // Forced doki for testing

	var dokiIndex:String = dokiArray[selected][0];
	bottom = dokiArray[selected][1];
	top = dokiArray[selected][2];

	trace(dokiArray[selected][0]);

	dokiApp.setPosition(0, bottom);
	dokiApp.frames = Paths.getSparrowAtlas('intro/' + dokiIndex);
	dokiApp.animation.addByPrefix('pop', dokiIndex, 26, false);
	dokiApp.screenCenter(FlxAxes.X);
	dokiApp.antialiasing = Options.Antialiasing;
	add(dokiApp);

	//preload maybe
	var predoki = new FlxSprite(0, 0);
	predoki.frames = Paths.getSparrowAtlas('intro/'+ dokiIndex );
	predoki.animation.addByPrefix('pop', dokiIndex, 26, false);
	predoki.screenCenter();
	predoki.antialiasing = Options.Antialiasing;
	predoki.alpha = 0.001;
	add(predoki);

	doki = new FlxSprite(50, 100);
	doki.frames = Paths.getSparrowAtlas('intro/DOKI DOKI');
	doki.animation.addByPrefix('doki', "Doki centered", 24, false);
	doki.antialiasing = Options.Antialiasing;
	doki.alpha = 0.001;
	doki.updateHitbox();
	add(doki);

	FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: 4});

	add(textGroup);
	
	if (initialized)
		skipIntro();
	else
		initialized = true;
}

function getIntroTextShit() {
	var fullText:String = Assets.getText(Paths.txt('introText'));
	var firstArray:Array<String> = fullText.split('\n');
	var swagGoodArray:Array<Array<String>> = [];

	for (i in firstArray)
	{
		swagGoodArray.push(i.split('--'));
	}

	return swagGoodArray;
}

function beatHit(){
	logoBl.animation.play('bump', true);
	danceLeft = !danceLeft;

	if (danceLeft)
		gfDance.animation.play('danceRight');
	else
		gfDance.animation.play('danceLeft');

	switch (curBeat)
	{
		case 1:
			createCoolText(['Team TBD']);
		case 3:
			//addMoreText('presents');
			tbdSpr.visible = true;
		case 4:
			tbdSpr.visible = false;
			deleteCoolText();
		case 5:
			createCoolText(['Powered', 'by']);
		case 7:
			addMoreText('Codename Engine');
			moniSpr.visible = true;
		case 8:
			deleteCoolText();
			moniSpr.visible = false;
		case 9:
			createCoolText([curWacky[0]]);
		case 11:
			addMoreText(curWacky[1]);
		case 12:
			deleteCoolText();
		case 13:
			// addMoreText('Doki');
			dokiApp.animation.play('pop');
			FlxTween.tween(dokiApp, {"scale.x": 0.75, y: top}, 0.15, {ease: FlxEase.sineIn, startDelay: 0.2, onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(dokiApp, {"scale.x": 1}, 0.2, {ease: FlxEase.bounceInOut});
				}});
		case 14:
			doki.alpha = 1;
			doki.animation.play('doki');
		case 15:
		case 16:
			skipIntro();
	}
}

var transitioning:Bool = false;
function update(elapsed:Float){
	if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;

	var pressedEnter:Bool = controls.ACCEPT || FlxG.mouse.justPressed;

	if (pressedEnter && !transitioning && skippedIntro){
		if (FlxG.save.data.flashing)
			titleText.animation.play('press');

		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

		transitioning = true;

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxG.switchState(new MainMenuState());
		});
	}

	if (pressedEnter && !skippedIntro && initialized)
		skipIntro();
}
var skippedIntro:Bool = false;

function skipIntro(){
	if (!skippedIntro)
	{
		remove(moniSpr);
		remove(tbdSpr);
		remove(doki);
		remove(dokiApp);
		deleteCoolText();

		FlxG.camera.flash(FlxColor.WHITE, 4);
		remove(credGroup);
		remove(textGroup);
		skippedIntro = true;
	}
}
//word text shits
function createCoolText(textArray:Array<String>) {
	for (text in textArray) {
		if (text == "" || text == null) continue;
		var money:Alphabet = new Alphabet(0, (textArray.indexOf(text) * 60) + 200, text, true, false);
		money.screenCenter(FlxAxes.X);
		textGroup.add(money);
	}
}

function addMoreText(text:String) {
	var coolText:Alphabet = new Alphabet(0, (textGroup.length * 60) + 200, text, true, false);
	coolText.screenCenter(FlxAxes.X);
	textGroup.add(coolText);
}

function deleteCoolText() {
	while (textGroup.members.length > 0) {
		textGroup.members[0].destroy();
		textGroup.remove(textGroup.members[0], true);
	}
}