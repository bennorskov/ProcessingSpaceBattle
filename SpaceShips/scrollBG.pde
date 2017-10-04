class scrollBG {
  int NUM_STARS = 40;
  PVector[] stars = new PVector[NUM_STARS];
  float[] starSpeeds = new float[NUM_STARS];
  scrollBG() {
    for (int i = 0; i<stars.length; i++) {
      stars[i] = new PVector(random(width), -random(height));
      starSpeeds[i] = random(.3, 4);
    }
  }

  void displayupdate(int level) {
    level=level+1;
    background(0);
    noStroke();
    fill(250);
    for (int i = 0; i<stars.length; i++) {
      ellipse(stars[i].x, stars[i].y, 2, 2*level);
      stars[i].y += starSpeeds[i]*level;
      if (stars[i].y > height) resetStar(i);
    }
  }
  void resetStar(int index) {
    stars[index] = new PVector(random(width), -random(height));
    starSpeeds[index] = random(.3, 4);
  }
}

