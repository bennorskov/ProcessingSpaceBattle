class Enemy {
  PVector pos, speed;
  PImage enemyGraphix = new PImage(); 
  float hitBoxWidth = 40;
  float hitBoxHeight = 40;
  boolean showHitBox = true;
  boolean isAlive = true;
  
  float leftSide, rightSide, top, bottom;
  Enemy (float x, float y){
    pos = new PVector(x, y);
    speed = new PVector(0, 0);
  }
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (enemyGraphix.isLoaded()) {
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
  
  //set up hitbox sides
    leftSide = pos.x -hitBoxWidth*.5;
    rightSide = pos.x + hitBoxWidth*.5;
    top = pos.y - hitBoxHeight*.5;
    bottom = pos.y + hitBoxHeight*.5;
  }
}