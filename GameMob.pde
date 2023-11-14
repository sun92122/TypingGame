class Mob {
  String name;
  JSONObject data;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  float currentRotation = 0;
  
  int state = 1; // 0 = idle, 1 = moving, 2 = attacking, 3 = dead
  String[] stateNames = {"idle", "moving", "attacking", "dead"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  float x;
  float y;
  float hp;
  float attackDamage;
  float attackDistance;
  float attackDuration;
  float velocity;
  // ...
  
  Mob() {}
  
  Mob(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    
    loadMobData();
  }
  
  void loadMobData() {
    this.hp = data.getFloat("HP");
    JSONObject attack = data.getJSONObject("attack");
    this.attackDamage = attack.getFloat("damage");
    this.attackDistance = attack.getFloat("distance");
    this.attackDuration = attack.getFloat("duration");
    this.velocity = data.getFloat("velocity");
    
    loadMobData_();
  }
  
  void loadMobData_() {}
  
  void setLocation(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    // display mob, scale *(unit)
    // x, y is left bottom corner of the mob
  }
  
  void update_() {}
  
  void update() {
    x -= velocity;
    update_();
  }
  
  void update(int state) {
    this.state = state;
    update_();
  }
  
  Mob copyData(Mob mob, int interval) {
    mob.name = name;
    mob.data = data;
    
    mob.hp = hp * interval;
    mob.attackDamage = attackDamage * interval;
    mob.attackDistance = attackDistance;
    mob.attackDuration = attackDuration;
    mob.velocity = velocity;
    
    return mob;
  }
  
  Mob copy(int interval) {
    return copy(new Mob(), interval);
  }
  
  Mob copy(Mob mob, int interval) {
    return copyData(mob, interval);
  }
}

class MobSvg extends Mob {
  MobSvg() {
    super();
  }
  
  MobSvg(JSONObject data) {
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
  
  Mob copy(int interval) {
    return copy(new MobSvg(), interval);
  }
  
  Mob copy(Mob mobSvg, int interval) {
    Mob mob = copyData(mobSvg, interval);
    
    mob.shapes = shapes;
    mob.animations = animations;
    
    return mob;
  }
}

class MobCode extends MobSvg {
  MobCode() {
    super();
  }
  
  MobCode(JSONObject data) {
    super(data);
  }
  
  void loadMobData_() {
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
  
  void display() {
    ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
    PShape currentShape = currentShapes.get(currentImageIndex);
    shapeMode(CORNER);
    shape(currentShape, x, y);
    
    debugPoint(x, y);
  }
  
  Mob copy(int interval) {
    return copyData(new MobCode(), interval);
  }
  
  Mob copy(Mob mobCode, int interval) {
    Mob mob = copyData(mobCode, interval);
    
    mob.shapes = shapes;
    mob.animations = animations;
    
    return mob;
  }
}

class MobDynamic extends Mob {
  MobDynamic() {
    super();
  }
  
  MobDynamic(JSONObject data) {
    super(data);
  }
  
  void display() {}
  
  Mob copy(int interval) {
    return copy(new MobDynamic(), interval);
  }
  
  Mob copy(Mob mobDynamic, int interval) {
    return copyData(mobDynamic, interval);
  }
}