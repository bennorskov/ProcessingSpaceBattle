class Ship {
  PVector pos, speed, acc;
  float FRICTION = .97;
  float ACC_AMOUNT = .5;
  ArrayList caughtLines = new ArrayList();
  int effectRange = 25;
  int effectLevel = 0;
  int tailLength = 5;
  ArrayList pastPositions = new ArrayList();
  // –––––––––– // –––––––––– // –––––––––– CONSTRUCTOR
  Ship() {
    pos = new PVector(width/2, 650);
    speed = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  // –––––––––– // –––––––––– // –––––––––– DISPLAY
  void display() {
    //draw styles
    fill(255);
    noStroke();
    //actual drawing
    pushMatrix();
    translate(pos.x, pos.y);
    beginShape();
    vertex(0, -20);
    vertex(8, 15);
    vertex(-8, 15);
    endShape(CLOSE);
    popMatrix();

    drawShipTail();

    for (int i = 0; i<caughtLines.size(); i++) {
      DropLine d = (DropLine) caughtLines.get(i);
      d.display();
    }
  }
  void drawShipTail() {
     for (int i = pastPositions.size()-1; i>=0; i--) {
      PVector p = (PVector) pastPositions.get(i);
      //draw styles
      fill(255, 15+i*2);
      noStroke();
      rect(p.x-7, p.y, 14, 14);
     }
  }
  // –––––––––– // –––––––––– // –––––––––– UPDATE
  void update() {
    pos.add(speed);
    friction();
    for (int i = 0; i<caughtLines.size(); i++) {
      DropLine d = (DropLine) caughtLines.get(i);
      d.update(pos.x, pos.y + i * - effectRange - effectRange);
    }
    // --------- add in ship's past positions
    if (pastPositions.size() < effectLevel * tailLength + tailLength) {
      pastPositions.add(new PVector(pos.x, pos.y));
    }
    if (pastPositions.size() == effectLevel * tailLength + tailLength) {
      pastPositions.add(new PVector(pos.x, pos.y));
      pastPositions.remove(0);
    }
  }
  // –––––––––– // –––––––––– // –––––––––– // –––––––––– LINECATCh
  void catchLine(DropLine d) {
    d.catchShip();
    caughtLines.add(d);
    effectLevel++;
  } 
  // –––––––––– // –––––––––– // –––––––––– MOVEMENT
  void moveLeft() {
    acc = new PVector(-ACC_AMOUNT, 0);
    computeSpeed();
  }
  void moveRight() {
    acc = new PVector(ACC_AMOUNT, 0);
    computeSpeed();
  }
  void moveUp() {
    acc = new PVector(0, -ACC_AMOUNT);
    computeSpeed();
  }
  void moveDown() {
    acc = new PVector(0, ACC_AMOUNT);
    computeSpeed();
  }
  void friction() {
    speed = new PVector(FRICTION * speed.x, FRICTION * speed.y);
  }
  void computeSpeed() {
    speed.add(acc);
    acc = new PVector( 0, 0);
  }
}

