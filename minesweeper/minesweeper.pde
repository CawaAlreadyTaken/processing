//______________________________________________________________________________________________________________________________________________________________________________________________________________________________________
//YOU CAN CHANGE THESE.
int cols = 15; // Min: 1, Max: what your pc can handle. Beware that nbombs must me less than or equal to cols*rows.
int rows = cols; // This can also be independent.
int nbombs = 40; // Read comment above.
//______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

PImage B;
PImage F;
char[][] grid;
boolean[][] bomb;
boolean[][] discovered;
boolean[][] flagged;
int lx, ly;
int bombsToPut = nbombs;
int hidden = cols*rows;

void setup() {
  textAlign(CENTER);
  if (nbombs > cols*rows) {
    println("There are more bombs than available squares. Exit.");
    System.exit(0);
  }
  size(600, 600);
  strokeWeight(2);
  lx = width/cols;
  ly = height/rows;
  grid = new char[cols][rows];
  bomb = new boolean[cols][rows];
  discovered = new boolean[cols][rows];
  flagged = new boolean[cols][rows];
  B = loadImage("media/bomb.png");
  F = loadImage("media/flag.png");
  while (bombsToPut>0) {
    int x = int(random(cols));
    int y = int(random(rows));
    if (!bomb[x][y]) {
      bomb[x][y]=true;
      bombsToPut--;
    }
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (bomb[i][j]) grid[i][j]='B';
      else {
        int count = 0; 
        for (int k = -1; k <= 1; k++) {
          for (int h = -1; h <= 1; h++) {
            if ((k!=0||h!=0) && i+k>=0 && i+k<cols && j+h>=0 && j+h<rows) {
              if (bomb[i+k][j+h]) count++;
            }
          }
        }
        grid[i][j]=(char)(count+48);
        if (grid[i][j]=='0') grid[i][j]=' ';
      }
      discovered[i][j]=false;
      flagged[i][j]=false;
    }
  }
  println("Number of squares: ", cols*rows);
  println("Number of bombs: ", nbombs, "(", float(nbombs)/(float(cols)*float(rows))*100, "% )");
}

void draw() {
  draw_grid();
  if (hidden==nbombs) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        discovered[i][j]=true;
      }
    }
    draw_grid();
    fill(0, 255, 0);
    textSize(60);
    text("YOU WON!", width/2, height/2);
    println("YOU WON!");
    frameRate(0);
  }
}

void draw_grid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (!discovered[i][j]) {
        fill(150);
        rect(i*lx, j*ly, (i+1)*lx, (j+1)*ly);
        if (flagged[i][j]) {
          image(F, i*lx, j*ly, lx, ly);
        }
      } else {
        textSize(20*min(lx, ly)/40);
        fill(255);
        rect(i*lx, j*ly, (i+1)*lx, (j+1)*ly);
        if (grid[i][j]=='1') {
          fill(30, 144, 255);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='2') {
          fill(0, 128, 0);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='3') {
          fill(255, 0, 0);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='4') {
          fill(0, 0, 255);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='5') {
          fill(139, 0, 0);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='6') {
          fill(95, 158, 160);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='7') {
          fill(0);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='8') {
          fill(100);
          text(grid[i][j], i*lx+lx/2, j*ly+ly*2/3);
        } else if (grid[i][j]=='B') {
          image(B, i*lx+lx/10, j*ly+ly/10, lx*4/5, ly*4/5);
        }
      }
    }
  }
}

void gameOver() {
  draw();
  fill(255, 0, 0);
  textSize(60);
  text("GAME OVER", width/2, height/2);
  println("GAME OVER,", (1-float(hidden)/float(cols*rows))*100, "% discovered.");
  frameRate(0);
}

void discover(int x, int y) {
  for (int k = -1; k <= 1; k++) {
    for (int h = -1; h <= 1; h++) {
      if ((k!=0||h!=0) && x+k>=0 && x+k<cols && y+h>=0 && y+h<rows&&!discovered[x+k][y+h]) {
        hidden--;
        discovered[x+k][y+h] = true;
        if (grid[x+k][y+h]==' ') discover(x+k, y+h);
      }
    }
  }
}

void mousePressed() {
  int x = mouseX/lx;
  int y = mouseY/ly;
  if (mouseButton==LEFT) {
    if (!flagged[x][y]) {
      if (!discovered[x][y]) {
        hidden--;
        discovered[x][y]=true;
      }
      if (bomb[x][y]) gameOver();
      else if (grid[x][y]==' ') {
        discover(x, y);
      }
    }
  } else {
    if (!discovered[x][y]) {
      flagged[x][y]=!flagged[x][y];
    }
  }
}
