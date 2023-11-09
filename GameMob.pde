class Mob extends Character {
  float x;
  float y;
  float hp;
  float attackDamage;
  float attackDistance;
  float attackDuration;
  float velocity;
  // ...
  
  Mob() {
    super();
    mobSetup();
  }
  
  Mob(JSONObject data) {
    super(data);
    mobSetup();
    loadMobData();
  }

  void mobSetup() {
    this.stateNames = new String[] {"idle", "moving", "attacking", "dead"};
    this.state = 1;
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
    PImage currentImage = images.get(stateNames[state])[currentImageIndex];
    float imageHeight = currentImage.height * unit;
    float imageWidth = currentImage.width * unit;
    image(currentImage, x, y - imageHeight, imageWidth, imageHeight);
    
    if(isDebugMode) {
      fill(#FF0000);
      circle(x, y, 5);
    }
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
    Mob mob = copyData(new Mob(), interval);
    
    mob.images = images;
    mob.animations = animations;
    
    return mob;
  }
}

class MobCode extends Mob {
  MobCode() {
    super();
  }
  
  MobCode(JSONObject data) {
    super();
    this.data = data;
    this.name = data.getString("name");
    loadMobData();
  }
  
  Mob copy(int interval) {
    return copyData(new MobCode(), interval);
  }
  
  Mob copy(MobCode mobCode, int interval) {
    Mob mob = copyData(mobCode, interval);
    
    mob.shapes = shapes;
    mob.animations = animations;
    
    return mob;
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

class MobDynamic extends Mob {
  MobDynamic() {
    super();
  }
  
  MobDynamic(JSONObject data) {
    super();
    this.data = data;
    this.name = data.getString("name");
    loadMobData();
  }
  
  void loadMobData_() {}
  
  Mob copy(int interval) {
    return copyData(new MobDynamic(), interval);
  }
  
  Mob copy(MobDynamic mobDynamic, int interval) {
    return copyData(mobDynamic, interval);
  }
}