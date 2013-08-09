class Player
{
  PVector vel, loc, nextLoc;
  int playerSize, hp, shootTime;
  float speed;
  boolean facingRight;

  color c = color(0, 255, 0);

  Player(PVector vel, PVector loc, PVector nextLoc, int playerSize, int hp, int shootTime, float speed, boolean facingRight)
  {
    this.vel = vel;
    this.loc = loc;
    this.nextLoc = nextLoc;
    this.playerSize = playerSize;
    this.hp = hp;
    this.shootTime = shootTime;
    this.speed = speed;
    this.facingRight = facingRight;
  }

  void show()
  {
    fill(c);
    if (!facingRight)
      triangle(loc.x - playerSize, loc.y, loc.x + playerSize, loc.y + playerSize, loc.x + playerSize, loc.y - playerSize);
    else
    {
      translate(loc.x, loc.y);
      rotate(PI);
      triangle(-playerSize, 0, playerSize, playerSize, playerSize, -playerSize);
      translate(-loc.x, -loc.y);
    }
  }

  void run()
  {
    //pushFromEdge();

    if (shootTime >= 4 && (mousePressed || autoFire))
    {
      final int BULLET_SPEED = 99;
      PVector direction;
      if (facingRight)
        direction = new PVector(BULLET_SPEED, 0);
      else
        direction = new PVector(-BULLET_SPEED, 0);

      bullets.add(new BulletStraight(direction, copy(p.loc), 5, 1, 7.0, true, true));

      shootTime = 0;
    }
    shootTime ++;

    if (keyCode == LEFT)
      facingRight = false; else if (keyCode == RIGHT)
      facingRight = true;

    if (p.hp <= 0)
      shouldRestart = true;
  }

  void move()
  {
    vel.set(0, 0, 0);

    if (keys[4])
      speed = 2.5;
    else
      speed = 5.0;

    if (keys[0] || keys[1] || keys[2] || keys[3])
    {
      if (keys[0])
        vel.x = -speed;
      if (keys[1])
        vel.x = speed;
      if (keys[2])
        vel.y = -speed;
      if (keys[3])
      {
        vel.y = speed;
      }
      vel.setMag(speed);
    }
    nextLoc.set(PVector.add(loc, vel));

    boolean onMap = nextLoc.x > 0 && nextLoc.x < width && nextLoc.y > 0 && nextLoc.y < height;
    if (onMap)
      loc.set(nextLoc);
  }
}

