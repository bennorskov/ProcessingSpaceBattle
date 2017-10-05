Ship player;
scrollBG background;
Boolean[] keyWasPressed = new Boolean[127];

ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Enemy> enemies = new ArrayList();

// –––––––––– // –––––––––– // –––––––––– SETUP
void setup() {
  size(600, 900);
  colorMode(HSB, 360, 100, 100);
  imageMode(CENTER);
  rectMode(CENTER);
  player = new Ship();
  enemies.add( new Enemy(width/2, 100) );
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
  moveDisplayEnemies();
  handleKeys();
  checkBulletHits();
}

// –––––––––– // –––––––––– // –––––––––– Enemy HANDLING
void moveDisplayEnemies() {
   for( int i = enemies.size()-1; i>=0; i--) {
     Enemy e = enemies.get(i);
     if (e.isAlive) {
       e.move();
       e.display();
       if(checkEnemyAgainstPlayer(e, player)) {
         println("kill player");
       }
     } else {
       enemies.remove(i);
     }
   }
}

// –––––––––– // –––––––––– // –––––––––– BULLET HANDLING
void spawnBullet() {
  //println(millis(), player.lastFire, 1000/player.bulletsPerSecond);
  if (player.lastFire + 1000/player.bulletsPerSecond < millis()) {
    bullets.add( new Bullet(player.pos.x, player.pos.y));
    player.lastFire = millis();
  }
}
void checkBulletHits() {
  for( int i = bullets.size()-1; i>=0; i--) {
    Bullet b = bullets.get(i);
    if (b.isAlive) {
      b.move();
      b.display();
      //remove bullets off screen
      if (b.pos.y < -b.hitBoxWidth) {
        b.isAlive = false;
      }
      //check bullets against enemies
     for( int j = enemies.size()-1; j>=0; j--) {
       Enemy e = enemies.get(j);
       if (checkEnemyBulletHit(e, b)) {
         b.isAlive = false;
         e.isAlive = false;
       }
     }
    } else {
      bullets.remove(i);
    }
  }
}
// –––––––––– // –––––––––– // –––––––––– HIT DETECTION
boolean checkEnemyBulletHit(Enemy e, Bullet b) {  
  return !(b.leftSide > e.rightSide || 
           b.rightSide < e.leftSide || 
           b.top > e.bottom ||
           b.bottom < e.top);
}
boolean checkEnemyAgainstPlayer( Enemy e, Ship p) {
  return !(p.leftSide > e.rightSide || 
           p.rightSide < e.leftSide || 
           p.top > e.bottom ||
           p.bottom < e.top);
}

// –––––––––– // –––––––––– // –––––––––– KEY HANDLING
void keyPressed() {
  if (keyCode < keyWasPressed.length) keyWasPressed[keyCode] = true;
}
void keyReleased() {
  if (keyCode < keyWasPressed.length) keyWasPressed[keyCode] = false;
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