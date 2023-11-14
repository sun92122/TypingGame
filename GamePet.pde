class Pet {
  String name;
  JSONObject data;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  
  int state = 1; // 0 = idle, 1 = moving, 2 = attacking
  String[] stateNames = {"idle", "moving", "attacking"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  float x;
  float y;
  float attackDamage;
  float attackDistance;
  float attackDuration;
  float velocity;
  // ...
  
  Pet(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    
    loadPetData();
  }
  
  void loadPetData() {
    // TODO: load pet data from JSON
    
    loadPetData_();
  }
  
  void loadPetData_() {}
  
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
}

class PetSvg extends Pet {
  PetSvg(JSONObject data) {
    super(data);
  }
  
  void loadMobData_() {
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
  
  void display() {
    ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
    PShape currentShape = currentShapes.get(currentImageIndex);
    shapeMode(CORNER);
    shape(currentShape, x, y - currentShape.getHeight(),
      currentShape.getWidth() * unit, currentShape.getHeight() * unit);
    
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