interface Page {
  void draw();
  void keyPressed();
  void keyReleased();
  void mouseClicked();
  void mouseDragged();
  void mousePressed();
  void mouseReleased();
}

class MenuPage implements Page {
  MainMenuButton[] mainMenuButton = {
    new MainMenuButton("Play", height / 2),
      new MainMenuButton("Upgrade", height / 2 + 75),
      new MainMenuButton("Setting", height / 2 + 150),
      new MainMenuButton("Exit", height / 2 + 225)
    };
  
  int currentButton = 0;
  
  MenuPage() {
    logPrint("MenuPage created.");
  }
  
  void draw() {
    background(255); // TODO: change menu background
    
    // title
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("PressStart2P"));
    text("Typing Game", width / 2, height / 2 - 200);
    
    // buttons // TODO: change to button class (Component.pde)
    for(int i = 0; i < mainMenuButton.length; i++) {
      if(mainMenuButton[i].isHover()) {
        currentButton = i;
      }
      mainMenuButton[i].display(currentButton == i);
    }
  }
  
  void keyPressed() {
    if(keyCode == UP) {
      currentButton--;
      if(currentButton < 0) {
        currentButton = mainMenuButton.length - 1;
      }
    } else if(keyCode == DOWN) {
      currentButton++;
      if(currentButton >= mainMenuButton.length) {
        currentButton = 0;
      }
    } else if(keyCode == ENTER) {
      if(currentButton == 3) {
        game.gameExit();
      } else {
        game.currentScene = currentButton + 1;
      }
    }
  }
  
  void keyReleased() {}
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(mainMenuButton[currentButton].isHover()) {
      if(currentButton == 3) {
        game.gameExit();
      } else {
        game.currentScene = currentButton + 1;
      }
    }
  }
}

class PlayPage implements Page {
  LevelData levelData;
  Level[] levels;
  int levelCount;
  
  int pageIndex = 0;
  
  PlayPage(LevelData levelData) {
    this.levelData = levelData;
    this.levelCount = levelData.levelCount;
    this.levels = new Level[levelCount];
    for(int i = 0; i < levelCount; i++) {
      levels[i] = new Level(i, levelData.levels.getJSONObject(i));
    }
    
    logPrint("PlayPage created.");
  }
  
  void draw() {
    background(255); // TODO: change play background
    rectMode(CENTER);
    
    // level choose (grid buttons)
    int pageStart = pageIndex * 15;
    for(int i = 0; i < 15; i++) {
      if(i + pageStart >= levelCount) {
        break;
      }
      levels[i + pageStart].desplayLevelIcon();
    }
    
    game.backButton.display();
    
    game.menuButton.display();
    
    // level choose text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text("Level", width / 2, 50);
  }
  
  void keyPressed() {}
  
  void keyReleased() {}
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(game.backButton.isHover()) {
      game.currentScene = 0;
    }
    for(int i = 0; i < 15; i++) {
      if(i + pageIndex * 15 >= levelCount) {
        break;
      }
      if(levels[i + pageIndex * 15].levelIcon.isHover() && 
        levels[i + pageIndex * 15].isUnlock) {
        game.currentScene = 4;
        game.playingPage = new PlayingPage(levels[i + pageIndex * 15]);
      }
    }
  }
}

class UpgradePage implements Page {
  UpgradePage() {
    logPrint("UpgradePage created.");
  }
  
  void draw() {
    background(255); // TODO: change upgrade background
    rectMode(CENTER);
    
    pushMatrix();
    translate(width / 4, 0);
    fill(0);
    textSize(30);
    textFont(game.fonts.get("NotoSansTC"));
    textAlign(CENTER, CENTER);
    text("Player ?", 0, 100);
    rect(0, height / 2, 200, 200); // TODO: show player image
    popMatrix();
    
    // player info at right
    pushMatrix();
    translate(width / 2 + width / 4, 0);
    text("HP: ?", 0, 200);
    text("Skill 1: ?", 0, 300);
    text("Skill 2: ?", 0, 400);
    popMatrix();
    
    game.backButton.display();
    
    game.menuButton.display();
    
    // upgrade text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Upgrade", width / 2, 50);
  }
  
  void keyPressed() {}
  
  void keyReleased() {}
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(game.backButton.isHover()) {
      game.currentScene = 0;
    }
  }
}

class SettingPage implements Page {
  int setting = 0; // 0: video, 1: audio, 2: difficulty, 3: language, 4: about
  Settings settings = new Settings();
  
  IntDict settingMap;
  SettingOption[] settingOption;
  
  SettingPage(Settings settings) {
    this.settingMap = settings.settingMap;
    
    settingOption = new SettingOption[settings.settings.size()];
    for(int i = 0; i < settingOption.length; i++) {
      String name = settings.settings.getJSONObject(i).getString("name");
      settingOption[i] = new SettingOption(
        settings.settings.getJSONObject(i), 75 * i + 150);
    }
    
    logPrint("SettingPage created.");
  }
  
  void draw() {
    background(255); // TODO: change setting background
    
    for(int i = 0; i < settingOption.length; i++) {
      settingOption[i].display(setting == i);
    }
    
    game.backButton.display();
    
    // setting text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text("Setting", width / 2, 50);
  }
  
  void keyPressed() {
    if(keyCode == CODED) {
      if(keyCode == UP) {
        setting--;
        if(setting < 0) {
          setting = settingOption.length - 1;
        }
      } else if(keyCode == DOWN) {
        setting++;
        if(setting >= settingOption.length) {
          setting = 0;
        }
      }
    }
  }
  
