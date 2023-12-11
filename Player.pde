class Player {
  String name;

  // 0: white dog, 1: dog, 2: fowl, 3: ox, 4: rat, 5: turtle
  int[] petLevel = new int[6];
  int earningEffiLevel = 1;
  int maxHpLevel = 1;

  float money = 5000;
  float earningEfficiency = 1;
  int maxHP = 100;
  IntDict attackLevel = new IntDict();
  HashMap<Integer, String> attackName = new HashMap<Integer, String>();
  // -2: basic, -1: fever, 0: skill1, 1: skill2, 2: skill3, 3: skill4

  String currentSkill1 = "mouse";
  String currentSkill2 = "ice";
  String currentPet = "white dog";
  /**
  * The player's settings.
  * @type {Object}
  * "settings": {
  *   "setting title": {
  *     "setting name": "setting value",
  *     ...
  *   },
  *   ...
  * }
  */
  JSONObject settings;

  String character = "Potato";
  String pet = "White Dog";
  
  Player() {
    this.name = "";
    this.settings = new JSONObject();

    this.attackName.put(-2, "basic");
    this.attackName.put(-1, "fever");
    this.attackName.put(0, "skill1");
    this.attackName.put(1, "skill2");
    this.attackName.put(2, "skill3");
    this.attackName.put(3, "skill4");
    // TODO: read from file
    for (int i = 0; i < 6; i++) {
      this.petLevel[i] = 1;
    }
    this.attackLevel.set("basic", 1);
    this.attackLevel.set("fever", 1);
    this.attackLevel.set("skill1", 1);
    this.attackLevel.set("skill2", 1);
    this.attackLevel.set("skill3", 1);
    this.attackLevel.set("skill4", 1);
  }

  // Getters and setters for attack level
  int getAttackLevel(int index) {
    return this.attackLevel.get(this.attackName.get(index));
  }

  int getAttackLevel(String attack) {
    return this.attackLevel.get(attack);
  }

  void setAttackLevel(String attack, int level) {
    this.attackLevel.set(attack, level);
  }

  void increaseAttackLevel(String attack) {
    this.attackLevel.add(attack, 1);
  }
  // End getters and setters for attack level
  
  // Getters and setters for settings
  int getSettingInt(String parent, String child) {
    return this.settings.getJSONObject(parent).getInt(child);
  }
  
  float getSettingFloat(String parent, String child) {
    return this.settings.getJSONObject(parent).getFloat(child);
  }
  
  String getSettingString(String parent, String child) {
    return this.settings.getJSONObject(parent).getString(child);
  }
  
  boolean getSettingBoolean(String parent, String child) {
    return this.settings.getJSONObject(parent).getBoolean(child);
  }
  
  void setSetting(String parent, String child, int value) {
    JSONObject parentObject = this.settings.getJSONObject(parent);
    parentObject.setInt(child, value);
    this.settings.setJSONObject(parent, parentObject);
  }
  
  void setSetting(String parent, String child, float value) {
    JSONObject parentObject = this.settings.getJSONObject(parent);
    parentObject.setFloat(child, value);
    this.settings.setJSONObject(parent, parentObject);
  }
  
  void setSetting(String parent, String child, String value) {
    JSONObject parentObject = this.settings.getJSONObject(parent);
    parentObject.setString(child, value);
    this.settings.setJSONObject(parent, parentObject);
  }
  
  void setSetting(String parent, String child, boolean value) {
    JSONObject parentObject = this.settings.getJSONObject(parent);
    parentObject.setBoolean(child, value);
    this.settings.setJSONObject(parent, parentObject);
  }
  // End getters and setters for settings
}