String inputText = "";

Player player;
Game game;

float unit = 1;

boolean isDebugMode = false;

void settings() {
  size(1280, 720); // default
}

void setup() {
  try {
    surface.setTitle("Typing Game");
    surface.setResizable(false);
    surface.setLocation((displayWidth - width) / 2,(displayHeight - height) / 2);
    
    player = new Player();
    game = new Game();
  } catch(Exception e) {
    println("Error: " + e);
    exit();
  }
}

void draw() {
  try {
    game.update();
    game.draw();
  } catch(Exception e) {
    println("Error: " + e);
    exit();
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

void logPrint(String text) {
  println("[" + nf(millis(), 5) + "]: " + text);
}