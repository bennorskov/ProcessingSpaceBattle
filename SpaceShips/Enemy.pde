class Enemy { 
  float hitBoxWidth = 40;
  float hitBoxHeight = 40;
  boolean showHitBox = true;
  
  float verticalSpeed = 5;
  float horizontalSpeed = 4;
  boolean wrapScreen = false;
  
  int pointValue = 5;
  String nameOfEnemyImage = "noPicture";
  
  int health = 1; 
  
  //
  // ––––––––––––––––– Don't edit below here –––––––––––––– //
  // (well, you can if you want, but it might mess stuff up)
  //
  
  boolean isAlive = true;
  PVector pos, speed;
  PImage enemyGraphix;
  boolean useImage = false;
  float leftSide, rightSide, top, bottom;
  
  Enemy (float x, float y){
    pos = new PVector(x, y);
    float ranNegW = (random(2) > 1) ? -1 : 1;
    float ranNegH = (random(2) > 1) ? -1 : 1;
    speed = new PVector(verticalSpeed * ranNegW, horizontalSpeed * ranNegH);
    
    if (nameOfEnemyImage != "noPicture") {
      enemyGraphix = loadImage(nameOfEnemyImage);
      useImage = true;
    }
  }
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (useImage) {
      image(enemyGraphix, 0, 0);
      if (showHitBox) {
        stroke(#FF99FF);
        strokeWeight(4);
        noFill();
        rect(0, 0, hitBoxWidth, hitBoxHeight);
      }
    } else {
      fill(#ff0000);
      noStroke();
      rect(0, 0, hitBoxWidth, hitBoxHeight);
    }
    popMatrix();
  }
  void move() {
    pos.add(speed);
    
    if (wrapScreen) {
      if (leftSide > width) {
        pos.x = hitBoxWidth * -.5;
      }else if (rightSide < 0) {
        pos.x = width + hitBoxWidth*.5;
      }
      if (top > height) {
        pos.y = hitBoxHeight * -.5;
      }else if (bottom < 0) {
        pos.y = height + hitBoxHeight * .5;
      }
    } else {
      //bounce off edges
      if (rightSide > width) {
        pos.x = width + hitBoxWidth * -.5;
        speed.x *= -1;
      } else if (leftSide < 0) {
        pos.x = hitBoxWidth*.5;
        speed.x *= -1;
      }
      if (bottom > height) {
        pos.y = height + hitBoxHeight * -.5;
        speed.y *= -1;
      }else if (top < 0) {
        pos.y = hitBoxHeight * .5;
        speed.y *= -1;
      }
    }
    
    //set up hitbox sides
    leftSide = pos.x -hitBoxWidth*.5;
    rightSide = pos.x + hitBoxWidth*.5;
    top = pos.y - hitBoxHeight*.5;
    bottom = pos.y + hitBoxHeight*.5;
  }
  
  void hit() {
    health-=1;
    if (health <= 0 ) {
       isAlive = false;
    }
  }
}