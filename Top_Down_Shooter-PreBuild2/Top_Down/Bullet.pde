class Bullet
{
  float x, y;
  float speed;
  float dx, dy;
  int size;
  int type;

  public Bullet(float x, float y, float dx, float dy, float speed, int size, int type)
{
  this.x = x;
  this.y = y;
  this.dx = dx;
  this.dy = dy;
  this.speed = speed;
  this.size = size;
  this.type = type;
}

  void display()
  {
    fill(0);
    stroke(10);
    circle(x, y, size);
    noStroke();
    noFill();
  }

  void movement()
  {
    x += dx * speed;
    y += dy * speed;
  }
}
