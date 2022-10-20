class Node
{
  int x, y;
  Node(int _x, int _y)
  {
    x = _x;
    y = _y;
  }

  boolean isWalkable = true;
  Node parent;
  int gCost, hCost;

  int fCost() {
    return gCost + hCost;
  }
}
