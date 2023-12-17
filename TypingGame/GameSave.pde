// save, load, export, import
class DataManager {
  String path = "data/saves/";
  
  DataManager() {}
  
  void save() {
    // player -> json
    JSONObject playerJson = new JSONObject();
    
    playerJson.setString("name", player.name);
    
    playerJson.setJSONArray("petLevel", getIntArrayToJson(player.petLevel));
    playerJson.setInt("earningEffiLevel", player.earningEffiLevel);
    playerJson.setInt("maxHpLevel", player.maxHpLevel);
    
    playerJson.setFloat("money", player.money);
    playerJson.setFloat("earningEfficiency", player.earningEfficiency);
    playerJson.setInt("maxHP", player.maxHP);
    playerJson.setJSONObject("attackLevel", getIntDictToJson(player.attackLevel));
    
    playerJson.setString("currentSkill1", player.currentSkill1);
    playerJson.setString("currentSkill2", player.currentSkill2);
    
    playerJson.setString("character", player.character);
    playerJson.setString("pet", player.pet);
    
    playerJson.setJSONObject("settings", player.settings);
    
    playerJson.setJSONObject("level", player.level);
    
    // json -> file
    saveJSONObject(playerJson, path + "player.json");
  }
  
  void load() {
    // file -> json
    JSONObject playerJson;
    try {
      playerJson = loadJSONObject(path + "player.json");
    } catch(Exception e) {
      playerJson = new JSONObject();
    }
    
    // json -> player
    if(playerJson.isNull("name")) player.name = "Player0";
    else player.name = playerJson.getString("name");
    
    if(playerJson.isNull("petLevel")) {
      player.petLevel = new int[6];
      for(int i = 0; i < player.petLevel.length; i++) {
        player.petLevel[i] = 1;
      }
    } else {
      player.petLevel = getJsonToIntArray(playerJson.getJSONArray("petLevel"));
    }
    if(playerJson.isNull("earningEffiLevel")) player.earningEffiLevel = 1;
    else player.earningEffiLevel = playerJson.getInt("earningEffiLevel");
    if(playerJson.isNull("maxHpLevel")) player.maxHpLevel = 1;
    else player.maxHpLevel = playerJson.getInt("maxHpLevel");
    
    if(playerJson.isNull("money")) player.money = 0;
    else player.money = playerJson.getFloat("money");
    if(playerJson.isNull("earningEfficiency")) player.earningEfficiency = 1;
    else player.earningEfficiency = playerJson.getFloat("earningEfficiency");
    if(playerJson.isNull("maxHP")) player.maxHP = 100;
    else player.maxHP = playerJson.getInt("maxHP");
    if(playerJson.isNull("attackLevel")) {
      player.attackLevel = new IntDict();
      player.attackLevel.set("basic", 1);
      player.attackLevel.set("fever", 1);
      player.attackLevel.set("skill1", 1);
      player.attackLevel.set("skill2", 1);
      player.attackLevel.set("skill3", 1);
      player.attackLevel.set("skill4", 1);
    } else {
      player.attackLevel = getJsonToIntDict(playerJson.getJSONObject("attackLevel"));
    }
    
    if(playerJson.isNull("currentSkill1")) player.currentSkill1 = "mouse";
    else player.currentSkill1 = playerJson.getString("currentSkill1");
    if(playerJson.isNull("currentSkill2")) player.currentSkill2 = "ice";
    else player.currentSkill2 = playerJson.getString("currentSkill2");
    
    if(playerJson.isNull("character")) player.character = "Potato";
    else player.character = playerJson.getString("character");
    if(playerJson.isNull("pet")) player.pet = "White Dog";
    else player.pet = playerJson.getString("pet");
    
    if(playerJson.isNull("settings")) player.settings = new JSONObject();
    else player.settings = playerJson.getJSONObject("settings");
    
    if(playerJson.isNull("level")) player.level = new JSONObject();
    else player.level = playerJson.getJSONObject("level");
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
        }
      }
      player.settings.setJSONObject(name, playS);
    }
  }
  
  JSONObject getIntDictToJson(IntDict dict) {
    JSONObject json = new JSONObject();
    for(String key : dict.keys()) {
      json.setInt(key, dict.get(key));
    }
    return json;
  }
  
  IntDict getJsonToIntDict(JSONObject json) {
    IntDict dict = new IntDict();
    String[] keys = {"basic", "fever", "skill1", "skill2", "skill3", "skill4"};
    for(String key : keys) {
      dict.set(key, json.getInt(key));
    }
    return dict;
  }
  
  JSONArray getIntArrayToJson(int[] array) {
    JSONArray json = new JSONArray();
    for(int i = 0; i < array.length; i++) {
      json.setInt(i, array[i]);
    }
    return json;
  }
  
  int[] getJsonToIntArray(JSONArray json) {
    return json.toIntArray();
  }
}