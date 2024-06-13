function onSongEnd() {
  if (!PlayState.isStoryMode) return;
  FlxG.save.data.beatNatsuki = true;
}