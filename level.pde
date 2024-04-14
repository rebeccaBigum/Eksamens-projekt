class Level {
  PImage stjerne;

  Level() {
    stjerne = loadImage("stjerne.png");
  }


  void starts() {
    fill(255);
    rect(width/2-250, height/2-100, 500, 200);
    fill(0);
    textSize(90);
    text("start spil", width/2-160, height/2+20);
    if (mousePressed && mouseX > width/2-250 && mouseX < width/2+250 && mouseY > height/2-100 && mouseY < height/2+100) {
      start=false;
      tryk=true;
    }
  }

  void levels() {
    //reloader alle variabler
    liv=3;
    tid=0;
    b.pHit=0;
    b.position.x=600;
    b.position.y=450;
    b.angle = -PI/4;
    b.speed = 0;
    b.acceleration = 0.1;
    b.deceleration = 0.2;
    lyd=false;
    fill(255);
    rect(width/2-400, height/2-50, 300, 300);
    fill(0);
    text("Vælg level", width/2-400, height/2-200);
    text("Level 1", width/2-375, height/2+110);
    if (mousePressed && mouseX > width/2-400 && mouseX < width/2+100 && mouseY > height/2-50 && mouseY < height/2+250 && tryk == false) {
      level=false;
      tryk=true;
    }
  }

  void restart() {
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
    b.tegn();

    //tegner bokse
    fill(255);
    rect(width/2-250, height/2-200, 500, 200);
    rect(width/2-250, height/2+100, 500, 200);
    fill(0);
    textSize(80);
    text("Du døde", width/2-150, height/2-300);
    text("Start forfra :)", width/2-190, height/2-80);
    text("Level", width/2-90, height/2+220);
    if (mousePressed && mouseX > width/2-250 && mouseX < width/2+250 && mouseY > height/2-200 && mouseY < height/2 && tryk == false) {
      dod=false;
      tryk=true;
      //reloader alle variabler
      liv=3;
      tid=0;
      b.pHit=0;
      b.position.x=600;
      b.position.y=450;
      b.angle = -PI/4;
      b.speed = 0;
      b.acceleration = 0.1;
      b.deceleration = 0.2;
      lyd=false;
    } else if (mousePressed && mouseX > width/2-250 && mouseX < width/2+250 && mouseY > height/2+100 && mouseY < height/2+300 && tryk == false) {
      dod=false;
      level=true;
      tryk=true;
    }
  }

  void vundet() {
    fill(255);
    rect(width/2-250, height/2+100, 500, 200);
    fill(0);
    textSize(80);
    text("Tillykke, du vandt :)", width/2-320, height/2-200);
    textSize(50);
    text("Point  :", width/2-150, height/2-100);
    textSize(80);
    text("Level", width/2-90, height/2+220);

    if (liv==3 && tid<50) {
      point=3;
    } else if (liv>=2 &&tid<80) {
      point=2;
    } else {
      point=1;
    }
    for (int i=0; i<point; i++) {
      image(stjerne, 650+i*100, height/2-112);
    }

    if (mousePressed && mouseX > width/2-250 && mouseX < width/2+250 && mouseY > height/2+100 && mouseY < height/2+300 && tryk == false) {
      vundet=false;
      level=true;
      tryk=true;
      yes=0;
    }
  }
}
