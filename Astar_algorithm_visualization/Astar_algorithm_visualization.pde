int nX, nY;
int gridLineStroke = 3;
int grid[][];
boolean safe[][];
boolean obstac[][];
int distFromStart[][];
int distFromEnd[][];
int step = 0;
PVector current = new PVector();
boolean end = false;
boolean canPlaceObstacles = true;
//___________________________________________________________________________________________________________________________________________________________________________________________________
//PLACE OBSTACLES WITH LEFT CLICK, EXPAND THE PATHFINDER WITH SPACEBAR. YOU CAN PLACE OBSTACLES ONLY BEFORE YOU START THE PATHFINDER.
//The dimension of a square is approximated to 10 meters x 10 meters. Its diagonal is approximated to 14 meters.
//Heuristic estimate uses Pythagorean theorem in order to approximate the distance left.
//___________________________________________________________________________________________________________________________________________________________________________________________________
//YOU CAN CHANGE THESE.
int l = 100;     //  l MUST divide both width and height, or program will close. Width and Height are into the size(w, h) function, in {void setup()}.
PVector start = new PVector(1, 2);   //  choose starting box coords. 
PVector done = new PVector(-1, -1);    //  choose end box coords. Copy start coords or put (-1, -1) for random.
//___________________________________________________________________________________________________________________________________________________________________________________________________


void setup() {
  size(900, 1000);
  nY = height/l;
  nX = width/l;
  while ((done.x == -1 && done.y == -1) || (done.x == start.x && done.y == start.y)) {
    done.x = int(random(nX)); 
    done.y = int(random(nY));
  }
  if (width%l != 0 || height%l != 0) {
    println("L MUST DIVIDE BOTH WIDTH AND HEIGHT.");
    System.exit(0);
  }
  grid = new int[nX][nY];
  distFromStart = new int[nX][nY];
  distFromEnd = new int[nX][nY];
  safe = new boolean[nX][nY];
  obstac = new boolean[nX][nY];

  //grid:   -3 = never visited,   -1 = start,   -2 = done,   ELSE = DistStart + DistEnd

  for (int i = 0; i < nX; i++)
    for (int j = 0; j < nY; j++)
      grid[i][j] = -3;


  for (int i = 0; i < nX; i++)
    for (int j = 0; j < nY; j++)
      distFromEnd[i][j] = calcDistFromEnd((int)i, (int)j);  

  for (int i = 0; i < nX; i++)
    for (int j = 0; j < nY; j++)
      safe[i][j] = false;

  for (int i = 0; i < nX; i++)
    for (int j = 0; j < nY; j++)
      obstac[i][j] = false;

  safe[(int)start.x][(int)start.y] = true;
  distFromStart[(int)start.x][(int)start.y] = 0;
  distFromEnd[(int)done.x][(int)done.y] = 0;
  grid[(int)start.x][(int)start.y] = -1;
  grid[(int)done.x][(int)done.y] = -2;

  println("Horizontal boxes: " + nX);
  println("Vertical boxes: " + nY);
  println();
  println("Total boxes: " + nX*nY);
  println();

  current = new PVector(start.x, start.y);
}


void draw() {
  background(255);

  //---------------------------------------------------------------------------------------------------------
  //grid DRAW

  stroke(0);
  strokeWeight(gridLineStroke);
  for (int i = 1; i <= nX-1; i++) {
    line(i*l, 0, i*l, height);
  }
  for (int i = 1; i <= nY-1; i++) {
    line(0, i*l, width, i*l);
  }

  //---------------------------------------------------------------------------------------------------------
  //grid SETUP
  noStroke();

  for (int i = 0; i < nX; i++) {
    for (int j = 0; j < nY; j++) {
      if (grid[i][j] == -1) {                              //  start
        fill(51, 221, 255);  
        rect(i*l+gridLineStroke/2, j*l+gridLineStroke/2, l-gridLineStroke/2, l-gridLineStroke/2); 
        fill(0);
        textSize(40*l/100);
        text('P', i*l+(l*4)/10, j*l+(l*6)/10);
        textSize(20*l/100);
        text(distFromStart[i][j], i*l+l/10, j*l+(l*9)/10);
        text(distFromEnd[i][j], i*l+(l*8)/15, j*l+(l*9)/10);
      } else if (i == done.x && j == done.y) {                        //  done
        fill(191, 128, 255); 
        rect(i*l+gridLineStroke/2, j*l+gridLineStroke/2, l-gridLineStroke/2, l-gridLineStroke/2);
        fill(0);
        textSize(40*l/100);
        text('A', i*l+(l*4)/10, j*l+(l*6)/10);
        textSize(20*l/100);
        text(distFromEnd[(int)start.x][(int)start.y], i*l+l/10, j*l+(l*9)/10);
        text(distFromEnd[i][j], i*l+(l*8)/15, j*l+(l*9)/10);
      } else if (safe[i][j]) {                                    //  safe  
        fill(255, 0, 0);
        rect(i*l+gridLineStroke/2, j*l+gridLineStroke/2, l-gridLineStroke/2, l-gridLineStroke/2);
        fill(0);
        textSize(40*l/100);
        text(distFromStart[i][j]+distFromEnd[i][j], i*l+(l*2)/10, j*l+(l*6)/10);
        textSize(20*l/100);
        text(distFromStart[i][j], i*l+l/15, j*l+(l*9)/10);
        text(distFromEnd[i][j], i*l+(l*5)/10, j*l+(l*9)/10);
      } else if (obstac[i][j]) {                                   //  (obstacles)
        fill(0);
        rect(i*l+gridLineStroke/2, j*l+gridLineStroke/2, l-gridLineStroke/2, l-gridLineStroke/2);
      } else if (grid[i][j] > 0) {                                
        fill(0, 255, 0);
        rect(i*l+gridLineStroke/2, j*l+gridLineStroke/2, l-gridLineStroke/2, l-gridLineStroke/2);
        fill(0);
        textSize(40*l/100);
        text(distFromStart[i][j]+distFromEnd[i][j], i*l+(l*2)/10, j*l+(l*6)/10);
        textSize(20*l/100);
        text(distFromStart[i][j], i*l+l/15, j*l+(l*9)/10);
        text(distFromEnd[i][j], i*l+(l*5)/10, j*l+(l*9)/10);
      }
    }
  }
}


