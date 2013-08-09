class EnemyMoveTowardsPlayer extends Enemy
{
  EnemyMoveTowardsPlayer(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight)
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
    {
      Bullet b = new BulletSplit(PVector.sub(p.loc, loc), copy(loc), 20, 1, 0, 100, 15, 7.0, false, true);
      bullets.add(b);

      shootTimeCurrent = 0;
    }
    shootTimeCurrent ++;

    moveTowardsYLoc(p.loc);
    return super.run();
  }
}

