float radpac = 35; //tamaño del personaje
float xac = 250;
float yac = 250;
ArrayList<comida> com = new ArrayList();
int vidas;

float x=0;
float y =0;
int radio =0;
float angulo=0;
float velocidad = 0;

float v2x;
float v2y;
float s2y =0;
int radio2 =0;
float velocidad2 = 0;

float s3x =0;
float s3y =0;
int radio3 =0;
float velocidad3 = 0;
float m1x;
float m1y;


boolean flag = false;
int ct_star;
int[] xp = new int[250];
int[] yp = new int[250];

int direccion = 1;
int direccion2 = 0;
int contcomida=0; //puntaje
int numeroComidas =50;

Table puntos;
int ptsacum = 0;

int pant;

PImage inicio;
PImage ec_color_rojo;
PImage ec_color_azul;
PImage instrucciones;
PImage niveles;
PImage jugar;
PImage puntaje;
PImage perdio;
PImage seguro;
PImage back;
PImage quit;
PImage emp;
PImage v1;
PImage v2;
PImage cj;

pantallas init;
pantallas ec_color1;
pantallas ec_color2;
pantallas inst;
pantallas lvl;
pantallas play;
pantallas pts;
pantallas perd;
pantallas seg;
pantallas vv;
pantallas v;

ovnis ovni1;

Integer h = hour();
Integer m = minute();
Integer s = second();


void setup() {
  size(1000, 1000);
  background(0, 6, 87);

  m1x =0;
  m1y=0;
  radio=250;
  angulo=0;
  velocidad = 1;

  v2x =10;
  v2y=0;
  radio2=200;
  velocidad2 = 1.5;

  s3x =100;
  s3y=0;
  radio3=150;
  velocidad3 = 2;

  calcularPosX(xp);
  calcularPosY(yp);

  pant = 1;

  inicio = loadImage("inicio.png");
  ec_color_rojo = loadImage("n_rojo.png");
  ec_color_azul = loadImage("n_azul.png");
  instrucciones = loadImage("instrucciones.png");
  niveles = loadImage("niveles.png");
  jugar = loadImage("juego.png");
  puntaje = loadImage("puntaje_gano.png");
  perdio = loadImage("puntaje_perdio.png");
  seguro = loadImage("seguro.png");
  back = loadImage("back.png");
  quit = loadImage("quit.png");
  emp = loadImage("emp.png");
  v1 = loadImage("1V.png");
  v2 = loadImage("2V.png");
  cj = loadImage("cj.png");

  init = new pantallas(inicio, emp);
  ec_color1 = new pantallas(ec_color_rojo, back);
  ec_color2 = new pantallas(ec_color_azul, back);
  inst = new pantallas(instrucciones, back);
  lvl = new pantallas(niveles, back);
  play = new pantallas(jugar, quit);
  pts = new pantallas(puntaje, emp);
  perd = new pantallas(perdio, emp);
  seg = new pantallas(seguro, emp);
  v = new pantallas(v1, quit);
  vv = new pantallas(v2, quit);

  for (int i=0; i<numeroComidas; i++) { 
    comida C = new comida((int)random(width), (int)random(height));
    com.add(C);
  }

  //ovni1 = new ovnis(v2x*random(1,3)+(width/2), v2y*random(1,3)+(height/2));

  vidas = 3;

  puntos = new Table();
  puntos.addColumn("Puntaje");
  puntos.addColumn("Tiempo");

  TableRow nuevaFila = puntos.addRow();
  nuevaFila.setInt(ptsacum, puntos.lastRowIndex());


  String tiempoAct = h.toString()+":"+m.toString()+":"+s.toString(); 

  nuevaFila.setString("Tiempo", tiempoAct);
}


