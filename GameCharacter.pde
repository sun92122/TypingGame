class Character {
  String name;
  JSONObject data;
  float scale = 1;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  
  int state = 1; // 0 = idle, 1 = moving, 2 = attacking, 3 = dead, 4 = typing
  String[] stateNames = {"idle", "moving", "attacking", "dead", "typing"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  Character(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    
    loadCharacterData();
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
    
    debugPoint(x, y);
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

class CharacterSvg extends Character {  
  CharacterSvg(JSONObject data) {
    super(data);
    this.scale = data.getFloat("scale");
  }
  
  void loadCharacterData() {
    JSONObject pictures = data.getJSONObject("pictures");
    for(String stateName : stateNames) {
      JSONArray stateData = pictures.getJSONArray(stateName);
      ArrayList<PShape> stateShapes = new ArrayList<PShape>();
      IntList stateAnimations = new IntList();
      for(int i = 0; i < stateData.size(); i++) {
        stateShapes.add(loadShape(stateData.getJSONObject(i).getString("path")));
        stateAnimations.append(stateData.getJSONObject(i).getInt("duration"));
      }
      shapes.put(stateName, stateShapes);
      animations.put(stateName, stateAnimations);
    }
  }
  
  void display(float x, float y) {
    // display the character, x, y is the right bottom corner of the character
    ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
    PShape currentShape = currentShapes.get(currentImageIndex);
    float h = currentShape.getHeight() * scale * unit;
    float w = currentShape.getWidth() * scale * unit;
    shape(currentShape, x - w, y - h, w, h);
    
    debugPoint(x, y);
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