class CharacterPotato extends CharacterCode {
  CharacterPotato(JSONObject data) {
    super(data);
    shapes = setupCharacterPotatoShape();
  }
}

HashMap<String, ArrayList<PShape>> setupCharacterPotatoShape() {
  HashMap<String, ArrayList<PShape>> shapes = new HashMap<String, ArrayList<PShape>>();
  String[] stateNames = {"idle", "moving", "attacking", "dead", "typing"};
  
  rectMode(CORNER);
  ellipseMode(CENTER);
  
  float rate = 0.5;
  
  PShape tempShape;
  
  ArrayList<PShape> stateShapes;
  // idle
  stateShapes = new ArrayList<PShape>();
  PShape idle0 = createShape(GROUP);
  idle0.addChild(characterPotatoShapeLeg('L'));
  idle0.addChild(characterPotatoShapeLeg('R'));
  idle0.addChild(characterPotatoShapeBody());
  idle0.addChild(characterPotatoShapeKeyboard());
  idle0.addChild(characterPotatoShapeArm('L'));
  idle0.addChild(characterPotatoShapeArm('R'));
  idle0.translate( -210 * rate * unit, -235 * rate * unit);
  idle0.scale(rate * unit);
  stateShapes.add(idle0);
  // ...
  shapes.put(stateNames[0], stateShapes);
  
  // moving
  stateShapes = new ArrayList<PShape>();
  stateShapes.add(idle0);
  PShape moving1 = createShape(GROUP);
  moving1.addChild(characterPotatoShapeLeg('L', 10));
  moving1.addChild(characterPotatoShapeLeg('R', 10));
  moving1.addChild(characterPotatoShapeBody());
  moving1.addChild(characterPotatoShapeKeyboard());
  moving1.addChild(characterPotatoShapeArm('L'));
  moving1.addChild(characterPotatoShapeArm('R'));
  moving1.translate( -210 * rate * unit, -235 * rate * unit);
  moving1.scale(rate * unit);
  stateShapes.add(moving1);
  shapes.put(stateNames[1], stateShapes);
  
  // attacking
  stateShapes = new ArrayList<PShape>();
  stateShapes.add(idle0);
  PShape attacking1 = createShape(GROUP);
  attacking1.addChild(characterPotatoShapeLeg('L'));
  attacking1.addChild(characterPotatoShapeLeg('R'));
  attacking1.addChild(characterPotatoShapeBody());
  attacking1.addChild(characterPotatoShapeArmAtt('L'));
  attacking1.addChild(characterPotatoShapeKeyboard(0));
  attacking1.addChild(characterPotatoShapeArmAtt('R'));
  attacking1.translate( -210 * rate * unit, -235 * rate * unit);
  attacking1.scale(rate * unit);
  stateShapes.add(attacking1);
  PShape attacking2 = createShape(GROUP);
  attacking2.addChild(characterPotatoShapeLeg('L'));
  attacking2.addChild(characterPotatoShapeLeg('R'));
  attacking2.addChild(characterPotatoShapeBody(true));
  attacking2.addChild(characterPotatoShapeArmAtt('L'));
  attacking2.addChild(characterPotatoShapeKeyboard(0));
  attacking2.addChild(characterPotatoShapeArmAtt('R'));
  attacking2.translate( -210 * rate * unit, -235 * rate * unit);
  attacking2.scale(rate * unit);
  stateShapes.add(attacking2);
  shapes.put(stateNames[2], stateShapes);
  
  // dead
  stateShapes = new ArrayList<PShape>();
  stateShapes.add(idle0);
  shapes.put(stateNames[3], stateShapes);
  
  // typing
  stateShapes = new ArrayList<PShape>();
  stateShapes.add(idle0);
  PShape typing1 = createShape(GROUP);
  typing1.addChild(characterPotatoShapeLeg('L'));
  typing1.addChild(characterPotatoShapeLeg('R'));
  typing1.addChild(characterPotatoShapeBody());
  typing1.addChild(characterPotatoShapeKeyboard());
  typing1.addChild(characterPotatoShapeArm('L', 40));
  typing1.addChild(characterPotatoShapeArm('R', 40));
  typing1.translate( -210 * rate * unit, -235 * rate * unit);
  typing1.scale(rate * unit);
  stateShapes.add(typing1);
  shapes.put(stateNames[4], stateShapes);
  
  return shapes;
}

