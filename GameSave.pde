class Save {
  Save() {}
  
  void savePlayerFile(int id) {
    JSONObject save = new JSONObject();
    // save.setString("name", player.name);
    save.setJSONObject("settings", player.settings);
    saveJSONObject(save, "data/progress/player" + id + ".json");
  }
}

class Load {
  // Player player; // global
  JSONObject savedSettings;

  Load() {}
  
  void loadPlayerFile(int id) {
    try {
      savedSettings = loadJSONObject("data/progress/player" + id + ".json");
      // player.name = savedSettings.getString("name");
      player.settings = savedSettings.getJSONObject("settings");
    } catch(Exception e) {
      println("No player file found, creating one");
      player.settings = new JSONObject();
    }
  }
  
  void loadSettings(Settings settings) {
    JSONArray datas = settings.settings;
    
    for(int i = 0; i < datas.size(); i++) {
      JSONObject s = datas.getJSONObject(i);
      
      String name = s.getString("name");
      JSONObject playS;
      try {
        playS = player.settings.getJSONObject(name);
        if(playS == null) playS = new JSONObject();
      } catch(Exception e) {
        playS = new JSONObject();
      }
      
      JSONArray subS = s.getJSONArray("sub");
      for(int j = 0; j < subS.size(); j++) {
        JSONObject sub = subS.getJSONObject(j);
        String subName = sub.getString("title");
        if(playS.isNull(subName)) {
          switch(sub.getString("type").charAt(0)) {
            case 's':
              playS.setInt(subName, sub.getInt("default"));
              break;
            case 't':
              playS.setBoolean(subName, sub.getBoolean("default"));
              break;
            case 'd':
              playS.setFloat(subName, sub.getFloat("default"));
              break;
          }
        } else {
          switch(sub.getString("type").charAt(0)) {
            case 's':
              playS.setInt(subName, sub.getInt("default"));
              break;
            case 't':
              playS.setBoolean(subName, sub.getBoolean("default"));
              break;
            case 'd':
              playS.setFloat(subName, sub.getFloat("default"));
              break;
          }
        }
      }
      player.settings.setJSONObject(name, playS);
    }
  }
  
}

class ExportData {
  ExportData() {}
  
  
}

class ImportData {
  ImportData() {}
  
  
}