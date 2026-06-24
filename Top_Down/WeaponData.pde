class WeaponData {
  //image fehlt
  int type;
  int damage;
  int cooldown;
  int spread;
  int speed;
  int count;
  int size;

  WeaponData(int damage, int cooldown, int spread, int speed, int count, int size, int type) {
    this.damage = damage;
    this.cooldown = cooldown;
    this.spread = spread;
    this.speed = speed;
    this.count = count;
    this.size = size;
    this.type = type;
  }
}
