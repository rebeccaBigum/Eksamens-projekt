class Parkering extends Forhindring {
  float x;
  float y;

  Parkering(float xIn, float yIn) {
    x = xIn;
    y = yIn;
    park = loadImage("park.png");
  }

  void tegner() {
    //tegner kegler
    image(park, x-b.position.x, y-b.position.y);
  }
}