int calcDistFromEnd(int x, int y) {
  return (int)(sqrt((x-(int)done.x)*(x-(int)done.x)+(y-(int)done.y)*(y-(int)done.y))*10);  //pythagoras approx
}

void updateCloseBoxes(int x, int y) {
  if (x+1 < nX && y+1 < nY && !obstac[x+1][y+1] && (grid[x+1][y+1] <= -2 || grid[x+1][y+1] > (distFromStart[x][y] + 14 + distFromEnd[x+1][y+1]) )) {
    grid[x+1][y+1] = (distFromStart[x][y] + 14 + distFromEnd[x+1][y+1]);
    distFromStart[x+1][y+1] = distFromStart[x][y] + 14;
  }
  if (y+1 < nY && !obstac[x][y+1] && (grid[x][y+1] <= -2 || grid[x][y+1] > (distFromStart[x][y] + 10 + distFromEnd[x][y+1]) )) {
    grid[x][y+1] = (distFromStart[x][y] + 10 + distFromEnd[x][y+1]);
    distFromStart[x][y+1] = distFromStart[x][y] + 10;
  }
  if (x-1 >= 0 && y+1 < nY && !obstac[x-1][y+1] && (grid[x-1][y+1] <= -2 || grid[x-1][y+1] > (distFromStart[x][y] + 14 + distFromEnd[x-1][y+1]) )) {
    grid[x-1][y+1] = (distFromStart[x][y] + 14 + distFromEnd[x-1][y+1]);
    distFromStart[x-1][y+1] = distFromStart[x][y] + 14;
  }
  if (x-1 >= 0 && !obstac[x-1][y] && (grid[x-1][y] <= -2 || grid[x-1][y] > (distFromStart[x][y] + 10 + distFromEnd[x-1][y]) )) {
    grid[x-1][y] = (distFromStart[x][y] + 10 + distFromEnd[x-1][y]);
    distFromStart[x-1][y] = distFromStart[x][y] + 10;
  }
  if (x-1 >= 0 && y-1 >= 0 && !obstac[x-1][y-1] && (grid[x-1][y-1] <= -2 || grid[x-1][y-1] > (distFromStart[x][y] + 14 + distFromEnd[x-1][y-1]) )) {
    grid[x-1][y-1] = (distFromStart[x][y] + 14 + distFromEnd[x-1][y-1]);
    distFromStart[x-1][y-1] = distFromStart[x][y] + 14;
  }
  if (y-1 >= 0 && !obstac[x][y-1] && (grid[x][y-1] <= -2 || grid[x][y-1] > (distFromStart[x][y] + 10 + distFromEnd[x][y-1]) )) {
    grid[x][y-1] = (distFromStart[x][y] + 10 + distFromEnd[x][y-1]);
    distFromStart[x][y-1] = distFromStart[x][y] + 10;
  }
  if (x+1 < nX && y-1 > 0 && !obstac[x+1][y-1] && (grid[x+1][y-1] <= -2 || grid[x+1][y-1] > (distFromStart[x][y] + 14 + distFromEnd[x+1][y-1]) )) {
    grid[x+1][y-1] = (distFromStart[x][y] + 14 + distFromEnd[x+1][y-1]);
    distFromStart[x+1][y-1] = distFromStart[x][y] + 14;
  }
  if (x+1 < nX && !obstac[x+1][y] && (grid[x+1][y] <= -2 || grid[x+1][y] > (distFromStart[x][y] + 10 + distFromEnd[x+1][y]) )) {
    grid[x+1][y] = (distFromStart[x][y] + 10 + distFromEnd[x+1][y]);
    distFromStart[x+1][y] = distFromStart[x][y] + 10;
  }
}


void keyPressed() {
  if (key==' ') {
    if (step == 0) println("Start.");
    canPlaceObstacles = false;
    if (!end) {
      step++;
      int min = MAX_INT;
      int indexI = -1;
      int indexJ = -1;
      updateCloseBoxes((int)current.x, (int)current.y);
      for (int i = 0; i < nX; i++)
        for (int j = 0; j < nY; j++)
          if (grid[i][j] > 0 && grid[i][j] <= min && !safe[i][j]) {
            min = grid[i][j];
            indexI = i;
            indexJ = j;
          }

      safe[indexI][indexJ] = true;
      current.x = indexI;
      current.y = indexJ;

      println(step);
      if (current.x == done.x && current.y == done.y) {
        println("Done.");
        end = true;
        println("Solution found in " + step + " steps.");
        println(str(grid[(int)done.x][(int)done.y]) + " 'meters' are needed to reach the end.");
      }
    }
  }
}

void mouseDragged() {
  if (canPlaceObstacles) {
    int osX, osY;
    osX = mouseX/l;
    osY = mouseY/l;
    obstac[osX][osY] = true;
  }
}
