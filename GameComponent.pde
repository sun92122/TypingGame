class MenuButton {
  float x = width - 75;
  float y = height - 75;
  float w = 50;
  float h = 50;
  
  MenuButton() {}

  MenuButton(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  MenuButton(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(127);
    rect(0, 0, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Menu", 0, 0);
    popMatrix();
  }
}

class BackButton {
  float x = 100;
  float y = 50;
  float w = 100;
  float h = 50;

  BackButton() {}

  BackButton(float x, float y) {
    this.x = x;
    this.y = y;
  }

  BackButton(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(127);
    rect(0, 0, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Back", 0, 0);
    popMatrix();
  }
}