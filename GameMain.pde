class Game {
  Player player;
  Menu menu;
  Play play;
  Upgrade upgrade;
  Setting setting;
  Playing playing;
  
  int currentScene = 0; // 0: menu, 1: play, 2: upgrade, 3: setting, 4: playing
  String[] scenes = {"menu", "play", "upgrade", "setting", "playing"};
  
  Game() {
    player = new Player();
    menu = new Menu();
    play = new Play();
    upgrade = new Upgrade();
    setting = new Setting();
    playing = new Playing();
  }
  
  void update() {}
  
  void draw() {
    switch(currentScene) {
      case 0:
        menu.draw();
        break;
      case 1:
        play.draw();
        break;
      case 2:
        upgrade.draw();
        break;
      case 3:
        setting.draw();
        break;
      case 4:
        playing.draw();
        break;
    }
  }
}
// TODO: konami code

class Playing {
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
  
  Playing() {
    words.set("test", "test");
    words.set("test2", "test2");
    words2.set("test3", "test3");
    healWords.set("heal", "heal");
  }
  
  Playing(Player player) {
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

