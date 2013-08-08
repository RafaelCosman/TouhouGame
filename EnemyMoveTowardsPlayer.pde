class EnemyMoveTowardsPlayer extends Enemy
{
  EnemyMoveTowardsPlayer(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight, boolean fatal)
  {
    super(vel, loc, enemySize, hp, shootTimeCurrent, shootTimeDeadline, speed, bulletSpeed, facingRight, fatal);
  }

  void show()
  {
    fill(255, 0, 0);
    super.show();
  }

  void run()
  {
    if (isTimeToShoot())
      shoot();

    moveTowardsYLoc(p.loc);
    super.run();
  }
}

