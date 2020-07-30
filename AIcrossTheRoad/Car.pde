class Car {
  int velX = -3;
  int pX, pY;
  Car(int x, int y, boolean direction) {
    pX = x;
    pY = y;
    if (direction) velX*=(-1);
  }
  
  void update() {
    pX+=velX;
  }
  
  void show() {
    fill(255, 0, 0);
    rect(pX, pY, wCars, hCars);  
  }
  
  boolean outOfScreen(boolean k) {
    if (k) return pX+wCars+width/nCars<0;
    else return pX>width;
  }
}
