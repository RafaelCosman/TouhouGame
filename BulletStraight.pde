class BulletStraight extends Bullet
{
  BulletStraight(PVector vel, PVector loc, int bulletSize, int damage, float speed, boolean madeByPlayer, boolean exists)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, true);
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(255, 0, 0);

    super.show();
  }

  void run()
  {
    super.run();
  }
}

