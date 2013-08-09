PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Enemy> survivingEnemies;
ArrayList<Bullet> bullets;

int enemyAppearTime;
int score;
int bombsRemaining;

float enemyAppearRate;

boolean[] keys;
boolean autoFire;
boolean shouldRestart;

void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  noStroke();
  rectMode(CENTER);
  keys = new boolean[5];
  autoFire = true;

  reset();
}

void reset()
{
  shouldRestart = false;
  font = createFont("Arial", 32);
  textFont(font);

  enemyAppearTime = millis();
  score = 0;
  bombsRemaining = 3;

  enemyAppearRate = 3000;

  p = new Player(new PVector(), new PVector(width / 2, height / 2), 20, 1, millis(), 5.0, true);
  bullets = new ArrayList<Bullet>();

  enemies = new ArrayList<Enemy>();
  survivingEnemies = new ArrayList<Enemy>();

  //enemies.add(new EnemyMoveTowardsPlayer(new PVector(), new PVector(100, 100), 30, 30, millis(), 500, 6.0, 7.0, true));
  //enemies.add(new EnemyMoveTowardsPredicted(new PVector(), new PVector(width-100, height-100), 30, 30, millis(), 500, 6.0, 7.0, true));
  //enemies.add(new EnemyShootHeadOn(new PVector(), new PVector(0, 0), 30, 30, millis(), 500, 6.0, 7.0, true));
  Enemy e = new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, millis(), 1000, 7.0, 7.0, true);
  enemies.add(e);
  while (e.loc.dist (p.loc) <= 500)
    e.loc.set(random(width), random(height));
}

void draw()
{
  if (!shouldRestart)
  {
    survivingEnemies.clear();
    fill(127.5, 175);
    rect(width / 2, height / 2, width, height);

    textAlign(LEFT, TOP);
    fill(0);
    text("Score: " + score, 0, 0);
    textAlign(RIGHT, TOP);
    text("Bombs: " + bombsRemaining, width, 0);

    if (millis() - enemyAppearTime >= enemyAppearRate)
    {
      Enemy e = new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, millis(), 1000, 7.0, 7.0, true);
      enemies.add(e);
      while (e.loc.dist (p.loc) <= 500)
        e.loc.set(random(width), random(height));
      enemyAppearRate /= .99;
      enemyAppearTime = millis();
    }
    for (int i = 0; i <= bullets.size() - 1; i ++)
    {
      Bullet b = bullets.get(i);
      if (!b.exists)
      {
        bullets.remove(i);
        break;
      }
    }

    for (Bullet b : bullets)
    {
      b.run();
      b.show();
    }

    for (Enemy e : enemies)
    {
      boolean survived = e.run();
      if (survived)
      {
        e.show();
        survivingEnemies.add(e);
      }
    }
    enemies.retainAll(survivingEnemies);

    p.run();
    p.show();
  } else {
    fill(255);
    text("Score: " + score, 0, 0);
  }
}

void keyPressed()
{
  if (key == 'a' || key == 'A')
    keys[0] = true;
  if (key == 'd' || key == 'D')
    keys[1] = true;
  if (key == 'w' || key == 'W')
    keys[2] = true;
  if (key == 's' || key == 'S')
    keys[3] = true;
  if (keyCode == SHIFT)
    keys[4] = true;
  if (key == 'r')
    reset();
  if (key == 'f')
    autoFire = !autoFire;
  if (key == ' ' && bombsRemaining > 0)
  {
    bullets.clear();
    bombsRemaining --;
  }
}

void keyReleased()
{
  if (key == 'a' || key == 'A')
    keys[0] = false;
  if (key == 'd' || key == 'D')
    keys[1] = false;
  if (key == 'w' || key == 'W')
    keys[2] = false;
  if (key == 's' || key == 'S')
    keys[3] = false;
  if (keyCode == SHIFT)
    keys[4] = false;
}

