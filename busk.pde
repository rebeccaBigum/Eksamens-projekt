class Busk extends Forhindring{
  float x,y;
Busk(float xIn, float yIn){
    x = xIn;
    y = yIn;
    busk = loadImage("busk.png");
  }

void tegner(){
  //tegner buske
    image(busk, x-b.position.x, y-b.position.y);
}

}
