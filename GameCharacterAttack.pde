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

    update();
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
  
  void attack(int attackType, Table attackTable, float mobX) {
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
        if(!isAttacking || attackingType <= BASIC_ATT) {
          attackingType = SPECIAL_ATT_1;
          currentAttack = specialAttack[skill1];
        }
        specialAttack[skill1].attackTypeToTableRow(attackTable);
        break;
      case SPECIAL_ATT_2:
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
}

class CharacterAttackType {
  int index = 0;
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
  IntList shiftX[];
  IntList shiftY[];
  
  ArrayList<PShape> shapes;
  IntList animations;
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
    
    damage = new int[maxLevel];
    cooldown = new int[maxLevel];
    piercing = new int[maxLevel];
    attackShapes = new ArrayList[maxLevel];
    attackAnimations = new IntList[maxLevel];
    shiftX = new IntList[maxLevel];
    shiftY = new IntList[maxLevel];
    
    for(int i = 0; i < maxLevel; i++) {
      damage[i] = damageData.getInt(i);
      cooldown[i] = cooldownData.getInt(i);
      piercing[i] = piercingData.getInt(i);
      attackShapes[i] = new ArrayList<PShape>();
      attackAnimations[i] = new IntList();
      shiftX[i] = new IntList();
      shiftY[i] = new IntList();
      
      JSONArray attackShapeDataLevel = attackShapeData.getJSONArray(i);
      for(int j = 0; j < attackShapeDataLevel.size(); j++) {
        JSONObject attackShapeDataLevelData = attackShapeDataLevel.getJSONObject(j);
        PShape shape = loadShape(attackShapeDataLevelData.getString("path"));
        int shapeAnimation = attackShapeDataLevelData.getInt("duration");
        int shapeShiftX = attackShapeDataLevelData.getInt("x");
        int shapeShiftY = attackShapeDataLevelData.getInt("y");
        
        attackShapes[i].add(shape);
        attackAnimations[i].append(shapeAnimation);
        shiftX[i].append(shapeShiftX);
        shiftY[i].append(shapeShiftY);
      }
    }
  }
  
  void loadCharacterAttackLevel() {
    // load attack level
    // level = player.getAttackLevel(index);
    level = 1;
    
    shapes = attackShapes[level - 1];
    animations = attackAnimations[level - 1];
  }
  
  void attackTypeToTableRow(Table attackTable) {
    TableRow row = attackTable.addRow();
    row.setInt("damage", damage[level - 1]);
    row.setInt("piercing", piercing[level - 1]);
    row.setInt("delay", delayTime);
    println("attack type: " + name +
      ", damage: " + damage[level - 1] +
      ", piercing: " + piercing[level - 1] +
      ", delay: " + delayTime  +
      ", level: " + level); // DEBUG
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
    float h = currentShape.getHeight() * scale * unit;
    float w = currentShape.getWidth() * scale * unit;
    shape(currentShape, x - w, y - h, w, h);
    return true;
  }
}

class CharacterAttackComponent {
  
}