class Player
{
  int level = 1;
  float nedxp = 20;
  float curxp = 0;
  float maxHP = 100;
  float curHP = 100;
  float damage = 35;
  float endX;
  float endY;
  PVector LocationP = new PVector(500, 500);
  float lineLength = 40;
  int size = 30;
  float speed = 4;
  
  void display()
  {
    fill(0);
    circle(LocationP.x, LocationP.y, size);
  }

  void movement()
  {
    if (up && LocationP.y > 0)    LocationP.y -= speed;
    if (down && LocationP.y < 1000)  LocationP.y += speed;
    if (left && LocationP.x > 0)  LocationP.x -= speed;
    if (right && LocationP.x < 1000) LocationP.x += speed;

    if (ActiveWeapon) {
      p.lineto();
    }
    noStroke();
  }
  void lineto()
  {
    float dx = mouseX - LocationP.x;
    float dy = mouseY - LocationP.y;

    // Länge berechnen
    float dist = sqrt(dx*dx + dy*dy);

    // Normalisieren + skalieren
    endX = LocationP.x + (dx / dist) * lineLength;
    endY = LocationP.y + (dy / dist) * lineLength;
    strokeWeight(10);
    stroke(10);
    line(LocationP.x, LocationP.y, endX, endY);
  }

  void HP()
  {
    noStroke();
    //max hp
    fill(255, 0, 0);
    rect(20, 20, 300, 24);

    //current hp
    fill(0, 200, 0);
    rect(20, 20, 300 * (p.curHP / p.maxHP), 24);
  }

  void XP()
  {
    noStroke();
    fill(105, 105, 105);
    rect(400, 20, 500, 24);

    //xp fill
    fill(0, 50, 255);
    rect(400, 20, 500 * (curxp / nedxp), 24);
  }

  void XPcheck()
  {
    if (curxp >= nedxp) {
      p.curxp = 0;
      level++ ;
      nedxp = level * 20;
      maxHP += 10;
      curHP = maxHP;
      println("LEVEL UP : " + level);
      println(" Needet XP : " + nedxp + " Current XP : " + curxp + " Current damage : " + damage + " maxHP : " + maxHP);
    }
  }
}