PShape characterPotatoShapeBody() {
  return characterPotatoShapeBody(false);
} 

PShape characterPotatoShapeBody(boolean mouse) {
  PShape body = createShape(GROUP);
  PShape tempShape;
  tempShape = createShape(ARC, 0, 0, 300, 460, PI, 2 * PI, OPEN);
  tempShape.setFill(color(#F2DFA8));
  tempShape.setStroke(color(#000000));
  tempShape.setStrokeWeight(4);
  body.addChild(tempShape);
  
  tempShape = createShape(ARC, 0, 0, 300, 300, 0, PI, OPEN);
  tempShape.setFill(color(#F2DFA8));
  tempShape.setStroke(color(#000000));
  tempShape.setStrokeWeight(4);
  body.addChild(tempShape);
  
  tempShape = createShape(RECT, 0, 0, 60, 10);
  tempShape.setFill(color(#000000));
  tempShape.translate( -87, -170);
  tempShape.rotate(radians(10));
  body.addChild(tempShape);
  
  tempShape = createShape(RECT, 0, 0, 60, 10);
  tempShape.setFill(color(#000000));
  tempShape.translate(20, -160);
  tempShape.rotate(radians( -10));
  body.addChild(tempShape);
  
  tempShape = createShape(ELLIPSE, -60, -110, 55, 55);
  tempShape.setFill(color(#000000));
  body.addChild(tempShape);
  
  tempShape = createShape(ELLIPSE, 55, -110, 55, 55);
  tempShape.setFill(color(#000000));
  body.addChild(tempShape);
  
  tempShape = createShape(ELLIPSE, -60, -97, 30, 30);
  tempShape.setFill(color(#FFFFFF));
  tempShape.setStroke(color(#000000));
  tempShape.setStrokeWeight(2);
  body.addChild(tempShape);
  
  tempShape = createShape(ELLIPSE, 55, -97, 30, 30);
  tempShape.setFill(color(#FFFFFF));
  tempShape.setStroke(color(#000000));
  tempShape.setStrokeWeight(2);
  body.addChild(tempShape);
  
  if(mouse) {
    tempShape = createShape(TRIANGLE, -25, -70, 25, -70, 0, -45);
  } else {
    tempShape = createShape(ARC, 0, -70, 50, 50, 0, PI, CHORD);
  }
  tempShape.setFill(color(#F2445D));
  body.addChild(tempShape);
  
  return body;
}

PShape characterPotatoShapeArm(char side) {
  return characterPotatoShapeArm(side, 25);
} 

PShape characterPotatoShapeArm(char side, float radius) {
  PShape arm = createShape(GROUP);
  switch(side) {
    case 'L':
      arm = createShape(RECT, -150, 0, 150, 50, 28, 5, 90, 28);
      arm.translate(140, -90);
      arm.rotate(radians( -radius));
      break;
    case 'R':
      arm = createShape(RECT, 0, 0, 150, 50, 5, 28, 28, 90);
      arm.translate( -140, -90);
      arm.rotate(radians(radius));
      break;
  }
  arm.setFill(color(#F2DFA8));
  arm.setStroke(color(#000000));
  arm.setStrokeWeight(4);
  return arm;
}

PShape characterPotatoShapeArmAtt(char side) {
  PShape arm = createShape(GROUP);
  PShape tempShape;
  switch(side) {
    case 'L':
      tempShape = createShape(RECT, -150, 0, 150, 50, 28, 28, 90, 28);
      tempShape.translate(110, -90);
      tempShape.rotate(radians( -75));
      tempShape.setFill(color(#F2DFA8));
      tempShape.setStroke(color(#000000));
      tempShape.setStrokeWeight(4);
      arm.addChild(tempShape);
      break;
    case 'R':
      arm = createShape(GROUP);
      tempShape = createShape(RECT, 0, 0, 185, 50, 28, 28, 28, 28);
      tempShape.translate( -120, -90);
      tempShape.rotate(radians(75));
      tempShape.setFill(color(#F2DFA8));
      tempShape.setStroke(color(#000000));
      tempShape.setStrokeWeight(4);
      arm.addChild(tempShape);
      tempShape = createShape(ARC, 70, 110, 50, 50, PI, 2 * PI, OPEN);
      tempShape.setFill(color(#F2DFA8));
      tempShape.setStroke(color(#000000));
      tempShape.setStrokeWeight(4);
      arm.addChild(tempShape);
      break;
  }
  return arm;
}

PShape characterPotatoShapeLeg(char side) {
  return characterPotatoShapeLeg(side, 0);
}

PShape characterPotatoShapeLeg(char side, float radius) {
  PShape leg = createShape(RECT, 0, 0, 50, 120, 0, 0, 28, 28);
  leg.setFill(color(#F2DFA8));
  leg.setStroke(color(#000000));
  leg.setStrokeWeight(4);
  switch(side) {
    case 'L':
      leg.translate( -70, 115);
      leg.rotate(radians(radius));
      break;
    case 'R':
      leg.translate(20, 115);
      leg.rotate(radians( -radius));
      break;
  }
  return leg;
}

PShape characterPotatoShapeKeyboard() {
  return characterPotatoShapeKeyboard( -8);
}

PShape characterPotatoShapeKeyboard(float radius) {
  PShape keyboard = createShape(GROUP);
  PShape tempShape;
  tempShape = createShape(RECT, 0, 0, 400, 120, 25);
  tempShape.setFill(color(#9D9D9D));
  keyboard.addChild(tempShape);
  
  tempShape = createShape(RECT, 21, 39, 18, 13);
  tempShape.setFill(color(#E0E0E0));
  keyboard.addChild(tempShape);
  
  tempShape = createShape(RECT, 21, 58, 27, 13);
  tempShape.setFill(color(#E0E0E0));
  keyboard.addChild(tempShape);
  
  tempShape = createShape(RECT, 21, 77, 33, 13);
  tempShape.setFill(color(#E0E0E0));
  keyboard.addChild(tempShape);
  
  for(int i = 0; i < 15; i++) {
    tempShape = createShape(RECT, 20 + i * 19, 20, 13, 13);
    tempShape.setFill(color(#E0E0E0));
    keyboard.addChild(tempShape);
  }
  
  for(int i = 0; i < 14; i++) {
    tempShape = createShape(RECT, 47 + i * 19, 38, 13, 13);
    tempShape.setFill(color(#E0E0E0));
    keyboard.addChild(tempShape);
  }
  
  for(int i = 0; i < 13; i++) {
    tempShape = createShape(RECT, 60 + i * 19, 56, 13, 13);
    tempShape.setFill(color(#E0E0E0));
    keyboard.addChild(tempShape);
  }
  
  for(int i = 0; i < 12; i++) {
    tempShape = createShape(RECT, 73 + i * 19, 74, 13, 13);
    tempShape.setFill(color(#E0E0E0));
    keyboard.addChild(tempShape);
  }
  
  for(int j = 0; j < 4; j++) {
    for(int i = 0; i < 4; i++) {
      tempShape = createShape(RECT, 323 + i * 19, 20 + j * 18, 13, 13);
      tempShape.setFill(color(#E0E0E0));
      keyboard.addChild(tempShape);
    }
  }
  keyboard.translate( -190, -10);
  keyboard.rotate(radians(radius));
  return keyboard;
}