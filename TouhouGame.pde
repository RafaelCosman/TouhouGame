PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Enemy> survivingEnemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> splitBullets;
ArrayList<Terrain> terrains;

int enemyAppearTime;
int score;
int bombsRemaining;

int enemyAppearDeadline;

boolean[] keys;
boolean autoFire;
boolean shouldRestart;

color terrainColor;

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

  enemyAppearTime = 0;
  score = 0;
  bombsRemaining = 3;

  enemyAppearDeadline = 300;
  p = new Player(new PVector(), new PVector(width / 2, height / 2), new PVector(), 20, 5, 0, 5.0, true);
  bullets = new ArrayList<Bullet>();
  splitBullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  survivingEnemies = new ArrayList<Enemy>();
  terrains = new ArrayList();

  terrainColor = color(255);

  Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 100, 7.0, 7.0, true);
  enemies.add(e);
  //Enemy e = new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 9999999, 7.0, 7.0, true);
  //enemies.add(e);
  //Enemy e = new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 9999999, 7.0, 7.0, true);
  //enemies.add(e);
  //Enemy e = new EnemyShootTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 9999999, 7.0, 7.0, true);
  //enemies.add(e);
  while (e.loc.dist (p.loc) <= 500)
    e.loc.set(random(width), random(height));
  terrains.add(new Terrain(new PVector(-5, 0), new PVector(width, height), new PVector(100, 500)));
}

void draw()
{
  if (!shouldRestart)
  {
    p.move();

    survivingEnemies.clear();
    fill(127.5, 175);
    rect(width / 2, height / 2, width, height);

    textAlign(LEFT, TOP);
    fill(0);
    text("Score: " + score, 0, 0);
    textAlign(RIGHT, TOP);
    text("Bombs: " + bombsRemaining, width, 0);

    if (enemyAppearTime >= enemyAppearDeadline)
    {
      Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 100, 7.0, 7.0, true);
      enemies.add(e);
      while (e.loc.dist (p.loc) <= 500)
        e.loc.set(random(width), random(height));
      enemyAppearDeadline --;
      enemyAppearTime = 0;
    }

    for (Terrain t : terrains)
    {
      t.show();
      t.run();
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

    for (Bullet b : splitBullets)
      bullets.add(b);

    for (int i = 0; i <= splitBullets.size() - 1; i ++)
    {
      Bullet b = splitBullets.get(i);
      if (!b.exists)
      {
        splitBullets.remove(i);
        break;
      }
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
    splitBullets.clear();
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

