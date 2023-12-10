class SoundManager {
  SoundData soundData;

  SoundManager() {
    soundData = new SoundData();
  }

  void play(String name) {
    soundData.sounds.get(name).play();
  }
}