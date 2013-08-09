class Terrain
{
  PVector passingVel, loc, terrainSize;

  Terrain(PVector passingVel, PVector loc, PVector terrainSize)
  {
    this.passingVel = passingVel;
    this.loc = loc;
    this.terrainSize = terrainSize;
  }

  void show()
  {
    fill(255);
    rect(loc.x, loc.y, terrainSize.x, terrainSize.y);
  }

  void run()
  {
    loc.add(passingVel);
  }
}

