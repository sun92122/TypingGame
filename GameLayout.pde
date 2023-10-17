class Menu {
  Menu() {}

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

class Play {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();

  Play() {}

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

class Upgrade {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();

  Upgrade() {}

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

class Setting {
  MenuButton menuButton = new MenuButton();
  BackButton backButton = new BackButton();
  int setting = 0; // 0: video, 1: audio, 2: difficulty, 3: language, 4: about

  Setting() {}

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