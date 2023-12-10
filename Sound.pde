class AudioManager {
  AudioData audioData;
  
  ArrayList<SoundFile> otherSounds = new ArrayList<SoundFile>();
  float soundVolume = 0.5;
  float musicVolume = 0.5;
  
  AudioManager() {
    audioData = new AudioData();
  }
  
  void playSound(String name) {
    SoundFile audio = audioData.sounds.get(name);
    if(audio != null) {
      if(audio.isPlaying()) {
        //copy the sound and play it
        SoundFile copy = new SoundFile(mainSketch, audioData.audiosPath.get(name), false);
        copy.amp(soundVolume);
        copy.play();
        otherSounds.add(copy);
      } else {
        audio.amp(soundVolume);
        audio.play();
      }
    }
  }
  
  void playSound(String name, int mode) {
    switch(mode) {
      case 0:
        playSound(name);
        break;
      case 1:
        playSoundIfNotPlaying(name);
        break;
      case 2:
        playSoundOnly(name);
        break;
      default:
      playSound(name);
      break;
    }
  }
  
  void playSoundOnly(String name) {
    SoundFile audio = audioData.sounds.get(name);
    if(audio != null) {
      audio.amp(soundVolume);
      audio.play();
    }
  }
  
  void playSoundIfNotPlaying(String name) {
    SoundFile audio = audioData.sounds.get(name);
    if(audio != null && !audio.isPlaying()) {
      audio.amp(soundVolume);
      audio.play();
    }
  }
  
  void playMusic(String name) {
    SoundFile audio = audioData.musics.get(name);
    if(audio != null && !audio.isPlaying()) {
      audio.amp(musicVolume);
      audio.loop();
    }
  }
  
  void stopMusic(String name) {
    SoundFile audio = audioData.musics.get(name);
    if(audio != null) {
      audio.stop();
    }
  }
  
  void stopAllMusic() {
    for(SoundFile audio : audioData.musics.values()) {
      audio.stop();
    }
  }
  
  void update() {
    for(int i = otherSounds.size() - 1; i >= 0; i--) {
      SoundFile audio = otherSounds.get(i);
      if(!audio.isPlaying()) {
        audio.removeFromCache();
        otherSounds.remove(i);
      }
    }
  }
}