class Row {
  Car[] cars;
  boolean dir;
  
  Row(int pY, int size, boolean direction) {
    dir = direction;
    cars = new Car[size];
    for (int i = 0; i < size; i++) {
      cars[i] = new Car(width/2+4*i*(wCars), pY, direction);
    }
  }
  void update() {
    for (int i = 0; i < cars.length; i++) {
      cars[i].update();
    }
  }

  void show() {
    for (int i = 0; i < cars.length; i++) {
      cars[i].show();
    }
  }

  void outOfScreen() {
    for (int i = 0; i < cars.length; i++) {
      if (!dir) {
        if (cars[i].outOfScreen(true)) cars[i].pX = width;
      } else {
        if (cars[i].outOfScreen(false)) cars[i].pX = -wCars;
      }
    }
  }
} 
