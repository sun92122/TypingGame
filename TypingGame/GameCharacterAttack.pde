class CharacterAttack {
  JSONObject attackData;
  float scale = 1;
  
  CharacterAttackType basicAttack;
  CharacterAttackType feverAttack;
  CharacterAttackType specialAttack[];
  final int BASIC_ATT = 0;
  final int FEVER_ATT = 1;
  final int SPECIAL_ATT_1 = 2;
  final int SPECIAL_ATT_2 = 3;
  IntDict specialAttackName = new IntDict();
  
  int skill1 = 0;
  int skill2 = 2;
  
  CharacterAttackType currentAttack;
  boolean isAttacking = false;
  int attackingType = 0;
  
  CharacterAttack(JSONObject attackData, float scale) {
    this.attackData = attackData;
    this.scale = scale;
    
    loadCharacterAttack();
  }
  
  void loadCharacterAttack() {
    JSONObject basicAttackData = attackData.getJSONObject("basic");
    JSONObject feverAttackData = attackData.getJSONObject("fever");
    JSONArray specialAttackDatas = attackData.getJSONArray("skill");
    
    basicAttack = new CharacterAttackType(basicAttackData, scale, -2);
    feverAttack = new CharacterAttackType(feverAttackData, scale, -1);
    
    specialAttack = new CharacterAttackType[4];
    for(int i = 0; i < 4; i++) {
      JSONObject specialAttackData = specialAttackDatas.getJSONObject(i);
      specialAttack[i] = new CharacterAttackType(specialAttackData, scale, i);
      specialAttackName.set(specialAttackData.getString("name"), i);
    }
  }
  
  void attack(int attackType, Table attackTable) {
    switch(attackType) {
      case BASIC_ATT:
        if(!isAttacking || attackingType < BASIC_ATT) {
          attackingType = BASIC_ATT;
          currentAttack = basicAttack;
        }
        basicAttack.attackTypeToTableRow(attackTable);
        break;
      case FEVER_ATT:
        attackingType = FEVER_ATT;
        currentAttack = feverAttack;
        feverAttack.attackTypeToTableRow(attackTable);
        break;
      case SPECIAL_ATT_1:
        skill1 = specialAttackName.get(player.getSkill1());
        if(!isAttacking || attackingType <= BASIC_ATT) {
          attackingType = SPECIAL_ATT_1;
          currentAttack = specialAttack[skill1];
        }
        specialAttack[skill1].attackTypeToTableRow(attackTable);
        break;
      case SPECIAL_ATT_2:
        skill2 = specialAttackName.get(player.getSkill2());
        if(!isAttacking || attackingType <= BASIC_ATT) {
          attackingType = SPECIAL_ATT_2;
          currentAttack = specialAttack[skill2];
        }
        specialAttack[skill2].attackTypeToTableRow(attackTable);
        break;
    }
    if(!isAttacking) {
      currentAttack.stateChangeTime = 0;
      isAttacking = true;
    } else {
      attackingType = BASIC_ATT;
    }
    return;
  }
  
  void display(float x, float y) {
    isAttacking = currentAttack.display(x, y);
  }
  
  void update() {
    basicAttack.loadCharacterAttackLevel();
    feverAttack.loadCharacterAttackLevel();
    for(int i = 0; i < 4; i++) {
      specialAttack[i].loadCharacterAttackLevel();
    }
  }
  
  void getAttackComponents(int attackType, ArrayList<CharacterAttackComponent> components, float mobX, float characterX, float characterY) {
    CharacterAttackComponent[] newComponents = new CharacterAttackComponent[0];
    switch(attackType) {
      case BASIC_ATT:
        newComponents = basicAttack.getComponent(mobX, characterX, characterY);
        break;
      case FEVER_ATT:
        newComponents = feverAttack.getComponent(mobX, characterX, characterY);
        break;
      case SPECIAL_ATT_1:
        newComponents = specialAttack[skill1].getComponent(mobX, characterX, characterY);
        break;
      case SPECIAL_ATT_2:
        newComponents = specialAttack[skill2].getComponent(mobX, characterX, characterY);
        break;
    }
    for(int i = 0; i < newComponents.length; i++) {
      components.add(newComponents[i]);
    }
  }
}

class CharacterAttackType {
  int index = -2;
  float scale = 1;
  JSONObject attackTypeData;
  
  String name = "";
  int maxLevel = 1;
  int effectType = 0;
  int delayTime = 0;
  int damage[];
  int cooldown[];
  int piercing[];
  
  ArrayList<PShape> attackShapes[];
  IntList attackAnimations[];
  IntList shiftXs[];
  IntList shiftYs[];
  ArrayList<CharacterAttackComponent> components[];
  
  ArrayList<PShape> shapes;
  IntList animations;
  IntList shiftX;
  IntList shiftY;
  ArrayList<CharacterAttackComponent> component;
  int currentImageIndex = 0;
  int stateChangeTime = 0;
  
