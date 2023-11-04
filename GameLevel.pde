class Level {
  
  int levelNumber;
  JSONObject data;
  
  LevelIcon levelIcon;
  int page;
  
  Level(int levelNumber, JSONObject data) {
    this.levelNumber = levelNumber;
    this.data = data;
    
    // TODO: loacate the level icon
    this.page = levelNumber / 15;
    int levelNum = levelNumber % 15;
    float x = ((levelNum % 5) - 2) * 150 + width / 2;
    float y = ((levelNum / 5) - 1) * 150 + height / 2;
    this.levelIcon = new LevelIcon(x, y, levelNumber);
  }
  
  void desplayLevelIcon() {
    levelIcon.display();
  }

  void drawBackground() {
    background(255);
    strokeWeight(1);
    stroke(0);
    line(0, height - 150, width, height - 150);
  }
}