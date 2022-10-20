
class Visualization {
  void show(int x, int y, int w, color col) {
    if (grid[x/w][y/w].isWalkable)
      fill(col); 
    else fill(0);
    rect(x, y, w, w);
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w) {
      fill(99, 
        99, 99);
      rect(x, y, w, w);
    }
  }

  void clearGrid()
  {
    if (key == 'd' && keyPressed)
    {
      for (int i = 0; i < rows; i++)
      {
        for (int j = 0; j < colls; j++)
        {
          grid[i][j].isWalkable = true;
        }
      }
      start = null;
      end = null;
      desigantionPoint = Designation.startPoint;
      isEndPath = false;
      openSet.clear();
      closedSet.clear();
    }
  }

  void retracePath() {
    Node current = end.parent;
    while (current != start) {
      pushMatrix();
      fill(204, 204, 255);
      rect(current.x, current.y, sizeCell, sizeCell);
      popMatrix();
      current = current.parent;
    }
  }

  void drawNeighbour(Node neighbour)
  {
    pushMatrix();
    fill(30, 61, 89);
    rect(neighbour.x, neighbour.y, sizeCell, sizeCell);
    popMatrix();
  }

  void drawPointsAndWalls(int i, int j) {

    int x = i * sizeCell;
    int y = j * sizeCell;

    if (mouseX > x && mouseX < x + sizeCell && mouseY > y && mouseY < y + sizeCell) {
      if (mousePressed && desigantionPoint == Designation.startPoint)
      {               
        start = grid[i][j];
        openSet.add(start);
      } else if (mousePressed && desigantionPoint == Designation.endPoint) 
      {
        end = grid[i][j];
      } else if (mousePressed && desigantionPoint == Designation.wall && grid[i][j] != start && grid[i][j] != end && grid[i][j].isWalkable)
      {
        grid[i][j].isWalkable = false;
      } else if (!grid[i][j].isWalkable && keyPressed && key == 'c') 
        grid[i][j].isWalkable = true;
    }

    if (start != null) {
      pushMatrix();
      fill(0, 255, 153);
      rect(start.x, start.y, sizeCell, sizeCell);
      popMatrix();
      desigantionPoint = Designation.endPoint;
    }

    if (end != null && end != start) {
      pushMatrix();
      fill(255, 51, 0);
      rect(end.x, end.y, sizeCell, sizeCell);
      popMatrix();
      desigantionPoint = Designation.wall;
    }
  }
}
