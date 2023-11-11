class Game {
  // player
  // Player player;
  // out of Game, global
  
  // data
  Vocab vocab;
  Settings settings;
  LevelData levelData;
  CharacterData characterData;
  MobData mobData;
  BackgroundData backgroundData;
  
  // view
  MenuPage menuPage;
  PlayPage playPage;
  UpgradePage upgradePage;
  SettingPage settingPage;
  PlayingPage playingPage;
  
  // controller
  Load load = new Load();
  Save save = new Save();
  ExportData exportData = new ExportData();
  ImportData importData = new ImportData();
  
  // global components
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  
  // character
  HashMap<String, Character> characters = new HashMap<String, Character>();
  String[] characterNameList = {
    "Potato",
    "Test"
  };
  
  // mob
  HashMap<String, Mob> mobs = new HashMap<String, Mob>();

  // background
  HashMap<String, Background> backgrounds = new HashMap<String, Background>();
  
  // font
  HashMap<String, PFont> fonts = new HashMap<String, PFont>();
  String[] fontNameList = {
    "NotoSansTC",
    "Cubic11",
    "PressStart2P",
    "Filepile"
  };
  String[] fontPathList = {
    "font/NotoSansTC-Regular.ttf",
    "font/Cubic_11_1.013_R.ttf",
    "font/PressStart2P-Regular.ttf",
    "font/Filepile.otf"
  };
  
  // state variables
  int currentScene = 0; // 0: menu, 1: play, 2: upgrade, 3: setting, 4: playing
  String[] scenes = {"menu", "play", "upgrade", "setting", "playing"};
  float screenScale = 1;
  
  Game() {
    vocab = new Vocab();
    settings = new Settings();
    levelData = new LevelData();
    characterData = new CharacterData();
    mobData = new MobData();
    backgroundData = new BackgroundData();
    
    load.loadSettings(settings);
    
    menuPage = new MenuPage();
    playPage = new PlayPage(levelData);
    upgradePage = new UpgradePage();
    settingPage = new SettingPage(settings);
    
    // load characters
    characters.put(characterNameList[0],
      new CharacterPotato(characterData.characters.getJSONObject(0)));
    for(int i = 1; i < characterNameList.length; i++) {
      characters.put(characterNameList[i],
        new Character(characterData.characters.getJSONObject(i)));
    }
    
    // load mobs
    Mob mobTemp;
    mobTemp = new MobDynamicSB(mobData.mobs.getJSONObject(0));
    mobs.put(mobTemp.name, mobTemp);
    mobTemp = new MobCodeBird(mobData.mobs.getJSONObject(1));
    mobs.put(mobTemp.name, mobTemp);
    for(int i = 2; i < mobData.mobCount; i++) {
      mobTemp = new Mob(mobData.mobs.getJSONObject(i));
      mobs.put(mobTemp.name, mobTemp);
    }

    // load backgrounds
    Background backgroundTemp;
    backgroundTemp = new Background(backgroundData, 0);
    backgrounds.put(backgroundTemp.name, backgroundTemp);
    backgrounds.put("", backgroundTemp);
    for(int i = 1; i < backgroundData.mapsCount; i++) {
      backgroundTemp = new Background(backgroundData, i);
      backgrounds.put(backgroundTemp.name, backgroundTemp);
    }
    
    // load fonts
    for(int i = 0; i < fontNameList.length; i++) {
      fonts.put(fontNameList[i], createFont(fontPathList[i], 32));
    }
    textFont(fonts.get("PressStart2P"));
    
    logPrint("Game initialized");
  }
  
  void update() {}
  
  void draw() {
    if(screenScale != 1) {
      scale(screenScale);
    }
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
  
  void mouseClicked() {
    switch(currentScene) {
      case 0:
        menuPage.mouseClicked();
        break;
      case 1:
        playPage.mouseClicked();
        break;
      case 2:
        upgradePage.mouseClicked();
        break;
      case 3:
        settingPage.mouseClicked();
        break;
      case 4:
        playingPage.mouseClicked();
        break;
    }
  }
  
  void mouseDragged() {
    switch(currentScene) {
      case 0:
        menuPage.mouseDragged();
        break;
      case 1:
        playPage.mouseDragged();
        break;
      case 2:
        upgradePage.mouseDragged();
        break;
      case 3:
        settingPage.mouseDragged();
        break;
      case 4:
        playingPage.mouseDragged();
        break;
    }
  }
  
  void mousePressed() {
    switch(currentScene) {
      case 0:
        menuPage.mousePressed();
        break;
      case 1:
        playPage.mousePressed();
        break;
      case 2:
        upgradePage.mousePressed();
        break;
      case 3:
        settingPage.mousePressed();
        break;
      case 4:
        playingPage.mousePressed();
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