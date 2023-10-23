class MainMenuButton {
  float x = width / 2;
  float y = height / 2;
  float w = 250;
  float h = 50;
  PixelArrow pixel_arrow_left = new PixelArrow('R');
  PixelArrow pixel_arrow_right = new PixelArrow('L');
  
  String str = "Play";
  
  MainMenuButton(String str) {
    this.str = str;
  }
  
  MainMenuButton(String str, float y) {
    this.str = str;
    this.y = y;
  }
  
  void display(boolean isSelect) {
    pushMatrix();
    translate(x, y);
    textSize(30);
    textAlign(CENTER, CENTER);
    w = textWidth(str) + 20;
    rectMode(CENTER);
    noStroke();
    if(isHover() || isSelect) {
      fill(225);
      rect(0, 0, w + 70, h);
      pixel_arrow_left.display( -w / 2 - 10, 0);
      pixel_arrow_right.display(w / 2 + 10, 0);
    }
    fill(0);
    text(str, 0, 0);
    popMatrix();
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

class MenuButton {
  float x = width - 75;
  float y = height - 75;
  float r = 50;
  
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
    textFont(game.fonts.get("NotoSansTC"));
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
    strokeWeight(2);
    stroke(0);
    fill(127);
    rect(0, 0, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Back", 0, 0);
    popMatrix();
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

class PixelArrow {
  char dir = 'R';
  
  PixelArrow() {}
  
  PixelArrow(char dir) {
    this.dir = dir;
  }
  
  void display(float x, float y) {
    pushMatrix();
    translate(x, y);
    fill(0);
    rectMode(CENTER);
    noStroke();
    switch(dir) {
      case 'R':
        break;
      case 'L':
        rotate(PI);
        break;
      case 'U':
        rotate(PI / 2);
        break;
      case 'D':
        rotate( -PI / 2);
        break;
    }
    rect(7.5, 0, 10, 5);
    rect(2.5, 2.5, 10, 5);
    rect(2.5, -2.5, 10, 5);
    rect( -2.5, 5, 10, 5);
    rect( -2.5, -5, 10, 5);
    rect( -7.5, 7.5, 10, 5);
    rect( -7.5, -7.5, 10, 5);
    popMatrix();
  }
}

class SettingOption {
  float x = width / 16;
  float y = 100;
  float w = 250;
  float h = 50;
  
  String str = "Music";
  
  SettingOption(String str, float y) {
    this.str = str;
    this.y = y;
  }
  
  void display(boolean isSelect) {
    pushMatrix();
    translate(x, y);
    textSize(30);
    textAlign(CENTER, CENTER);
    w = textWidth(str) + 20;
    rectMode(CENTER);
    noStroke();
    if(isHover() || isSelect) {
      fill(225);
      rect(0, 0, w + 70, h);
    }
    fill(0);
    text(str, 0, 0);
    popMatrix();
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

// TODO: slider, toggle, dropdown
class SubSetting {
  float x = width / 2;
  float y = height / 2;
  char type = 's';
  String title = "Music";
  
  int intVal = 0;
  float floatVal = 50;
  boolean boolVal = false;
  
  Slider slider;
  Toggle toggle;
  Dropdown dropdown;
  
  SubSetting(float x, float y, JSONObject data, int value) {
    this.intVal = value;
    switchType(x, y, data);
  }
  
  SubSetting(float x, float y, JSONObject data, float value) {
    this.floatVal = value;
    switchType(x, y, data);
  }
  
  SubSetting(float x, float y, JSONObject data, boolean value) {
    this.boolVal = value;
    switchType(x, y, data);
  }
  
  void switchType(float x, float y, JSONObject data) {
    this.x = x;
    this.y = y;
    this.type = data.getString("type").charAt(0);
    this.title = data.getString("title");
    
    switch(type) {
      case 's':
        slider = new Slider(x, y, 250, 0, 100, floatVal);
        break;
      case 't':
        toggle = new Toggle(x, y, 50, 25, boolVal);
        break;
      case 'd':
        break;
    }
  }
  
}

class Slider {
  float x;
  float y;
  float w = 250;
  float h = 5;
  float min = 0;
  float max = 100;
  float value = 50;
  
  Slider(float x, float y, float w, float min, float max, float value) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.min = min;
    this.max = max;
    this.value = value;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, w, 5);
    circle(map(value, min, max, -w / 2, w / 2), 0, 10);
    popMatrix();
  }
  
  void update() {
    if(mousePressed && isHover()) {
      value = constrain(map(mouseX, x - w / 2, x + w / 2, min, max), min, max);
    }
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

class Toggle {
  float x;
  float y;
  float w = 50;
  float h = 25;
  boolean value = false;
  
  Toggle(float x, float y, float w, float h, boolean value) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.value = value;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, w, h);
    if(value) {
      fill(255);
      rect(w / 2, 0, w, h);
    }
    popMatrix();
  }
  
  void update() {
    if(mousePressed && isHover()) {
      value = !value;
    }
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

class Dropdown {
  
}