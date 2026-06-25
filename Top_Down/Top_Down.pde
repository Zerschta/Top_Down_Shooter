boolean up, down, left, right, pickup, drop;
int lastShot = 0;
int cooldown = 0;

boolean leftHeld = false;

int Color = 255;
int Color2 = 255;

boolean GameActive = true;


Bullet current;
WeaponObject currentw;
WeaponData currentData;

boolean ActiveWeapon = false;

public Player p;
public Enemy e;
public WeaponObject W;


PImage pistol;
PImage shotgu;
PImage rocketlauncher;
PImage snipe;

// damage, cooldown, spread, speed, count, size, type

WeaponData pistole = new WeaponData(60, 200, 0, 20, 1, 6, 0);
WeaponData shotgun = new WeaponData(40, 500, 20, 12, 5, 4, 1);
WeaponData rocket = new WeaponData(50, 3000, 0, 10, 1, 25, 2);
WeaponData sniper = new WeaponData(200, 1000, 0, 25, 1, 2, 3);

final int PISTOL = 0;
final int SHOTGUN = 1;
final int ROCKET = 2;
final int SNIPER = 3;

public ArrayList<Enemy> Enemys = new ArrayList<Enemy>();
public ArrayList<Bullet> bullets = new ArrayList<>();
public ArrayList<WeaponObject> groundGuns = new ArrayList<>();
public ArrayList<WeaponData> PlayerInv = new ArrayList<>();

void setup()
{
  pistol = loadImage("Pistol.png");
  shotgu = loadImage("shotgun.png");
  rocketlauncher = loadImage("rocket.png");
  snipe = loadImage("sniper.png");

  //WeaponData pistole = new WeaponData(10, 200, 0, 15, 1, 5);
  groundGuns.add(new WeaponObject(200, 300, 20, 40, 40, pistole, pistol));

  //WeaponData shotgun = new WeaponData(5, 500, 30, 12, 5, 4);
  groundGuns.add(new WeaponObject(400, 300, 20, 40, 40, shotgun, shotgu));

  groundGuns.add(new WeaponObject(600, 300, 20, 50, 40, rocket, rocketlauncher));

  groundGuns.add(new WeaponObject(800, 300, 20, 60, 40, sniper , snipe));

  size(900, 900);
  p = new Player();

  /*Enemy p = new Enemy(200, 50, 1, 30, 90);
   Enemys.add(p);
   while (Enemys.size() <= waves)
   {
   e = new Enemy(30, 30, 2, 10, 10);
   Enemys.add(e);
   }
   */
}

void draw()
{
  if (GameActive) {
    background(255);
    displayWeapon();
    wavesystem();
    CheckPlayer();
    p.movement();
    p.display();
    p.XPcheck();
    p.XP();
    p.HP();
    Reload();
    mousepr();
    

    CheckBullet();
    drop();
    noStroke();
    noFill();
  } else if (!GameActive) {
    MainMenu();
  }
}

void MainMenu() {
}

boolean WaveActive = false;
int enemyCount = 5;
int score = 0;
int wave = 0;
int waveRes = 0;
int wavecount = 0;

int enemyHP = 30;
int enemySize = 30;
int enemySpeed = 2;
int enemyEXP = 10;
int enemyDMG = 10;

void wavesystem() {
  if (wavecount >= 10) {

    wavecount = 0;
    enemyCount += 1;
  } else if (waveRes <= 5) {
    if (Enemys.size() <= enemyCount   && !WaveActive) {
      Enemy p = new Enemy(enemyHP, enemySize, enemySpeed, enemyEXP, enemyDMG);  //HP , size, speed, EXP, dmg
      Enemys.add(p);
    } else if (Enemys.size() >= enemyCount) {
      WaveActive = true;
    } else if (Enemys.size() == 0) {

      WaveActive = false;
      wavecount += 1;
      waveRes += 1;
    }
  } else if (waveRes >= 5) {
    enemyHP += 20;
    enemySize += 2;
    enemySpeed *= 1.3;
    enemyEXP += 10;
    enemyDMG += 20;


    waveRes = 0;
    wave += 1;

    WaveActive = false;
  }

  println(" waveRes : " + waveRes +  " wave :  " + wave + " wavecount : " + wavecount );
}

void Reload() {
  for (int j = 0; j < PlayerInv.size(); j++) {
    currentData = PlayerInv.get(j);
    fill(Color2, Color, 0);
    rect(20, 100, 65, 50); //ActiveGun Screen
    noFill();

    fill(255);
    rect(30, 110, 45, 30); //Backround #ImageGUN
    noFill();
    if (ActiveWeapon) {
      if (currentData.type == PISTOL) {
        image(pistol, 25, 100, 50, 50);
      } else if (currentData.type == SHOTGUN) {
        image(shotgu, 32.5, 100, 40, 40);
      } else if (currentData.type == ROCKET) {
        image(rocketlauncher, 32.5, 100, 40, 40);
      } else if (currentData.type == SNIPER) {
        image(snipe, 32.5, 105, 40, 40);
      }
    }
    if (millis() - lastShot <= cooldown) {
      //println(millis() - lastShot);
      Color = 0;
      Color2 = 255;
    }
    if (millis() - lastShot >= cooldown) {
      //println("Gun ready");
      Color = 255;
      Color2 = 0;
    }
  }
}

