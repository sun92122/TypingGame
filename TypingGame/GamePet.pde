class Pet {
  String name;
  JSONObject data;
  float scale = 1;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  HashMap<String, IntList> shiftX = new HashMap<String, IntList>();
  HashMap<String, IntList> shiftY = new HashMap<String, IntList>();
  
  int state = 1; // 0 = idle, 1 = moving, 2 = attacking
  String[] stateNames = {"idle", "moving", "attacking"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  float x = 0;
  float y = 630;
  float attackDamage;
  float attackDistance;
  float attackDuration;
  float velocity;
  // ...
  
  Pet(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    this.scale = data.getFloat("scale");
    
    loadPetData();
  }
  
  void loadPetData() {
    // TODO: load pet data from JSON
    
    loadPetData_();
  }
  
  void loadPetData_() {}
  
  void display() {}
  
  void setLocation(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void move() {
    x += velocity;
  }
  
  void update_() {}
  
  void update() {
    update_();
  }
  
  void update(int state) {
    this.state = state;
    
    this.stateChangeTime = 0;
    this.currentImageIndex = 0;
    
    update_();
  }
}

class PetSvg extends Pet {
  PetSvg(JSONObject data) {
    super(data);
  }
  
  void loadPetData_() {
    JSONObject pictures = data.getJSONObject("pictures");
    for(String stateName : stateNames) {
      JSONArray stateData = pictures.getJSONArray(stateName);
      ArrayList<PShape> stateShapes = new ArrayList<PShape>();
      IntList stateAnimations = new IntList();
      IntList stateShiftX = new IntList();
      IntList stateShiftY = new IntList();
      for(int i = 0; i < stateData.size(); i++) {
        stateShapes.add(loadShape(stateData.getJSONObject(i).getString("path")));
        stateAnimations.append(stateData.getJSONObject(i).getInt("duration"));
        stateShiftX.append(stateData.getJSONObject(i).getInt("x"));
        stateShiftY.append(stateData.getJSONObject(i).getInt("y"));
      }
      shapes.put(stateName, stateShapes);
      animations.put(stateName, stateAnimations);
      shiftX.put(stateName, stateShiftX);
      shiftY.put(stateName, stateShiftY);
    }
  }
  
  void display() {
    ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
    PShape currentShape = currentShapes.get(currentImageIndex);
    int currentShiftX = shiftX.get(stateNames[state]).get(currentImageIndex);
    int currentShiftY = shiftY.get(stateNames[state]).get(currentImageIndex);
    shapeMode(CORNER);
    float h = currentShape.getHeight() * scale * unit;
    float w = currentShape.getWidth() * scale * unit;
    float x = this.x - w + currentShiftX * scale * unit;
    float y = this.y - h + currentShiftY * scale * unit;
    shapeMode(CORNER);
    shape(currentShape, x, y, w, h);

    debugPoint(this.x, this.y);
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