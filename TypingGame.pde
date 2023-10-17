String inputText = "";

final int[] mainHeight = {640, 800, 1440, 2560};
final int[] mainWidth = {1024, 1280, 2304, 4096};

Game game;

void settings() {
  size(1280, 800); // 16:10 1024x640 -> 1280x800
}

void setup() {
  surface.setTitle("Typing Game");
  surface.setResizable(true);
  surface.setLocation((displayWidth - width) / 2,(displayHeight - height) / 2);
  
  game = new Game();
  
  textFont(createFont("NotoSansTC-Regular.ttf", 36));
  textAlign(CENTER, CENTER);
  textSize(36);
}

void draw() {
  game.update();
  game.draw();
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == DOWN) {
      game.currentScene = (game.currentScene + 1) % game.scenes.length;
    } else if(keyCode == UP) {
      game.currentScene = (game.currentScene - 1 + game.scenes.length) % game.scenes.length;
    }
  }
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