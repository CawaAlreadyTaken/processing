int pX, pY;
boolean beginning = true;

//____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
// # YOU CAN ADD COLOURS OR CHANGE THE ARRAY. JUST REMIND TO ADD IT OR CHANGE IT IN BOTH THE ARRAYS: LETTER TO PRESS AND COLOR RGB CODE
// # You can also change the size(a, b) settings in funciont "setup()" a bit.
char[] coloriN = {'r', 'g', 'b', 'y', 'o', 'w', 'k', 'd', 'p', 'l'};
color[] coloriC = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), color(255, 165, 0), color(255), color(222, 184, 135), color(0), color(186, 85, 211), color(173, 216, 230)};
//____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________


void setup() {
  size(1000, 700); 
  background(255);
  stroke(0);
  textSize(20);
}

void draw() {
  strokeWeight(0);
  for (int i = 0; i < coloriC.length; i++) {
    fill(coloriC[i]);
    rect(width/40, (i+1)*(height/20), width/40, width/40);
    if (coloriC[i]==color(255)) fill(0);
    text(coloriN[i], width*3/50, (i+1)*(height/20)+height/40);
  }
  fill(0);
  text("Spacebar: clear", width/40, height*19/20);
}

void mouseDragged() {
  if (beginning) {
    pX = mouseX;
    pY = mouseY;
    beginning = false;
  }
  strokeWeight(4);
  line(pX, pY, mouseX, mouseY); 
  pX = mouseX;
  pY = mouseY;
}

void mouseReleased() {
  beginning = true;
}

void keyPressed() {
  if (key==' ') 
    background(255);
  else 
    for (int i = 0; i < coloriC.length; i++) 
      if (key==coloriN[i]||key==coloriN[i]-32)
        stroke(coloriC[i]);
}
