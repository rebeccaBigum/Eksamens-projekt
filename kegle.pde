class Kegle extends Forhindring{
  float x;
  float y;
  
Kegle(float xIn, float yIn){
    x = xIn;
    y = yIn;
    kegle = loadImage("kegle.png");
  }

void tegner(){
  //tegner kegler
    image(kegle,  x-b.position.x, y-b.position.y);
}


}
