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
  
  String getVocab(int vocabIndex, int index) {
    return vocabs[vocabIndex].getString(index, 0);
  }
  
  String getRandVocab(int vocabIndex) {
    int index = (int) random(vocabs[vocabIndex].getRowCount());
    String vocab = vocabs[vocabIndex].getString(index, 0);
    while(vocab.indexOf(" ") != -1) {
      index = (int) random(vocabs[vocabIndex].getRowCount());
      vocab = vocabs[vocabIndex].getString(index, 0);
    }
    return vocab;
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