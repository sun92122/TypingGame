class MainMenuButton {
  float x = width / 2;
  float y = height / 2;
  float w = 250;
  float h = 50;
  
  String str = "Play";
  
  MainMenuButton(String str) {
    this.str = str;
  }
  
  MainMenuButton(String str, float y) {
    this.str = str;
    this.y = y;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    textSize(30);
    textAlign(CENTER, CENTER);
    this.w = textWidth(str) + 20;
    rectMode(CENTER);
    noStroke();
    if(isHover()) {
      fill(225);
      rect(0, 0, w + 70, h);
      fill(0);
      triangle( -w / 2 - 10, 0, -w / 2 - 30, -10, -w / 2 - 30, 10);
      triangle(w / 2 + 10, 0, w / 2 + 30, -10, w / 2 + 30, 10);
    }
    fill(0);
    text(str, 0, 0);
    popMatrix();
  }
  
  boolean isHover() {
    return mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2;
  }
}

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
  
  MenuButton(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    strokeWeight(2);
    stroke(0);
    fill(127);
    circle(0, 0, r);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("≡", 0, 0);
    popMatrix();
  }
  
  boolean isHover() {
    return dist(mouseX, mouseY, x, y) < r / 2;
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
  
  boolean isHover() {
    return mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2;
  }
}