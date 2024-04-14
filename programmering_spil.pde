Bil b;
Forhindring r;
Level l;
Parkering p;

import processing.sound.*;
SoundFile file;

PImage hjul;
PImage busk;
PImage boks;
PImage kegle;
PImage hjerte;
PImage park;
float hjulAngle;
boolean op;
boolean venstre;
boolean hojre;
boolean nede;
boolean lyd;
int yes=0;
int point=0;


ArrayList<Kegle> kegleArray = new ArrayList<Kegle>();
ArrayList<Busk> buskArray = new ArrayList<Busk>();
ArrayList<Boks> boksArray = new ArrayList<Boks>();
ArrayList<Parkering> parkArray = new ArrayList<Parkering>();

int time;
int tid=0;
int liv = 3;
boolean start= true;
boolean level = true;
boolean dod  = false;
boolean tryk = false;
boolean ramt = false;
boolean win = false;
boolean vundet;

void setup() {
  b = new Bil(width/2, height/2);
  r = new Forhindring();
  l = new Level();
  size(1200, 900);
  r.load();
  time = millis();
  file = new SoundFile(this, "bilacc.wav");
}


void draw() {
  background(200);
  //først køres startfunktion og derefter level funktion
  if (start) {
    l.starts();
  } else if (level) {
    l.levels();
  }

  //herefter køres selve spillet, når man er igennem start og level og ikke er død
  if (start==false && level==false && dod==false && vundet==false) {

    //her tælles sekunder
    if (millis() > time + 1000 ) { //et sekund
      time = millis();
      tid+=1;
    }

    //forhindringer tegnes
    for (int i = 0; i < buskArray.size(); i ++) {
      buskArray.get(i).tegner();
    }
    for (int i = 0; i < boksArray.size(); i ++) {
      boksArray.get(i).tegner();
    }
    for (int i = 0; i < kegleArray.size(); i ++) {
      kegleArray.get(i).tegner();
    }

    parkArray.get(0).tegner();

    //bilens hastighed begrænset
    b.update();

    //hvis man trykker på taster kører bilen efter det
    if (hojre==true && nede==false && venstre==false) {
      b.accelerate();
      b.turnRight();
    }
    if (venstre==true && nede==false && hojre==false) {
      b.accelerate();
      b.turnLeft();
    }
    if (op==true) {
      b.accelerate();
      b.drive();
    }
    if (nede==true) {
      b.accelerate();
      b.back();
    }
    if (hojre==true && nede==true && venstre==false) {
      b.accelerate();
      b.back();
      b.turnLeft();
    }
    if (venstre==true && nede==true && hojre==false) {
      b.accelerate();
      b.back();
      b.turnRight();
    }

    //hjul opdateres og bilen og hjul tegnes
    b.hjul();
    b.tegn();


    //bilen decelereres hvis der ikke trykkes
    b.decelerate();


    //finder punkter om bilen og tjekker kolision og tegner liv samt tid
    b.findPunkter();
    b.colision();
    text("Tid :  "+ tid, 100, 100);

    //kører lyd i starten af spillet
    if (lyd==false) {
      if (venstre==true || nede==true || op==true || hojre==true) {
        file.play();
        lyd=true;
      }
    }
    
    //tjekker for vinder
    b.winCheck();
  }

  //hvis spiller er død køres dødfunktion
  if (dod) {
    l.restart();
  }

  //hvis vundet, køres vinderfunktion
  if (vundet) {
    l.vundet();
  }
}


void keyPressed() {
  if (key=='a'||key=='A') {
    venstre=true;
  }
  if (key=='d'||key=='D') {
    hojre=true;
  }
  if (key=='w'||key=='W') {
    op=true;
  }
  if (key=='s'||key=='S') {
    nede=true;
  }
}

void keyReleased() {
  //hvis en af tasterne trykkes sættes en bollean værdi der passer til sand
  if (key=='a'||key=='A') {
    venstre=false;
  }
  if (key=='d'||key=='D') {
    hojre=false;
  }
  if (key=='w'||key=='W') {
    op=false;
  }
  if (key=='s'||key=='S') {
    nede=false;
  }
}

void mouseReleased() {
  //tryk er false, hvilken gør at der kun klikkes en gang ved hvert tryk
  tryk=false;
}
