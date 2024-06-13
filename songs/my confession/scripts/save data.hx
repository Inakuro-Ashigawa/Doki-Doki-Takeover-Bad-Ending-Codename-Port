function onSongEnd() {
  if (!PlayState.isStoryMode) return;
  FlxG.save.data.beatSayori = true;
}