class Game {
  // player
  Player player;
  
  // data
  Vocab vocab;
  Settings settings;
  
  // view
  MenuPage menuPage;
  PlayPage playPage;
  UpgradePage upgradePage;
  SettingPage settingPage;
  PlayingPage playingPage;
  
  // global components
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  
  // style
  HashMap<String , PFont> fonts = new HashMap<String , PFont>();
  
  int currentScene = 0; // 0: menu, 1: play, 2: upgrade, 3: setting, 4: playing
  String[] scenes = {"menu", "play", "upgrade", "setting", "playing"}; // not used, just for reference
  
  Game() {
    player = new Player();
    
    vocab = new Vocab();
    settings = new Settings();
    
    menuPage = new MenuPage();
    playPage = new PlayPage();
    upgradePage = new UpgradePage();
    settingPage = new SettingPage();
    playingPage = new PlayingPage();
    
    // font = createFont("font/NotoSansTC-Regular.ttf", 32);
    // font = createFont("font/Cubic_11_1.013_R.ttf", 32);
    // font = createFont("font/PressStart2P-Regular.ttf", 32);
    fonts.put("NotoSansTC", createFont("font/NotoSansTC-Regular.ttf", 32));
    fonts.put("Cubic11", createFont("font/Cubic_11_1.013_R.ttf", 32));
    fonts.put("PressStart2P", createFont("font/PressStart2P-Regular.ttf", 32));
    textFont(fonts.get("PressStart2P"));
  }
  
  void update() {}
  
  void draw() {
    switch(currentScene) {
      case 0:
        menuPage.draw();
        break;
      case 1:
        playPage.draw();
        break;
      case 2:
        upgradePage.draw();
        break;
      case 3:
        settingPage.draw();
        break;
      case 4:
        playingPage.draw();
        break;
    }
  }
  
  void keyPressed() {
    if(key == CODED) {
      // if(keyCode == DOWN) {
      //   game.currentScene = (game.currentScene + 1) % game.scenes.length;
      // } else if(keyCode == UP) {
      //   game.currentScene = (game.currentScene - 1 + game.scenes.length) % game.scenes.length;
      // }
    } // test
    switch(currentScene) {
      case 0:
        menuPage.keyPressed();
        break;
      case 1:
        playPage.keyPressed();
        break;
      case 2:
        upgradePage.keyPressed();
        break;
      case 3:
        settingPage.keyPressed();
        break;
      case 4:
        playingPage.keyPressed();
        break;
    }
  }
  
  void keyReleased() {
    switch(currentScene) {
      case 0:
        menuPage.keyReleased();
        break;
      case 1:
        playPage.keyReleased();
        break;
      case 2:
        upgradePage.keyReleased();
        break;
      case 3:
        settingPage.keyReleased();
        break;
      case 4:
        playingPage.keyReleased();
        break;
    }
  }
  
  void mouseReleased() {
    switch(currentScene) {
      case 0:
        menuPage.mouseReleased();
        break;
      case 1:
        playPage.mouseReleased();
        break;
      case 2:
        upgradePage.mouseReleased();
        break;
      case 3:
        settingPage.mouseReleased();
        break;
      case 4:
        playingPage.mouseReleased();
        break;
    }
  }
  
  void gameExit() {
    exit();
  }
}
// TODO: konami code