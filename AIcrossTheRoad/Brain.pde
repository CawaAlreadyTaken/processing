class Brain{
  int step = 0;
  PVector[] directions;
  
  Brain(int size) {
    directions = new PVector[size];
    randomize();
  } 
  
  void randomize() {
    for (int i = 0; i < directions.length; i++) {
      float angle = random(2*PI);
      directions[i] = PVector.fromAngle(angle);
    }
  }
  
  void mutate() {
    float mutationRateo = 0.01;
    for (int i = 0; i < directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRateo) {
        float angle = random(2*PI);
        directions[i] = PVector.fromAngle(angle);
      } 
    }
  }
  
  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }
    return clone;
  }
  
} 