  int level = 1;
  
  CharacterAttackType(JSONObject attackTypeData, float scale, int index) {
    this.index = index;
    this.scale = scale;
    this.attackTypeData = attackTypeData;
    
    this.name = attackTypeData.getString("name");
    this.maxLevel = attackTypeData.getInt("max level");
    this.effectType = attackTypeData.getInt("effect");
    this.delayTime = attackTypeData.getInt("delay");
    
    JSONArray damageData = attackTypeData.getJSONArray("damage");
    JSONArray cooldownData = attackTypeData.getJSONArray("cooldown");
    JSONArray piercingData = attackTypeData.getJSONArray("piercing");
    JSONArray attackShapeData = attackTypeData.getJSONArray("pictures");
    JSONArray attackComponentData = attackTypeData.getJSONArray("other");
    
    damage = new int[maxLevel];
    cooldown = new int[maxLevel];
    piercing = new int[maxLevel];
    attackShapes = new ArrayList[maxLevel];
    attackAnimations = new IntList[maxLevel];
    shiftXs = new IntList[maxLevel];
    shiftYs = new IntList[maxLevel];
    components = new ArrayList[maxLevel];
    
    for(int i = 0; i < maxLevel; i++) {
      damage[i] = damageData.getInt(i);
      cooldown[i] = cooldownData.getInt(i);
      piercing[i] = piercingData.getInt(i);
      attackShapes[i] = new ArrayList<PShape>();
      attackAnimations[i] = new IntList();
      shiftXs[i] = new IntList();
      shiftYs[i] = new IntList();
      components[i] = new ArrayList<CharacterAttackComponent>();
      
      JSONArray attackShapeDataLevel = attackShapeData.getJSONArray(i);
      for(int j = 0; j < attackShapeDataLevel.size(); j++) {
        JSONObject attackShapeDataLevelData = attackShapeDataLevel.getJSONObject(j);
        PShape shape = loadShape(attackShapeDataLevelData.getString("path"));
        int shapeAnimation = attackShapeDataLevelData.getInt("duration");
        int shapeShiftX = attackShapeDataLevelData.getInt("x");
        int shapeShiftY = attackShapeDataLevelData.getInt("y");
        
        attackShapes[i].add(shape);
        attackAnimations[i].append(shapeAnimation);
        shiftXs[i].append(shapeShiftX);
        shiftYs[i].append(shapeShiftY);
      }
      JSONArray attackComponentDataLevel = attackComponentData.getJSONArray(i);
      for(int j = 0; j < attackComponentDataLevel.size(); j++) {
        JSONObject attackComponentDataLevelData = attackComponentDataLevel.getJSONObject(j);
        components[i].add(new CharacterAttackComponent(attackComponentDataLevelData, delayTime));
      }
    }
  }
  
  void loadCharacterAttackLevel() {
    // load attack level
    // level = player.getAttackLevel(index);
    level = player.getAttackLevel(index);
    
    shapes = attackShapes[level - 1];
    animations = attackAnimations[level - 1];
    shiftX = shiftXs[level - 1];
    shiftY = shiftYs[level - 1];
    component = components[level - 1];
  }
  
  void attackTypeToTableRow(Table attackTable) {
    TableRow row = attackTable.addRow();
    row.setInt("damage", damage[level - 1]);
    row.setInt("piercing", piercing[level - 1]);
    row.setInt("delay", delayTime);
    return;
  }
  
  boolean display(float x, float y) {
    if(stateChangeTime == 0) {
      currentImageIndex = 0;
      stateChangeTime = millis() + animations.get(currentImageIndex);
      // push component to playing page
    }
    if(millis() > stateChangeTime) {
      if(currentImageIndex == animations.size() - 1) {
        return false;
      }
      currentImageIndex++;
      stateChangeTime = millis() + animations.get(currentImageIndex);
    }
    PShape currentShape = shapes.get(currentImageIndex);
    int currentShiftX = shiftX.get(currentImageIndex);
    int currentShiftY = shiftY.get(currentImageIndex);
    float h = currentShape.getHeight() * scale * unit;
    float w = currentShape.getWidth() * scale * unit;
    shape(currentShape, x - w + currentShiftX, y - h + currentShiftY, w, h);
    return true;
  }
  
  CharacterAttackComponent[] getComponent(float mobX, float characterX, float characterY) {
    CharacterAttackComponent[] newComponents = new CharacterAttackComponent[component.size()];
    for(int i = 0; i < component.size(); i++) {
      newComponents[i] = component.get(i).clone(mobX, characterY, characterX, characterY);
    }
    return newComponents;
  }
}

class CharacterAttackComponent {
  JSONObject data;
  
