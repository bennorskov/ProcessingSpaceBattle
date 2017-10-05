class Ship {
  
  // Easily editable variables:
  float bulletsPerSecond = 10;
  float FRICTION = .97;
  float accelerationAmount = .5;
  boolean wrapScreen = false;

  // — Hitbox variables:
  boolean showHitBox = true;
  float hitBoxWidth = 20;
  float hitBoxHeight = 40;
  
  //
  // ––––––––––––––––– Don't edit below here –––––––––––––– //
  // (well, you can if you want, but it might mess stuff up)
  //
  
  PVector pos, speed, acc;
  PImage shipGraphix = new PImage();
  float lastFire = millis();
  float leftSide, rightSide, top, bottom;
  
  // –––––––––– // –––––––––– // –––––––––– CONSTRUCTOR
  Ship() {
    pos = new PVector(width/2, 650);
    speed = new PVector(0, 0);
    acc = new PVector(0, 0);
    // you shoulnd't need more than 100, right? 
    bulletsPerSecond = constrain(bulletsPerSecond, .01, 100);
  }
  // –––––––––– // –––––––––– // –––––––––– DISPLAY
  void display() {
    //actual drawing
    pushMatrix();
    translate(pos.x, pos.y);
    if (!shipGraphix.isLoaded()) {
      //draw styles
      fill(255);
      noStroke();
      beginShape();
      vertex(0, -20);
      vertex(8, 15);
      vertex(-8, 15);
      endShape(CLOSE);
    } else {
      image(shipGraphix, 0, 0);
    }
    if (showHitBox) {
      stroke(#FF99FF);
      strokeWeight(4);
      noFill();
      rect(0, 0, hitBoxWidth, hitBoxHeight);
    }
    popMatrix();
  }
  
  // –––––––––– // –––––––––– // –––––––––– UPDATE
  void update() {
    pos.add(speed);
    friction();
    keepOnScreen();
    
    //set up hitbox sides
    leftSide = pos.x -hitBoxWidth*.5;
    rightSide = pos.x + hitBoxWidth*.5;
    top = pos.y - hitBoxHeight*.5;
    bottom = pos.y + hitBoxHeight*.5;
  }
  // –––––––––– // –––––––––– // –––––––––– MOVEMENT
  void moveLeft() {
    acc = new PVector(-accelerationAmount, 0);
    computeSpeed();
  }
  void moveRight() {
    acc = new PVector(accelerationAmount, 0);
    computeSpeed();
  }
  void moveUp() {
    acc = new PVector(0, -accelerationAmount);
    computeSpeed();
  }
  void moveDown() {
    acc = new PVector(0, accelerationAmount);
    computeSpeed();
  }
  void friction() {
    speed = new PVector(FRICTION * speed.x, FRICTION * speed.y);
  }
  void computeSpeed() {
    speed.add(acc);
    acc = new PVector( 0, 0);
  }
  void keepOnScreen() {
    if (!wrapScreen) {
      pos.x = constrain(pos.x, 0, width);
      pos.y = constrain(pos.y, 0, height);
    } else {
      if (pos.x > width) pos.x = 0;
      if (pos.x < 0) pos.x = width;
      if (pos.y > height) pos.y = 0;
      if (pos.y < 0) pos.y = height;
    }
  }
}