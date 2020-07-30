Population pop;
Row[] rows; 

// INSPIRED BY A VIDEO FROM CODEBULLET. https://www.youtube.com/channel/UC0e3QhIYukixgh5VVpKHH9Q

//____________________________________________________________________________________________________________________________________________________________________________________________________________________________________
//This setting can be changed.

boolean aggressiveLearning = false;

//____________________________________________________________________________________________________________________________________________________________________________________________________________________________________

int wCars;
int hCars;
int nCars = 3;
int nRows = 3;
int k;
int gen = 1;
boolean showOnlyBest = false;
int textSize;
boolean flag = false;
double bestPrevFitness = 0.000003;
int minStep1 = MAX_INT;

void setup() {
  size(800, 600);
  wCars = width/8;
  hCars = height/12;
  k = height/10;
  pop = new Population(100);
  rows = new Row[nRows];
  for (int i = 0; i < nCars; i++) rows[i] = new Row((i+1)*7*(height)/30, nCars, i%2==0);
  textSize = 30*(min(width, height)/600);
}

void draw() {
  background(100);
  for (int i = 0; i < 4; i++) {
    fill(255, 220);
    rect(width/10, (i*2+1)*k, width*8/10, k);
  }
  for (int i = 0; i < nRows; i++) {
    rows[i].update();
    rows[i].show();
    rows[i].outOfScreen();
  }
  if (pop.allDead()) {
    gen++;
    for (int i = 0; i < nCars; i++) rows[i] = new Row((i+1)*7*(height)/30, nCars, i%2==0);
    pop.calcFitness();
    pop.darwin();
    pop.randomize();
  } else {
    pop.update();
    pop.show();
  }
  fill(176, 224, 230);
  textSize(textSize);
  textAlign(LEFT);
  text("Generation: "+gen, width/20, height-(textSize+5));
  if (flag) {
    textAlign(LEFT);
    text("min Steps: " + minStep1, width*2/3, height-(textSize+5));
  }
}
