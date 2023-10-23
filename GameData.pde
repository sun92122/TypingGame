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
  
  Vocab() {};
  
  void loadVocab() {
    for(int i = 0; i < vocabsPath.length; i++) {
      vocabs[i] = loadTable(vocabsPath[i]);
    }
  }
  
  String getVocab(int level, int index) {
    return vocabs[level - 1].getString(index, 0);
  }
  
  String getRandVocab(int level) {
    int index = (int) random(vocabs[level - 1].getRowCount());
    return vocabs[level - 1].getString(index, 0);
  }
}

class Settings {
  String settingPath = "data/settings/settings.json";
  
  JSONArray settings;
  
  Settings() {
    loadSetting();
  }
  
  void loadSetting() {
    try {
      settings = loadJSONArray(settingPath);
    } catch(Exception e) {
      println("Errow, settings file not found");
    }
  }
  
  void saveSetting() {
    saveJSONArray(settings, settingPath);
  }
}