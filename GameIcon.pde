// load svg files in the icon folder and make a function to display the icon
// Still Debugging
class Icon {
  String name = "icon1";
  String path;
  PShape image;
    
  void loadIcon(String name) {
    this.name = name;
    this.path = "images/icon/" + name + ".svg";
    println(path);
    image = loadShape(path);
  }

  void display(){
    shape(image, mouseX, mouseY, 100, 100);
  }

}
