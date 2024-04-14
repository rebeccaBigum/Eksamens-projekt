class Bil {

  PImage bil;
  int h = 165;
  int b = 75;
  int pHit = 0;
  //variabler til hvilke har jeg tidligere ramt
  int tidRambu = 13;
  int tidRambo = 13;
  int tidRamke = 13;

  PVector position;
  float angle;
  float speed;
  float maxSpeed;
  float acceleration;
  float deceleration;
  float[] bilX = new float[12];
  float[] bilY = new float[12];



  Bil(float x, float y) {
    hjul = loadImage("dæk.png");
    bil = loadImage("bil.png");
    hjerte = loadImage("hjerte.png");
    position = new PVector(x, y);
    angle = -PI/4;
    speed = 0;
    maxSpeed = 5;
    acceleration = 0.1;
    deceleration = 0.2;
  }

  void hjul() {
    //drejer vinklen som hjulbilledet vises med
    if (venstre == true && hjulAngle>-0.4 || hjulAngle>0 && venstre==false && hojre==false) {
      hjulAngle-=0.01;
    }
    if (hojre == true && hjulAngle<0.4 || hjulAngle<0 && venstre==false && hojre==false) {
      hjulAngle+=0.01;
    }
  }


  void tegn() {
    //kører push pop matrix hvor at jeg tegner hjuæl og vil ud fra rigtige vinkler
    pushMatrix();
    translate(width/2, height/2);
    imageMode(CENTER);
    rotate(angle+PI/2);
    hjuldrej(60, 90, 0);
    hjuldrej(-58, 90, 0);
    hjuldrej(63, -90, hjulAngle);
    hjuldrej(-61, -90, hjulAngle);
    image(bil, 0, 0);
    popMatrix();
  }

  void update() {
    // Begrænser bilens hastighed
    speed = constrain(speed, 0, maxSpeed);
  }


  void accelerate() {
    // Accelerer bilen både forlæns og baglæns
    if (speed >= 0)
      speed += acceleration;
    else
      speed -= acceleration;
  }

  void decelerate() {
    // Decelerer bilen enten fremad eller bagud
    if (op==false && venstre==false && hojre==false && nede==false && speed>0) {
      // Decelerer bilen
      if (speed >= 0)
        speed -= deceleration;
      else
        speed += deceleration;
    }
  }

  void turnLeft() {
    // Drej bilen til venstre
    angle -= 0.03;
    float dx = cos(angle) * speed*0.5;
    float dy = sin(angle) * speed*0.5;
    position.add(dx, dy);
  }

  void turnRight() {
    // Drej bilen til højre
    angle += 0.03;
    float dx = cos(angle) * speed*0.5;
    float dy = sin(angle) * speed*0.5;
    position.add(dx, dy);
  }

  void drive() {
    // Kør bilen fremad baseret på dens nuværende hastighed og retning
    PVector velocity = PVector.fromAngle(angle);
    velocity.mult(speed);
    position.add(velocity);
  }

  void back() {
    // Kør bilen baglæns baseret på dens nuværende hastighed og retning
    PVector velocity = PVector.fromAngle(angle);
    velocity.mult(speed);
    position.sub(velocity);
  }


  void findPunkter() {
    //finder 12 punkter rundt om bilen for at køre kollision tjek
    //punkt 1
    bilX[0]=(width/2+cos(angle)*h);
    bilY[0]=(height/2+sin(angle)*h);

    //punkt 2
    bilX[1]=(width/2+(cos(angle+PI)*h));
    bilY[1]=(height/2+(sin(angle+PI)*h));

    //punkt 3
    bilX[2]=(width/2+cos(angle+PI/2)*b);
    bilY[2]=(height/2+sin(angle+PI/2)*b);

    //punkt 4
    bilX[3]=(width/2+cos(angle-PI/2)*b);
    bilY[3]=(height/2+sin(angle-PI/2)*b);

    //punkt 5
    bilX[4]=(bilX[3]+cos(angle)*(h/2));
    bilY[4]=(bilY[3]+sin(angle)*(h/2));

    //punkt 6
    bilX[5]=(bilX[2]+cos(angle)*(h/2));
    bilY[5]=(bilY[2]+sin(angle)*(h/2));

    //punkt 7
    bilX[6]=(bilX[2]-cos(angle)*(h/2));
    bilY[6]=(bilY[2]-sin(angle)*(h/2));


    //punkt 8
    bilX[7]=(bilX[3]+cos(angle+PI)*(h/2));
    bilY[7]=(bilY[3]+sin(angle+PI)*(h/2));

    //punkt 9
    bilX[8]=(bilX[2]+cos(angle)*(h-20));
    bilY[8]=(bilY[2]+sin(angle)*(h-20));


    //punkt 10
    bilX[9]=(bilX[3]+cos(angle)*(h-20));
    bilY[9]=(bilY[3]+sin(angle)*(h-20));


    //punkt 11
    bilX[10]=(bilX[2]+cos(angle+PI+0.05)*(h-20));
    bilY[10]=(bilY[2]+sin(angle+PI+0.05)*(h-20));


    //punkt 12
    bilX[11]=(bilX[3]+cos(angle+PI-0.05)*(h-20));
    bilY[11]=(bilY[3]+sin(angle+PI-0.05)*(h-20));
  }

  void colision() {
    //hvis en af bilens punkters afstand til midden af busken er mindre end buskens radius rammer bilen
    for (int i=0; i<12; i++) {
      for (int j=0; j<buskArray.size(); j++) {
        if (dist(buskArray.get(j).x, buskArray.get(j).y, bilX[i]+position.x, bilY[i]+position.y)<72) {
          //hvis der enten er gået 2 sekunder siden sidste ram eller bilen rammer en ny busk tages et liv
          if ( pHit+1<tid && liv>0 || tidRambu!=j && liv>0) {
            tidRambu=j;
            pHit=tid;
            liv--;
            speed=0;
          }
        }
      }
      for (int j=0; j<kegleArray.size(); j++) {
        if (bilX[i]+position.x<kegleArray.get(j).x+42 && bilX[i]+position.x>kegleArray.get(j).x-42 && bilY[i]+position.y<kegleArray.get(j).y+42 && bilY[i]+position.y>kegleArray.get(j).y-42) {
          if ( pHit+1<tid && liv>0 || tidRamke!=j && liv>0) {
            tidRamke=j;
            pHit=tid;
            liv--;
            speed=0;
          }
        }
      }
      for (int j=0; j<boksArray.size(); j++) {
        if (bilX[i]+position.x<boksArray.get(j).x+281 && bilX[i]+position.x>boksArray.get(j).x-281 && bilY[i]+position.y<boksArray.get(j).y+141 && bilY[i]+position.y>boksArray.get(j).y-141) {
          if ( pHit+1<tid && liv>0 || tidRambo!=j && liv>0) {
            tidRambo=j;
            pHit=tid;
            liv--;
            speed=0;
          }
        }
      }
    }

    //hvis alle liv er væk så er man død :((
    if (liv==0) {
      dod=true;
    }

    //tegner de liv der er tilbage
    for (int i=0; i<liv; i++) {
      image(hjerte, 500+i*150, 100);
    }
  }

  void winCheck() {
    //kører alle bilens punkter igennem
    for (int i=0; i<12; i++) {
      //er punktet indenfor parkeringspladsen
      if (bilX[i]+position.x<parkArray.get(0).x+105 && bilX[i]+position.x>parkArray.get(0).x-105 && bilY[i]+position.y<parkArray.get(0).y+210 && bilY[i]+position.y>parkArray.get(0).y-210) {
        yes+=1;
        println(yes);
      }
    }
    if (yes==12) {
      vundet=true;
    } else {
      yes=0;
    }
  }
  
    void hjuldrej(int X, int Y, float Z) {
    //funktion til at tegne bilhjul
    pushMatrix();
    translate(X, Y);
    rotate(Z);
    image(hjul, 0, 0);
    popMatrix();
  }
}