  void keyReleased() {}
  
  void mouseClicked() {
    for(int i = 0; i < settingOption.length; i++) {
      settingOption[i].mouseClicked();
    }
  }
  
  void mouseDragged() {
    for(int i = 0; i < settingOption.length; i++) {
      settingOption[i].mouseDragged();
    }
  }
  
  void mousePressed() {
    for(int i = 0; i < settingOption.length; i++) {
      settingOption[i].mousePressed();
    }
  }
  
  void mouseReleased() {
    if(game.backButton.isHover()) {
      game.currentScene = 0;
    }
    for(int i = 0; i < settingOption.length; i++) {
      if(settingOption[i].isHover()) {
        setting = i;
      }
      settingOption[i].mouseReleased();
    }
  }
}

class PlayingPage implements Page {
  
  Level level;
  Character character;
  
  // game info
  float countDown = 3.5f;
  int timer = 9999000; // count down to 0
  int score = 0;
  int fever = 50;
  ArrayList<Mob> mobs = new ArrayList<Mob>();
  
  
  // player info
  int hp = 100;
  int max_hp = 200;
  int money = 100;
  
  // status
  boolean isStart = false;
  int state = 1; // 0: pause, 1: entering, 2: playing, 3: ending
  final int PAUSE = 0;
  final int ENTERING = 1;
  final int PLAYING = 2;
  final int ENDING = 3;
  
  PlayingPage(Level level) {
    this.level = level;
    this.character = game.characters.get(player.character);
    
    this.timer = level.data.getInt("timelimit");
  }
  
  void update() {
    character.update();
    if(state == PLAYING) {
      timer = max(0, timer - round(1000 / frameRate));
      for(int i = 0; i < mobs.size(); i++) {
        mobs.get(i).update();
      }
      while(level.enemies.getRow(0).getInt("time") >= timer) {
        TableRow row = level.enemies.getRow(0);
        Mob mob = game.mobs.get(row.getString("mob")).copy(row.getInt("moblevel"));
        mob.setLocation(width, height - 150);
        mobs.add(mob);
        level.enemies.removeRow(0);
      }
      // level.update();
    }
    if(state == ENDING) {
      // level.end();
      // level background shift?
    }
  }
  
  void draw() {
    if(!isStart) {
      isStart = true;
      // level.start();
      character.update(1);
    }
    if(state != PAUSE) {
      update();
    }
    
    level.drawBackground();
    
    // show player image // TODO
    switch(state) {
      case PAUSE:
        drawPause();
        break;
      case ENTERING:
        drawEnter();
        break;
      case PLAYING:
        drawPlaying();
        break;
      case ENDING:
        drawEnding();
        break;
    }
    
    // mobs // TODO
    for(int i = 0; i < mobs.size(); i++) {
      mobs.get(i).display();
    }
    
    
    // info.draw(); // TODO: draw info
    fill(0);
    textFont(game.fonts.get("Cubic11"));
    textSize(30);
    textAlign(LEFT);
    
    // HP
    text("HP:", 30, 50);
    stroke(0);
    strokeWeight(2);
    noFill();
    rectMode(CORNER);
    rect(100, 25, max_hp + 5, 30);
    noStroke();
    fill(192, 0, 0);
    if(hp > max_hp) {
      rect(102.5, 28, max_hp, 24.5);
      hp = max_hp;
    } else if(hp < 0) {
      hp = 0;
    } else{
      rect(102.5, 28, hp, 24.5);
    }
    // testing the change in hp
    if(mousePressed && (mouseButton == LEFT)) {
      hp -= 5;
    } else if(mousePressed && (mouseButton == RIGHT)) {
      hp += 5;
    }
    
    // money
    fill(0);
    text("$", 37.5, 100);
    text(":", 68, 100);
    text(money, 100, 100);
    
    // score
    textAlign(LEFT);
    text("score: ", width - 250, 50);
    textAlign(RIGHT);
    text(score, width - 30, 50);
    
    // time
    textAlign(LEFT);
    // text("HP: " + hp, 50, 50);
    // text("money: " + money, 50, 100);
    // text("score: " + score, width - 250, 50);
    // text("time: " + nfc(time, 2), width - 250, 100);
    // fever
    fill(#FFCC33);
    rect(width / 2 - 150, height - 100, 300, 30);
    fill(#FF0000);
    rect(width / 2 - 150, height - 100, 3 * fever, 30);
    fill(0);
    textFont(game.fonts.get("Filepile"));
    textAlign(CENTER);
    textSize(30);
    text("fever", width / 2, height - 85);
    
    // TODO: draw words
    // fill(0);
    // textSize(20);
    // text("test", width / 2, 200);
    // text("test2", width / 2, 250);
    // text("test3", width / 2, 300);
    
    game.menuButton.display();
  }
  
  void drawPause() {}
  
  void drawEnter() {
    fill(0);
    textSize(250);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text("0" + nfc(countDown, 2), width / 2, height / 2);
    
    character.display(
      constrain(300 * (1.2 - countDown / 2.5) + 60, 0, 300), height - 150);
    countDown -= 1 / frameRate;
    if(countDown <= 0) {
      state = PLAYING;
      character.update(0);
    }
  }
  
  void drawPlaying() {
    character.display(300, height - 150);
  }
  
  void drawEnding() {
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text("Ending", width / 2, height / 2);
  }
  
  void keyPressed() {}
  
  void keyReleased() {
    if(isDebugMode) {
      if(key == ' ') {
        state = ENDING;
      }
    }
  }
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {}
}