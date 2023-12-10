class Player {
  String name;

  // 0: Basic, 1: FEVER, 2: Mouse, 3: Phone, 4: Ice, 5: Shuriken
  int[] skillLevel = new int[6];
  // 0: white dog, 1: dog, 2: fowl, 3: ox, 4: rat, 5: turtle
  int[] petLevel = new int[6];
  int earningEffiLevel = 1;
  int maxHpLevel = 1;

  float money = 5000;
  float earningEfficiency = 1 + 0.1f * (earningEffiLevel - 1);
  int maxHP = 100 + 10 * (maxHpLevel - 1);

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

    for (int i = 0; i < 6; i++) {
      this.skillLevel[i] = 1;
      this.petLevel[i] = 1;
    }
  }
  
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