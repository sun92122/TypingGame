class MenuPage {
  MenuPage() {}
  
  void draw() {
    background(255); // TODO: change menu background
    
    // title
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Typing Game", width / 2, height / 2 - 100);
    
    // buttons // TODO: change to button class (Component.pde)
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Play", width / 2, height / 2);
    text("Upgrade", width / 2, height / 2 + 50);
    text("Setting", width / 2, height / 2 + 100);
    text("Exit", width / 2, height / 2 + 150);
  }
}

class PlayPage {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  
  PlayPage() {}
  
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
    
    backButton.display();
    
    menuButton.display();
    
    // level choose text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Level", width / 2, 50);
  }
}

class UpgradePage {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  
  UpgradePage() {}
  
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
    
    backButton.display();
    
    menuButton.display();
    
    // upgrade text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Upgrade", width / 2, 50);
  }
}

class SettingPage {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  int setting = 0; // 0: video, 1: audio, 2: difficulty, 3: language, 4: about
  
  SettingPage() {}
  
  void draw() {
    background(255); // TODO: change setting background
    
    // left side main setting options
    pushMatrix();
    translate(width / 4, 0);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Video", 0, 100);
    text("Audio", 0, 200);
    text("Difficulty", 0, 300);
    text("Language", 0, 400);
    text("About", 0, 500);
    popMatrix();
    
    // right side Set details
    pushMatrix();
    translate(width / 2 + width / 4, 0);
    switch(setting) {
      case 0:
        text("Resolution: ?", 0, 100);
        text("Fullscreen: ?", 0, 200);
        break;
      case 1:
        text("Volume: ?", 0, 100);
        text("Mute: ?", 0, 200);
        break;
      case 2:
        text("Difficulty: ?", 0, 100);
        break;
      case 3:
        text("Language: ?", 0, 100);
        break;
      case 4:
        text("About: ?", 0, 100);
        break;
    }
    popMatrix();
    
    backButton.display();
    
    menuButton.display();
    
    // setting text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Setting", width / 2, 50);
  }
}

class PlayingPage {
  MenuButton menuButton = new MenuButton();
  
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
    words.set("test", "test");
    words.set("test2", "test2");
    words2.set("test3", "test3");
    healWords.set("heal", "heal");
  }
  
  PlayingPage(Player player) {
    // info = new Info(player);
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
    
    menuButton.display();
  }
}