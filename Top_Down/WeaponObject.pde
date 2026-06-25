class WeaponObject{
  int size;
  PVector LocationW = new PVector(); 
  PImage skin;
  int sizex;
  int sizey;
  WeaponData weapon;
  WeaponObject(float x , float y, int size, int sizex, int sizey, WeaponData weapon, PImage skin)
  {
    this.size = size;
    this.LocationW.x = x;
    this.LocationW.y = y;
    this.weapon = weapon;
    this.sizex = sizex;
    this.sizey = sizey;
    this.skin = skin;
  }
  void display() 
  {
    fill(0);
    image(skin, LocationW.x, LocationW.y, sizex, sizey);
  }
  
}
