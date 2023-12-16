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
  PetData petData;
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
    "Potato"
  };
  
  // mob
  HashMap<String, Mob> mobs = new HashMap<String, Mob>();
  
  // pet
  HashMap<String, Pet> pets = new HashMap<String, Pet>();
  
  // background
  HashMap<String, Background> backgrounds = new HashMap<String, Background>();
  
  // font
  HashMap<String, PFont> fonts = new HashMap<String, PFont>();
  String[] fontNameList = {
    "NotoSansTC",
    "Cubic11",
    "PressStart2P",
    "Filepile",
    "Arial Black",
    "Karmatic Arcade",
    "Undo"
  };
  String[] fontPathList = {
    "font/NotoSansTC-Regular.ttf",
    "font/Cubic_11_1.013_R.ttf",
    "font/PressStart2P-Regular.ttf",
    "font/Filepile.otf",
    "font/ARIBLK.TTF",
    "font/ka1.ttf",
    "font/editundo.ttf"
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
    petData = new PetData();
    backgroundData = new BackgroundData();
    
    load.loadSettings(settings);
    
    menuPage = new MenuPage();
    playPage = new PlayPage(levelData);
    upgradePage = new UpgradePage();
    settingPage = new SettingPage(settings);
    
    // load characters
    // characters.put(characterNameList[0],
    //   new CharacterPotato(characterData.characters.getJSONObject(0)));
    for(int i = 0; i < characterNameList.length; i++) {
      characters.put(characterNameList[i],
        new CharacterSvg(characterData.characters.getJSONObject(i)));
    }
    menuPage.character = characters.get(characterNameList[0]); // set menu character
    
    // load mobs
    Mob mobTemp;
    mobTemp = new MobDynamicSB(mobData.mobs.getJSONObject(0));
    mobs.put(mobTemp.name, mobTemp);
    mobTemp = new MobCodeBird(mobData.mobs.getJSONObject(1));
    mobs.put(mobTemp.name, mobTemp);
    for(int i = 2; i < mobData.mobCount; i++) {
      mobTemp = new MobSvg(mobData.mobs.getJSONObject(i));
      mobs.put(mobTemp.name, mobTemp);
    }
    
    // load pets
    Pet petTemp;
    for(int i = 0; i < petData.petCount; i++) {
      petTemp = new PetSvg(petData.pets.getJSONObject(i), i);
      pets.put(petTemp.name, petTemp);
    }
    
    // load backgrounds
    Background backgroundTemp;
    backgroundTemp = new Background(backgroundData, 0);
    backgrounds.put(backgroundTemp.name, backgroundTemp);
    backgrounds.put("", backgroundTemp);
    menuPage.background = backgroundTemp; // set menu background
    for(int i = 1; i < backgroundData.mapsCount; i++) {
      backgroundTemp = new Background(backgroundData, i);
      backgrounds.put(backgroundTemp.name, backgroundTemp);
    }
    
    // load fonts
    for(int i = 0; i < fontNameList.length; i++) {
      fonts.put(fontNameList[i], createFont(fontPathList[i], 32));
    }
    textFont(fonts.get("PressStart2P"));
    
    // setup vocab text setting
    for(int i = 0; i < 3; i++) {
      VocabTextSetting.positionX[i] *= unit;
      VocabTextSetting.positionY[i] *= unit;
    }
    
    logPrint("Game initialized");
    menuPage.init();
  }
  
  void switchScene(int scene) {
    currentScene = scene;
    if(currentScene == 0) {
      menuPage.init();
    }
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
  
  void keyTyped() {
    switch(currentScene) {
      case 0:
        menuPage.keyTyped();
        break;
      case 1:
        playPage.keyTyped();
        break;
      case 2:
        upgradePage.keyTyped();
        break;
      case 3:
        settingPage.keyTyped();
        break;
      case 4:
        playingPage.keyTyped();
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
    audio.playSound("click");
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