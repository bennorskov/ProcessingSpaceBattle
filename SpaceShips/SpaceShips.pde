/*
 * Basic Space Shooter
 * Replace the graphics with ones you like!
 * variables that are easily editable are at the top of every file
 * You're welcome to poke through the code and change whatever you'd like
 * Sometimes you'll break things. That's ok. That's part of coding.
*/

int numberOfEnemies = 13;

//
// ––––––––––––––––– Don't edit below here –––––––––––––– //
// (well, you can if you want, but it might mess stuff up)
//

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
  for (int i = 0; i<numberOfEnemies; i++) {
    enemies.add( new Enemy(random(40, width-40), height/2 - i*50) );
  }
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
  // Make a bullet if the player did not recently fire one 
  if (player.lastFire + 1000/player.bulletsPerSecond < millis()) {
    bullets.add( new Bullet(player.pos.x, player.pos.y));
    player.lastFire = millis();
  }
}
void checkBulletHits() {
  // find all the bullets and see if they hit enemies
  // or go off screen
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
// I should make a base class here that everything extends (bullet, player, enemy)
// or a rectangle class, and then just have one hit function
// but this is almost as easy and only a few more lines of code.
// This game is simple, don't over engineer, yo!
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
// In processing, the keyPressed and keyReleased events don't 
// always line up with the framerate. With a boolean array, the keys are 
// detected here, then handled during the draw loop. 
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