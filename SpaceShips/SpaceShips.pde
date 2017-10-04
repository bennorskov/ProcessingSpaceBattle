Ship player;
scrollBG background;
Boolean[] keyWasPressed = new Boolean[127];

// –––––––––– // –––––––––– // –––––––––– SETUP
void setup() {
  size(600, 900);
  colorMode(HSB, 360, 100, 100);
  player = new Ship();
  for (int i = 0; i<keyWasPressed.length; i++) {
    keyWasPressed[i] = false;
  }
  background = new scrollBG();
}
// –––––––––– // –––––––––– // –––––––––– DRAW
void draw() {
  background.displayupdate(2);
  player.display();
  player.update();
  handleKeys();
  checkBulletHits();
}

// –––––––––– // –––––––––– // –––––––––– BULLET HANDLING
void spawnBullet() {}
void checkBulletHits() {}

// –––––––––– // –––––––––– // –––––––––– KEY HANDLING
void keyPressed() {
        println(keyCode);
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
        player.moveLeft();
        break;
      case RIGHT:
        player.moveRight();
        break;
      case UP:
        player.moveUp();
        break;
      case DOWN:
        player.moveDown();
        break;
      case 32: //spacebar
        spawnBullet();
        break;
      }
    }
  }
}