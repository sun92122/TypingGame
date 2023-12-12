// load svg files in the icon folder and make a function to display the icon
// Still Debugging
class Icon {
  String[] filenames = {"red", "orange", "green", "blue", "purple", "rainbow", "mouse1", "mouse2", "phone", "ice", "rotator", "earningEfficiency", "maxHp", "white dog", "dog", "fowl", "ox", "rat", "turtle"};
  PShape[] icons = new PShape[filenames.length];
  
  void loadIcon() {
    for(int i = 0; i < filenames.length; i++) {
      icons[i] = loadShape("images/icon/" + filenames[i] + ".svg");
    }
    for(int i = 0; i < 5; i++) {
      icons[i].rotate(-PI/8);
    }
  }
  
  void display(int i, float x, float y) {
    shapeMode(CENTER);
    shape(icons[i], x, y);
  }
  
}