  ArrayList<PShape> shapes;
  IntList animations;
  int stateChangeTime = 0;
  int currentShapeIndex = 0;
  PShape currentShape;
  float scale = 1;
  
  int startDelay = 0;
  float startX = 0;
  float startY = 0;
  float endX = 0;
  float endY = 0;
  int flyingTime = 0; // should be damage delay - image delay (ms)
  int type = 0; // 0: straight, 1: parabola, 2: knockback
  
  float currentX = 0;
  float currentY = 0;
  float currentVX = 0;
  float currentVY = 0;
  float currentAX = 0;
  float currentAY = 0;
  float characterX = 400;
  float characterY = width - 150.0f;
  
  CharacterAttackComponent(JSONObject data, int damageDelay) {
    this.data = data;
    
    loadCharacterAttackComponent();
    this.flyingTime = damageDelay - this.startDelay;
    if(this.type == 2) {
      this.flyingTime *= 2;
    }
  }
  
  CharacterAttackComponent(CharacterAttackComponent component) {
    this.data = component.data;
    this.shapes = component.shapes;
    this.animations = component.animations;
    this.stateChangeTime = component.stateChangeTime;
    this.currentShapeIndex = component.currentShapeIndex;
    this.currentShape = component.currentShape;
    this.scale = component.scale;
    
    this.startDelay = component.startDelay;
    this.type = component.type;
    
    this.startX = component.startX;
    this.startY = component.startY;
    this.flyingTime = component.flyingTime;
    this.currentX = component.startX;
    this.currentY = component.startY;
  }
  
  void loadCharacterAttackComponent() {
    shapes = new ArrayList<PShape>();
    animations = new IntList();
    
    JSONArray shapeData = data.getJSONArray("pictures");
    for(int i = 0; i < shapeData.size(); i++) {
      JSONObject shapeDataData = shapeData.getJSONObject(i);
      shapes.add(loadShape(shapeDataData.getString("path")));
      animations.append(shapeDataData.getInt("duration"));
    }
    currentShape = shapes.get(0);
    
    scale = data.getFloat("scale");
    startDelay = data.getInt("delay");
    startX = data.getFloat("x");
    startY = data.getFloat("y");
    type = data.getInt("type");
  }
  
  void display() {
    if(startDelay > 0) {
      return;
    }
    
    float h = currentShape.getHeight() * scale * unit;
    float w = currentShape.getWidth() * scale * unit;
    shape(currentShape, currentX - w, currentY - h, w, h);
  }
  
  boolean update() {
    float frameCorrection = 60.0f / frameRate;
    
    if(startDelay > 0) {
      startDelay -= 1000 / frameRate;
      return false;
    }
    currentX += currentVX * frameCorrection;
    currentY += currentVY * frameCorrection;
    currentVX += currentAX * frameCorrection;
    currentVY += currentAY * frameCorrection;
    
    if(millis() > stateChangeTime) {
      currentShapeIndex = (currentShapeIndex + 1) % animations.size();
      currentShape = shapes.get(currentShapeIndex);
      stateChangeTime = millis() + animations.get(currentShapeIndex);
    }
    
    if(currentX >= endX) {
      if(type == 2) {
        currentVX = -1 * currentVX;
      } else {
        return true;
      }
    }
    if(type == 2 && currentX <= startX) {
      return true;
    }
    return false;
  }
  
  CharacterAttackComponent clone(float endX, float endY, float characterX, float characterY) {
    CharacterAttackComponent newComponent = new CharacterAttackComponent(this);
    newComponent.startX = characterX;
    newComponent.startY = characterY;
    newComponent.endX = endX;
    newComponent.endY = endY;
    newComponent.currentX += characterX;
    newComponent.currentY += characterY;
    switch(type) {
      case 0:
        newComponent.currentVX = ((endX - newComponent.currentX) / (flyingTime / 1000.0f)) / 60.0f;
        newComponent.currentVY = ((newComponent.currentY - endY) / (flyingTime / 1000.0f)) / 60.0f;
        newComponent.currentAX = 0;
        newComponent.currentAY = 0;
        break;
      case 1:
        newComponent.currentVX = ((endX - newComponent.currentX) / (flyingTime / 1000.0f)) / 60.0f;
        newComponent.currentVY = ((newComponent.currentY - endY) / (flyingTime / 1000.0f)) / 60.0f;
        newComponent.currentAX = 0;
        newComponent.currentAY = (-1 * newComponent.currentVY * 3 / (flyingTime / 1000.0f)) / 60.0f;
        break;
      case 2:
        newComponent.currentVX = ((endX - newComponent.currentX) / (flyingTime / 1000.0f)) / 60.0f * 2;
        newComponent.currentVY = ((newComponent.currentY - endY) / (flyingTime / 1000.0f)) / 60.0f;
        newComponent.currentAX = 0;
        newComponent.currentAY = 0;
        break;
    }
    return newComponent;
  }
}