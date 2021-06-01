class ovnis { 

  PImage ovni;

  float x, y;
  ovnis(float x, float y) {
    this.x = x;
    this.y = y;
    ovni = loadImage("ovni.png");
  }
  void draw() {
    image(ovni,x,y,60,60);
  }
}