void displayWeapon() {
  for (int j = 0; j < groundGuns.size(); j++) {
    currentw = groundGuns.get(j);
    currentw.display();

    if (dist(currentw.LocationW.x, currentw.LocationW.y, p.LocationP.x, p.LocationP.y) <= 50 && pickup && PlayerInv.size() <= 0) {
      groundGuns.remove(currentw);
      ActiveWeapon = true;
      PlayerInv.add(currentw.weapon);
      p.damage = currentw.weapon.damage;
      cooldown = currentw.weapon.cooldown;
    }
  }
}

void drop() {
  if (drop) {
    for (int j = 0; j < PlayerInv.size(); j++) {
      currentData = PlayerInv.get(j);
      PlayerInv.remove(currentData);
      ActiveWeapon = false;

      if (currentData.type == PISTOL) {
        groundGuns.add(new WeaponObject(p.LocationP.x, p.LocationP.y, 20, 40, 40, currentData, pistol));
      } else if (currentData.type == SHOTGUN) {
        groundGuns.add(new WeaponObject(p.LocationP.x, p.LocationP.y, 20, 40, 40, currentData, shotgu));
      } else if (currentData.type == ROCKET) {
        groundGuns.add(new WeaponObject(p.LocationP.x, p.LocationP.y, 20, 50, 40, currentData, rocketlauncher));
      } else if (currentData.type == SNIPER) {
        groundGuns.add(new WeaponObject(p.LocationP.x, p.LocationP.y, 20, 60, 40, currentData, snipe));
      }
    }
  }
}

void mousepr() {
  if (leftHeld) {
    if (PlayerInv.size() == 0) return;
    if (millis() - lastShot <= cooldown) return;

    WeaponData held = PlayerInv.get(0);
    float mausWinkel = atan2(mouseY - p.LocationP.y, mouseX - p.LocationP.x);
    float spreadRad = radians(held.spread);

    for (int i = 0; i < held.count; i++) {
      float bulletWinkel = mausWinkel + (-spreadRad/2 + i * (spreadRad / max(1, held.count - 1)));
      float dx = cos(bulletWinkel);
      float dy = sin(bulletWinkel);

      bullets.add(new Bullet(p.LocationP.x, p.LocationP.y, dx, dy, held.speed, held.size, held.type));
    }

    lastShot = millis();
    Color = 255;
  }
}


void mousePressed()
{
  if (mouseButton == LEFT) {
    leftHeld = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    leftHeld = false;
  }
}


void CheckBullet()
{
  for (int j = 0; j < bullets.size(); j++)
  {
    current = bullets.get(j);
    current.display();
    current.movement();
    if (current.x < 0 || current.x > 1000 || current.y < 0 || current.y > 1000)
    {
      bullets.remove(j);
    }
  }
}

void CheckPlayer()
{
  for (int i = 0; i < Enemys.size(); i++)
  {
    e = Enemys.get(i);
    //e.movement();
    e.display();
    e.eHP();
    if (dist(e.LocationE.x, e.LocationE.y, p.LocationP.x, p.LocationP.y) < e.size - 2) //enemy connection
    {
      p.curHP = max(0, p.curHP - e.damage);
      Enemys.remove(e);
      background(255, 0, 0);
    }
  }
  collision();
}



void collision()
{
  for (int j = bullets.size() - 1; j >= 0; j--) {
    current = bullets.get(j);
    for (int i = Enemys.size() - 1; i >= 0; i--) {
      e = Enemys.get(i);
      if (dist(current.x, current.y, e.LocationE.x, e.LocationE.y) < e.size) {

        if (current.type == ROCKET) {
          int explosionCount = 30;
          float angleStep = TWO_PI / explosionCount;  // 360° / 40 = 9° pro Kugel

          for (int a = 0; a < explosionCount; a++) {
            float d = a * angleStep;
            float dx = cos(d);
            float dy = sin(d);
            bullets.add(new Bullet(current.x, current.y, dx, dy, 15, 10, 0));
          }
          bullets.remove(j);
        } else if (current.type != SNIPER ) {
          bullets.remove(j);
        }

        e.curHP = max(0, e.curHP - p.damage);
        if (e.isDead()) {
          p.curxp += e.expvalue;
          Enemys.remove(i);
        }
        break;
      }
    }
  }
}

float mult = 1.5;

void keyPressed()
{
  if (keyCode == SHIFT) p.speed = 7;
  if (key == 'q' || key == 'Q') drop = true;
  if (key == 'e' || key == 'E') pickup = true;
  if (key == 'w' || key == 'W') up = true;
  if (key == 's' || key == 'S') down = true;
  if (key == 'a' || key == 'A') left = true;
  if (key == 'd' || key == 'D') right = true;
}
void keyReleased()
{
  if (keyCode == SHIFT) p.speed = 4;
  if (key == 'q' || key == 'Q') drop = false;
  if (key == 'e' || key == 'E') pickup = false;
  if (key == 'w' || key == 'W') up = false;
  if (key == 's' || key == 'S') down = false;
  if (key == 'a' || key == 'A') left = false;
  if (key == 'd' || key == 'D') right = false;
}
