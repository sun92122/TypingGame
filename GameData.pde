class Vocab {
  String[] vocabsPath = {
    "vocab/level1.csv",
    "vocab/level2.csv",
    "vocab/level3.csv",
    "vocab/level4.csv",
    "vocab/level5.csv",
    "vocab/level6.csv"
  };
  
  Table[] vocabs = new Table[6];
  
  Vocab() {
    loadVocab();
  };
  
  void loadVocab() {
    for(int i = 0; i < vocabsPath.length; i++) {
      vocabs[i] = loadTable(vocabsPath[i]);
    }
  }
  
  String[] getVocab(int vocabIndex, int index) {
    String[] vocab = new String[2];
    vocab[0] = vocabs[vocabIndex].getString(index, 0);
    vocab[1] = vocabs[vocabIndex].getString(index, 2);
    return vocab;
  }
  
  String[] getRandVocab(int vocabIndex) {
    int index = (int) random(vocabs[vocabIndex].getRowCount());
    String[] vocab = new String[2]; 
    vocab[0] = vocabs[vocabIndex].getString(index, 0);
    while(!checkVocab(vocab[0])) {
      index = (int) random(vocabs[vocabIndex].getRowCount());
      vocab[0] = vocabs[vocabIndex].getString(index, 0);
    }
    vocab[1] = vocabs[vocabIndex].getString(index, 2);
    return vocab;
  }
  
  boolean checkVocab(String vocab) {
    for(int i = 0; i < vocab.length(); i++) {
      char c = vocab.charAt(i);
      if('a' <= c && c <= 'z') {
        continue;
      } else if('A' <= c && c <= 'Z') {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }
}

class Settings {
  String settingPath = "data/setting/settings.json";
  
  JSONArray settings;
  IntDict settingMap = new IntDict();
  
  Settings() {
    loadSetting();
  }
  
  void loadSetting() {
    try {
      settings = loadJSONArray(settingPath);
      for(int i = 0; i < settings.size(); i++) {
        settingMap.set(settings.getJSONObject(i).getString("name"), i);
      }
    } catch(Exception e) {
      println("Errow, settings file not found");
    }
  }
}

class LevelData {
  String levelPath = "data/setting/levels.json";
  
  JSONArray levels;
  int levelCount;
  
  LevelData() {
    loadLevelData();
  }
  
  void loadLevelData() {
    try {
      levels = loadJSONArray(levelPath);
      levelCount = levels.size();
    } catch(Exception e) {
      println("Error, levels file not found");
    }
  }
}

class CharacterData {
  String characterPath = "data/setting/characters.json";
  
  JSONArray characters;
  int characterCount;
  
  CharacterData() {
    loadCharacterData();
  }
  
  void loadCharacterData() {
    try {
      characters = loadJSONArray(characterPath);
      characterCount = characters.size();
    } catch(Exception e) {
      println("Error, characters file not found");
    }
  }
}

class MobData {
  String mobPath = "data/setting/mobs.json";
  
  JSONArray mobs;
  int mobCount;
  
  MobData() {
    loadMobData();
  }
  
  void loadMobData() {
    try {
      mobs = loadJSONArray(mobPath);
      mobCount = mobs.size();
    } catch(Exception e) {
      println("Error, mobs file not found");
    }
  }
}

class PetData {
  String petPath = "data/setting/pets.json";
  
  JSONArray pets;
  int petCount;
  
  PetData() {
    loadPetData();
  }
  
  void loadPetData() {
    try {
      pets = loadJSONArray(petPath);
      petCount = pets.size();
    } catch(Exception e) {
      println("Error, pets file not found");
    }
  }
  
}

class BackgroundData {
  String backgroundPath = "data/setting/backgrounds.json";
  
  JSONObject backgroundData;
  HashMap<String, PShape> pictures = new HashMap<String, PShape>();
  JSONArray maps;
  int mapsCount;
  
  BackgroundData() {
    loadBackgroundData();
  }
  
  void loadBackgroundData() {
    try {
      backgroundData = loadJSONObject(backgroundPath);
      maps = backgroundData.getJSONArray("maps");
      mapsCount = maps.size();
      JSONArray picturesData = backgroundData.getJSONArray("pictures");
      for(int i = 0; i < picturesData.size(); i++) {
        JSONObject pictureData = picturesData.getJSONObject(i);
        String name = pictureData.getString("name");
        PShape picture = loadShape(pictureData.getString("path"));
        pictures.put(name, picture);
      }
    } catch(Exception e) {
      println("Error, backgrounds file not found");
      println(e);
    }
  }
}

class AudioData {

  String audioPath = "data/setting/audios.json";
  
  JSONObject audiosDatas;
  HashMap<String, String> audiosPath = new HashMap<String, String>();
  HashMap<String, SoundFile> sounds = new HashMap<String, SoundFile>();
  HashMap<String, SoundFile> musics = new HashMap<String, SoundFile>();
  
  AudioData() {
    loadAudioData();
  }
  
  void loadAudioData() {
    try {
      audiosDatas = loadJSONObject(audioPath);

      JSONArray musicsData = audiosDatas.getJSONArray("musics");
      for(int i = 0; i < musicsData.size(); i++) {
        JSONObject musicData = musicsData.getJSONObject(i);
        String name = musicData.getString("name");
        String path = musicData.getString("path");
        SoundFile musicFile = new SoundFile(mainSketch, path);
        musics.put(name, musicFile);
        audiosPath.put(name, path);
      }

      JSONArray soundsData = audiosDatas.getJSONArray("sounds");
      for(int i = 0; i < soundsData.size(); i++) {
        JSONObject soundData = soundsData.getJSONObject(i);
        String name = soundData.getString("name");
        String path = soundData.getString("path");
        SoundFile soundFile = new SoundFile(mainSketch, path);
        sounds.put(name, soundFile);
        audiosPath.put(name, path);
      }
    } catch(Exception e) {
      println("Error, audios file not found");
      println(e);
    }
  }
}