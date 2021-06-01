class comida { 
  
  int x, y;
  comida(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(0,random(255),255);//color de la comida
    ellipse(x, y, 10, 10);
  }
}
