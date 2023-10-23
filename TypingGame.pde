String inputText = "";

Player player;
Game game;

float unit = 1;

void settings() {
  // 16:9 {1280, 720}, {1600, 900}, {1920, 1080}, {2560, 1440}
  size(1280, 720); // default
  // if(displayWidth > 2560 && displayHeight > 1440) {
  //   size(2560, 1440);
  // } else if(displayWidth > 1920 && displayHeight > 1080) {
  //   size(1920, 1080);
  // } else if(displayWidth > 1600 && displayHeight > 900) {
  //   size(1600, 900);
  // }
}

void setup() {
  surface.setTitle("Typing Game");
  surface.setResizable(false);
  surface.setLocation((displayWidth - width) / 2,(displayHeight - height) / 2);
  
  player = new Player();
  game = new Game();
}

void draw() {
  game.update();
  game.draw();
  if(frameCount % 60 == 0) {
    println(frameRate);
  }
}

void keyPressed() {
  game.keyPressed();
}

void keyTyped() {
  if(key == CODED) {
    return;
  }
  
  if(key == BACKSPACE) {
    if(inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    }
  } else if(key == ENTER || key == RETURN) {
    inputText = "";
  } else {
    inputText += key;
  }
}

void mouseClicked() {
  game.mouseClicked();
}

void mouseDragged() {
  game.mouseDragged();
}

void mousePressed() {
  game.mousePressed();
}

void mouseReleased() {
  game.mouseReleased();
}