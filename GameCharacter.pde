class Character {
  String name;
  JSONObject data;
  float scale = 1;
  
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  HashMap<String, IntList> animations = new HashMap<String, IntList>();
  
  CharacterAttack attack;
  int attackType = -1;
  final int BASIC_ATT = 0;
  final int FEVER_ATT = 1;
  final int SPECIAL_ATT_1 = 2;
  final int SPECIAL_ATT_2 = 3;
  
  int state = 1; // 0 = idle, 1 = moving, 2 = typing, 3 = injured, 4 = attacking
  String[] stateNames = {"idle", "moving", "typing", "injured"};
  int stateChangeTime = 0;
  int currentImageIndex = 0;
  
  Character(JSONObject data) {
    this.data = data;
    this.name = data.getString("name");
    this.scale = data.getFloat("scale");
    
    loadCharacterData();
  }
  
  void loadCharacterData() {}
  
  void display(float x, float y) {}
  
  void update_() {}
  
  void update() {
    if(state < 4) {
      update_();
    } else if(!attack.isAttacking) {
      changeState(0);
    }
  }
  
  void update(int state) {
    changeState(state);
    update_();
  }
  
  void changeState(int state) {
    if(this.state >= state && state != 0) return;
    this.state = state;
    currentImageIndex = 0;
    stateChangeTime = 0;
  }
  
  void changeState(int state, int attackType, Table attackTable) {
    if(this.state >= state) return;
    this.state = state;
    currentImageIndex = 0;
    stateChangeTime = 0;
    attack.attack(attackType, attackTable);
  }

  void getAttackComponents(int attackType, ArrayList<CharacterAttackComponent> attackComponents, float mobXMin, float characterX, float characterY) {
    attack.getAttackComponents(attackType, attackComponents, mobXMin, characterX, characterY);
  }
}

class CharacterSvg extends Character {  
  CharacterSvg(JSONObject data) {
    super(data);
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
    
    attack = new CharacterAttack(data.getJSONObject("attack"), scale);
  }
  
  void display(float x, float y) {
    if(state == 4) {
      attack.display(x, y);
    } else {
      ArrayList<PShape> currentShapes = shapes.get(stateNames[state]);
      PShape currentShape = currentShapes.get(currentImageIndex);
      float h = currentShape.getHeight() * scale * unit;
      float w = currentShape.getWidth() * scale * unit;
      shape(currentShape, x - w, y - h, w, h);
    }
    
    debugPoint(x, y);
  }
  
  void update_() {
    if(stateChangeTime == 0) {
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
    if(millis() > stateChangeTime) {
      if(state > 1 && currentImageIndex == shapes.get(stateNames[state]).size() - 1) {
        changeState(0);
      }
      currentImageIndex = (currentImageIndex + 1) % shapes.get(stateNames[state]).size();
      stateChangeTime = millis() + animations.get(stateNames[state]).get(currentImageIndex);
    }
  }
}