class Population {
  Pedestrian[] pedestrians;
  int bestPedestrian = 0;
  float sumFitness;
  int minStep = 400;

  Population(int size) {
    pedestrians = new Pedestrian[size];
    for (int i = 0; i < size; i++) {
      pedestrians[i] = new Pedestrian();
    }
  }

  boolean allDead() {
    for (int i = 0; i < pedestrians.length; i++) {
      if (!pedestrians[i].dead && !pedestrians[i].end) {
        return false;
      }
    } 
    return true;
  }

  void calcFitness() {
    for (int i = 0; i < pedestrians.length; i++) {
      pedestrians[i].calcFitness();
    }
  }

  void darwin() {
    Pedestrian[] newPedestrians = new Pedestrian[pedestrians.length];
    setBestPoint();
    calcSumFitness();

    newPedestrians[0] = pedestrians[bestPedestrian].takeSon();
    newPedestrians[0].best = true;
    for (int i = 1; i < pedestrians.length; i++) {
      Pedestrian parent = selectParent();
      newPedestrians[i] = parent.takeSon();
    }
    pedestrians = newPedestrians.clone();
  }

  void calcSumFitness() {
    sumFitness = 0;
    for (int i = 0; i < pedestrians.length; i++) {
      sumFitness += pedestrians[i].fitness;
    }
  }

  Pedestrian selectParent() {
    float rand = random(sumFitness);
    float nowSum = 0;
    for (int i = 0; i < pedestrians.length; i++) {
      nowSum += pedestrians[i].fitness;
      if (nowSum > rand) return pedestrians[i];
    }
    return null;
  }

  void randomize() {
    for (int i = 0; i < pedestrians.length; i++) {
      pedestrians[i].brain.mutate();
    }
  }

  void update() {
    for (int i = 0; i < pedestrians.length; i++) {
      if (pedestrians[i].brain.step > minStep) {
        pedestrians[i].dead = true;
      } else {
        pedestrians[i].update();
      }
    }
  }

  void check() {
    for (int i = 0; i < pedestrians.length; i++) {
      pedestrians[i].check();
    }
  }

  void show() {
    if (gen==1 || !showOnlyBest) {
      for (int i = 0; i < pedestrians.length; i++) {
        pedestrians[i].show();
      }
    }
    pedestrians[0].show();
  }

  void setBestPoint() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < pedestrians.length; i++) {
      if (pedestrians[i].fitness > max) {
        max = pedestrians[i].fitness;
        maxIndex = i;
      }
    }
    bestPrevFitness = max(max, (float)(bestPrevFitness));
    bestPedestrian = maxIndex;

    if (pedestrians[bestPedestrian].end) {
      minStep = pedestrians[bestPedestrian].brain.step;
    }
    minStep1 = min(minStep, minStep1);
  }
}
