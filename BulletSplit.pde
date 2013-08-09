class BulletSplit extends Bullet
{
  int splitTimeCurrent, splitTimeDeadline, splitNum;

  BulletSplit(PVector vel, PVector loc, int bulletSize, int damage, int splitTimeCurrent, int splitTimeDeadline, int splitNum, float speed, boolean madeByPlayer, boolean exists)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, true);
    this.splitTimeCurrent = splitTimeCurrent;
    this.splitTimeDeadline = splitTimeDeadline;
    this.splitNum = splitNum;
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

    if (splitTimeCurrent >= splitTimeDeadline)
    {
      PVector rotateAmount = PVector.sub(p.loc, loc);
      exists = false;
      float m = rotateAmount.mag();

      for (float a = rotateAmount.heading2D(); a <= PVector.sub(p.loc, loc).heading2D() + TWO_PI; a += TWO_PI / splitNum)
      {
        rotateAmount.x = m * cos(a);
        rotateAmount.y = m * sin(a);
        splitBullets.add(new BulletStraight(copy(rotateAmount), copy(loc), 20, 1, 1.0, false, true));
      }
      splitTimeCurrent = 0;
    }
    splitTimeCurrent ++;
  }
}

