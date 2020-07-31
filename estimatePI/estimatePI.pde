int n = 10000;
double PIvalue;
int nIn = 0;
int nOut = 0;

Dot[] dots = new Dot[n];
Circle circ;

float r = 2;
int iter = 0;

void setup() {
  size(800, 800); 
  int w = width;
  int h = height;
  for (int i = 0; i < dots.length; i++) {
    dots[i] = new Dot(random(width), random(height), 4);
  }
  circ = new Circle(min(w, h));
}


void draw() {
  background(0);
  for (int i = 0; i < dots.length; i++) {
    if (!dots[i].hide) {
      dots[i].update();
      if (dots[i].inside < 0) {
        dots[i].check();
        
        if (dots[i].inside == 1) {
          nIn++;
        } else {
          nOut++; 
        }
        updatePi();
      }
    }
  }
  circ.update();
  
  fill(255);
  textSize(17);
  text("N. dots total: " + (nIn + nOut), 20, height-80);
  text("N. dots inside the circle: " + nIn, 20, height-60);
  text("N. dots outside the circle: " + nOut, 20, height-40);
  text("PI estimated: " + PIvalue, 20, height-20);
  text("Press Spacebar to drop a dot", width*2/3, height-20);
}

void keyPressed() {
  switch(key) {
  case ' ':
    if (iter < n) {
      dots[iter].show();
      iter++;
      break;
    }
  }
}

void updatePi() {
  PIvalue = ((double)nIn / ((double)nIn + (double)nOut))*4;
  
}
