class Bullet {
  
  float hitBoxWidth = 20;
  float hitBoxHeight = 20;
  boolean showHitBox = true;
  float bulletSpeed = 10;
  
  String nameOfBulletImage = "noPicture";
  
  //
  // ––––––––––––––––– Don't edit below here –––––––––––––– //
  // (well, you can if you want, but it might mess stuff up)
  //
  
  PImage bulletGraphix;
  boolean useImage = false;
  boolean isAlive = true;
  PVector pos, speed;
  float leftSide, rightSide, top, bottom;
  
  Bullet(float x, float y) {
    pos = new PVector(x, y);
    speed = new PVector(0, -bulletSpeed);
    
    if (nameOfBulletImage != "noPicture") {
      bulletGraphix = loadImage(nameOfBulletImage);
      useImage = true;
    }
  }
  
  void display() {
    if (useImage) {
      image(bulletGraphix, pos.x, pos.y);
      if (showHitBox) {
        stroke(#FF99FF);
        strokeWeight(3);
        noFill();
        rect(0, 0, hitBoxWidth, hitBoxHeight);
      }
    } else {
      fill(100);
      noStroke();
      ellipse(pos.x, pos.y, hitBoxWidth, hitBoxWidth);
      stroke(#FF99FF);
      strokeWeight(3);
      noFill();
      rect(pos.x, pos.y, hitBoxWidth, hitBoxHeight);
    }
  }
  void move() {
    pos.add(speed);
    //set up hitbox sides
    leftSide = pos.x - hitBoxWidth*.5;
    rightSide = pos.x + hitBoxWidth*.5;
    top = pos.y - hitBoxHeight*.5;
    bottom = pos.y + hitBoxHeight*.5;
  }
}