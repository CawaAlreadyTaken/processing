//______________________________________________________________________________________________________________________________________________________
// # STUFF YOU CAN CHANGE

int difficulty = 12; //4-13, bot difficulty (only for 1 player, less than 4 literally it can't play, 13 may take a while)
int players = 1;
int cols = 6, rows = 7;
//______________________________________________________________________________________________________________________________________________________

int borderX;
int borderY;
int lx;
int ly;
int p;
int x1V, x2V, y1V, y2V;
int freeSpots;
boolean redWins = false;
boolean yellowWins = false;
boolean loading = false;
boolean clickable = true;
int botX = -1, botY = -1;
int count1 = 0;
int count2 = 0;
boolean gameAlive = true;
String[][] grid0 = new String[cols][rows];

void setup() {
  size(720, 840);
  lx = width/cols;
  ly = height/rows;
  borderX = lx/8;
  borderY = ly/8;
  p = 1;
  freeSpots = cols*rows;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid0[i][j]=" ";
    }
  }
}


int dx = -1;
int dy = -1;

int maxi(int max, int min, int depth, String[][] grid1) {
  if (depth==0) return evaluate(grid1);
  for (int i = 0; i < cols; i++) {
    for (int j = rows-1; j >= 0; j--) {
      if (j+1<rows&&grid1[i][j+1]==" ") break;
      if (grid1[i][j]==" ") {
        grid1[i][j]="2";
        int score = mini(max, min, depth - 1, grid1);
        if (score >= min) {
          grid1[i][j]=" ";

          return min;
        }
        if (score > max) {
          max = score;
          if (depth==difficulty) {
            dx = i;
            dy = j;
          }
        }
        grid1[i][j]=" ";
      }
    }
  }
  return max;
}

int mini(int max, int min, int depth, String[][] grid1) {
  if (depth==0) return evaluate(grid1);
  for (int i = 0; i < cols; i++) {
    for (int  j = rows-1; j >= 0; j--) {
      if (j+1<rows&&grid1[i][j+1]==" ") break;
      if (grid1[i][j]==" ") {
        grid1[i][j]="1";
        int score = maxi(max, min, depth - 1, grid1);
        if (score <= max) {
          grid1[i][j]=" ";
          return max;
        }
        if (score < min) {
          min = score;
        }
        grid1[i][j]=" ";
      }
    }
  }
  return min;
}

int evaluate(String[][] grid1) {
  int out = 0;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid1[i][j]=="1") {
        for (int k = 1; k < 4; k++) {
          if (j+k<rows) {
            if (grid1[i][j+k]!="1") {
              out-=k; 
              break;
            } else if (k==3) {
              out-=500;
            }
          } else break;
        }
        for (int k = 1; k < 4; k++) {
          if (i+k<cols) {
            if (grid1[i+k][j]!="1") {
              out-=k; 
              break;
            } else if (k==3) {
              out-=500;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j+k<rows) {
            if (grid1[i+k][j+k]!="1") {
              out-=k; 
              break;
            } else if (k==3) {
              out-=500;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j-k>=0) {
            if (grid1[i+k][j-k]!="1") {
              out-=k; 
              break;
            } else if (k==3) {
              out-=500;
            }
          } else break;
        }
      }
    }
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid1[i][j]=="2") {
        for (int k = 1; k < 4; k++) {
          if (j+k<rows) {
            if (grid1[i][j+k]!="2") {
              out+=k; 
              break;
            } else if (k==3) {
              out+=450;
            }
          } else break;
        }
        for (int k = 1; k < 4; k++) {
          if (i+k<cols) {
            if (grid1[i+k][j]!="2") {
              out+=k; 
              break;
            } else if (k==3) {
              out+=450;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j+k<rows) {
            if (grid1[i+k][j+k]!="2") {
              out+=k; 
              break;
            } else if (k==3) {
              out+=450;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j-k>=0) {
            if (grid1[i+k][j-k]!="2") {
              out+=k; 
              break;
            } else if (k==3) {
              out+=450;
            }
          } else break;
        }
      }
    }
  }
  return out;
}

boolean redWinCheck() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid0[i][j]=="1") {
        for (int k = 1; k < 4; k++) {
          if (j+k<rows) {
            if (grid0[i][j+k]!="1") break;
            else if (k==3) {
              x1V=i; 
              x2V=i; 
              y1V=j; 
              y2V=j+3; 
              return true;
            }
          } else break;
        }
        for (int k = 1; k < 4; k++) {
          if (i+k<cols) {
            if (grid0[i+k][j]!="1") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j; 
              return true;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j+k<rows) {
            if (grid0[i+k][j+k]!="1") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j+3; 
              return true;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j-k>=0) {
            if (grid0[i+k][j-k]!="1") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j-3; 
              return true;
            }
          } else break;
        }
      }
    }
  }
  return false;
}

