Ship player;
scrollBG background;
Boolean[] keyWasPressed = new Boolean[127];

ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Enemy> enemies = new ArrayList();

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
  background.displayupdate(3);
  player.display();
  player.update();
  handleKeys();
  checkBulletHits();
}

// –––––––––– // –––––––––– // –––––––––– BULLET HANDLING
void spawnBullet() {
  bullets.add( new Bullet(player.pos.x, player.pos.y));
}
void checkBulletHits() {
  for( int i = bullets.size()-1; i>=0; i--) {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
    //remove bullets off screen
    if (b.pos.y < -b.hitBoxWidth) {
      bullets.remove(i);
    }
  }
}

// –––––––––– // –––––––––– // –––––––––– KEY HANDLING
void keyPressed() {
  //      println(keyCode);
  if (keyCode < 127) keyWasPressed[keyCode] = true;
}
void keyReleased() {
  if (keyCode < 127) keyWasPressed[keyCode] = false;
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