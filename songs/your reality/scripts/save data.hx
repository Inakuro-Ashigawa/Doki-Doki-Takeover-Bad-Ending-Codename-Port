function onSongEnd() {
  if (!PlayState.isStoryMode) return;
  FlxG.save.data.beatPrologue = true;
}