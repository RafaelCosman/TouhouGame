class Tree
{
  float h;
  float angle;
  float start;
  boolean madeYet;

  Tree(float h, float angle, float start, boolean madeYet)
  {
    this.h = h;
    this.angle = angle;
    this.start = start;
    this.madeYet = madeYet;
  }

  void show()
  {
    if (!madeYet)
      h = start;
    fill(255);
    stroke(0);
    pushMatrix();
    translate(width/random(0, width), 0);
    rotate(random(-PI/12, PI/12));
    tree();
    popMatrix();
    madeYet = true;
  }

  void tree()
  {
    // Start the tree from the bottom of the screen
    translate(0, height);
    // Draw a line 120 pixels
    strokeWeight(start / 3);
    line(0, 0, 0, -start);
    // Move to the end of that line
    translate(0, -start);
    // Start the recursive branching!
    for (int branchNum = 0; branchNum <= random(1, 4); branchNum ++)
      branch(start);
  }

  void branch(float h)
  {
    if (!madeYet)
      h *= random(0.5, 0.85);

    if (h > 2) {
      float a = random(0, angle);

      if (!madeYet)
      {
        pushMatrix();    // Save the current state of transformation (i.e. where are we now)
        rotate(a);   // Rotate by angle
        strokeWeight(h/4);
        line(0, 0, 0, -h);  // Draw the branch
        translate(0, -h); // Move to the end of the branch
        branch(h);       // Ok, now call myself to draw two new branches!!
        popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
      }
      // Repeat the same thing, only branch off to the "left" this time!
      if (!madeYet)
        a = random(0, angle);
      pushMatrix();
      rotate(-a);
      strokeWeight(h/4);
      line(0, 0, 0, -h);
      translate(0, -h);
      branch(h);
      popMatrix();
    } else {
      // put a flower at the end of branch
      ellipse(0, 0, 4, 6);
    }
  }
}

