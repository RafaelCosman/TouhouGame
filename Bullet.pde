abstract class Bullet
{
  PVector vel, loc;
  int bulletSize, damage;
  float speed;
  boolean madeByPlayer, exists;

  Bullet(PVector vel, PVector loc, int bulletSize, int damage, float speed, boolean madeByPlayer, boolean exists)
  {
    this.vel = vel;
    this.loc = loc;
    this.bulletSize = bulletSize;
    this.damage = damage;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.exists = true;
  }

  void show()
  {
    ellipse(loc.x, loc.y, bulletSize, bulletSize);
  }

  void run()
  {
    for (Enemy e : enemies)
    {
      if (madeByPlayer && loc.dist(e.loc) <= bulletSize / 2 + (e.enemySize / 2))
      {
        e.hp -= damage;
        exists = false;
      }
      if (!madeByPlayer && loc.dist(p.loc) <= bulletSize / 2)
      {
        p.hp -= damage;
        exists = false;
      }
      vel.limit(speed);
      loc.add(vel);
    }
  }
}

