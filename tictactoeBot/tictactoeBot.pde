//________________________________________________________________________________________________________________________________________________________________________________________________________________________
// # YOU CAN CHANGE THESE.
int cols = 3; //I mean, this also works with other settings, but i don't think a standard computer will be able to work with a 4x4 grid or more. Maybe i should try to optimize something.
int p = 2; //P = 1 : You begin, P = 2 : Bot begins
//________________________________________________________________________________________________________________________________________________________________________________________________________________________

int rows = cols;
int l;
int dX=-1, dY=-1;
char[][] grid;
boolean[][] taken;

void setup() {
  size(600, 600);  
  l=width/cols;
  textAlign(CENTER);
  grid = new char[cols][rows];
  taken = new boolean[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j]=' ';
      taken[i][j]=false;
    }
  }
  
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(255);
      rect(i*l, j*l, l, l);
      fill(0);
      textSize(l/4);
      text(grid[i][j], i*l+l/2, j*l+l/2);
    }
  }
  if (p==2)
  {
    minimax(grid);
    if (winner(grid, 'O')) {
      text('O', dX*l+l/2, dY*l+l/2);
      fill(255, 0, 0);
      text("P2 WINS", width/2, height/2-l/5);
      frameRate(0);
    } else if (tie(grid)) {
      text('O', dX*l+l/2, dY*l+l/2);
      fill(255, 0, 0);
      text("DRAW", width/2, height/2-l/5);
      frameRate(0);
    }
    p=1;
  }
}

void mouseClicked() {
  int x = mouseX/l, y = mouseY/l;
  textAlign(CENTER);
  textSize(l/3);
  if (p==1&&!taken[x][y])
  {
    grid[x][y] = 'X';
    taken[x][y] = true;
    p = 2;
    if (winner(grid, 'X'))
    {
      draw();
      fill(255, 0, 0);
      textSize(l/3);
      text("P1 WINS", width/2, height/2-l/5);
      frameRate(0);
    } else if (tie(grid)) {
      draw();
      fill(255, 0, 0);
      text("DRAW", width/2, height/2-l/5);
      frameRate(0);
    }
  }
}

boolean winner(char[][] grid, char player) {
  for (int i=0; i<cols; i++)
  {
    for (int j=0; j<rows; j++)
    {
      if (grid[i][j]==player)
      {
        for (int k=1; k<3; k++)
        {
          if (j+k<rows)
          {
            if (grid[i][j+k]!=player)
              break;
            else if (k==2)
              return true;
          } else
            break;
        }
        for (int k=1; k<3; k++)
        {
          if (i+k<cols)
          {
            if (grid[i+k][j]!=player)
              break;
            else if (k==2)
              return true;
          } else 
          break;
        }
        for (int k=1; k<3; k++)
        {
          if (i+k<cols&&j+k<rows)
          {
            if (grid[i+k][j+k]!=player)
              break;
            else if (k==2)
              return true;
          } else
            break;
        }
        for (int k=1; k<3; k++)
        {
          if (i+k<cols&&j-k>=0)
          {
            if (grid[i+k][j-k]!=player)
              break;
            else if (k==2)
              return true;
          } else
            break;
        }
      }
    }
  }
  return false;
}

boolean tie(char[][] grid) {
  if (!winner(grid, 'O')&&!winner(grid, 'X')) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (grid[i][j]==' ') return false;
      }
    } 
    return true;
  } else return false;
}

void minimax(char[][] grid1) {
  int max = -100000;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid1[i][j]==' ') {
        grid1[i][j]='O';
        int score=mini(grid1);
        grid1[i][j]=' ';
        if (score > max) {
          max = score;
          dX = i;
          dY = j;
        }
      }
    }
  }
  grid[dX][dY]='O';
  taken[dX][dY] = true;
}

int maxi(char[][] grid) {
  int max = -100000;
  if (winner(grid, 'O')) return 1;
  else if (winner(grid, 'X')) return -1;
  else if (tie(grid)) return 0;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j]==' ') {
        grid[i][j]='O';
        int score=mini(grid);
        grid[i][j]=' ';
        if (score > max) max=score;
      }
    }
  }
  return max;
}

int mini(char[][] grid) {
  int min = 100000;
  if (winner(grid, 'O')) return 1;
  else if (winner(grid, 'X')) return -1;
  else if (tie(grid)) return 0;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j]==' ') {
        grid[i][j]='X';
        int score=maxi(grid);
        grid[i][j]=' ';
        if (score < min) min=score;
      }
    }
  }
  return min;
}
