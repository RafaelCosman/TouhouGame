PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> splitBullets;
ArrayList<Terrain> terrains;
ArrayList<Mist> mists;
ArrayList<Tree> trees;

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
  strokeWeight(5);
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
  terrains = new ArrayList();
  mists = new ArrayList<Mist>();
  trees = new ArrayList<Tree>();

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
  trees.add(new Tree(-1, 100*random(0.25, 0.75), (int)random(80, 120), false));
}


void draw()
{
  if (shouldRestart)
  {
    fill(255);
    text("Score: " + score, 0, 0);
    return;
  }
  ArrayList<Enemy> survivingEnemies = new ArrayList<Enemy>();


  p.move();

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

  splitBullets.clear();

  for (Tree t : trees)
  {
    t.show();
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

  enemies = survivingEnemies;

  for (int i = 0; i <= mists.size() - 1; i ++)
  {
    Mist m = mists.get(i);
    if (!m.exists)
    {
      mists.remove(i);
      break;
    }
  }

  for (Mist m : mists)
  {
    m.run();
    m.show();
  }

  p.run();
  p.show();
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

