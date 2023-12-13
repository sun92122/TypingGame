class Mob {
  String name;
  JSONObject data;
  float scale = 1;
  int characterX = 400;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  HashMap<String, IntList> shiftX = new HashMap<String, IntList>();
  HashMap<String, IntList> shiftY = new HashMap<String, IntList>();
  float currentRotation = 0;
  
  int state = 1; // 0 = idle, 1 = moving, 2 = attacking, 3 = dead
  String[] stateNames = {"idle", "moving", "attacking", "dead"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  boolean isAttacked = false;
  int attackTime = 0;
  
  float x;
  float y;
  float hp;
  float attackDamage;
  int attackDistance;
  int attackDuration;
  float velocity;
  // ...
  
  Mob() {}
  
  Mob(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    try {
      this.scale = data.getFloat("scale");
    } catch(Exception e) {
      this.scale = 1;
    }
    
    loadMobData();
  }
  
  void loadMobData() {
    this.hp = data.getFloat("HP");
    JSONObject attack = data.getJSONObject("attack");
    this.attackDamage = attack.getFloat("damage");
    this.attackDistance = attack.getInt("distance");
    this.attackDuration = attack.getInt("duration");
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
  
  boolean update() {
    x -= velocity * unit * 60 / frameRate;
    if(x < characterX + attackDistance) {
      x = characterX + attackDistance;
      if(state != 2 && attackTime < millis()) {
        changeState(2);
        attackTime = millis() + attackDuration;
      }
    }
    update_();
    
    return isAttacked;
  }
  
  void changeState(int state) {
    this.state = state;
    currentImageIndex = 0;
    stateChangeTime = 0;
  }
  
  float attacked() {
    isAttacked = false;
    // return damage
    return attackDamage;
  }
  
  void injured(float damage) {
    hp -= damage;
    audio.playSound("mob injured");
    if(hp <= 0) {
      hp = 0;
      changeState(3);
    }
  }
  
  Mob copyData(Mob mob, float moblevel) {
    mob.name = name;
    mob.data = data;
    mob.scale = scale;
    
    mob.hp = hp * moblevel;
    mob.attackDamage = attackDamage * moblevel;
    mob.attackDistance = attackDistance;
    mob.attackDuration = attackDuration;
    mob.velocity = velocity;
    
    return mob;
  }
  
  Mob copy(float moblevel) {
    return copy(new Mob(), moblevel);
  }
  
  Mob copy(Mob mob, float moblevel) {
    return copyData(mob, moblevel);
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
    float x = this.x + currentShiftX * scale * unit;
    float y = this.y + currentShiftY * scale * unit - h;
    shape(currentShape, x, y, w, h);
    
    debugPoint(this.x, this.y);
  }
  
  void update_() {
    if(stateChangeTime == 0) {
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
    if(millis() > stateChangeTime) {
      if(state == 2 && currentImageIndex == shapes.get(stateNames[state]).size() - 1) {
        changeState(0);
        isAttacked = true;
      }
      currentImageIndex = (currentImageIndex + 1) % shapes.get(stateNames[state]).size();
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
  }
  
  Mob copy(float moblevel) {
    return copy(new MobSvg(), moblevel);
  }
  
  Mob copy(Mob mobSvg, float moblevel) {
    Mob mob = copyData(mobSvg, moblevel);
    
    mob.shapes = shapes;
    mob.animations = animations;
    mob.shiftX = shiftX;
    mob.shiftY = shiftY;
    
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
  
  Mob copy(float moblevel) {
    return copyData(new MobCode(), moblevel);
  }
  
  Mob copy(Mob mobCode, float moblevel) {
    Mob mob = copyData(mobCode, moblevel);
    
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
  
  Mob copy(float moblevel) {
    return copy(new MobDynamic(), moblevel);
  }
  
  Mob copy(Mob mobDynamic, float moblevel) {
    return copyData(mobDynamic, moblevel);
  }
}