class EnemyShootHeadOn extends Enemy
{
  EnemyShootHeadOn(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight)
  {
    super(vel, loc, enemySize, hp, shootTimeCurrent, shootTimeDeadline, speed, bulletSpeed, facingRight);
  }

  void show()
  {
    fill(255, 0, 0);
    super.show();
  }

  boolean run()
  {
    if (isTimeToShoot())
      shootTowards(p.loc);

    moveTowardsYLoc(p.loc);
    return super.run();
  }
}