boolean yellowWinCheck() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid0[i][j]=="2") {
        for (int k = 1; k < 4; k++) {
          if (j+k<rows) {
            if (grid0[i][j+k]!="2") break;
            else if (k==3) {
              x1V=i; 
              x2V=i; 
              y1V=j; 
              y2V=j+3; 
              return true;
            }
          } else break;
        }
        for (int k = 1; k < 4; k++) {
          if (i+k<cols) {
            if (grid0[i+k][j]!="2") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j; 
              return true;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j+k<rows) {
            if (grid0[i+k][j+k]!="2") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j+3; 
              return true;
            }
          } else break;
        }
        for (int k=1; k < 4; k++) {
          if (i+k<cols&&j-k>=0) {
            if (grid0[i+k][j-k]!="2") break;
            else if (k==3) {
              x1V=i; 
              x2V=i+3; 
              y1V=j; 
              y2V=j-3; 
              return true;
            }
          } else break;
        }
      }
    }
  }
  return false;
}

void minimax(int depth, String[][] grid1) {
  if (freeSpots<depth) depth = freeSpots;
  int f = maxi(-1000000, 1000000, depth, grid1);
  grid0[dx][dy]="2";
  botX=dx;
  botY=dy;
  freeSpots--;
  p=1;
  if (yellowWinCheck()) {
    yellowWins = true;
  }
}

void draw() {
  if (gameAlive) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        fill(255);
        strokeWeight(2);
        if (i==botX&&j==botY) fill(135, 206, 250);
        rect(i*lx, j*ly, lx, ly); 
        if (grid0[i][j]=="1") {
          strokeWeight(1);
          fill(255, 0, 0);
          ellipse(i*lx+lx/2, j*ly+ly/2, lx-borderX, ly-borderY);
        } else if (grid0[i][j]=="2") {
          strokeWeight(1);
          fill(255, 255, 0);
          ellipse(i*lx+lx/2, j*ly+ly/2, lx-borderX, ly-borderY);
        }
      }
    }
    if (p==1) {
      textSize(20);
      fill(255, 0, 0);
      textAlign(LEFT);
      text("RED", width/50, height/30);
    } else {
      textSize(20);
      fill(240, 200, 80);
      textAlign(LEFT);
      text("YELLOW", width/50, height/30);
    }
    if (redWins) {
      strokeWeight(4);
      stroke(127, 255, 0);
      line(x1V*lx+lx/2, y1V*ly+ly/2, x2V*lx+lx/2, y2V*ly+ly/2);
      fill(255, 127, 80);
      textSize(100);
      textAlign(CENTER);
      text("RED WINS", width/2, height/2);
      gameAlive = false;
    } else if (yellowWins) {
      strokeWeight(4);
      stroke(127, 255, 0);
      line(x1V*lx+lx/2, y1V*ly+ly/2, x2V*lx+lx/2, y2V*ly+ly/2);
      fill(255, 127, 80);
      textSize(100);
      textAlign(CENTER);
      text("YELLOW WINS", width/2, height/2);
      gameAlive = false;
    }
    if (loading) {
      textSize(70);
      textAlign(CENTER);
      fill(255, 127, 80);
      text("LOADING...", width/2, height/2);
    }
  }
  if (players == 1) {
    if (p==2)
      count1++;
    if (count1>60) { 
      count1=0;
      int depth = difficulty; 
      String[][] grid1 = new String[cols][rows];
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          grid1[i][j]= grid0[i][j];
        }
      }
      minimax(depth, grid1);
      loading = false;
    }
  }
  if (p == 1) {
    count2++;
    if (count2==10) {
      clickable = true; 
      count2 = 0;
    }
  }
}

int col = -1;

void mouseClicked() {
  if (gameAlive) {
    if (p == 1&&clickable) {
      if (players == 1) clickable = false;
      col = mouseX/lx;
      for (int i = rows-1; i >= 0; i--) {
        if (grid0[col][i]==" ") {
          grid0[col][i]="1";
          p=2;
          break;
        }
      }
      if (redWinCheck()) {
        redWins = true;
      }
      freeSpots--;
      if (players == 1) loading = true;
    } else if (p == 2) {
      if (players == 2) {
        col = mouseX/lx;
        for (int i = rows-1; i >= 0; i--) {
          if (grid0[col][i]==" ") {
            grid0[col][i]="2";
            p=1;
            break;
          }
        }
        if (yellowWinCheck()) {
          yellowWins = true;
        }
      }
    }
  }
}