void draw() {

  background(0, 3, 36);
  angulo = angulo + 1;

  stroke (255, 255, 255);


  for (int i = 0; i < xp.length; i++) {
    strokeWeight (random(1, 4));
    point (xp[i], yp[i]);
  }

  //Estados del juego

  if (pant == 1) {
    fill(155, 46, 158);
    noStroke();
    v2x = 150*sin(radians(2*angulo));
    v2y = 150*cos(radians(2*angulo));
    ellipse(100+(width/2.525), 0+(height/2), random(95, 100), random(95, 100));
    init.pintarPantalla();
  }

  if (pant == 2) {

    ec_color1.pintarPantalla();
  }

  if (pant == 3) {
    ec_color2.pintarPantalla();
  }

  if (pant == 4) {

    inst.pintarPantalla();
  }

  if (pant == 5) {
    lvl.pintarPantalla();
  }
  if (pant == 6) {

    ptsacum = contcomida;
    render();
    for (int i=0; i<com.size(); i++) {
      comida Pn = (comida) com.get(i);
      Pn.display();
      if (dist(xac, yac, Pn.x, Pn.y)<radpac) { // revisa si pacman está sobre la comida
        com.remove(i); // borra la comida que se comió
        contcomida =contcomida+100; // sumador de puntos
      }
    }
    if ( contcomida != 0 && contcomida%1000 == 0) { //poner condicion de nivel para que sean más puntos
      pant = 7;
    }
    if (vidas == 3) {
      play.pintarPantalla();
    }
    pintarPlanetas();

    fill(245, 38, 252);
    text(contcomida, 155, 60);
    textAlign(LEFT);
    textSize(40);

    if (vidas == 2) {
      vv.pintarPantalla();
    }
    if (vidas == 1) {
      v.pintarPantalla();
    }

    if (vidas == 0) {
      pant = 8;
    }

    if (dist(xac, yac, ovni1.x, ovni1.y)<radpac) { // revisa si pacman está sobre el ovni
      vidas --; // borra la comida que se comió
      //render();
    }

    Integer h = hour();
    Integer m = minute();
    Integer s = second();

    TableRow nuevaFila = puntos.addRow();
    nuevaFila.setInt("Puntaje", ptsacum);

    String tiempoAct = h.toString()+":"+m.toString()+":"+s.toString(); 

    nuevaFila.setString("Tiempo", tiempoAct);

    saveTable(puntos, "./puntos.csv");
  }


  if (pant == 7) {
    pts.pintarPantalla();
    fill(245, 38, 252);
    text(ptsacum+100, width/2, height/2);
    textAlign(CENTER, BOTTOM);
    textSize(100);
    contcomida=ptsacum+100;
  }
  if (pant == 8) {

    perd.pintarPantalla();
    fill(245, 38, 252);
    text(ptsacum, width/2, height/2);
    textAlign(CENTER, BOTTOM);
    textSize(100);
    contcomida=0;
  }
  if (pant == 9) {
    seg.pintarPantalla();
  }

  if (pant == 10) {
    play.pintarPantalla();
    if(millis()<5*1000){
      
    image(cj, 0, 0);
    }
    else{
      pant = 6;
    }
  }
}

void calcularPosX(int[] x) {

  for (int i = 0; i < x.length; i++) {
    x[i] = int(random(0, 1000));
  }
}


void calcularPosY(int[] y) {

  for (int i = 0; i < y.length; i++) {
    y[i] = int(random(0, 1000));
  }
}


