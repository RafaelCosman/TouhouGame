PVector copy(PVector vec)
{
  return new PVector(vec.x, vec.y);
}

void translate(PVector vec)
{
  translate(vec.x, vec.y);
}

void rect(PVector loc, int w, int h)
{
  rect(loc.x, loc.y, w, h);
}

void rect(PVector loc, PVector dimensions)
{
  rect(loc.x, loc.y, dimensions.x, dimensions.y);
}

void ellipse(PVector loc, int diameter)
{
  ellipse(loc.x, loc.y, diameter, diameter);
}

void point(PVector loc)
{
  point(loc.x, loc.y);
}
