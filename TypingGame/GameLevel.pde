class Level {
  
  int levelNumber;
  JSONObject data;
  
  LevelIcon levelIcon;
  boolean isUnlock = true;
  int page;
  
  int timeLimit;
  String map;
  String bgm;
  int[] vocabs = new int[6];
  int weightSum = 0;
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
    this.bgm = data.getString("music");

    getVocabWeights();
    
    this.enemies.addColumn("time");
    this.enemies.addColumn("mob");
    this.enemies.addColumn("moblevel");
    getEnemiesTable();
  }

  Level(Level level) {
    this.levelNumber = level.levelNumber;
    this.data = level.data;

    this.levelIcon = level.levelIcon;
    this.isUnlock = level.isUnlock;
    this.page = level.page;
    
    this.timeLimit = level.timeLimit;
    this.map = level.map;
    this.bgm = level.bgm;
    this.vocabs = level.vocabs;
    this.weightSum = level.weightSum;
    this.enemies = new Table();
    this.enemies.addColumn("time");
    this.enemies.addColumn("mob");
    this.enemies.addColumn("moblevel");
    for(TableRow row : level.enemies.rows()) {
      TableRow newRow = enemies.addRow();
      newRow.setInt("time", row.getInt("time"));
      newRow.setString("mob", row.getString("mob"));
      newRow.setFloat("moblevel", row.getFloat("moblevel"));
    }
  }

  void getVocabWeights() {
    JSONObject vocabs = data.getJSONObject("vocab");
    int weightSum = 0;
    for(int i = 0; i < 6; i++) {
      try {
        weightSum += vocabs.getInt(str(i + 1));
        this.vocabs[i] = weightSum;
      } catch(Exception e) {
        this.vocabs[i] = weightSum;
      }
    }
    this.weightSum = weightSum;
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
      mobLevel = wave.getFloat("moblevel");
      time = wave.getInt("time");
      count = wave.getInt("count");
      interval = wave.getInt("interval");
      for(int j = 0; j < count; j++) {
        TableRow row = enemies.addRow();
        row.setInt("time", time - j * interval);
        row.setString("mob", mob);
        row.setFloat("moblevel", mobLevel);
      }
    }
    enemies.sortReverse("time");
  }
  
  void desplayLevelIcon() {
    levelIcon.display();
  }

  Level copy() {
    Level level = new Level(this);
    return level;
  }
}