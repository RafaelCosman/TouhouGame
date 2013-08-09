class EnemyMoveTowardsPredicted extends Enemy
{
  EnemyMoveTowardsPredicted(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, float speed, float bulletSpeed, boolean facingRight)
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
      PVector direction;
      if (facingRight)
        direction = new PVector(99, 0);
      else
        direction = new PVector(-99, 0);
      shootTowards(direction);
    }

    final int EXPECTED_PLAYER_SPEED = 20;
    moveTowardsYLoc(PVector.add(p.loc, PVector.mult(p.vel, EXPECTED_PLAYER_SPEED)));

    return super.run();
  }
}

