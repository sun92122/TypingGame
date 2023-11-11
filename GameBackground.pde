class Background {
  String name;
  JSONObject data;
  
  HashMap<String, PImage> images = new HashMap<String, PImage>();
  
  float xShift = 0;
  // float yShift = 0;
  
  Background(BackgroundData backgrounds, int index) {
    loadBackgroundData(backgrounds, index);
  }
  
  void loadBackgroundData(BackgroundData backgrounds, int index) {
    this.data = backgrounds.maps.getJSONObject(index);
    this.name = data.getString("name");
    JSONArray pictures = data.getJSONArray("pictures");
    for(int i = 0; i < pictures.size(); i++) {
      String pictureName = pictures.getString(i);
      images.put(pictureName, backgrounds.pictures.get(pictureName));
    }
  }
  
  void drawBehind() {
    background(255);
    drawImages(data.getJSONArray("behind"));
  }
  
  void drawInFront() {
    drawImages(data.getJSONArray("infront"));
  }
  
  void drawImages(JSONArray imagesData) {
    for(int i = 0; i < imagesData.size(); i++) {
      JSONObject imageData = imagesData.getJSONObject(i);
      String mode = imageData.getString("mode");
      String pictureName = imageData.getString("picture");
      PImage picture = images.get(pictureName);
      float pictureW = imageData.getFloat("width") * unit;
      float pictureH = imageData.getFloat("height") * unit;
      float startX = check(imageData.getFloat("startx") * unit, width);
      float startY = check(imageData.getFloat("starty") * unit, height);
      if(startX < 0) {
        startX = width + startX;
      }
      if(startY < 0) {
        startY = height + startY;
      }
      if(mode.equals("repeat")) {
        drawImageRepeat(imageData, picture, pictureW, pictureH, startX, startY);
      } else if(mode.equals("once")) {
        drawImageOnce(imageData, picture, pictureW, pictureH, startX, startY);
      } else if(mode.equals("interval")) {
        drawImageInterval(imageData, picture, pictureW, pictureH, startX, startY);
      }
    }
  }
  
  void drawImageRepeat(JSONObject imageData, PImage picture,
    float w, float h, float startX, float startY) {
    float x = startX;
    float y = startY;
    float endX = check(imageData.getFloat("endx") * unit, width);
    float endY = check(imageData.getFloat("endy") * unit, height);
    while(y <= endY) {
      while(x <= endX) {
        drawImage(picture, x, y, w, h);
        x += w;
      }
      x = startX;
      y += h;
    }
  }
  
  void drawImageOnce(JSONObject imageData, PImage picture,
    float w, float h, float startX, float startY) {
    float velocity = imageData.getFloat("velocity") * unit;
    float x = startX + xShift * velocity;
    float y = startY;
    drawImage(picture, x, y, w, h);
  }
  
  void drawImageInterval(JSONObject imageData, PImage picture,
    float w, float h, float startX, float startY) {
    float x = startX;
    float y = startY;
  }
  
  void drawImage(PImage picture, float x, float y, float w, float h) {
    if(x > width || x + w < 0 || y > height || y + h < 0) {
      return;
    }
    image(picture, x , y , w , h);
    
    if(isDebugMode) {
      fill(#FF0000);
      circle(x, y, 5);
    }
  }
  
  void update(char direction) {
    if(direction == 'L') {
      xShift++;
    } else if(direction == 'R') {
      xShift--;
    }
  }
  
  float check(float original, float max) {
    if(original < 0) {
      return max + original;
    } else {
      return original;
    }
  }
}