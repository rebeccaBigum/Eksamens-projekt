class Boks extends Forhindring{
  float x,y;

Boks(float xIn, float yIn){
    x = xIn;
    y = yIn;
    boks = loadImage("boks.png");
  }

void tegner(){
  //tegner bokse
    image(boks, x-b.position.x, y-b.position.y);
}

}
