PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;

int enemyAppearTime;
int score;

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
  textAlign(LEFT, TOP);

  enemyAppearTime = millis();
  score = 0;

  enemyAppearRate = 3000;

  p = new Player(new PVector(), new PVector(width / 2, height / 2), 20, 1, millis(), 4.0, true);
  bullets = new ArrayList<Bullet>();

  enemies = new ArrayList<Enemy>();

  //enemies.add(new EnemyMoveTowardsPlayer(new PVector(), new PVector(100, 100), 30, 30, millis(), 500, 6.0, 7.0, true));
  //enemies.add(new EnemyMoveTowardsPredicted(new PVector(), new PVector(width-100, height-100), 30, 30, millis(), 500, 6.0, 7.0, true));
  //enemies.add(new EnemyShootHeadOn(new PVector(), new PVector(0, 0), 30, 30, millis(), 500, 6.0, 7.0, true));
  enemies.add(new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, millis(), 99999999, 7.0, 7.0, true, false));
  Enemy e = enemies.get(enemies.size() - 1);
  while (e.loc.dist (p.loc) <= 500)
    e.loc.set(random(width), random(height));
  e.fatal = true;
}

void draw()
{
  if (!shouldRestart)
  {
    fill(127.5, 175);
    rect(width / 2, height / 2, width, height);

    fill(0);
    text("Score: " + score, 0, 0);

    if (millis() - enemyAppearTime >= enemyAppearRate)
    {
      enemies.add(new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, millis(), 999999999, 7.0, 7.0, true, false));
      Enemy e = enemies.get(enemies.size() - 1);
      while (e.loc.dist (p.loc) <= 500)
        e.loc.set(random(width), random(height));
      e.fatal = true;
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
      e.run();
      e.show();
    }
    p.show();
    p.run();
  } else {
    fill(255);
    text("Score: " + score, 0, 0);
  }
}

void keyPressed()
{
  if (key == 'a')
    keys[0] = true;
  if (key == 'd')
    keys[1] = true;
  if (key == 'w')
    keys[2] = true;
  if (key == 's')
    keys[3] = true;
  if (key == 'p')
    keys[4] = true;
  if (key == 'r')
    reset();
  if (key == 'f')
    autoFire = !autoFire;
}

void keyReleased()
{
  if (key == 'a')
    keys[0] = false;
  if (key == 'd')
    keys[1] = false;
  if (key == 'w')
    keys[2] = false;
  if (key == 's')
    keys[3] = false;
  if (key == 'p')
    keys[4] = false;
}

