class Pedestrian {
  PVector position;
  PVector speed;
  PVector acc;
  boolean dead = false;
  float fitness;
  boolean end = false;
  boolean best = false;
  int l;

  Brain brain;

  Pedestrian() {
    brain = new Brain(300);
    acc = new PVector(0, 0);
    speed = new PVector(0, 0);
    position = new PVector(width/2, height*19/20);
    l = min(width, height)/50;
  }

  void calcFitness() {
    if (end) {
      flag = true;
      fitness = 1.0/16.0 + 10000.0/float(brain.step*brain.step);
    } else {
      fitness = 1/(position.y*position.y);
    }
  }

  void update() {
    if (!dead && !end) {
      if (aggressiveLearning) {
        if (min(brain.directions.length, sqrt((float)(bestPrevFitness*1000000000))) > brain.step) {
          println(sqrt((float)(bestPrevFitness*1000000000)));
          if (brain.directions.length <= sqrt((float)(bestPrevFitness*1000000000))) {
            aggressiveLearning = false;
          }
          acc = brain.directions[brain.step];
          brain.step++;
        } else {
          dead = true;
        }
      } else {
        if (brain.directions.length > brain.step) {
          acc = brain.directions[brain.step];
          brain.step++;
        } else {
          dead = true;
        }
      }

      speed.add(acc);
      speed.limit(min(width, height)/200);
      position.add(speed);
      check();
    }
  }

  void check() {
    if (position.y < l) {
      end = true;
    } else if (position.x < 0 || position.x > width-l || position.y > height-l) {
      dead = true;
    } else {
      for (int j = 0; j < nRows; j++) {
        for (int i = 0; i < nCars; i++) {
          if (rows[j].cars[i].pX<position.x+l && rows[j].cars[i].pX+wCars>position.x&&rows[j].cars[i].pY<position.y+l&&rows[j].cars[i].pY+hCars>position.y) dead = true;
        }
      }
    }
  }

  void show() {
    if (dead) { 
      fill(147, 112, 219);
      textSize(20);
      textAlign(CENTER);
      text("SPLAT", position.x, position.y+hCars/5);
    } else if (best) {
      fill(0, 255, 0);
      rect(position.x, position.y, l, l);
    } else {
      fill(176, 224, 230);
      rect(position.x, position.y, l, l);
    }
  }

  Pedestrian takeSon() {
    Pedestrian son = new Pedestrian();
    son.brain = brain.clone();
    return son;
  }
}
