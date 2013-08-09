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
    fill(terrainColor);
    rect(loc, terrainSize);
  }

  void run()
  {
    loc.add(passingVel);

    boolean leftOfPlayer = p.loc.x > loc.x + (terrainSize.x / 2);
    boolean rightOfPlayer = p.loc.x < loc.x - (terrainSize.x / 2);
    boolean abovePlayer = p.loc.y > loc.y + (terrainSize.y / 2);
    boolean belowPlayer = p.loc.y < loc.y - (terrainSize.y / 2);

    if (get(int(p.loc.x + 1), int(p.loc.y)) == color(terrainColor))
      p.loc.add(passingVel);
  }
}

