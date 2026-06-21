class WeaponObject{
  int size;
  PVector LocationW = new PVector(); 
  int sizex;
  int sizey;
  WeaponData weapon;
  WeaponObject(float x , float y, int size, int sizex, int sizey, WeaponData weapon)
  {
    this.size = size;
    this.LocationW.x = x;
    this.LocationW.y = y;
    this.weapon = weapon;
    this.sizex = sizex;
    this.sizey = sizey;
  }
  void display() 
  {
    fill(0);
    rect(LocationW.x, LocationW.y, sizex, sizey);
  }
  
}
