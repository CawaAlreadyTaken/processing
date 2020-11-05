PImage T1;
PImage T2;
PImage H1;
PImage H2;
PImage B1;
PImage B2;
PImage K1;
PImage K2;
PImage Q1;
PImage Q2;
PImage P1;
PImage P2;
PFont Font1;

int l;
int nowX = -1;
int nowY = -1;
int previousX = -1;
int previousY = -1;
int dx = -1;
int dy = -1;
int pX = -1;
int pY = -1;
int prevMoveX = -1;
int prevMoveY = -1;
int count = 0;
int delay = 20;
int checkX = -1;
int checkY = -1;
String piece = "x";
String pieceToMove ="  ";
boolean flag = true;
boolean flagCount = false;
boolean flagLoading = false;
boolean gameAlive = true;
boolean whiteWins = false;
boolean blackWins = false;
boolean neverMovedT1L = true;
boolean neverMovedT1R = true;
boolean neverMovedK1 = true;
boolean neverMovedT2L = true;
boolean neverMovedT2R = true;
boolean neverMovedK2 = true;
boolean starting = true; 

//__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
// # You can change this.
int depth0 = 6; //1-7 (1-3 is veeery stupid, from 6 on it will take a while.)
int p = 2; //1: human starts, 2: bot starts
//__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

