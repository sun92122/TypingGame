class Player {
  String name;

  int basicSkillLevel = 1;
  int feverLevel = 1;
  int[] skillLevel = new int[4];

  int money = 1000;
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

    for (int i = 0; i < 4; i++) {
      this.skillLevel[i] = 1;
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