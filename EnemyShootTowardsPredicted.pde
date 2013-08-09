class EnemyShootTowardsPredicted extends Enemy
{
  EnemyShootTowardsPredicted(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight)
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
      shootTowards(PVector.add(p.loc, PVector.mult(p.vel, PVector.dist(loc, p.loc) / bulletSpeed)));

    moveTowardsLoc(p.loc, .75);
    return super.run();
  }
}

