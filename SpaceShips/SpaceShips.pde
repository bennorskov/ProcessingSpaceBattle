Ship s;
scrollBG bg;
Boolean[] keyWasPressed = new Boolean[127];

int lastDroppedLineTime = 0;
// –––––––––– // –––––––––– // –––––––––– SETUP
void setup() {
  size(600, 900);
  colorMode(HSB, 360, 100, 100);
  s = new Ship();
  for (int i = 0; i<keyWasPressed.length; i++) {
    keyWasPressed[i] = false;
  }
  bg = new scrollBG();
}
// –––––––––– // –––––––––– // –––––––––– DRAW
void draw() {
  bg.displayupdate(s.effectLevel);
  s.display();
  s.update();
  handleKeys();
  timeLines();
}

// –––––––––– // –––––––––– // –––––––––– KEY HANDLING
void keyPressed() {
  //      println(keyCode);
  keyWasPressed[keyCode] = true;
}
void keyReleased() {
  keyWasPressed[keyCode] = false;
}

void handleKeys() {
  for (int i = 0; i<keyWasPressed.length; i++) {
    if (keyWasPressed[i]) {
      switch (i) {
      case LEFT:
        s.moveLeft();
        break;
      case RIGHT:
        s.moveRight();
        break;
      case UP:
        s.moveUp();
        break;
      case DOWN:
        s.moveDown();
        break;
      }
    }
  }
}