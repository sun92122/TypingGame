class MobDynamicSB extends MobDynamic {
  MobDynamicSB() {
    super();
  }
  
  MobDynamicSB(JSONObject data) {
    super(data);
    setupMobSBData();
  }
  
  void display() {
    currentRotation = (currentRotation + MobSBData.rotateSpeed / frameRate) % 360;
    switch(state) {
      case 0:
        displayMobSBIdle(x, y, currentRotation);
        break;
      case 1:
        displayMobSBMoving(x, y, currentRotation);
        break;
      case 2:
        displayMobSBAttacking(x, y, currentRotation);
        break;
      case 3:
        displayMobSBDying(x, y, currentRotation);
        break;
    }
    
    debugPoint(x, y);
  }
  
  Mob copy(int interval) {
    return super.copy(new MobDynamicSB(), interval);
  }
}

static class MobSBData {
  static color[] outColors = {#E0E0E0, #ADADAD, #7B7B7B, #4F4F4F, #000000};
  static color[] inColors = {#ACD6FF, #66B3FF, #0080FF, #005AB5, #003060};
  
  static int satellitesNum = 5;
  static float scale = 0.7;
  
  static PShape face = new PShape();
  static PShape outShape = new PShape();
  static PShape inShape = new PShape();

  static float rotateSpeed = 300;
}

void setupMobSBData() {
  MobSBData.face = createShape(GROUP);
  PShape tempShape;
  tempShape = createShape(ELLIPSE, 0, 0, 100, 100);
  tempShape.setFill(#C8C8C8);
  tempShape.setStrokeWeight(0);
  MobSBData.face.addChild(tempShape);
  tempShape = createShape(ELLIPSE, 0, 0, 31.7, 18.4);
  tempShape.setFill(#000000);
  tempShape.setStrokeWeight(0);
  tempShape.translate(25, -5);
  tempShape.rotate(radians( -26));
  MobSBData.face.addChild(tempShape);
  tempShape = createShape(ELLIPSE, 0, 0, 28.3, 11.3);
  tempShape.setFill(#000000);
  tempShape.setStrokeWeight(0);
  tempShape.translate( -31, -10);
  tempShape.rotate(radians( -119));
  MobSBData.face.addChild(tempShape);
  tempShape = createShape(QUAD, 1, 19, 12, 37, -18, 37.5, -26, 27);
  tempShape.setFill(#FFFFFF);
  tempShape.setStroke(2);
  tempShape.setStroke(#000000);
  MobSBData.face.addChild(tempShape);
  MobSBData.face.scale(MobSBData.scale);
  
  MobSBData.outShape = createShape(GROUP);
  MobSBData.inShape = createShape(GROUP);
  for(int j = 0; j < 5; j++) {
    tempShape = createShape(RECT, 130, 0, 20, 20);
    tempShape.rotate(radians( -5 * j));
    tempShape.setFill(MobSBData.outColors[j]);
    tempShape.setStrokeWeight(0);
    MobSBData.outShape.addChild(tempShape);
    tempShape = createShape(ELLIPSE, 80, 0, 20, 20);
    tempShape.rotate(radians(5 * j));
    tempShape.setFill(MobSBData.inColors[j]);
    tempShape.setStrokeWeight(0);
    MobSBData.inShape.addChild(tempShape);
  }
  MobSBData.outShape.scale(MobSBData.scale);
  MobSBData.inShape.scale(MobSBData.scale);
}

void displayMobSBIdle(float x, float y, float r) {
  pushMatrix();
  translate(x + 170 * MobSBData.scale, y - 250 * MobSBData.scale);
  shape(MobSBData.face);
  for(int i = 0; i < MobSBData.satellitesNum; i++) {
    pushMatrix();
    rotate(radians(360 / MobSBData.satellitesNum * i - r));
    translate(20 * sin(radians(r * 3)) * MobSBData.scale, 0);
    shape(MobSBData.outShape);
    popMatrix();
    pushMatrix();
    rotate(radians(360 / MobSBData.satellitesNum * i + r));
    translate(10 * sin(radians(r * 2.99)) * MobSBData.scale, 0);
    shape(MobSBData.inShape);
    popMatrix();
  }
  popMatrix();
}

void displayMobSBMoving(float x, float y, float r) {
  displayMobSBIdle(x, y, r);
}

void displayMobSBAttacking(float x, float y, float r) {
  displayMobSBIdle(x, y, r);
}

void displayMobSBDying(float x, float y, float r) {
  displayMobSBIdle(x, y, r);
}