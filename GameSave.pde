class Save {
  Save() {}
  
  
}

class Load {
  JSONObject savedSettings;
  Load() {}
  
  void loadPlayerFile(int id) {
    try {
      savedSettings = loadJSONObject("data/progress/player" + id + ".json");
    } catch(Exception e) {
      println("No player file found, creating one");
      // createPlayerFile();
    }
  }
  
  void loadSettings(Settings settings, Player player) {
    JSONArray datas = settings.settings;
    
    for(int i = 0; i < datas.size(); i++) {
      JSONObject s = datas.getJSONObject(i);
      
      String name = s.getString("name");
      JSONArray subS = s.getJSONArray("sub");
      for(int j = 0; j < s.size(); j++) {
        
      }
    }
  }
  
}

class Export {
  Export() {}
  
  
}

class Import {
  Import() {}
  
  
}