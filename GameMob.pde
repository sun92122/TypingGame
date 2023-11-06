class Mob extends Character {

  Mob() {
    super();
  }

  Mob(JSONObject data) {
    super(data);
  }

  void display(float x, float y) {
    // display mob, scale *(unit)
    // x, y is left bottom corner of the mob
    PImage currentImage = images.get(stateNames[state])[currentImageIndex];
    float imageHeight = currentImage.height * unit;
    float imageWidth = currentImage.width * unit;
    image(currentImage, x, y - imageHeight, imageWidth, imageHeight);
  }

  Mob copy() {
    Mob mob = new Mob();
    
    mob.name = name;
    mob.data = data;

    mob.images = images;
    mob.animations = animations;

    return mob;
  }
}

// just for example
class Slime extends Mob {
  
  Slime(JSONObject data) {
    super(data);
  }
}

Mob mobGenrator(int type, JSONObject data) {
  switch(type) {
    case 1:
      return new Slime(data);
      
    default:
      return new Mob(data);
  }
}