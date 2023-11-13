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

// TODO: slider, toggle, dropdown
class SubSetting {
  float x = width / 2;
  float y = height / 2;
  char type = 's';
  String title = "Music";
  
  int intVal = 0;
  float floatVal = 50;
  boolean boolVal = false;
  String parent;
  
  Slider slider;
  Toggle toggle;
  Dropdown dropdown;
  
  SubSetting(float x, float y, JSONObject data, String parent) {
    this.x = x;
    this.y = y;
    this.type = data.getString("type").charAt(0);
    this.title = data.getString("title");
    this.parent = parent;
    
    switch(type) {
      case 's':
        slider = new Slider(x + width / 2, y, 250, data, parent);
        break;
      case 't':
        toggle = new Toggle(x + width / 2, y, 250, 50, data, parent);
        break;
      case 'd':
        dropdown = new Dropdown(x + width / 2, y, 250, 50, data, parent);
        break;
    }
  }
  
  void display(boolean isSelect) {
    fill(0);
    textFont(game.fonts.get("Cubic11"));
    textSize(26);
    textAlign(LEFT, CENTER);
    float w = textWidth(title) + 20;
    if(isSelect) {
      fill(225);
      rect(x, y, w + 70, 50);
    }
    fill(0);
    text(title, x, y);
    switch(type) {
      case 's':
        slider.display();
        break;
      case 't':
        toggle.display();
        break;
      case 'd':
        dropdown.display();
        break;
    }
  }
  
  void mouseClicked() {
    switch(type) {
      case 's':
        slider.mouseClicked();
        break;
      case 't':
        toggle.mouseClicked();
        break;
      case 'd':
        dropdown.mouseClicked();
        break;
    }
  }
  
  void mouseDragged() {
    switch(type) {
      case 's':
        slider.mouseDragged();
        break;
      case 't':
        toggle.mouseDragged();
        break;
      case 'd':
        dropdown.mouseDragged();
        break;
    }
  }
  
  void mousePressed() {
    switch(type) {
      case 's':
        slider.mousePressed();
        break;
      case 't':
        toggle.mousePressed();
        break;
      case 'd':
        dropdown.mousePressed();
        break;
    }
  }
  
  void mouseReleased() {
    switch(type) {
      case 's':
        slider.mouseReleased();
        break;
      case 't':
        toggle.mouseReleased();
        break;
      case 'd':
        dropdown.mouseReleased();
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
  
  JSONObject data;
  String title;
  String parent;
  
  boolean isFocus = false;
  
  Slider(float x, float y, float w, JSONObject data, String parent) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.data = data;
    this.min = data.getFloat("min");
    this.max = data.getFloat("max");
    this.title = data.getString("title");
    this.parent = parent;
  }
  
  void display() {
    value = player.getSettingFloat(parent, title);
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, w, 5);
    circle(map(value, min, max, -w / 2, w / 2), 0, 10);
    popMatrix();
  }
  
  void mouseClicked() {
    if(isHover()) {
      isFocus = true;
      value = constrain(map(mouseX, x - w / 2, x + w / 2, min, max), min, max);
      player.setSetting(parent, title, value);
    }
  }
  
  void mouseDragged() {
    if(isFocus) {
      value = constrain(map(mouseX, x - w / 2, x + w / 2, min, max), min, max);
      player.setSetting(parent, title, value);
    }
  }
  
  void mousePressed() {
    if(isHover()) {
      isFocus = true;
    }
  }
  
  void mouseReleased() {
    isFocus = false;
  }
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - 20 && mouseY < y + 20) {
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
  
  JSONObject data;
  String title;
  String parent;
  
  Toggle(float x, float y, float w, float h, JSONObject data, String parent) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.data = data;
    this.title = data.getString("title");
    this.parent = parent;
  }
  
  void display() {
    value = player.getSettingBoolean(parent, title);
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    if(value) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(0, 0, w, h);
    popMatrix();
  }
  
  void mouseClicked() {
    if(isHover()) {
      value = !value;
      player.setSetting(parent, title, value);
    }
  }
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {}
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
}

class Dropdown {
  float x;
  float y;
  float w = 250;
  float h = 50;
  JSONArray options;
  int index = 0;
  
  JSONObject data;
  String title;
  String parent;
  
  Dropdown(float x, float y, float w, float h, JSONObject data, String parent) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.data = data;
    this.title = data.getString("title");
    this.options = data.getJSONArray("options");
    this.parent = parent;
  }
  
  void display() {
    index = player.getSettingInt(parent, title);
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(0);
    rect(0, 0, w, h);
    fill(255);
    rect(0, 0, w - 10, h - 10);
    fill(0);
    textFont(game.fonts.get("Cubic11"));
    textSize(26);
    textAlign(LEFT, CENTER);
    text(options.getJSONObject(index).getString("name"), -w / 2 + 10, 0);
    popMatrix();
  }
  
  void mouseClicked() {
    if(isHover()) {
      index = (index + 1) % options.size();
      player.setSetting(parent, title, index);
    }
  }
  
  void mouseDragged() {}
  
  void mousePressed() {}
  
  void mouseReleased() {}
  
  boolean isHover() {
    if(mouseX > x - w / 2 && mouseX < x + w / 2 && 
      mouseY > y - h / 2 && mouseY < y + h / 2) {
      return true;
    }
    return false;
  }
  
  float getValue() {
    return options.getJSONObject(index).getFloat("value");
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
    fill(225);
    rect(0, 0, w, h, r);
    fill(0);
    textFont(game.fonts.get("NotoSansTC"));
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
      float halfTextWidth = textWidth("FEVER!!") / 2;
      float halfTextAscent = textAscent() / 2;
      rect( -1 * halfTextWidth, -10 - halfTextAscent, halfTextWidth, min( -10 + halfTextAscent, 0));
      
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
        stroke(i / 494 * maxColorHue, 200, 255);
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