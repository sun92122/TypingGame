interface Page {
  void draw();
  void keyPressed();
  void keyTyped();
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
  Background background;
  Character character;
  float characterX = 0;
  float characterY = height - 150;
  
  CheckExit checkExit = new CheckExit();
  boolean isExiting = false;
  
  MenuPage() {
    logPrint("MenuPage created.");
  }
  
  void draw() {
    background.drawBehind();
    character.display(characterX, characterY);
    background.drawInFront();
    fill(#FFFFFF, 125);
    rectMode(CORNER);
    rect(0, 0, width, height);
    
    if(!keyPressed) { 
      background.update();
      characterX += 10 / frameRate;
    }
    character.update();
    
    // title
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("PressStart2P"));
    text("Typing Game", width / 2, height / 2 - 200);
    
    // buttons
    for(int i = 0; i < mainMenuButton.length; i++) {
      if(mainMenuButton[i].isHover() && !isExiting) {
        currentButton = i;
      }
      mainMenuButton[i].display(currentButton == i);
    }
    
    if(isExiting) {
      checkExit.display();
    }
    
    if(isDebugMode) {
      fill(#FF0000);
      textSize(10);
      textAlign(LEFT, TOP);
      textFont(game.fonts.get("NotoSansTC"));
      text("LEFT: +characterX", 10, 50);
      text("RIGHT: -characterX", 10, 75);
      text("UP: -currentButton", 10, 100);
      text("DOWN: +currentButton", 10, 125);
      text("ENTER: change scene", 10, 150);
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
    if(keyCode == LEFT) {
      characterX -= 1;
      background.update('L');
    } else if(keyCode == RIGHT) {
      characterX += 1;
      background.update('R');
    }
  }
  
  void keyTyped() {}
  
  void keyReleased() {
    if(key == ESC_) {
      isExiting = true;
    }
  }
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(isExiting) {
      if(checkExit.isHoverYes()) {
        game.gameExit();
      } else if(checkExit.isHoverNo()) {
        isExiting = false;
      }
    } else if(mainMenuButton[currentButton].isHover()) {
      if(currentButton == 3) {
        isExiting = true;
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
  
  void keyTyped() {}
  
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
  Icon icon = new Icon();
  
  UpgradePage() {
    icon.loadIcon();
    logPrint("UpgradePage created.");
  }
  
  void draw() {
    background(255); // TODO: change upgrade background
    
    attack_Page_Display();
    
    game.backButton.display();
    
    icon.display(5);    
  }
  
  void attack_Page_Display() {
    float tagWidth = width * 7 / 35;
    float tagHeight = height / 7;
    float pageWidth = width * 24 / 35;
    float pageHeight = height * 46 / 65;
    float skillWidth = pageWidth / 4;
    float skillHeight = pageHeight / 3;
    
    int Stroke_Weight = 6;
    int text_Size = 30;
    
    rectMode(CORNER);
    // Money & HP
    fill(200);
    stroke(0);
    strokeWeight(Stroke_Weight);
    rect(width / 5.6 + tagWidth, height / 11, tagWidth, tagHeight, 20);
    textAlign(CENTER);
    textFont(game.fonts.get("Cubic11"));
    textSize(text_Size);
    fill(0);
    text("MONEY & HP", width / 5.6 + tagWidth * 1.5, height / 11 + tagHeight / 2.1);
    // PET
    fill(200);
    stroke(0);
    rect(width / 5.6 + 2 * tagWidth, height / 11, tagWidth, tagHeight, 20);
    fill(0);
    text("PET", width / 5.6 + tagWidth * 2.5, height / 11 + tagHeight / 2.1);
    // Attack
    fill(255);
    stroke(0);
    rect(width / 5.6, height / 5.3, pageWidth, pageHeight, 20);
    rect(width / 5.6, height / 11, tagWidth, tagHeight, 20);
    noStroke();
    rect(width / 5.6 + Stroke_Weight / 2, height / 5.3 + Stroke_Weight / 2, width / 4.5, tagHeight);
    fill(0);
    text("ATTACK", width / 5.6 + tagWidth * 0.5, height / 11 + tagHeight / 2.1);
    
    // SKILLS
    
    // Basic attack
    float BasicX = width / 5.6 + pageWidth / 6;
    float BasicY = height / 5.3 + pageHeight / 3.2;
    fill(0);
    text("Basic", BasicX, BasicY - skillHeight / 2 - text_Size / 2);
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(BasicX, BasicY, skillWidth, skillHeight, 20);
    // Add an upgrade button in the square
    fill(#00a2ed);
    rect(BasicX, BasicY + skillHeight / 3.2, skillWidth * 3 / 4, skillHeight / 4);
    fill(255);
    text("Upgrade", BasicX, BasicY + skillHeight / 2.8);    
    
    // FEVER
    float FEVERX = BasicX;
    float FEVERY = height / 5.3 + pageHeight / 3 * 2.3;
    fill(0);
    text("FEVER", FEVERX, FEVERY - skillHeight / 2 - text_Size / 2);
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(FEVERX, FEVERY, skillWidth, skillHeight, 20);
    
    // seperate line
    stroke(0);
    strokeWeight(4);
    line(width / 5.6 + pageWidth / 3, height / 5.3 + pageHeight / 8, width / 5.6 + pageWidth / 3, height / 5.3 + pageHeight - pageHeight / 16);
    
    // Skill 1-1
    float Skill_1_1_X = width / 5.6 + pageWidth / 3 + pageWidth / 5.5;
    float Skill_1_1_Y = height / 5.3 + pageHeight / 3.2;
    fill(0);
    text("Skill 1", Skill_1_1_X + skillWidth / 2 + pageWidth * 3.5 / 264, Skill_1_1_Y - skillHeight / 2 - text_Size / 2);
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(Skill_1_1_X, Skill_1_1_Y, skillWidth, skillHeight, 20);
    
    // Skill 1-2
    float Skill_1_2_X = width / 5.6 + pageWidth / 3 + pageWidth / 3 + skillWidth / 2;
    float Skill_1_2_Y = Skill_1_1_Y;
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(Skill_1_2_X, Skill_1_2_Y, skillWidth, skillHeight, 20);
    
    // Skill 2-1
    float Skill_2_1_X = Skill_1_1_X;
    float Skill_2_1_Y = height / 5.3 + pageHeight / 3 * 2.3;
    fill(0);
    text("Skill 2", Skill_2_1_X + skillWidth / 2 + pageWidth * 3.5 / 264, Skill_2_1_Y - skillHeight / 2 - text_Size / 2);
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(Skill_2_1_X, Skill_2_1_Y, skillWidth, skillHeight, 20);
    
    // Skill 2-2
    float Skill_2_2_X = width / 5.6 + pageWidth / 3 + pageWidth / 3 + skillWidth / 2;
    float Skill_2_2_Y = Skill_2_1_Y;
    fill(255);
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(Skill_2_2_X, Skill_2_2_Y, skillWidth, skillHeight, 20);
  }
  
  void keyPressed() {}
  
  void keyTyped() {}
  
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
  
  void keyTyped() {}
  
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
  Pet pet;
  Background background;
  float backgroundY = 570;
  FeverBar feverBar = new FeverBar();
  PausePage pausePage = new PausePage();
  
  // game info
  float countDown = 3.5f;
  int timer = 9999000; // count down to 0
  int score = 0;
  int fever = 100;
  ArrayList<Mob> mobs = new ArrayList<Mob>();
  float mobXMin = width;
  String inputText = "";
  String[] vocabs = new String[3];
  VocabText[] vocabText = new VocabText[3];
  
  // player info
  int hp = 100;
  int max_hp = 200;
  int money = 100;
  
  // status
  boolean isStart = false;
  int state = 1; // 0: pause, 1: entering, 2: playing, 3: ending
  int preState = 1;
  final int PAUSE = 0;
  final int ENTERING = 1;
  final int PLAYING = 2;
  final int ENDING = 3;
  
  PlayingPage(Level level) {
    this.level = level;
    this.character = game.characters.get(player.character);
    this.pet = game.pets.get(player.pet);
    this.background = game.backgrounds.get(level.map);
    this.backgroundY = height - 200;
    pausePage.w = width;
    pausePage.h = height;
    
    this.timer = level.timeLimit;
    for(int i = 0; i < 3; i++) {
      vocabs[i] = getVocab();
      vocabText[i] = new VocabText(i, vocabs[i]);
    }
  }
  
  void update() {
    character.update();
    pet.update();
    if(state == ENTERING) {
      background.update();
      countDown -= 1 / frameRate;
      if(countDown <= 0) {
        state = PLAYING;
        character.update(0);
        pet.update(0);
      }
    }
    if(state == PLAYING) {
      timer = max(0, timer - round(1000 / frameRate));
      for(int i = 0; i < mobs.size(); i++) {
        mobs.get(i).update();
      }
      if(level.enemies.getRowCount() > 0) {
        while(level.enemies.getRow(0).getInt("time") >= timer) {
          TableRow row = level.enemies.getRow(0);
          Mob mob = game.mobs.get(row.getString("mob")).copy(row.getInt("moblevel"));
          mob.setLocation(width, backgroundY);
          mobs.add(mob);
          level.enemies.removeRow(0);
          if(level.enemies.getRowCount() == 0) {
            break;
          }
        }
      }
      // find the mob x min
      mobXMin = width;
      for(int i = 0; i < mobs.size(); i++) {
        mobXMin = min(mobXMin, mobs.get(i).x);
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
      background.init();
    }
    if(state != PAUSE) {
      update();
    }
    
    background.drawBehind();
    
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
    
    background.drawInFront();
    
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
    // testing the change in hp & fever // DEBUG
    if(mousePressed && (mouseButton == LEFT)) {
      hp -= 1;
      fever -= 1;
    } else if(mousePressed && (mouseButton == RIGHT)) {
      hp += 1;
      fever += 1;
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
    text("time: " + nfc(timer / 1000.0, 2), width - 250, 100);
    
    // fever
    fever = constrain(fever, 0, 100);
    feverBar.display(fever);
    
    if(state == PAUSE) {
      pausePage.display();
    } else {
      game.menuButton.display();
    }
  }
  
  void drawPause() {
    if(preState == ENTERING) {
      drawEnter();
    } else {
      drawPlaying();
    }
  }
  
  void drawEnter() {
    fill(0);
    textSize(250);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("Cubic11"));
    text("0" + nfc(countDown, 2), width / 2, height / 2);
    
    character.display(
      constrain(400 * (1.2 - countDown / 2.5) + 60, 0, 400), backgroundY);
    pet.setLocation(
      constrain(400 * (1.2 - countDown / 2.5) - 140, 0, 200), backgroundY);
    pet.display();
  }
  
  void drawPlaying() {
    character.display(400, backgroundY);
    pet.display();
    
    // input text
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text(inputText, 200, 300);
    
    // vocab text
    for(int i = 0; i < 3; i++) {
      vocabText[i].display(inputText);
    }
  }
  
  void drawEnding() {
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    text("Ending", width / 2, height / 2);
  }
  
  String getVocab() {
    int index = (int)random(0, level.weightSum);
    int vocabIndex = 0;
    while(index >= level.vocabs[vocabIndex]) {
      vocabIndex++;
    }
    return game.vocab.getRandVocab(vocabIndex);
  }
  
  void attack(int attackType) {
    score += 100;
    fever += 10;
  }
  
  void keyPressed() {}
  
  void keyTyped() {
    if(state != PLAYING) {
      return;
    }
    if(key == CODED || key == TAB) {
      return;
    }
    
    if(key == BACKSPACE) {
      if(inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      }
    } else if(key == ENTER || key == RETURN || key == ' ') {
      for(int i = 2; i >= 0; i--) {
        if(vocabs[i].equals(inputText)) {
          attack(i + (i % 1));
          vocabs[i] = getVocab();
          vocabText[i] = new VocabText(i, vocabs[i]);
          break;
        }
      }
      inputText = "";
    } else {
      if('a' <= key && key <= 'z') {
        inputText += key;
      } else if('A' <= key && key <= 'Z') {
        inputText += key;
      }
    }
  }
  
  void keyReleased() {
    if(isDebugMode) {
      if(key == TAB) {
        for(int i = 0; i < 3; i++) {
          vocabs[i] = getVocab();
          vocabText[i] = new VocabText(i, vocabs[i]);
        }
      }
    }
    if(state == PAUSE && key == ENTER) {
      state = preState;
    }
  }
  
  void mouseClicked() {
    if(game.menuButton.isHover()) {
      this.pause();
    }
  }
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    // if(game.menuButton.isHover()) {
    //   this.pause();
    // }
    if(state == PAUSE) {
      pausePage.mouseReleased();
      if(pausePage.state == pausePage.Play) {
        state = preState;
      } else if(pausePage.state == pausePage.Exit) {
        game.currentScene = 0;
      }
    }
  }
  
  void pause() {
    preState = state;
    state = PAUSE;
  }
}