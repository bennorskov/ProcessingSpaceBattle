class scrollBG {
  
  int NUM_STARS = 40;
  String backgroundImageName = "noPicture";
  
  //
  // ––––––––––––––––– Don't edit below here –––––––––––––– //
  // (well, you can if you want, but it might mess stuff up)
  //

  PImage backgroundImage;
  boolean useImage = false;
  PVector[] stars = new PVector[NUM_STARS];
  float[] starSpeeds = new float[NUM_STARS];
  scrollBG() {
    if (backgroundImageName != "noPicture") {
      backgroundImage = loadImage(backgroundImageName);
      useImage = true;
    }
    
    for (int i = 0; i<stars.length; i++) {
      stars[i] = new PVector(random(width), -random(height));
      starSpeeds[i] = random(.3, 4);
    }
  }

  void displayupdate(int level) {
    if (useImage) {
      background(0);
      image(backgroundImage, width*.5, height*.5);
    } else {
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
  }
  void resetStar(int index) {
    stars[index] = new PVector(random(width), -random(height));
    starSpeeds[index] = random(.3, 4);
  }
}