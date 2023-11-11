class Level {
  
  int levelNumber;
  JSONObject data;
  
  LevelIcon levelIcon;
  boolean isUnlock = true;
  int page;
  
  int timeLimit;
  String map;
  Table enemies = new Table();
  
  Level(int levelNumber, JSONObject data) {
    this.levelNumber = levelNumber;
    this.data = data;
    
    // TODO: loacate the level icon
    this.page = levelNumber / 15;
    int levelNum = levelNumber % 15;
    float x = ((levelNum % 5) - 2) * 150 + width / 2;
    float y = ((levelNum / 5) - 1) * 150 + height / 2;
    // TODO: check if the level is unlock
    // test
    if(levelNumber > 8) {
      isUnlock = false;
    }
    this.levelIcon = new LevelIcon(x, y, levelNumber, !isUnlock);

    this.timeLimit = data.getInt("timelimit");
    this.map = data.getString("background");
    
    this.enemies.addColumn("time");
    this.enemies.addColumn("mob");
    this.enemies.addColumn("moblevel");
    getEnemiesTable();
  }
  
  void getEnemiesTable() {
    JSONArray waves = data.getJSONArray("enemies");
    JSONObject wave;
    String mob;
    int mobLevel;
    int time;
    int count;
    int interval;
    for(int i = 0; i < waves.size(); i++) {
      wave = waves.getJSONObject(i);
      mob = wave.getString("mob");
      mobLevel = wave.getInt("moblevel");
      time = wave.getInt("time");
      count = wave.getInt("count");
      interval = wave.getInt("interval");
      for(int j = 0; j < count; j++) {
        TableRow row = enemies.addRow();
        row.setInt("time", time - j * interval);
        row.setString("mob", mob);
        row.setInt("moblevel", mobLevel);
      }
    }
    enemies.sortReverse("time");
  }
  
  void desplayLevelIcon() {
    levelIcon.display();
  }
}