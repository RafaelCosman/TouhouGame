abstract class Enemy
{
  PVector vel, loc;
  int enemySize, hp, shootTimeCurrent, shootTimeDeadline;
  float speed, bulletSpeed;
  boolean facingRight, fatal;

  Enemy(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight, boolean fatal)
  {
    this.vel = vel;
    this.loc = loc;
    this.enemySize = enemySize;
    this.hp = hp;
    this.shootTimeCurrent = shootTimeCurrent;
    this.shootTimeDeadline = shootTimeDeadline;
    this.speed = speed;
    this.bulletSpeed = bulletSpeed;
    this.facingRight = facingRight;
    this.fatal = fatal;
  }

  void show()
  {
    ellipse(loc.x, loc.y, enemySize, enemySize);
  }

  //Returns true when the enemy survives
  boolean run()
  {
    vel.setMag(speed);
    loc.add(vel);

    if (p.loc.x > loc.x)
      facingRight = true;
    else
      facingRight = false;

    if (loc.dist(p.loc) <= enemySize / 2 + (p.playerSize / 2) && fatal)
      shouldRestart = true;
    if (hp <= 0)
    {
      score ++;
      return false;
    }
    else
      return true;
  }

  void shoot()
  {
    PVector direction;
    if (facingRight)
      direction = new PVector(99, 0);
    else
      direction = new PVector(-99, 0);

    bullets.add(new BulletStraight(copy(direction), copy(loc), 20, 1, 7.0, false, true));

    shootTimeCurrent = millis();
  }

  void shootTowards(PVector targetLoc)
  {
    bullets.add(new BulletStraight(copy(PVector.sub(targetLoc, loc)), copy(loc), 20, 1, 7.0, false, true));

    shootTimeCurrent = millis();
  }

  void moveTowardsYLoc(PVector targetLoc)
  {
    final float OCCILATION_MODIFIER = .025;
    vel.y += OCCILATION_MODIFIER * (targetLoc.y - loc.y);
  }

  void moveTowardsLoc(PVector targetLoc, float curvaturesetMag)
  {
    PVector velChange = PVector.sub(p.loc, loc);
    velChange.setMag(curvaturesetMag);
    vel.add(velChange);
  }
  boolean isTimeToShoot()
  {
    return millis() - shootTimeCurrent >= shootTimeDeadline;
  }
}

