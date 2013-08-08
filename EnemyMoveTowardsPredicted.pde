class EnemyMoveTowardsPredicted extends Enemy
{
  EnemyMoveTowardsPredicted(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight, boolean fatal)
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

    final int EXPECTED_PLAYER_SPEED = 20;
    moveTowardsYLoc(PVector.add(p.loc, PVector.mult(p.vel, EXPECTED_PLAYER_SPEED)));

    super.run();
  }
}

