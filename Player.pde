class Enemy
{
  int expvalue = 10;
  int damage = 0;
  int speed = 2;
  int size = 30;
  float maxHP = 0;
  float curHP = 0;
  PVector LocationE = new PVector(random(0, 1000), random(0, 1000));
  
  Enemy(float HP, int size, int speed, int expvalue, int damage)
  {
    this.maxHP = HP;
    this.curHP = HP;
    this.size = size;
    this.speed = speed;
    this.expvalue = expvalue;
    this.damage = damage;
  }
  
  boolean isDead()
  {
    return curHP <= 0;
  }
  
  void display()
  {
    noStroke(); 
    
    fill(0);
    circle(LocationE.x, LocationE.y, size);
  }
  
  void eHP()
  {
    //max hp
    fill(255, 0, 0);
    rect(e.LocationE.x - 25  , (e.LocationE.y - size/2) - 15 , 50, 10);
  
    //current hp
    fill(0, 200, 0);
    rect(e.LocationE.x - 25 , (e.LocationE.y - size/2) - 15 , 50 * (curHP / maxHP) , 10);
  }
  
  void movement()
  {
    // movement
    float dx = p.LocationP.x - LocationE.x;
    float dy = p.LocationP.y - LocationE.y;
    float distance = sqrt(dx * dx + dy * dy);
    if (distance > 0)
    {
      LocationE.x += (dx / distance) * speed;
      LocationE.y += (dy / distance) * speed;
    }
    
    for (int i = 0; i < Enemys.size(); i++)
    {
      Enemy other = Enemys.get(i);
      if (other == this) continue;  // sich selbst überspringen
      
      float ex = LocationE.x - other.LocationE.x;  // abstand zu anderem Enemy
      float ey = LocationE.y - other.LocationE.y;
      float d = sqrt(ex * ex + ey * ey);
      
      if (d < 40 && d > 0)  
      {
        LocationE.x += (ex / d) * 2;  //abstand
        LocationE.y += (ey / d) * 2;
      }
    }
  }
}
