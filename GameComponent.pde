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
    textFont(game.fonts.get("PressStart2P"));
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

class CheckExit {
  float x = width / 2;
  float y = height / 2;
  float w = width / 1.5;
  float h = height / 2;
  
  void display() {
    fill(0, 100);
    rectMode(CORNER);
    rect(0, 0, width, height);
    
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(250);
    rect(0, 0, w, h, 10);
    fill(0);
    textFont(game.fonts.get("PressStart2P"));
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Are you sure you want to exit?", 0, -100);
    noFill();
    stroke(0);
    strokeWeight(3);
    rect(-100, 100, 100, 50);
    text("Yes", -100, 100);
    rect(100, 100, 100, 50);
    text("No", 100, 100);

    // Draw red frame when the mouse is hovering over the button
    if(isHoverYes()) {
      noFill();
      stroke(#FF0800);
      strokeWeight(3);
      rect(-100, 100, 100, 50);
    } else if(isHoverNo()) {
      noFill();
      stroke(#FF0800);
      strokeWeight(3);
      rect(100, 100, 100, 50);
    }

    popMatrix();
  }
  
  boolean isHoverYes() {
    if(mouseX > x - 150 && mouseX < x + 50 && 
      mouseY > y + 50 && mouseY < y + 150) {
      return true;
    }
    return false;
  }
  
  boolean isHoverNo() {
    if(mouseX > x + 50 && mouseX < x + 150 && 
      mouseY > y + 50 && mouseY < y + 150) {
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
    textFont(game.fonts.get("NotoSansTC"));
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
  PixelArrow arrow = new PixelArrow('R');
  
  JSONObject data;
  String title;
  SubSetting[] subSettings;
  
  int index = -1;
  
  SettingOption(JSONObject data, float y) {
    this.data = data;
    this.y = y;
    this.title = data.getString("name");
    
    JSONArray subSettingsData = data.getJSONArray("sub");
    subSettings = new SubSetting[subSettingsData.size()];
    for(int i = 0; i < subSettingsData.size(); i++) {
      JSONObject subSettingData = subSettingsData.getJSONObject(i);
      subSettings[i] = new SubSetting(
        width / 4, 150 + 60 * i, subSettingData, title);
    }
  }
  
  void display(boolean isSelect) {
    pushMatrix();
    translate(x, y);
    fill(0);
    textFont(game.fonts.get("Cubic11"));
    textSize(26);
    textAlign(LEFT, CENTER);
    w = textWidth(title);
    text(title, 0, 0);
    popMatrix();
    if(isHover()) {
      // add text hover effect
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(225, 225, 225, 100);
      text(title, x + w / 2, y);
      
      rectMode(CENTER);
      noStroke();
      fill(225, 225, 225, 40);
      rect(width * 3 / 32, y, width * 3 / 16, h);
    }
    
    
    if(isSelect) {
      noFill();
      stroke(0);
      strokeWeight(2);
      rect(width * 9 / 16, height * 5 / 9, width * 11 / 16, height * 7 / 9, 10);
      
      arrow.display( -x / 2, 0);
      for(int i = 0; i < subSettings.length; i++) {
        subSettings[i].display(i == index);
      }
    }
  }
  
  boolean isHover() {
    if(mouseX < x + w + 20 && mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
  
  void mouseClicked() {
    for(int i = 0; i < subSettings.length; i++) {
      subSettings[i].mouseClicked();
    }
  }
  
  void mouseReleased() {
    for(int i = 0; i < subSettings.length; i++) {
      subSettings[i].mouseReleased();
    }
  }
  
  void mousePressed() {
    for(int i = 0; i < subSettings.length; i++) {
      subSettings[i].mousePressed();
    }
  }
  
  void mouseDragged() {
    for(int i = 0; i < subSettings.length; i++) {
      subSettings[i].mouseDragged();
    }
  }
}

// TODO: slider, toggle, dropdown, info
class SubSetting {
  JSONObject data;
  
  float x = width / 2;
  float y = height / 2;
  float w = 250;
  float h = 50;
  char type = 's';
  String title = "Music";
  String parent;
  
  // slider
  float min = 0;
  float max = 100;
  float sliderValue = 50;
  boolean isFocus = false;
  // toggle
  boolean toggleValue = false;
  // dropdown
  JSONArray options;
  int dropdownIndex = 0;
  
  SubSetting(float x, float y, JSONObject data, String parent) {
    this.x = x + width / 2;
    this.y = y;
    this.data = data;
    this.type = data.getString("type").charAt(0);
    this.title = data.getString("title");
    this.parent = parent;
    if(type == 's') {
      this.min = data.getFloat("min");
      this.max = data.getFloat("max");
      this.h = 5;
    } else if(type == 'd') {
      this.options = data.getJSONArray("options");
    }
  }
  
  void display(boolean isSelect) {
    fill(0);
    textFont(game.fonts.get("Cubic11"));
    textSize(26);
    textAlign(LEFT, CENTER);
    float titleW = textWidth(title) + 20;
    if(isSelect) {
      fill(225);
      rect(x - width / 2, y, titleW + 70, 50);
    }
    fill(0);
    text(title, x - width / 2, y);
    
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    switch(type) {
      case 's':
        sliderValue = player.getSettingFloat(parent, title);
        fill(0);
        rect(0, 0, w, 5);
        circle(map(sliderValue, min, max, -w / 2, w / 2), 0, 10);
        break;
      case 't':
        toggleValue = player.getSettingBoolean(parent, title);
        if(toggleValue) {
          fill(0, 255, 0);
        } else {
          fill(255, 0, 0);
        }
        rect(0, 0, w, h);
        break;
      case 'd':
        dropdownIndex = player.getSettingInt(parent, title);
        fill(0);
        rect(0, 0, w, h);
        fill(255);
        rect(0, 0, w - 10, h - 10);
        fill(0);
        textFont(game.fonts.get("Cubic11"));
        textSize(26);
        textAlign(LEFT, CENTER);
        text(options.getJSONObject(dropdownIndex).getString("name"), -w / 2 + 10, 0);
        break;
      case 'i':
        break;
    }
    popMatrix();
  }
  
  void mouseClicked() {
    switch(type) {
      case 's':
        if(isHover()) {
          isFocus = true;
          sliderValue = constrain(map(mouseX, x - w / 2, x + w / 2, min, max), min, max);
          player.setSetting(parent, title, sliderValue);
        }
        break;
      case 't':
        if(isHover()) {
          toggleValue = !toggleValue;
          player.setSetting(parent, title, toggleValue);
        }
        break;
      case 'd':
        if(isHover()) {
          dropdownIndex = (dropdownIndex + 1) % options.size();
          player.setSetting(parent, title, dropdownIndex);
        }
        break;
    }
  }
  
  void mouseDragged() {
    if(type == 's' && isFocus) {
      sliderValue = constrain(map(mouseX, x - w / 2, x + w / 2, min, max), min, max);
      player.setSetting(parent, title, sliderValue);
    }
  }
  
  void mousePressed() {
    if(type == 's' && isHover()) {
      isFocus = true;
    }
  }
  
  void mouseReleased() {
    if(type == 's') {
      isFocus = false;
    }
  }
  
  boolean isHover() {
    if(type == 's') {
      if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
        mouseY > y - 20 && mouseY < y + 20) {
        return true;
      }
    } else if(type == 't' || type == 'd') {
      if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
        mouseY > y - h / 2 && mouseY < y + h / 2) {
        return true;
      }
    }
    return false;
  }
  
  float getValue() {
    return options.getJSONObject(dropdownIndex).getFloat("value");
  }
}

class Stars {
  float x;
  float y;
  float r1 = 10;
  float r2 = 20;
  float rotateAngle = 0;
  int isLight = 0;
  
  float angle = TWO_PI / 5;
  float halfAngle = angle / 2.0;
  
  Stars(float x, float y, float r1, float r2, float rotateAngle, int isLight) {
    this.x = x;
    this.y = y;
    this.r1 = r1;
    this.r2 = r2;
    this.rotateAngle = rotateAngle;
    this.isLight = isLight;
  }
  
  Stars(float x, float y, int isLight) {
    this.x = x;
    this.y = y;
    this.isLight = isLight;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotateAngle);
    if(isLight == 1) {
      fill(#FFD700);
    } else {
      fill(#C0C0C0);
    }
    beginShape();
    for(float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * r2;
      float sy = y + sin(a) * r2;
      vertex(sx, sy);
      sx = x + cos(a + halfAngle) * r1;
      sy = y + sin(a + halfAngle) * r1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
    popMatrix();
  }
}

class LevelIcon {
  float x;
  float y;
  float w = 100;
  float h = 100;
  float r = 10;
  int level;
  boolean isLock = true;
  
  Stars[] stars = new Stars[3];
  
  LevelIcon(float x, float y, int level, boolean isLock) {
    this.x = x;
    this.y = y;
    this.level = level;
    this.isLock = isLock;
    // this.isLock = level > player.getLevel();
    // test
    for(int i = 0; i < 3; i++) {
      int tmp = 0;
      if(!isLock) {
        tmp = random(1) > 0.5 ? 1 : 0;
      }
      stars[i] = new Stars(20 * (i - 1), 25, tmp);
    }
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    strokeWeight(2);
    stroke(0);
    fill(255);
    rect(0, 0, w, h, r);
    fill(0);
    textFont(game.fonts.get("Karmatic Arcade"));
    textAlign(CENTER, CENTER);
    if(isLock) {
      textSize(20);
      text("Lock", 0, 0);
    } else {
      textSize(30);
      text(level, 0, 0);
    }
    for(int i = 0; i < 3; i++) {
      stars[i].display();
    }
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

class FeverBar {
  float x = width / 2;
  float y = height - 80;
  
  int maxColorHue = 400;
  int hueOffset = 400;
  int saturation = 130;
  int feverSatDirection = 1;
  float feverTextSize = 30;
  int feverTextDirection = 1;
  
  
  void display(int fever) {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(#FFFFFF);
    stroke(#000000);
    strokeWeight(2);
    rect(0, 15, 500, 30);
    
    if(fever == 100) {
      textFont(game.fonts.get("Filepile"));
      textAlign(CENTER, CENTER);
      if(feverTextSize > 35) {
        feverTextSize = 35;
        feverTextDirection = -1;
      } else if(feverTextSize < 30) {
        feverTextSize = 30;
        feverTextDirection = 1;
      }
      feverTextSize += 0.3 * feverTextDirection;
      textSize(feverTextSize);
      
      fill(#FFFFFF);
      noStroke();
      rectMode(CORNERS);
      float halfW = textWidth("FEVER!!") / 2;
      float halfH = textAscent() / 2;
      rect( -1 * halfW, -10 - halfH, halfW, min( -10 + halfH, -1));
      
      colorMode(HSB, maxColorHue, 255, 255);
      // 更新色帶的水平位置
      hueOffset -= 5;  // 使色帶向左移動
      if(hueOffset < 0) {
        hueOffset = maxColorHue;  // 超過最大色調值時重置偏移量
      }
      
      rectMode(CENTER);
      for(int i = 0; i <= 500; i++) {
        // 計算當前點的色調
        stroke(adjustHue((i + hueOffset) % maxColorHue), saturation, 255);  // 使用更新的亮度值
        strokeWeight(0.5);
        noFill();
        rect(i - 250, 15, 1, 30);
      }
      // fever text
      fill(0);
      text("FEVER!!", 0, -10);
      
      // 更新飽和度
      saturation += 3 * feverSatDirection;
      if(saturation > 200) {  // 調整飽和度上限
        saturation = 200;
        feverSatDirection = -1;
      } else if(saturation <= 130) {
        saturation = 130;
        feverSatDirection = 1;
      }
    } else {
      colorMode(HSB, maxColorHue, 255, 255);
      for(float i = 0; i <= 494 * fever / 100; i += 1) {
        stroke(map(i / 494 * maxColorHue, 0, 255, 170, 240), 200, 255);
        strokeWeight(0.5);
        noFill();
        rect(i - 246, 15.5, 1, 24);
      }
    }
    
    colorMode(RGB, 255, 255, 255);
    
    popMatrix();
  }
  
  float adjustHue(float hue) {
    // 將 360 度的色調範圍分為數個區段，並對每個區段進行調整
    if(hue < 60) {  // 紅色到黃色的區域
      return map(hue, 0, 60, 0, 50);
    } else if(hue < 120) {  // 黃色到綠色的區域
      return map(hue, 60, 120, 50, 150);
    } else if(hue < 240) {  // 綠色到藍色的區域
      return map(hue, 120, 240, 150, 240);
    } else {  // 藍色到紫色的區域
      return map(hue, 240, 400, 240, 400);
    }
  }
}

class VocabText {
  float x;
  float y;
  float w;
  float h;
  char[] vocab;
  VocabTextSetting setting = new VocabTextSetting();
  TextBox textBox;
  
  VocabText(int index, String vocab) {
    this.x = setting.positionX[index];
    this.y = setting.positionY[index];
    this.vocab = vocab.toCharArray();
    textFont(game.fonts.get(setting.font));
    textSize(setting.textSize);
    w = textWidth(vocab);
    h = setting.textSize;
    textBox = new TextBox(x, y - 45, 450, 50);
  }
  
  void display(String input) {
    if(equals(input)) {
      textBox.display(#FFCC00);
    } else {
      textBox.display(#FFFFFF);
    }
    pushMatrix();
    translate(x - w / 2, y - 45);
    boolean lastCorrect = true;
    for(int i = 0; i < vocab.length; i++) {
      if(lastCorrect && i < input.length() && vocab[i] == input.charAt(i)) {
        fill(setting.colors[1]);
      } else if(lastCorrect && i < input.length()) {
        fill(setting.colors[2]);
        lastCorrect = false;
      } else {
        fill(setting.colors[0]);
      }
      textFont(game.fonts.get(setting.font));
      textSize(setting.textSize);
      textAlign(LEFT, CENTER);
      text(vocab[i], 0, 0);
      translate(textWidth(vocab[i]), 0);
    }
    popMatrix();
  }
  
  boolean equals(String input) {
    if(player.getSettingBoolean("Difficulty", "Case Sensitivity")) {
      return input.equals(new String(vocab));
    } else {
      return input.equalsIgnoreCase(new String(vocab));
    }
  }
}

static class VocabTextSetting {
  static color[] colors = {#000000, #33CC33, #FF0000};
  static int textSize = 35;
  static String font = "Cubic11";
  static float[] positionX = {640, 640, 640};
  static float[] positionY = {130, 190, 250};
}

class TextBox {
  float x;
  float y;
  float w;
  float h;
  
  TextBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    this.display(#FFFFFF);
  }
  
  void display(color c) {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(c);
    stroke(#000000);
    strokeWeight(2);
    rect(0, 0, w, h, 10);
    popMatrix();
  }
}

class PausePage {
  float x = 0;
  float y = 0;
  float w = width;
  float h = height;
  
  PausePageButton[] buttons = new PausePageButton[3];
  int index = -1;

  int state = 0; // 0: play, 1: pause, 2: Select_Level, 3: Main Menu
  final int PLAY = 0;
  final int PAUSE = 1;
  final int SELECT_LEVEL = 2;
  final int MAIN_MENU = 3;

  PausePage() {
    buttons[0] = new PausePageButton("Resume", 300);
    buttons[1] = new PausePageButton("Select Level", 400);
    buttons[2] = new PausePageButton("Main Menu", 500);
  }
  
  void display() {
    noStroke();
    fill(0, 100);
    rectMode(CORNER);
    rect(0, 0, w, h);
    rectMode(CENTER);
    fill(250);
    rect(w / 2, h / 1.8, w / 1.5, h / 1.5, 10);
    textSize(50);
    textAlign(CENTER, CENTER);
    textFont(game.fonts.get("NotoSansTC"));
    fill(#FFFFFF);
    text("Pause", w / 2, 100);
    
    for(int i = 0; i < buttons.length; i++) {
      buttons[i].display(i == index);
      if(buttons[i].isHover()) {
        index = i;
      }
    }
  }
  
  void mouseReleased() {
    if(index == 0) {
      state = 0;
    } else if(index == 1) {
      state = 2;
    } else if(index == 2) {
      state = 3;
    }
  }
}

class PausePageButton {
  float x = width / 2;
  float y = height / 2;
  float w = 250;
  float h = 50;
  PixelArrow pixel_arrow_left = new PixelArrow('R');
  PixelArrow pixel_arrow_right = new PixelArrow('L');
  
  String str = "Resume";
  
  PausePageButton(String str) {
    this.str = str;
  }
  
  PausePageButton(String str, float y) {
    this.str = str;
    this.y = y;
  }
  
  void display(boolean isSelect) {
    pushMatrix();
    translate(x, y);
    textFont(game.fonts.get("PressStart2P"));
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