void pintarPlanetas() {
  m1x = radio*sin(radians(velocidad*angulo));
  m1y = radio*cos(radians(velocidad*angulo));

  //mercurio
  fill(164, 199, 70, 127);
  noStroke();
  ellipse(m1x/2+(width/2), m1y/2+(height/2), random(20, 25), random(20, 25));

  //venus
  fill(205, 217, 169, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*angulo));
  v2y = radio2*cos(radians(velocidad2*angulo));
  ellipse(v2x+(width/2), v2y+(height/2), random(15, 20), random(15, 20));

  //tierra
  fill(17, 189, 237, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad*1.2*angulo));
  v2y = radio2*cos(radians(velocidad*1.2*angulo));
  ellipse(v2x*1.5+(width/2), v2y*1.5+(height/2), random(30, 35), random(30, 35));

  //marte
  fill(204, 60, 10, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.5*angulo));
  v2y = radio2*cos(radians(velocidad2*0.5*angulo));
  ellipse(v2x*1.7+(width/2), v2y*1.7+(height/2), random(29, 32), random(29, 32));

  //jupiter
  fill(255, 128, 0);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.4*angulo));
  v2y = radio2*cos(radians(velocidad2*0.4*angulo));
  ellipse(v2x*2+(width/2), v2y*2+(height/2), random(45, 50), random(45, 50));

  //saturno
  fill(209, 204, 153, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.3*angulo));
  v2y = radio2*cos(radians(velocidad2*0.3*angulo));
  ellipse(v2x*2.2+(width/2), v2y*2.2+(height/2), random(45, 50), random(45, 50));

  //urano
  fill(0, 237, 206, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.2*angulo));
  v2y = radio2*cos(radians(velocidad2*0.2*angulo));
  ellipse(v2x*2.4+(width/2), v2y*2.4+(height/2), random(20, 25), random(20, 25));

  //neptuno
  fill(135, 48, 201, 127);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.35*angulo));
  v2y = radio2*cos(radians(velocidad2*0.35*angulo));
  ellipse(v2x*2.6+(width/2), v2y*2.6+(height/2), random(20, 25), random(20, 25));

  //pluto
  fill(247, 3, 255);
  noStroke();
  v2x = radio2*sin(radians(velocidad2*0.45*angulo));
  v2y = radio2*cos(radians(velocidad2*0.45*angulo));
  ellipse(v2x*2.7+(width/2), v2y*2.7+(height/2), random(10, 15), random(10, 15));

  //sol
  fill(255, 221, 0);
  noStroke();
  v2x = radio3*sin(radians(velocidad3*angulo));
  v2y = radio3*cos(radians(velocidad3*angulo));
  ellipse(s3x+(width/2.5), s3y+(height/2), random(115, 120), random(115, 120));

  //ovni
  v2x = radio3*sin(radians(velocidad*0.7*angulo));
  v2y = radio3*cos(radians(velocidad*0.7*angulo));
  ovni1 = new ovnis(v2x*random(1, 3)+(width/2), v2y*random(1, 3)+(height/2));
  ovni1.draw();
}

