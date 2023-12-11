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
  
  void init() {
    audio.playMusic("menu");
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
        game.switchScene(currentButton + 1);
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
      isExiting = !isExiting;
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
        game.switchScene(currentButton + 1);
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
  
  void keyReleased() {
    if(key == ESC_) {
      game.switchScene(0);
    }
  }
  
  void mouseClicked() {}
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(game.backButton.isHover()) {
      game.switchScene(0);
    }
    for(int i = 0; i < 15; i++) {
      if(i + pageIndex * 15 >= levelCount) {
        break;
      }
      if(levels[i + pageIndex * 15].levelIcon.isHover() && 
        levels[i + pageIndex * 15].isUnlock) {
        game.switchScene(4);
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
  
  float tagWidth = width * 7 / 35;
  float tagHeight = height / 7;
  float pageWidth = width * 24 / 35;
  float pageHeight = height * 46 / 65;
  float skillWidth = pageWidth / 4;
  float skillHeight = pageHeight / 3;
  float moneyHpWidth = pageWidth / 3;
  float moneyHpHeight = pageHeight / 1.4;

  // ATTACK page variables
  float BasicX = width / 5.6 + pageWidth / 6;
  float BasicY = height / 5.3 + pageHeight / 3.2;
  float FEVERX = BasicX;
  float FEVERY = height / 5.3 + pageHeight / 3 * 2.3;
  float Skill_1_1_X = width / 5.6 + pageWidth / 3 + pageWidth / 5.5;
  float Skill_1_1_Y = height / 5.3 + pageHeight / 3.2;
  float Skill_1_2_X = width / 5.6 + pageWidth / 3 + pageWidth / 3 + skillWidth / 2;
  float Skill_1_2_Y = Skill_1_1_Y;
  float Skill_2_1_X = Skill_1_1_X;
  float Skill_2_1_Y = height / 5.3 + pageHeight / 3 * 2.3;
  float Skill_2_2_X = width / 5.6 + pageWidth / 3 + pageWidth / 3 + skillWidth / 2;
  float Skill_2_2_Y = Skill_2_1_Y;

  // MONEY & HP page variables
  float moneyX = width / 2 - pageWidth / 4.3 + 25;
  float moneyHpY = height / 1.75;
  float hpX = width / 2 + pageWidth / 4.3 + 25;

  // PET page variables
  float dogX = width / 5.6 + pageWidth / 2;
  float dogY = height / 5.3 + pageHeight / 3.2;
  float whiteDogX = dogX - pageWidth / 3.2;
  float whiteDogY = dogY;
  float fowlX = dogX + pageWidth / 3.2;
  float fowlY = dogY;
  float ratX = dogX;
  float ratY = height / 5.3 + pageHeight / 3 * 2.3;
  float oxX = dogX - pageWidth / 3.2;
  float oxY = ratY;
  float turtleX = dogX + pageWidth / 3.2;
  float turtleY = ratY;

  int Stroke_Weight = 6;
  int text_Size = 30;
  int text_Size_Skill = 25;

  int currentPage = 0;

  PFont C11;
  PFont ABL;
  
  void draw() {
    background(255); // TODO: change upgrade background

    C11 = game.fonts.get("Cubic11");
    ABL = game.fonts.get("Arial Black");
    
    switch(currentPage){
      case 0:
        attack_Page_Display();
        break;
      case 1:
        money_hp_Page_Display();
        break;
      case 2:
        pet_Page_Display();
        break;
    }

    show_Money();
    
    game.backButton.display();    
  }
  
  void show_Money(){
    // draw a rectangular frame at the down left corner
    noFill();
    stroke(0);
    strokeWeight(4);
    rectMode(CORNER);
    rect(1120, 10, 150, 50, 10);
    // show money at the down left corner
    fill(0);
    textFont(C11);
    textSize(text_Size);
    textAlign(LEFT);
    text("$:  ", 1130, 45);
    textAlign(RIGHT);
    text(round(player.money), 1260, 45);
  }

  void attack_Page_Display() {
    rectMode(CORNER);
    // Money & HP
    fill(200);
    stroke(0);
    strokeWeight(Stroke_Weight);
    rect(width / 5.6 + tagWidth, height / 11, tagWidth, tagHeight, 20);
    textAlign(CENTER);
    textFont(C11);
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
    // Skill Icon
    skill_Icon_Display();

    // Skill Level
    skill_Level_Display(BasicX, BasicY, 0);
    skill_Level_Display(FEVERX, FEVERY, 1);
    skill_Level_Display(Skill_1_1_X, Skill_1_1_Y, 2);
    skill_Level_Display(Skill_1_2_X, Skill_1_2_Y, 3);
    skill_Level_Display(Skill_2_1_X, Skill_2_1_Y, 4);
    skill_Level_Display(Skill_2_2_X, Skill_2_2_Y, 5);

    // Skill Frame
    skill_Frame_Display(BasicX, BasicY, 0);
    skill_Frame_Display(FEVERX, FEVERY, 1);
    skill_Frame_Display(Skill_1_1_X, Skill_1_1_Y, 2);
    skill_Frame_Display(Skill_1_2_X, Skill_1_2_Y, 3);
    skill_Frame_Display(Skill_2_1_X, Skill_2_1_Y, 4);
    skill_Frame_Display(Skill_2_2_X, Skill_2_2_Y, 5);

    // Skill Text
    fill(0);
    text("Basic", BasicX, BasicY - skillHeight / 2 - text_Size / 2);
    text("FEVER", FEVERX, FEVERY - skillHeight / 2 - text_Size / 2);
    text("Skill 1", Skill_1_1_X + skillWidth / 2 + pageWidth * 3.5 / 264, Skill_1_1_Y - skillHeight / 2 - text_Size / 2);
    text("Skill 2", Skill_2_1_X + skillWidth / 2 + pageWidth * 3.5 / 264, Skill_2_1_Y - skillHeight / 2 - text_Size / 2);

    // Show the current selected skill
    red_Frame_Display(player.currentSkill1, player.currentSkill2);

    // seperate line
    stroke(0);
    strokeWeight(4);
    line(width / 5.6 + pageWidth / 3, height / 5.3 + pageHeight / 8, width / 5.6 + pageWidth / 3, height / 5.3 + pageHeight - pageHeight / 16);
  }

  void skill_Frame_Display(float x, float y, int levelIndex){
    // draw rectangular frame
    noFill();
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    rect(x, y, skillWidth, skillHeight, 20);
    // Add an upgrade button in the square
    textSize(text_Size);
    textFont(C11);
    textAlign(CENTER);
    // check if the player has enough money to upgrade
    if((player.money < player.skillLevel[levelIndex] * 10) || (player.skillLevel[levelIndex] == 5)){
      fill(150);
    }else{
      fill(#00a2ed);
    }
    rect(x, y + skillHeight / 3.2, skillWidth * 3 / 4, skillHeight / 4);
    fill(255);
    text("Upgrade", x, y + skillHeight / 2.8);
  }

  void skill_Icon_Display() {
    // Show Basic icon
    if(player.skillLevel[0] < 5){
      icon.display(player.skillLevel[0]-1, BasicX, BasicY + skillHeight / 10);
    } else{
      icon.display(4, BasicX, BasicY + skillHeight / 10);
    }
    // Show FEVER icon
    icon.display(5, FEVERX, FEVERY - skillHeight / 20);
    // Show Skill Mouse icon
    if(player.skillLevel[2] > 3){
      icon.display(7, Skill_1_1_X, Skill_1_1_Y - skillHeight / 20);
    } else{
      icon.display(6, Skill_1_1_X, Skill_1_1_Y - skillHeight / 20);
    }
    // Show Skill Phone icon
    icon.display(8, Skill_1_2_X, Skill_1_2_Y - skillHeight / 10);
    // Show Skill Ice icon
    icon.display(9, Skill_2_1_X, Skill_2_1_Y - skillHeight / 10);
    // Show Skill Shuriken icon
    icon.display(10, Skill_2_2_X, Skill_2_2_Y - skillHeight / 10);
  }

  void skill_Level_Display(float x, float y, int levelIndex){
    color[] levelColor = {0, #008000, #0077B6, #A335EE};
    // Show the current level of the skill
    textAlign(LEFT);
    textFont(ABL);
    fill(0);
    textSize(text_Size_Skill);
    if(player.skillLevel[levelIndex] < 5){
      fill(levelColor[player.skillLevel[levelIndex]-1]);
      text("Lv." + player.skillLevel[levelIndex], x - skillWidth / 2 + 10, y - skillHeight / 2 + 25);
    } else{
      fill(#FF8000);
      text("Lv.MAX", x - skillWidth / 2 + 10, y - skillHeight / 2 + 25);
    }
  }

  void red_Frame_Display(String currentSkill1, String currentSkill2){
      stroke(#FF0800);
      strokeWeight(5);
      noFill();
      rectMode(CENTER);
      rect(BasicX, BasicY, skillWidth, skillHeight, 20);
      rect(FEVERX, FEVERY, skillWidth, skillHeight, 20);
    if(currentSkill1 == "mouse"){
      rect(Skill_1_1_X, Skill_1_1_Y, skillWidth, skillHeight, 20);
    }else if(currentSkill1 == "phone"){
      rect(Skill_1_2_X, Skill_1_2_Y, skillWidth, skillHeight, 20);
    }
    if(currentSkill2 == "ice"){
      rect(Skill_2_1_X, Skill_2_1_Y, skillWidth, skillHeight, 20);
    }else if(currentSkill2 == "shuriken"){
      rect(Skill_2_2_X, Skill_2_2_Y, skillWidth, skillHeight, 20);
    }
  }

  void money_hp_Page_Display(){
    rectMode(CORNER);
    // ATTACK
    fill(200);
    stroke(0);
    strokeWeight(Stroke_Weight);
    rect(width / 5.6, height / 11, tagWidth, tagHeight, 20);
    textAlign(CENTER);
    textFont(C11);
    textSize(text_Size);
    fill(0);
    text("ATTACK", width / 5.6 + tagWidth * 0.5, height / 11 + tagHeight / 2.1);
    // PET
    fill(200);
    stroke(0);
    rect(width / 5.6 + 2 * tagWidth, height / 11, tagWidth, tagHeight, 20);
    fill(0);
    text("PET", width / 5.6 + tagWidth * 2.5, height / 11 + tagHeight / 2.1);
    // MONEY & HP
    fill(255);
    stroke(0);
    rect(width / 5.6, height / 5.3, pageWidth, pageHeight, 20);
    rect(width / 5.6 + tagWidth, height / 11, tagWidth, tagHeight, 20);
    noStroke();
    rect(width / 5.6 - Stroke_Weight + tagWidth, height / 5.3 + Stroke_Weight / 2, width / 4.5, tagHeight);
    fill(0);
    text("MONEY & HP", width / 5.6 + tagWidth * 1.5, height / 11 + tagHeight / 2.1);

    // Show Frame
    money_hp_Frame_Display();

    // Icon
    icon.display(11, moneyX, moneyHpY - moneyHpHeight / 10);
    icon.display(12, hpX, moneyHpY - moneyHpHeight / 10);

    // Level
    money_hp_Leval_Display(moneyX, moneyHpY, player.earningEffiLevel);
    money_hp_Leval_Display(hpX, moneyHpY, player.maxHpLevel);

    // show the current earning efficiency
    textAlign(CENTER);
    textFont(ABL);
    textSize(text_Size_Skill);
    fill(0);
    text("Efficiency: " + float(round(10 * player.earningEfficiency)) / 10 + " x", moneyX, moneyHpY + moneyHpHeight / 3.5);
    // show the current max HP
    text("Max HP: " + player.maxHP, hpX, moneyHpY + moneyHpHeight / 3.5);
  }

  void money_hp_Frame_Display(){
    noFill();
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    // Money Frame
    rect(moneyX, moneyHpY, moneyHpWidth, moneyHpHeight, 20);
    // HP Frame
    rect(hpX, moneyHpY, moneyHpWidth, moneyHpHeight, 20);

    // Text
    fill(0);
    text("Earning Efficiency", moneyX, moneyHpY - moneyHpHeight / 2 - text_Size / 2);
    text("Max HP", hpX, moneyHpY - moneyHpHeight / 2 - text_Size / 2);

    // Money uprade button
    if((player.money < player.earningEffiLevel * 10) || (player.earningEffiLevel == 11)){
      fill(150);
    }else{
      fill(#00a2ed);
    }
    rect(moneyX, moneyHpY + moneyHpHeight / 2.5, moneyHpWidth * 3 / 4, skillHeight / 4);
    fill(255);
    text("Upgrade", moneyX, moneyHpY + moneyHpHeight / 2.4);
    // HP uprade button
    if((player.money < player.maxHpLevel * 10) || (player.maxHpLevel == 11)){
      fill(150);
    }else{
      fill(#00a2ed);
    }
    rect(hpX, moneyHpY + moneyHpHeight / 2.5, moneyHpWidth * 3 / 4, skillHeight / 4);
    fill(255);
    text("Upgrade", hpX, moneyHpY + moneyHpHeight / 2.4);
  }

  void money_hp_Leval_Display(float x, float y, int level){
    color[] levelColor = {0, 0, 0, #008000, #008000, #008000, #0077B6, #0077B6, #A335EE, #A335EE};
    // Show the current level of the skill
    textAlign(LEFT);
    textFont(ABL);
    fill(0);
    textSize(text_Size_Skill);
    if(level < 11){
      fill(levelColor[level-1]);
      text("Lv." + level, x - moneyHpWidth / 2 + 10, y - moneyHpHeight / 2 + 25);
    }else{
      fill(#FF8000);
      text("Lv.MAX", x - moneyHpWidth / 2 + 10, y - moneyHpHeight / 2 + 25);
    }
  }

  void pet_Page_Display(){
    rectMode(CORNER);
    // ATTACK
    fill(200);
    stroke(0);
    strokeWeight(Stroke_Weight);
    rect(width / 5.6, height / 11, tagWidth, tagHeight, 20);
    textAlign(CENTER);
    textFont(C11);
    textSize(text_Size);
    fill(0);
    text("ATTACK", width / 5.6 + tagWidth * 0.5, height / 11 + tagHeight / 2.1);
    // MONEY & HP
    fill(200);
    stroke(0);
    rect(width / 5.6 + 1 * tagWidth, height / 11, tagWidth, tagHeight, 20);
    fill(0);
    text("MONEY & HP", width / 5.6 + tagWidth * 1.5, height / 11 + tagHeight / 2.1);
    // PET
    fill(255);
    stroke(0);
    rect(width / 5.6, height / 5.3, pageWidth, pageHeight, 20);
    rect(width / 5.6 + 2 * tagWidth, height / 11, tagWidth, tagHeight, 20);
    noStroke();
    rect(width / 5.6 - Stroke_Weight + 2 * tagWidth, height / 5.3 + Stroke_Weight / 2, width / 4.5, tagHeight);
    fill(0);
    text("PET", width / 5.6 + tagWidth * 2.5, height / 11 + tagHeight / 2.1);

    // Icon
    icon.display(13, whiteDogX, whiteDogY - skillHeight / 10);
    icon.display(14, dogX, dogY - skillHeight / 10);
    icon.display(15, fowlX, fowlY - skillHeight / 10);
    icon.display(16, oxX, oxY - skillHeight / 10);
    icon.display(17, ratX, ratY - skillHeight / 10);
    icon.display(18, turtleX, turtleY - skillHeight / 10);

    // frame & Upgrade Button
    pet_Frame_Display(whiteDogX, whiteDogY, 0);
    pet_Frame_Display(dogX, dogY, 1);
    pet_Frame_Display(fowlX, fowlY, 2);
    pet_Frame_Display(oxX, oxY, 3);
    pet_Frame_Display(ratX, ratY, 4);
    pet_Frame_Display(turtleX, turtleY, 5);

    // Level
    pet_Leval_Display(whiteDogX, whiteDogY, 0);
    pet_Leval_Display(dogX, dogY, 1);
    pet_Leval_Display(fowlX, fowlY, 2);
    pet_Leval_Display(oxX, oxY, 3);
    pet_Leval_Display(ratX, ratY, 4);
    pet_Leval_Display(turtleX, turtleY, 5);

    // Text
    fill(0);
    textAlign(CENTER);
    textFont(C11);
    textSize(text_Size);
    text("Bingo", whiteDogX, whiteDogY - skillHeight / 2 - text_Size / 2);
    text("Lucky", dogX, dogY - skillHeight / 2 - text_Size / 2);
    text("Cogi", fowlX, fowlY - skillHeight / 2 - text_Size / 2);
    text("Oxygen", oxX, oxY - skillHeight / 2 - text_Size / 2);
    text("Jerry", ratX, ratY - skillHeight / 2 - text_Size / 2);
    text("TingCoCo", turtleX, turtleY - skillHeight / 2 - text_Size / 2);

    // red frame
    pet_red_Frame_Display(player.currentPet);
  }

  void pet_Frame_Display(float x, float y, int petIndex){
    noFill();
    stroke(0);
    strokeWeight(4);
    rectMode(CENTER);
    // draw rectangular frame
    rect(x, y, skillWidth, skillHeight, 20);
    // Add an upgrade button in the square
    textSize(text_Size);  
    textFont(C11);
    textAlign(CENTER);
    // check if the player has enough money to upgrade
    if((player.money < player.petLevel[petIndex] * 10) || (player.petLevel[petIndex] == 5)){
      fill(150);
    }else{
      fill(#00a2ed);
    }
    rect(x, y + skillHeight / 3.2, skillWidth * 3 / 4, skillHeight / 4);
    fill(255);
    text("Upgrade", x, y + skillHeight / 2.8); 
  }

  void pet_Leval_Display(float x, float y, int petIndex){
    color[] levelColor = {0, #008000, #0077B6, #A335EE};
    // Show the current level of the pet
    textAlign(LEFT);
    textFont(ABL);
    fill(0);
    textSize(text_Size_Skill);
    if(player.petLevel[petIndex] < 5){
      fill(levelColor[player.petLevel[petIndex]-1]);
      text("Lv." + player.petLevel[petIndex], x - skillWidth / 2 + 10, y - skillHeight / 2 + 25);
    }else{
      fill(#FF8000);
      text("Lv.MAX", x - skillWidth / 2 + 10, y - skillHeight / 2 + 25);
    }
  }

  void pet_red_Frame_Display(String currentpet){
      stroke(#FF0800);
      strokeWeight(5);
      noFill();
      rectMode(CENTER);
    if(currentpet == "white dog"){
      rect(whiteDogX, whiteDogY, skillWidth, skillHeight, 20);
    }else if(currentpet == "dog"){
      rect(dogX, dogY, skillWidth, skillHeight, 20);
    }else if(currentpet == "fowl"){
      rect(fowlX, fowlY, skillWidth, skillHeight, 20);
    }else if(currentpet == "ox"){
      rect(oxX, oxY, skillWidth, skillHeight, 20);
    }else if(currentpet == "rat"){
      rect(ratX, ratY, skillWidth, skillHeight, 20);
    }else if(currentpet == "turtle"){
      rect(turtleX, turtleY, skillWidth, skillHeight, 20);
    }
  }
  
  void keyPressed() {}
  
  void keyTyped() {}
  
  void keyReleased() {
    if(key == ESC_) {
      game.switchScene(0);
    }
  }
  
  void mouseClicked() {
  }
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {
    if(game.backButton.isHover()) {
      game.currentScene = 0;
    }
    // Select the page
    if(mouseX > (width / 5.6) && mouseX < (width / 5.6 + tagWidth) && mouseY > (height / 11) && mouseY < (height / 11 + tagHeight)){
      currentPage = 0;
    }else if(mouseX > (width / 5.6 + tagWidth) && mouseX < (width / 5.6 + tagWidth * 2) && mouseY > (height / 11) && mouseY < (height / 11 + tagHeight)){
      currentPage = 1;
    }else if(mouseX > (width / 5.6 + tagWidth * 2) && mouseX < (width / 5.6 + tagWidth * 3) && mouseY > (height / 11) && mouseY < (height / 11 + tagHeight)){
      currentPage = 2;
    }
    switch(currentPage){
      case 0:
        // Upgrade button Basic
        if(mouseX > (BasicX - skillWidth * 3 / 8) && mouseX < (BasicX + skillWidth * 3 / 8) && mouseY > (BasicY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (BasicY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[0] < 5){
            if(player.money >= player.skillLevel[0] * 10){
              player.money -= player.skillLevel[0] * 10;
              player.skillLevel[0] += 1;
            }
          }
        }
        // Upgrade button FEVER
        if(mouseX > (FEVERX - skillWidth * 3 / 8) && mouseX < (FEVERX + skillWidth * 3 / 8) && mouseY > (FEVERY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (FEVERY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[1] < 5){
            if(player.money >= player.skillLevel[1] * 10){
              player.money -= player.skillLevel[1] * 10;
              player.skillLevel[1]++;
            }
          }
        }
        // Upgrade button Skill 1-1
        if(mouseX > (Skill_1_1_X - skillWidth * 3 / 8) && mouseX < (Skill_1_1_X + skillWidth * 3 / 8) && mouseY > (Skill_1_1_Y + skillHeight / 3.2 - skillHeight / 8) && mouseY < (Skill_1_1_Y + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[2] < 5){
            if(player.money >= player.skillLevel[2] * 10){
              player.money -= player.skillLevel[2] * 10;
              player.skillLevel[2]++;
              return;
            }
          }
        }
        // Upgrade button Skill 1-2
        if(mouseX > (Skill_1_2_X - skillWidth * 3 / 8) && mouseX < (Skill_1_2_X + skillWidth * 3 / 8) && mouseY > (Skill_1_2_Y + skillHeight / 3.2 - skillHeight / 8) && mouseY < (Skill_1_2_Y + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[3] < 5){
            if(player.money >= player.skillLevel[3] * 10){
              player.money -= player.skillLevel[3] * 10;
              player.skillLevel[3]++;
              return;
            }
          }
        }
        // Upgrade button Skill 2-1
        if(mouseX > (Skill_2_1_X - skillWidth * 3 / 8) && mouseX < (Skill_2_1_X + skillWidth * 3 / 8) && mouseY > (Skill_2_1_Y + skillHeight / 3.2 - skillHeight / 8) && mouseY < (Skill_2_1_Y + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[4] < 5){
            if(player.money >= player.skillLevel[4] * 10){
              player.money -= player.skillLevel[4] * 10;
              player.skillLevel[4]++;
              return;
            }
          }
        }
        // Upgrade button Skill 2-2
        if(mouseX > (Skill_2_2_X - skillWidth * 3 / 8) && mouseX < (Skill_2_2_X + skillWidth * 3 / 8) && mouseY > (Skill_2_2_Y + skillHeight / 3.2 - skillHeight / 8) && mouseY < (Skill_2_2_Y + skillHeight / 3.2 + skillHeight / 8)){
          if(player.skillLevel[5] < 5){
            if(player.money >= player.skillLevel[5] * 10){
              player.money -= player.skillLevel[5] * 10;
              player.skillLevel[5]++;
              return;
            }
          }
        }
        // Select Skill1
        if(mouseX > (Skill_1_1_X - skillWidth / 2) && mouseX < (Skill_1_1_X + skillWidth / 2) && mouseY > (Skill_1_1_Y - skillHeight / 2) && mouseY < (Skill_1_1_Y + skillHeight / 2)){
          player.currentSkill1 = "mouse";
        }
        if(mouseX > (Skill_1_2_X - skillWidth / 2) && mouseX < (Skill_1_2_X + skillWidth / 2) && mouseY > (Skill_1_2_Y - skillHeight / 2) && mouseY < (Skill_1_2_Y + skillHeight / 2)){
          player.currentSkill1 = "phone";
        }
        // Select Skill2
        if(mouseX > (Skill_2_1_X - skillWidth / 2) && mouseX < (Skill_2_1_X + skillWidth / 2) && mouseY > (Skill_2_1_Y - skillHeight / 2) && mouseY < (Skill_2_1_Y + skillHeight / 2)){
          player.currentSkill2 = "ice";
        }
        if(mouseX > (Skill_2_2_X - skillWidth / 2) && mouseX < (Skill_2_2_X + skillWidth / 2) && mouseY > (Skill_2_2_Y - skillHeight / 2) && mouseY < (Skill_2_2_Y + skillHeight / 2)){
          player.currentSkill2 = "shuriken";
        }
        break;
      case 1:
        // Upgrade button Money
        if(mouseX > (moneyX - moneyHpWidth * 3 / 8) && mouseX < (moneyX + moneyHpWidth * 3 / 8) && mouseY > (moneyHpY + moneyHpHeight / 2.5 - skillHeight / 8) && mouseY < (moneyHpY + moneyHpHeight / 2.5 + skillHeight / 8)){
          if(player.money >= player.earningEffiLevel * 10){
            if(player.earningEffiLevel < 11){
              player.money -= player.earningEffiLevel * 10;
              player.earningEffiLevel++;
              player.earningEfficiency += 0.1;
            }
          }
        }
        // Upgrade button HP
        if(mouseX > (hpX - moneyHpWidth * 3 / 8) && mouseX < (hpX + moneyHpWidth * 3 / 8) && mouseY > (moneyHpY + moneyHpHeight / 2.5 - skillHeight / 8) && mouseY < (moneyHpY + moneyHpHeight / 2.5 + skillHeight / 8)){
          if(player.money >= player.maxHpLevel * 10){
            if(player.maxHpLevel < 11){
              player.money -= player.maxHpLevel * 10;
              player.maxHpLevel++;
              player.maxHP += 10;
            }
          }
        }
        break;
      case 2:
        // Upgrade button White Dog
        if(mouseX > (whiteDogX - skillWidth * 3 / 8) && mouseX < (whiteDogX + skillWidth * 3 / 8) && mouseY > (whiteDogY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (whiteDogY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[0] * 10){
            if(player.petLevel[0] < 5){
              player.money -= player.petLevel[0] * 10;
              player.petLevel[0]++;
              return;
            }
          }
        }
        // Upgrade button Dog
        if(mouseX > (dogX - skillWidth * 3 / 8) && mouseX < (dogX + skillWidth * 3 / 8) && mouseY > (dogY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (dogY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[1] * 10){
            if(player.petLevel[1] < 5){
              player.money -= player.petLevel[1] * 10;
              player.petLevel[1]++;
              return;
            }
          }
        }
        // Upgrade button Fowl
        if(mouseX > (fowlX - skillWidth * 3 / 8) && mouseX < (fowlX + skillWidth * 3 / 8) && mouseY > (fowlY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (fowlY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[2] * 10){
            if(player.petLevel[2] < 5){
              player.money -= player.petLevel[2] * 10;
              player.petLevel[2]++;
              return;
            }
          }
        }
        // Upgrade button Ox
        if(mouseX > (oxX - skillWidth * 3 / 8) && mouseX < (oxX + skillWidth * 3 / 8) && mouseY > (oxY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (oxY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[3] * 10){
            if(player.petLevel[3] < 5){
              player.money -= player.petLevel[3] * 10;
              player.petLevel[3]++;
              return;
            }
          }
        }
        // Upgrade button Rat
        if(mouseX > (ratX - skillWidth * 3 / 8) && mouseX < (ratX + skillWidth * 3 / 8) && mouseY > (ratY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (ratY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[4] * 10){
            if(player.petLevel[4] < 5){
              player.money -= player.petLevel[4] * 10;
              player.petLevel[4]++;
              return;
            }
          }
        }
        // Upgrade button Turtle
        if(mouseX > (turtleX - skillWidth * 3 / 8) && mouseX < (turtleX + skillWidth * 3 / 8) && mouseY > (turtleY + skillHeight / 3.2 - skillHeight / 8) && mouseY < (turtleY + skillHeight / 3.2 + skillHeight / 8)){
          if(player.money >= player.petLevel[5] * 10){
            if(player.petLevel[5] < 5){
              player.money -= player.petLevel[5] * 10;
              player.petLevel[5]++;
              return;
            }
          }
        }
        // Select Pet
        if(mouseX > (whiteDogX - skillWidth / 2) && mouseX < (whiteDogX + skillWidth / 2) && mouseY > (whiteDogY - skillHeight / 2) && mouseY < (whiteDogY + skillHeight / 2)){
          player.currentPet = "white dog";
        }
        if(mouseX > (dogX - skillWidth / 2) && mouseX < (dogX + skillWidth / 2) && mouseY > (dogY - skillHeight / 2) && mouseY < (dogY + skillHeight / 2)){
          player.currentPet = "dog";
        }
        if(mouseX > (fowlX - skillWidth / 2) && mouseX < (fowlX + skillWidth / 2) && mouseY > (fowlY - skillHeight / 2) && mouseY < (fowlY + skillHeight / 2)){
          player.currentPet = "fowl";
        }
        if(mouseX > (oxX - skillWidth / 2) && mouseX < (oxX + skillWidth / 2) && mouseY > (oxY - skillHeight / 2) && mouseY < (oxY + skillHeight / 2)){
          player.currentPet = "ox";
        }
        if(mouseX > (ratX - skillWidth / 2) && mouseX < (ratX + skillWidth / 2) && mouseY > (ratY - skillHeight / 2) && mouseY < (ratY + skillHeight / 2)){
          player.currentPet = "rat";
        }
        if(mouseX > (turtleX - skillWidth / 2) && mouseX < (turtleX + skillWidth / 2) && mouseY > (turtleY - skillHeight / 2) && mouseY < (turtleY + skillHeight / 2)){
          player.currentPet = "turtle";
        }
      break;
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
  
  void keyReleased() {
    if(key == ESC_) {
      game.switchScene(0);
    }
  }
  
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
      game.switchScene(0);
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
  int currentHP = player.maxHP;
  int fever = 0;
  ArrayList<Mob> mobs = new ArrayList<Mob>();
  float mobXMin = width;
  String inputText = "";
  String[] vocabs = new String[3];
  VocabText[] vocabText = new VocabText[3];
  Table attackTable = new Table();
  
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
    
    attackTable.addColumn("damage");
    attackTable.addColumn("piercing");
    attackTable.addColumn("delay");
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
      audio.stopAllMusic();
      audio.playMusic(level.bgm);
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
    rect(100, 25, 1.5 * player.maxHP + 5, 30);
    noStroke();
    fill(192, 0, 0);
    if(currentHP > player.maxHP) {
      rect(102.5, 28, 1.5 * player.maxHP, 24.5);
      currentHP = player.maxHP;
    } else if(currentHP < 0) {
      currentHP = 0;
    } else{
      rect(102.5, 28, 1.5 * currentHP, 24.5);
    }
    // testing the change in hp & fever // DEBUG
    if(mousePressed && (mouseButton == LEFT)) {
      currentHP -= 1;
      fever -= 1;
    } else if(mousePressed && (mouseButton == RIGHT)) {
      currentHP += 1;
      fever += 1;
    }
    
    // money
    fill(0);
    text("$", 37.5, 100);
    text(":", 68, 100);
    text(round(player.money), 100, 100);
    
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
    character.changeState(4, attackType, attackTable, mobXMin);
  }
  
  void keyPressed() {
    if(state != PAUSE) {
      if(key == ESC_) {
        pause();
      }
    }
  }
  
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
      pause();
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
      if(pausePage.state == pausePage.PLAY) {
        state = preState;
      } else if(pausePage.state == pausePage.LEVEL_MENU) {
        audio.stopMusic(level.bgm);
        game.switchScene(1);
      } else if(pausePage.state == pausePage.MAIN_MENU) {
        audio.stopMusic(level.bgm);
        game.switchScene(0);
      }
    }
  }
  
  void pause() {
    preState = state;
    state = PAUSE;
  }
}