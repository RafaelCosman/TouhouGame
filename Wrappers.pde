PVector copy(PVector vec)
{
  return new PVector(vec.x, vec.y);
}

void translate(PVector vec)
{
  translate(vec.x, vec.y);
}
