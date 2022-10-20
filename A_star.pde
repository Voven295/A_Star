int sizeCell = 30;
int colls, rows;
Node[][] grid;
Node start, end;

ArrayList<Node> openSet = new ArrayList(); 
ArrayList<Node> closedSet = new ArrayList();
boolean isEndPath = false;


Visualization visual = new Visualization();

enum Designation {
  startPoint, endPoint, wall;
}

Designation desigantionPoint;

void setup() { 
  size(1024, 1024);
  //fullScreen();
  strokeWeight(3);
  cursor(CROSS);
  rows = width / sizeCell;
  colls = height / sizeCell;
  grid = new Node[rows][colls];
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < colls; j++)
    {
      grid[i][j] = new Node(i * sizeCell, j * sizeCell);
    }
  }
  desigantionPoint = Designation.startPoint;
}


void draw()
{
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < colls; j++)
    {
      visual.show(i * sizeCell, j * sizeCell, sizeCell, color(255));
      visual.drawPointsAndWalls(i, j);
    }
  }

  if (desigantionPoint == Designation.wall && key == ENTER)
    pathFinder();

  if (isEndPath)
    visual.retracePath();

    visual.clearGrid();
}

void pathFinder() 
{
  frameRate(30);
  
  if (!isEndPath) {
    Node current = openSet.get(0); 
    for (int i = 1; i < openSet.size(); i++) {
      if (openSet.get(i).fCost() < current.fCost() || (openSet.get(i).fCost() == current.fCost() && openSet.get(i).hCost < current.hCost)) {
        current = openSet.get(i);
      }
    }

    openSet.remove(current); 
    closedSet.add(current); 

    if (current == end)
    { 
      isEndPath = true;
      return;
    }

    for (Node neighbour : getNeighbors(current))
    {
      if (!neighbour.isWalkable || closedSet.contains(neighbour))
      {
        continue;
      }
      int movementCostToNeighbour = current.gCost + getDistance(current, neighbour); 

      if (movementCostToNeighbour < neighbour.gCost || !openSet.contains(neighbour)) {
        neighbour.gCost = movementCostToNeighbour; 
        neighbour.hCost = getDistance(neighbour, end); 
        neighbour.parent = current; 
        if (!openSet.contains(neighbour)) {
          openSet.add(neighbour);
        }
      }
    }
  }
  for (int i = 0; i < openSet.size(); i++)
  {
    if (openSet.get(i) != start && openSet.get(i) != end)
      visual.show(openSet.get(i).x, openSet.get(i).y, sizeCell, color(255, 51, 153));
  }
  for (int j = 0; j < closedSet.size(); j++)
  {
    if (closedSet.get(j) != start && closedSet.get(j) != end)
      visual.show(closedSet.get(j).x, closedSet.get(j).y, sizeCell, color(51, 51, 102));
  }
}



ArrayList<Node> getNeighbors(Node current)
{
  ArrayList<Node> neighbors = new ArrayList(); 

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) continue; 
      if (current.x / sizeCell + i >= 0 && current.x / sizeCell + i < rows && current.y / sizeCell + j >= 0 && current.y / sizeCell + j < colls) {
        Node neighbour = grid[current.x / sizeCell + i][current.y / sizeCell + j]; 
        neighbors.add(neighbour);
      }
    }
  }
  return neighbors;
}

int getDistance(Node a, Node b) {
  int dx = abs(a.x - b.x); 
  int dy = abs(a.y - b.y); 
  int remaining = abs(dx - dy); 
  return 14 * min(dx, dy) + 10 * remaining;
}

//i != 0 && (j == -1 || j == 1) or (i != 0 && j != 0) delete diagonals