String[][] chessboard0 = {
  {"T1", "H1", "B1", "K1", "Q1", "B1", "H1", "T1"}, 
  {"P1", "P1", "P1", "P1", "P1", "P1", "P1", "P1"}, 
  {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, 
  {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, 
  {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, 
  {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, 
  {"P2", "P2", "P2", "P2", "P2", "P2", "P2", "P2"}, 
  {"T2", "H2", "B2", "K2", "Q2", "B2", "H2", "T2"}, 
};


void setup() {
  size (720, 720);
  Font1 = createFont("P052-Bold", 20);
  textFont(Font1);
  T1 = loadImage("media/T1.jpg");
  T2 = loadImage("media/T2.jpg");
  H1 = loadImage("media/H1.jpg");
  H2 = loadImage("media/H2.jpg");
  B1 = loadImage("media/B1.png");
  B2 = loadImage("media/B2.png");
  K1 = loadImage("media/K1.png");
  K2 = loadImage("media/K2.png");
  Q1 = loadImage("media/Q1.png");
  Q2 = loadImage("media/Q2.png");
  P1 = loadImage("media/P1.png");
  P2 = loadImage("media/P2.png");
}


void draw() {
  if (gameAlive) {
    int tSize;
    l = width/8;
    whiteWins = true;
    blackWins = true;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (i%2==j%2) {
          fill(255);
          if (j==nowY&&i==nowX&&!flag) fill(240, 230, 140);
          if ((j==prevMoveY&&i==prevMoveX)||(j==dy&&i==dx)) fill(135, 206, 250);
          if (i==checkX&&j==checkY) fill(255, 0, 0);
          rect(i*l, j*l, l, l);
          //fill(255, 0, 0);
          if (chessboard0[j][i] == "P2") image(P2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "T2") image(T2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "H2") image(H2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "B2") image(B2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "K2") {
            image(K2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8); 
            whiteWins = false;
          } else if (chessboard0[j][i] == "Q2") image(Q2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "P1") image(P1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "T1") image(T1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "H1") image(H1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "B1") image(B1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "K1") {
            image(K1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8); 
            blackWins = false;
          } else if (chessboard0[j][i] == "Q1") image(Q1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          //text(chessboard0[j][i], i*l+l/2-tSize/2, j*l+l/2);
        } else {
          fill(0);
          if (j==nowY&&i==nowX&&!flag) fill(240, 230, 140);
          if ((j==prevMoveY&&i==prevMoveX)||(j==dy&&i==dx)) fill(135, 206, 250);
          if (i==checkX&&j==checkY) fill(255, 0, 0);
          rect(i*l, j*l, l, l);
          //fill(255, 0, 0);  
          if (chessboard0[j][i] == "P2") image(P2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "T2") image(T2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "H2") image(H2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "B2") image(B2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "K2") {
            image(K2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8); 
            whiteWins = false;
          } else if (chessboard0[j][i] == "Q2") image(Q2, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "P1") image(P1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "T1") image(T1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "H1") image(H1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "B1") image(B1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          else if (chessboard0[j][i] == "K1") {
            image(K1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8); 
            blackWins = false;
          } else if (chessboard0[j][i] == "Q1") image(Q1, i*l+l*1.5/8, j*l+l/8, l*5/8, l*6/8);
          //text(chessboard0[j][i], i*l+l/2-tSize/2, j*l+l/2);
        }
      }
    }
    if (whiteWins) {
      fill(255, 127, 80);
      tSize =70;
      textSize(tSize);
      text("WHITE WINS!", width/2-tSize*3.5, height/2+tSize/3);
      gameAlive = false;
    } else if (blackWins) {
      fill(255, 127, 80);
      tSize = 70;
      textSize(tSize);
      text("BLACK WINS!", width/2-tSize*3.5, height/2+tSize/3);
      gameAlive = false;
    }
    if (flagLoading&&p==2) {
      fill(255, 0, 0);
      tSize=40;
      textSize(tSize);
      text("LOADING...", width/2-tSize*3, height/2-height/20);
    }
    if (flagCount) count++;
    if (starting) {
      count = delay;
      starting = false;  
    }
    if (count==delay) {
      count = 0;
      flagCount = false;
      if (p == 2) {
        checkX=-1;
        checkY=-1;
        String[][] chessboardNow = new String[8][8];
        for (int i = 0; i < 8; i++)
          for (int j = 0; j < 8; j++)
            chessboardNow[i][j] = chessboard0[i][j];
        minimax(depth0, chessboardNow);
        flagLoading = false;
        if (K1underCheck()) {
          for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
              if (chessboard0[j][i]=="K1") {
                checkX=i; 
                checkY=j;
              }
            }
          }
        }
      }
    }
  }
}

int maxi(int max, int min, int depth, String[][] chessboard1) {
  if ( depth == 0 ) return evaluate(chessboard1);
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (chessboard1[i][j] == "P2") {
        for (int m = -2; m<=2; m++) {
          for (int n = -2; n <=2; n++) {
            if (checkP2(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "P2";
              int score = mini(max, min, depth - 1, chessboard1);

              if (score >= min) {
                chessboard1[i][j] = "P2";
                chessboard1[i+m][j+n] = prev;
                return min;
              }

              if ( score > max ) {
                max = score;
                if (depth == depth0) {
                  previousX = j;
                  previousY = i;
                  dx = j+n;
                  dy = i+m;
                  pieceToMove = "P2";
                }
              } 

              chessboard1[i][j] = "P2";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "T2") {
        for (int m = -7; m<=7; m++) {
          if (checkT2(j, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j] = "T2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "T2";
              chessboard1[i+m][j] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j;
                dy = i+m;
                pieceToMove = "T2";
              }
            }
            chessboard1[i][j] = "T2";
            chessboard1[i+m][j] = prev;
          }
          if (checkT2(j+m, i, j, i, chessboard1)) {
            String prev = chessboard1[i][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i][j+m] = "T2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "T2";
              chessboard1[i][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i;
                pieceToMove = "T2";
              }
            }
            chessboard1[i][j] = "T2";
            chessboard1[i][j+m] = prev;
          }
        }
      } else if (chessboard1[i][j] == "H2") {
        for (int m = -3; m<=3; m++) {
          for (int n = -3; n <=3; n++) {
            if (checkH2(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "H2";
              int score = mini(max, min, depth - 1, chessboard1);
              if (score >= min) {
                chessboard1[i][j] = "H2";
                chessboard1[i+m][j+n] = prev;
                return min;
              }
              if ( score > max ) {
                max = score;
                if (depth == depth0) {

                  previousX = j;
                  previousY = i;
                  dx = j+n;
                  dy = i+m;
                  pieceToMove = "H2";
                }
              }
              chessboard1[i][j] = "H2";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "B2") {
        for (int m = 1; m<=7; m++) {
          if (checkB2(j+m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j+m] = "B2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "B2";
              chessboard1[i+m][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i+m;
                pieceToMove = "B2";
              }
            }
            chessboard1[i][j] = "B2";
            chessboard1[i+m][j+m] = prev;
          }
          if (checkB2(j+m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j+m] = "B2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "B2";
              chessboard1[i-m][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i-m;
                pieceToMove = "B2";
              }
            }
            chessboard1[i][j] = "B2";
            chessboard1[i-m][j+m] = prev;
          }
          if (checkB2(j-m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j-m] = "B2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "B2";
              chessboard1[i+m][j-m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j-m;
                dy = i+m;
                pieceToMove = "B2";
              }
            }
            chessboard1[i][j] = "B2";
            chessboard1[i+m][j-m] = prev;
          }
          if (checkB2(j-m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j-m] = "B2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "B2";
              chessboard1[i-m][j-m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j-m;
                dy = i-m;
                pieceToMove = "B2";
              }
            }
            chessboard1[i][j] = "B2";
            chessboard1[i-m][j-m] = prev;
          }
        }
      } else if (chessboard1[i][j] == "K2") {
        for (int m = -1; m<=1; m++) {
          for (int n = -1; n <=1; n++) {
            if (checkK2(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "K2";
              int score = mini(max, min, depth - 1, chessboard1);
              if (score >= min) {
                chessboard1[i][j] = "K2";
                chessboard1[i+m][j+n] = prev;
                return min;
              }
              if ( score > max ) {
                max = score;
                if (depth == depth0) {
                  previousX = j;
                  previousY = i;
                  dx = j+n;
                  dy = i+m;
                  pieceToMove = "K2";
                }
              }
              chessboard1[i][j] = "K2";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "Q2") {
        for (int m = 1; m<=7; m++) {
          if (checkQ2(j+m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j+m] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i+m][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i+m;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i+m][j+m] = prev;
          }
          if (checkQ2(j-m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j-m] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i+m][j-m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j-m;
                dy = i+m;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i+m][j-m] = prev;
          }
          if (checkQ2(j+m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j+m] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i-m][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i-m;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i-m][j+m] = prev;
          }
          if (checkQ2(j-m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j-m] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i-m][j-m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j-m;
                dy = i-m;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i-m][j-m] = prev;
          }
        }
        for (int m = -7; m<=7; m++) {
          if (checkQ2(j, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i+m][j] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j;
                dy = i+m;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i+m][j] = prev;
          }
          if (checkQ2(j+m, i, j, i, chessboard1)) {
            String prev = chessboard1[i][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i][j+m] = "Q2";
            int score = mini(max, min, depth - 1, chessboard1);
            if (score >= min) {
              chessboard1[i][j] = "Q2";
              chessboard1[i][j+m] = prev;
              return min;
            }
            if ( score > max ) {
              max = score;
              if (depth == depth0) {
                previousX = j;
                previousY = i;
                dx = j+m;
                dy = i;
                pieceToMove = "Q2";
              }
            }
            chessboard1[i][j] = "Q2";
            chessboard1[i][j+m] = prev;
          }
        }
      }
    }
  }
  return max;
}

