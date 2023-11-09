class Character {
  String name;
  JSONObject data;
  
  HashMap<String, PImage[]> images = new HashMap<String, PImage[]>();
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  
  int state = 0; // 0 = idle, 1 = moving, 2 = attacking, 3 = dead, 4 = typing
  String[] stateNames = {"idle", "moving", "attacking", "dead", "typing"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  Character() {}
  
  Character(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    
    loadCharacterData();
  }
  
  void loadCharacterData() {
    JSONObject pictures = data.getJSONObject("pictures");
    for(String stateName : stateNames) {
      JSONArray stateData = pictures.getJSONArray(stateName);
      PImage[] stateImages = new PImage[stateData.size()];
      IntList stateAnimations = new IntList();
      for(int i = 0; i < stateData.size(); i++) {
        stateImages[i] = loadImage(stateData.getJSONObject(i).getString("path"));
        stateAnimations.append(stateData.getJSONObject(i).getInt("duration"));
      }
      images.put(stateName, stateImages);
      animations.put(stateName, stateAnimations);
    }
  }
  
  void display(float x, float y) {
    // display the character, max height 300px, proportional scaling
    // x, y is the right bottom corner of the character
    PImage currentImage = images.get(stateNames[state])[currentImageIndex];
    float imageHeight = min(300, currentImage.height);
    float imageWidth = currentImage.width * imageHeight / currentImage.height;
    image(currentImage, x - imageWidth, y - imageHeight, imageWidth, imageHeight);
    
    if(isDebugMode) {
      fill(#FF0000);
      circle(x, y, 5);
    }
  }
  
  void update_() {
    if(stateChangeTime == 0) {
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
    if(millis() > stateChangeTime) {
      currentImageIndex = (currentImageIndex + 1) % images.get(stateNames[state]).length;
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
  }
  
  void update() {
    update_();
  }
  
  void update(int state) {
    changeState(state);
    update_();
  }
  
  void changeState(int state) {
    this.state = state;
    currentImageIndex = 0;
    stateChangeTime = 0;
  }
}

class CharacterCode extends Character {  
  CharacterCode() {}
  
  CharacterCode(JSONObject data) {
    super(data);
  }
  
  void loadCharacterData() {
    JSONObject pictures = data.getJSONObject("pictures");
    for(String stateName : stateNames) {
      JSONArray stateData = pictures.getJSONArray(stateName);
      IntList stateAnimations = new IntList();
      for(int i = 0; i < stateData.size(); i++) {
        stateAnimations.append(stateData.getJSONObject(i).getInt("duration"));
      }
      animations.put(stateName, stateAnimations);
    }
  }
  
  void display(float x, float y) {
    // display the character, x, y is the right bottom corner of the character
    ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
    PShape currentShape = currentShapes.get(currentImageIndex);
    shape(currentShape, x, y);
    
    if(isDebugMode) {
      fill(#FF0000);
      circle(x, y, 5);
    }
  }
  
  void update_() {
    if(stateChangeTime == 0) {
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
    if(millis() > stateChangeTime) {
      currentImageIndex = (currentImageIndex + 1) % shapes.get(stateNames[state]).size();
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
  }
}