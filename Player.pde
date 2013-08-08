class Player
{
  PVector vel, loc;
  int playerSize, hp, shootTime;
  float speed;
  boolean facingRight;

  Player(PVector vel, PVector loc, int playerSize, int hp, int shootTime, float speed, boolean facingRight)
  {
    this.vel = vel;
    this.loc = loc;
    this.playerSize = playerSize;
    this.hp = hp;
    this.shootTime = shootTime;
    this.speed = speed;
    this.facingRight = facingRight;
  }

  void show()
  {
    fill(0, 255, 0);
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
    loc.add(vel);

    float FRICTION = .85;
    vel.mult(FRICTION);

    final int ACCEL = 1;
    if (keys[0])
      vel.x -= ACCEL;
    if (keys[1])
      vel.x += ACCEL;
    if (keys[2])
      vel.y -= ACCEL;
    if (keys[3])
      vel.y += ACCEL;

    if (keys[4])
      speed = 2.0;
    else
      speed = 4.0;

    pushFromEdge();

    if (millis() - shootTime >= 100 && (mousePressed || autoFire))
    {
      final int BULLET_SPEED = 99;
      PVector direction;
      if (facingRight)
        direction = new PVector(BULLET_SPEED, 0);
      else
        direction = new PVector(-BULLET_SPEED, 0);

      bullets.add(new BulletStraight(direction, copy(p.loc), 5, 1, 7.0, true, true));

      shootTime = millis();
    }

    if (keyCode == LEFT)
      facingRight = false; else if (keyCode == RIGHT)
      facingRight = true;

    if (p.hp <= 0)
      shouldRestart = true;
  }

  void pushFromEdge()
  {
    if (loc.x < 0 || loc.x > width)
      vel.x *= -1;
    if (loc.y < 0 || loc.y > height)
      vel.y *= -1;
  }
}