int mini(int max, int min, int depth, String[][] chessboard1) {
  if ( depth == 0 ) return evaluate(chessboard1);
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (chessboard1[i][j] == "P1") {
        for (int m = -2; m<=2; m++) {
          for (int n = -2; n <=2; n++) {
            if (checkP(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "P1";
              int score = maxi(max, min, depth - 1, chessboard1);
              if (score <= max) {
                chessboard1[i][j] = "P1";
                chessboard1[i+m][j+n] = prev;
                return max;
              }
              if ( score < min ) {
                min = score;
              }
              chessboard1[i][j] = "P1";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "T1") {
        for (int m = -7; m<=7; m++) {
          if (checkT(j, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j] = "T1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "T1";
              chessboard1[i+m][j] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "T1";
            chessboard1[i+m][j] = prev;
          }
          if (checkT(j+m, i, j, i, chessboard1)) {
            String prev = chessboard1[i][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i][j+m] = "T1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "T1";
              chessboard1[i][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "T1";
            chessboard1[i][j+m] = prev;
          }
        }
      } else if (chessboard1[i][j] == "H1") {
        for (int m = -3; m<=3; m++) {
          for (int n = -3; n <=3; n++) {
            if (checkC(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "H1";
              int score = maxi(max, min, depth - 1, chessboard1);
              if (score <= max) {
                chessboard1[i][j] = "H1";
                chessboard1[i+m][j+n] = prev;
                return max;
              }
              if ( score < min ) {
                min = score;
              }
              chessboard1[i][j] = "H1";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "B1") {
        for (int m = 1; m<=7; m++) {
          if (checkA(j+m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j+m] = "B1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "B1";
              chessboard1[i+m][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "B1";
            chessboard1[i+m][j+m] = prev;
          }
          if (checkA(j-m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j-m] = "B1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "B1";
              chessboard1[i+m][j-m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "B1";
            chessboard1[i+m][j-m] = prev;
          }
          if (checkA(j+m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j+m] = "B1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "B1";
              chessboard1[i-m][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "B1";
            chessboard1[i-m][j+m] = prev;
          }
          if (checkA(j-m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j-m] = "B1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "B1";
              chessboard1[i-m][j-m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "B1";
            chessboard1[i-m][j-m] = prev;
          }
        }
      } else if (chessboard1[i][j] == "K1") {
        for (int m = -1; m<=1; m++) {
          for (int n = -1; n <=1; n++) {
            if (checkK(j+n, i+m, j, i, chessboard1)) {
              String prev = chessboard1[i+m][j+n];
              chessboard1[i][j] = "  ";
              chessboard1[i+m][j+n] = "K1";
              int score = maxi(max, min, depth - 1, chessboard1);
              if (score <= max) {
                chessboard1[i][j] = "K1";
                chessboard1[i+m][j+n] = prev;
                return max;
              }
              if ( score < min ) {
                min = score;
              }
              chessboard1[i][j] = "K1";
              chessboard1[i+m][j+n] = prev;
            }
          }
        }
      } else if (chessboard1[i][j] == "Q1") {
        for (int m = 1; m<=7; m++) {
          if (checkA(j+m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j+m] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i+m][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i+m][j+m] = prev;
          }
          if (checkA(j-m, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j-m] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i+m][j-m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i+m][j-m] = prev;
          }
          if (checkA(j+m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j+m] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i-m][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i-m][j+m] = prev;
          }
          if (checkA(j-m, i-m, j, i, chessboard1)) {
            String prev = chessboard1[i-m][j-m];
            chessboard1[i][j] = "  ";
            chessboard1[i-m][j-m] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i-m][j-m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i-m][j-m] = prev;
          }
        }
        for (int m = -7; m<=7; m++) {
          if (checkT(j, i+m, j, i, chessboard1)) {
            String prev = chessboard1[i+m][j];
            chessboard1[i][j] = "  ";
            chessboard1[i+m][j] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i+m][j] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i+m][j] = prev;
          }
          if (checkT(j+m, i, j, i, chessboard1)) {
            String prev = chessboard1[i][j+m];
            chessboard1[i][j] = "  ";
            chessboard1[i][j+m] = "Q1";
            int score = maxi(max, min, depth - 1, chessboard1);
            if (score <= max) {
              chessboard1[i][j] = "Q1";
              chessboard1[i][j+m] = prev;
              return max;
            }
            if ( score < min ) {
              min = score;
            }
            chessboard1[i][j] = "Q1";
            chessboard1[i][j+m] = prev;
          }
        }
      }
    }
  }
  return min;
}

void minimax(int depth, String[][] chessboard1) {
  int f = maxi(-1000000000, 1000000000, depth, chessboard1);
  chessboard0[previousY][previousX] = "  ";
  prevMoveY=previousY;
  prevMoveX=previousX;
  chessboard0[dy][dx] = pieceToMove;
  p = 1;
}

int evaluate(String[][] scacchieraD) {
  int ris = 0;
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (scacchieraD[i][j] == "P2") ris+=2;
      else if (scacchieraD[i][j] == "T2") ris+=5;
      else if (scacchieraD[i][j] == "H2") ris+=4;
      else if (scacchieraD[i][j] == "B2") ris+=4;
      else if (scacchieraD[i][j] == "K2") ris+=10000;
      else if (scacchieraD[i][j] == "Q2") ris+=10;
      else if (scacchieraD[i][j] == "P1") ris-=2;
      else if (scacchieraD[i][j] == "T1") ris-=5;
      else if (scacchieraD[i][j] == "H1") ris-=4;
      else if (scacchieraD[i][j] == "B1") ris-=4;
      else if (scacchieraD[i][j] == "K1") ris-=10000;
      else if (scacchieraD[i][j] == "Q1") ris-=10;
    }
  }
  return ris;
}
boolean checkT(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else if (y == pY) {
    if (x < pX) {
      for (int i = x+1; i < pX; i++) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (x > pX) {
      for (int i = x-1; i > pX; i--) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else return false;
}
boolean checkT2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else if (y == pY) {
    if (x < pX) {
      for (int i = x+1; i < pX; i++) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (x > pX) {
      for (int i = x-1; i > pX; i--) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else return false;
}

boolean checkC(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (abs(y-pY) == 2) {
    if (abs(x-pX) == 1) {
      if (chessboard1[y][x].charAt(1)=='1') return false;
      else return true;
    } else return false;
  } else if (abs(x-pX) == 2) {
    if (abs(y-pY) == 1) {
      if (chessboard1[y][x].charAt(1)=='1') return false;
      else return true;
    } else return false;
  } else return false;
}
boolean checkH2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (abs(y-pY) == 2) {
    if (abs(x-pX) == 1) {
      if (chessboard1[y][x].charAt(1)=='2') return false;
      else return true;
    } else return false;
  } else if (abs(x-pX) == 2) {
    if (abs(y-pY) == 1) {
      if (chessboard1[y][x].charAt(1)=='2') return false;
      else return true;
    } else return false;
  } else return false;
}
boolean checkB2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (pY-pX==y-x) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else if (pY-y==x-pX) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else return false;
}

boolean checkK2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (y==pY&&x==pX) return false;
  if (y-pY<=-1&&y-pY>=1&&x-pX<=-1&&x-pX>=1) {
    if (chessboard1[y][x].charAt(1)!='2') {
      return true;
    } else return false;
  } else if (pX==3&&pY==7&&x==1&&y==7) {
    if (chessboard1[7][0]=="T2"&&chessboard1[7][1]=="  "&&chessboard1[7][2]=="  "&&neverMovedT2L&&neverMovedK2) return true;
    else return false;
  } else if (pX==3&&pY==7&&x==6&&y==7) {
    if (chessboard1[7][7]=="T2"&&chessboard1[7][6]=="  "&&chessboard1[7][5]=="  "&&chessboard1[7][4]=="  "&&neverMovedT2R&&neverMovedK2) return true;
    else return false;
  } else return false;
}

boolean checkQ2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else if (y == pY) {
    if (x < pX) {
      for (int i = x+1; i < pX; i++) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (x > pX) {
      for (int i = x-1; i > pX; i--) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else if (pY-pX==y-x) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else if (pY-y==x-pX) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='2') return false;
      return true;
    } else return false;
  } else return false;
}

boolean checkP2(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y-pY==-2 && (pY == 6)) {
      if (chessboard1[y][x] != "  ") return false;
      else return true;
    } else if (y-pY==-1) {
      if (chessboard1[y][x] != "  ") return false;
      else return true;
    } else return false;
  } else if (x==pX+1) {
    if (y-pY == -1) {
      if (chessboard1[y][x].charAt(1)=='1') return true;
      return false;
    } else return false;
  } else if (x==pX-1) {
    if (y-pY == -1) {
      if (chessboard1[y][x].charAt(1)=='1') return true;
      return false;
    } else return false;
  }

  return false;
}
boolean checkA(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (pY-pX==y-x) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else if (pY-y==x-pX) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else return false;
}

boolean checkK(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (y==pY&&x==pX) return false;
  if (y-pY<=1&&y-pY>=-1&&x-pX<=1&&x-pX>=-1) {
    if (chessboard1[y][x].charAt(1)!='1') {
      return true;
    } else return false;
  } else if (pX==3&&pY==0&&x==1&&y==0) {
    if (chessboard1[0][0]=="T1"&&chessboard1[0][1]=="  "&&chessboard1[0][2]=="  "&&neverMovedT1L&&neverMovedK1) return true;
    else return false;
  } else if (pX==3&&pY==0&&x==6&&y==0) {
    if (chessboard1[0][7]=="T1"&&chessboard1[0][6]=="  "&&chessboard1[0][5]=="  "&&chessboard1[0][4]=="  "&&neverMovedT1R&&neverMovedK1) return true;
    else return false;
  } else return false;
}

boolean checkQ(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][x]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else if (y == pY) {
    if (x < pX) {
      for (int i = x+1; i < pX; i++) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (x > pX) {
      for (int i = x-1; i > pX; i--) {
        if (chessboard1[y][i]!="  ") return false;
      } 
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else if (pY-pX==y-x) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][i-(pY-pX)]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else if (pY-y==x-pX) {
    if (y > pY) {
      for (int i = y-1; i > pY; i--) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else if (y < pY) {
      for (int i = y+1; i < pY; i++) {
        if (chessboard1[i][(pY+pX)-i]!="  ") return false;
      }
      if (chessboard1[y][x].charAt(1)=='1') return false;
      return true;
    } else return false;
  } else return false;
}

boolean checkP(int x, int y, int pX, int pY, String[][] chessboard1) {
  if (x<0||x>7||y<0||y>7) return false;
  if (x==pX) {
    if (y-pY==2 && (pY == 1)) {
      if (chessboard1[y][x] != "  ") return false;
      else return true;
    } else if (y-pY==1) {
      if (chessboard1[y][x] != "  ") return false;
      else return true;
    } else return false;
  } else if (x==pX+1) {
    if (y-pY == 1) {
      if (chessboard1[y][x].charAt(1)=='2') return true;
      return false;
    } else return false;
  } else if (x==pX-1) {
    if (y-pY == 1) {
      if (chessboard1[y][x].charAt(1)=='2') return true;
      return false;
    } else return false;
  }

  return false;
}

boolean K1underCheck() {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (chessboard0[j][i] == "P2") {
        if (j-1>=0&&i-1>=0&&chessboard0[j-1][i-1]=="K1")
          return true;
        if (j-1>=0&&i+1<8&&chessboard0[j-1][i+1]=="K1")
          return true;
      }
      if (chessboard0[j][i] == "T2") {
        for (int k = 1; k < 8; k++) {
          if (i+k>7) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K1") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (j+k>7) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K1") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (i+k<0) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K1") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (j+k<0) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K1") return true;
            break;
          }
        }
      }
      if (chessboard0[j][i]=="H2") {
        int[] sup1 = {1, 2, 2, 1, -1, -2, -2, -1};
        int[] sup2 = {2, 1, -1, -2, -2, -1, 1, 2};
        for (int k = 0; k < 8; k++) {
          if (i+sup1[k]>=0&&i+sup1[k]<8&&j+sup2[k]>=0&&j+sup2[k]<8) {
            if (chessboard0[j+sup2[k]][i+sup1[k]]=="K1") return true;
          }
        }
      }
      if (chessboard0[j][i]=="B2") {
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j+k<8) {
            if (chessboard0[j+k][i+k]!="  ") {
              if (chessboard0[j+k][i+k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j+k<8) {
            if (chessboard0[j+k][i-k]!="  ") {
              if (chessboard0[j+k][i-k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j-k>=0) {
            if (chessboard0[j-k][i+k]!="  ") {
              if (chessboard0[j-k][i+k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j-k>=0) {
            if (chessboard0[j-k][i-k]!="  ") {
              if (chessboard0[j-k][i-k]=="K1") return true;
              break;
            }
          } else break;
        }
      }
      if (chessboard0[j][i]=="K2") {
        for (int k1 = -1; k1 < 2; k1++) {
          for (int k2 = -1; k2 < 2; k2++) {
            if (j+k1<8&j-k1>=0&&i+k2<8&&j-k2>=0)
              if (chessboard0[j+k1][i+k2]=="K1") return true;
          }
        }
      }
      if (chessboard0[j][i]=="Q2") {
        for (int k = 1; k < 8; k++) {
          if (i+k>7) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K1") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (j+k>7) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K1") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (i+k<0) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K1") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (j+k<0) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K1") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j+k<8) {
            if (chessboard0[j+k][i+k]!="  ") {
              if (chessboard0[j+k][i+k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j+k<8) {
            if (chessboard0[j+k][i-k]!="  ") {
              if (chessboard0[j+k][i-k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j-k>=0) {
            if (chessboard0[j-k][i+k]!="  ") {
              if (chessboard0[j-k][i+k]=="K1") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j-k>=0) {
            if (chessboard0[j-k][i-k]!="  ") {
              if (chessboard0[j-k][i-k]=="K1") return true;
              break;
            }
          } else break;
        }
      }
    }
  }
  return false;
}

boolean K2underCheck() {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (chessboard0[j][i] == "P1") {
        if (j+1<8&&i-1>=0&&chessboard0[j+1][i-1]=="K2")
          return true;
        if (j+1>=0&&i+1<8&&chessboard0[j+1][i+1]=="K2")
          return true;
      }
      if (chessboard0[j][i] == "T1") {
        for (int k = 1; k < 8; k++) {
          if (i+k>7) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K2") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (j+k>7) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K2") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (i+k<0) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K2") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (j+k<0) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K2") return true;
            break;
          }
        }
      }
      if (chessboard0[j][i]=="H1") {
        int[] sup1 = {1, 2, 2, 1, -1, -2, -2, -1};
        int[] sup2 = {2, 1, -1, -2, -2, -1, 1, 2};
        for (int k = 0; k < 8; k++) {
          if (i+sup1[k]>=0&&i+sup1[k]<8&&j+sup2[k]>=0&&j+sup2[k]<8) {
            if (chessboard0[j+sup2[k]][i+sup1[k]]=="K2") return true;
          }
        }
      }
      if (chessboard0[j][i]=="B1") {
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j+k<8) {
            if (chessboard0[j+k][i+k]!="  ") {
              if (chessboard0[j+k][i+k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j+k<8) {
            if (chessboard0[j+k][i-k]!="  ") {
              if (chessboard0[j+k][i-k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j-k>=0) {
            if (chessboard0[j-k][i+k]!="  ") {
              if (chessboard0[j-k][i+k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j-k>=0) {
            if (chessboard0[j-k][i-k]!="  ") {
              if (chessboard0[j-k][i-k]=="K2") return true;
              break;
            }
          } else break;
        }
      }
      if (chessboard0[j][i]=="K1") {
        for (int k1 = -1; k1 < 2; k1++) {
          for (int k2 = -1; k2 < 2; k2++) {
            if (j+k1<8&j+k1>=0&&i+k2<8&&j+k2>=0)
              if (chessboard0[j+k1][i+k2]=="K2") return true;
          }
        }
      }
      if (chessboard0[j][i]=="Q1") {
        for (int k = 1; k < 8; k++) {
          if (i+k>7) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K2") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (j+k>7) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K2") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (i+k<0) break;
          if (chessboard0[j][i+k]!="  ") {
            if (chessboard0[j][i+k]=="K2") return true;
            break;
          }
        }
        for (int k = -1; k > -8; k--) {
          if (j+k<0) break;
          if (chessboard0[j+k][i]!="  ") {
            if (chessboard0[j+k][i]=="K2") return true;
            break;
          }
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j+k<8) {
            if (chessboard0[j+k][i+k]!="  ") {
              if (chessboard0[j+k][i+k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j+k<8) {
            if (chessboard0[j+k][i-k]!="  ") {
              if (chessboard0[j+k][i-k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i+k<8&&j-k>=0) {
            if (chessboard0[j-k][i+k]!="  ") {
              if (chessboard0[j-k][i+k]=="K2") return true;
              break;
            }
          } else break;
        }
        for (int k = 1; k < 8; k++) {
          if (i-k>=0&&j-k>=0) {
            if (chessboard0[j-k][i-k]!="  ") {
              if (chessboard0[j-k][i-k]=="K2") return true;
              break;
            }
          } else break;
        }
      }
    }
  }
  return false;
}

void mouseClicked() {
  if (gameAlive) {
    if (p == 1) {
      if (flag) {
        pX = mouseX/l;
        pY = mouseY/l;
        if (chessboard0[mouseY/l][mouseX/l].charAt(1)=='1') {
          nowX = pX;
          nowY = pY;
          piece = chessboard0[mouseY/l][mouseX/l];
          flag = false;
        }
      } else {

        flagCount = true;
        flagLoading = true;
        if (mouseX/l == pX && mouseY/l == pY) {
          flag = true;
          flagLoading = false;
        } else {
          checkX=-1;
          checkY=-1;
          if (piece=="T1") {
            if (checkT(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "T1";
              flag = true;
              p=2;
            }
          } else if (piece=="H1") {
            if (checkC(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "H1";
              flag = true;

              p=2;
            }
          } else if (piece=="B1") {
            if (checkA(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "B1";
              flag = true;

              p=2;
            }
          } else if (piece=="K1") {
            if (checkK(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "K1";
              if (pX==3&&pY==0&&mouseX/l==1&&mouseY/l==0) {
                chessboard0[pY][pX] = "  ";
                chessboard0[mouseY/l][mouseX/l] = "K1";
                chessboard0[0][2] = "T1";
                chessboard0[0][0] = "  ";
              } else if (pX==3&&pY==0&&mouseX/l==6&&mouseY/l==0) {
                chessboard0[pY][pX] = "  ";
                chessboard0[mouseY/l][mouseX/l] = "K1";
                chessboard0[0][5] = "T1";
                chessboard0[0][7] = "  ";
              }
              flag = true;

              p=2;
            }
          } else if (piece=="Q1") {
            if (checkQ(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "Q1";
              flag = true;

              p=2;
            }
          } else if (piece=="P1") {
            if (checkP(mouseX/l, mouseY/l, pX, pY, chessboard0)) {
              chessboard0[pY][pX] = "  ";
              chessboard0[mouseY/l][mouseX/l] = "P1";
              flag = true;
              p=2;
            }
          }

          if (K2underCheck()) {
            println("a");
            for (int i = 0; i < 8; i++) {
              for (int j = 0; j < 8; j++) {
                if (chessboard0[j][i]=="K2") {
                  checkX=i; 
                  checkY=j;
                }
              }
            }
          }
        }
      }
    }
  }
}
