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
    text("Typing Game", width / 2, height / 2 - 100);
    
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
  
  PlayPage(LevelData levelData) {
    // this.levelData = levelData;
    // this.levelCount = levelData.levelCount;
    // for(int i = 0; i < levelCount; i++) {
    //   levels[i] = new Level(i, levelData.levels.getJSONObject(i));
    // }
    
    logPrint("PlayPage created.");
  }
  
  void draw() {
    background(255); // TODO: change play background
    rectMode(CENTER);
    
    // level choose (grid buttons)
    pushMatrix();
    translate(width / 2, height / 2);
    for(int i = -2; i <= 2; i++) {
      for(int j = -1; j <= 1; j++) {
        rect(200 * i, 200 * j, 150, 150); // TODO: change to button class (Component.pde)
      }
    }
    popMatrix();
    
    game.backButton.display();
    
    game.menuButton.display();
    
    // level choose text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
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
  
  StringDict words = new StringDict(); // test
  StringDict words2 = new StringDict(); // test
  StringDict healWords = new StringDict(); // test
  
  // Info info;
  int score = 0;
  int combo = 0;
  int maxCombo = 0;
  int hp = 100;
  int money = 0;
  float time = 0;
  float fever = 0;
  
  PlayingPage() {
    // info = new Info(player);
    words.set("test", "test");
    words.set("test2", "test2");
    words2.set("test3", "test3");
    healWords.set("heal", "heal");
    
    logPrint("PlayingPage created.");
  }
  
  void update() {}
  
  void draw() {
    background(255); // TODO: change background
    fill(#CCFF33);
    rectMode(CENTER);
    rect(width / 2, height - 100, width, 200);
    
    
    // show player image // TODO
    fill(0);
    rectMode(CENTER);
    rect(200, height - 200, 100, 100);
    
    // mobs // TODO
    fill(0);
    rectMode(CENTER);
    rect(width - 200, height - 200, 100, 100);
    
    // info.draw(); // TODO: draw info
    fill(0);
    textSize(20);
    textAlign(LEFT);
    text("HP: " + hp, 50, 50);
    text("money: " + money, 50, 100);
    text("score: " + score, width - 250, 50);
    text("time: " + nfc(time, 2), width - 250, 100);
    // fever
    fill(#FFCC33);
    rectMode(CORNER);
    rect(width / 2 - 150, height - 100, 300, 30);
    fill(#FF0000);
    rect(width / 2 - 150, height - 100, 3 * fever, 30);
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("fever", width / 2, height - 85);
    
    // TODO: draw words
    fill(0);
    textSize(20);
    text("test", width / 2, 200);
    text("test2", width / 2, 250);
    text("test3", width / 2, 300);
    
    game.menuButton.display();
  }
  
  void keyPressed() {}
  
  void keyReleased() {}
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {}
}