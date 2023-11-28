// load svg files in the icon folder and make a function to display the icon
// Still Debugging
class Icon {
  String[] filenames = {"orange", "green", "blue", "purple", "rainbow", "mouse1", "mouse2", "phone", "rotator"};
  PShape[] icons = new PShape[filenames.length];
  Boolean isloaded = false;

  void loadIcon(){
    if(isloaded == false){
      for(int i = 0; i < filenames.length; i++){
        icons[i] = loadShape("images/icon/" + filenames[i] + ".svg");
      }
      isloaded = true;
    }
  }

  void display(int i){
    shape(icons[i], mouseX, mouseY);
  }

}
