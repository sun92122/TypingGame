class MobCodeBird extends MobCode {
  MobCodeBird() {
    super();
  }
  
  MobCodeBird(JSONObject data) {
    super(data);
    setupMobBirdData();
    shapes = MobBirdData.shapes;
  }
  
  Mob copy(int interval) {
    return super.copy(new MobCodeBird(), interval);
  }
}

static class MobBirdData {
  static HashMap<String, ArrayList<PShape>> shapes;
  static String[] states = {"idle", "moving", "attacking", "dead"};
  
  static PShape body;
  static PShape horn;
  static PShape eye;
  
  static float xShift = 0;
  static float yShift = -500;
}

void setupMobBirdData() {
  MobBirdData.shapes = new HashMap<String, ArrayList<PShape>>();
  
  rectMode(CORNER);
  ellipseMode(CENTER);
  
  float scale = 0.3f;
  
  MobBirdData.body = mobBirdShapeBody();
  MobBirdData.horn = mobBirdShapeHorn();
  MobBirdData.eye = mobBirdShapeEye();
  
  PShape tempShape;
  ArrayList<PShape> stateShapes;
  
  // idle
  stateShapes = new ArrayList<PShape>();
  tempShape = createShape(GROUP); // idle 1
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(mobBirdShapeWing('R', 215, 400));
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 260, 400));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // idle 1
  tempShape = createShape(GROUP); // idle 2
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 290, 380));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // idle 2
  tempShape = createShape(GROUP); // idle 3
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 320, 360));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // idle 3
  tempShape = createShape(GROUP); // idle 4
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 350, 340));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // idle 4
  tempShape = createShape(GROUP); // idle 5
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 380, 320));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // idle 5
  MobBirdData.shapes.put("idle", stateShapes);
  
  // moving
  stateShapes = new ArrayList<PShape>();
  tempShape = createShape(GROUP); // moving 1
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(mobBirdShapeWing('R', 215, 400));
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 260, 400));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // moving 1
  tempShape = createShape(GROUP); // moving 2
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 290, 380));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // moving 2
  tempShape = createShape(GROUP); // moving 3
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 320, 360));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // moving 3
  tempShape = createShape(GROUP); // moving 4
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 350, 340));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // moving 4
  tempShape = createShape(GROUP); // moving 5
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 380, 320));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape); // moving 5
  MobBirdData.shapes.put("moving", stateShapes);
  
  // attacking
  stateShapes = new ArrayList<PShape>();
  tempShape = createShape(GROUP);
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 380, 320));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape);
  MobBirdData.shapes.put("attacking", stateShapes);
  
  // dead
  stateShapes = new ArrayList<PShape>();
  tempShape = createShape(GROUP);
  tempShape.addChild(MobBirdData.horn);
  tempShape.addChild(MobBirdData.body);
  tempShape.addChild(mobBirdShapeWing('L', 380, 320));
  tempShape.addChild(MobBirdData.eye);
  tempShape.scale(scale);
  tempShape.translate(MobBirdData.xShift, MobBirdData.yShift);
  stateShapes.add(tempShape);
  MobBirdData.shapes.put("dead", stateShapes);
}

PShape mobBirdShapeBody() {
  PShape body = createShape(ELLIPSE, 200, 200, 250, 250);
  body.setFill(color(#F7B602));
  body.setStroke(false);
  return body;
}

PShape mobBirdShapeHorn() {
  PShape horn = createShape();
  horn.beginShape();
  horn.fill(#0DCCFF);
  horn.noStroke();
  horn.curveVertex(135, 104);
  horn.vertex(150, 75);
  horn.vertex(160, 20);
  horn.vertex(170, 75);
  horn.vertex(180, 20);
  horn.vertex(190, 75);
  horn.vertex(200, 20);
  horn.vertex(210, 75);
  horn.endShape();
  return horn;
}

PShape mobBirdShapeEye() {
  PShape eye = createShape(GROUP);
  eye.addChild(mobBirdShapeEyeWhite());
  eye.addChild(mobBirdShapeEyePupil());
  return eye;
}

PShape mobBirdShapeEyeWhite() {
  PShape eyeWhite = createShape(ELLIPSE, 90, 200, 190, 130);
  eyeWhite.setFill(color(#F7F5DC));
  eyeWhite.setStroke(false);
  return eyeWhite;
}

PShape mobBirdShapeEyePupil() {
  PShape eyePupil = createShape(ELLIPSE, 40, 200, 60, 60);
  eyePupil.setFill(color(#0F0F0E));
  eyePupil.setStroke(false);
  return eyePupil;
}

PShape mobBirdShapeWing(char side, float xVertex, float yVertex) {
  PShape wing = createShape();
  switch(side) {
    case 'L':
      wing = createShape(TRIANGLE, 325.5, 195, xVertex, yVertex, 210, 195);
      wing.setFill(color(#0DCCFF));
      break;
    case 'R':
      wing = createShape(TRIANGLE, 250, 230, xVertex, yVertex, 84.5, 230);
      wing.setFill(color(#254FE3));
      break;
  }
  wing.setStroke(false);
  return wing;
}