void mousePressed() {

  //defino cómo cambian las pantallas

  //comenzar
  int xj = 450;
  int yj = 460;
  int wj = 80;
  int hj = 70;

  if (pant ==1 && mouseX>xj && mouseX <xj+wj && mouseY>yj && mouseY <yj+hj) {
    pant = 10;
  }

  //colores (desde el menú)
  int xc = 450;
  int yc = 605;
  int wc = 90;
  int hc = 25;

  if (pant == 1 && mouseX>xc && mouseX <xc+wc && mouseY>yc && mouseY <yc+hc) {
    pant = 2;
  }

  //back
  int xb = 40;
  int yb = 30;
  int wb = 110;
  int hb = 35;

  if (pant != 1  && mouseX>xb && mouseX <xb+wb && mouseY>yb && mouseY <yb+hb) {
    pant = 1;
  }


  //color azul (dentro del menu de selección)
  int xa = 410;
  int ya = 570;
  int wa = 315;
  int ha = 50;

  if (pant == 2 && mouseX>xa && mouseX <xa+wa && mouseY>ya && mouseY <ya+ha) {
    pant = 3;
  }

  //color rojo (dentro del menu de selección)
  int xr = 410;
  int yr = 390;
  int wr = 315;
  int hr = 50;

  if (pant == 3 && mouseX>xr && mouseX <xr+wr && mouseY>yr && mouseY <yr+hr) {
    pant = 2;
  }

  //instrucciones

  int xi = 420;
  int yi = 650;
  int wi = 150;
  int hi = 25;

  if (pant == 1 && mouseX>xi && mouseX <xi+wi && mouseY>yi && mouseY <yi+hi) {
    pant = 4;
  }

  //niveles

  int xn = 460;
  int yn = 705;
  int wn = 70;
  int hn = 25;

  if (pant == 1 && mouseX>xn && mouseX <xn+wn && mouseY>yn && mouseY <yn+hn) {
    pant = 5;
  }

  //siguiente nivel
  int xs = 400;
  int ys = 560;
  int ws = 200;
  int hs = 40;

  if (pant == 7 && mouseX>xs && mouseX <xs+ws && mouseY>ys && mouseY <ys+hs) {
    pant = 6;
    //reiniciarJuego();
  }

  //salir
  int xx = 460;
  int yx = 630;
  int wx = 70;
  int hx = 40;

  if ( pant == 7 && mouseX>xx && mouseX <xx+wx && mouseY>yx && mouseY <yx+hx) { //pant != 9 && pant != 3 && pant != 4 && pant != 5 && pant !=6 && pant != 1 && pant != 8
    pant = 9;
  }

  //seguro si
  int x1 = 450;
  int y1 = 450;
  int w1 = 100;
  int h1 = 100;

  if (pant == 9 && mouseX>x1 && mouseX <x1+w1 && mouseY>y1 && mouseY <y1+h1) {
    pant = 1;
    reiniciarJuego();
  }

  //seguro no
  int x2 = 490;
  int y2 = 650;
  int w2 = 50;
  int h2 = 50;

  if (pant == 9 && pant != 7 && mouseX>x2 && mouseX <x2+w2 && mouseY>y2 && mouseY <y2+h2) {
    pant = 7;
  }

  //reintentar perdio

  int x3 = 300;
  int y3 = 680;
  int w3 = 50;
  int h3 = 50;

  if (pant == 8 && mouseX>x3 && mouseX <x3+w3 && mouseY>y3 && mouseY <y3+h3) {
    pant = 6;
    reiniciarJuego();
  }

  //menu perdio

  int x4 = 640;
  int y4 = 680;
  int w4 = 50;
  int h4 = 50;

  if (pant == 8 && mouseX>x4 && mouseX <x4+w4 && mouseY>y4 && mouseY <y4+h4) {
    pant = 1;
  }

  //quit

  int xq = 930;
  int yq = 940;
  int wq = 35;
  int hq = 35;

  if (pant == 6 && mouseX>xq && mouseX <xq+wq && mouseY>yq && mouseY <yq+hq) {
    pant = 9;
  }
  
  //disponer instr

  int xit = 430;
  int yit = 545;
  int wit = 140;
  int hit = 15;
  
   if (pant == 10 && mouseX>xit && mouseX <xit+wit && mouseY>yit && mouseY <yit+hit) {
    pant = 6;
  }
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      xac = xac - 10;
      direccion = -1;
      direccion2 = 0;
    } else if (keyCode == RIGHT) {  
      xac = xac + 10;
      direccion = 1;
      direccion2 = 0;
    } else if (keyCode == UP) {
      yac = yac - 10;
      direccion = 0;
      direccion2 = -1;
    } else if (keyCode == DOWN) { 
      yac = yac + 10;
      direccion = 0;
      direccion2 = 1;
    }
  }
}

void render() {
  for ( int i=-1; i < 2; i++) {
    for ( int j=-1; j < 2; j++) {
      pushMatrix();
      translate(xac + (i * width), yac + (j*height));
      if ( direccion == -1) { 
        rotate(PI);
      }
      if ( direccion2 == 1) { 
        rotate(HALF_PI);
      }
      if ( direccion2 == -1) { 
        rotate( PI + HALF_PI );
      }
      noStroke();
      fill(random(190, 250), 255, 0);//color de pacman
      arc(0, 0, radpac, radpac, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
      popMatrix();
      //movimiento de la boca //
    }
  }
}

void reiniciarJuego() {
  if (pant != 6) {

    for (int i=0; i<com.size(); i++) {
      comida Pn = (comida) com.get(i);
      Pn.display();
      //pintar comida de nuevo
      if (dist(xac, yac, Pn.x, Pn.y)<radpac) { 
        com.remove(i);
        contcomida =contcomida+100;
      }
    }
  }
  contcomida = 0;
  vidas = 3;
}
