class Bullet {
  PVector pos, speed;
  float hitBoxWidth = 30;
  float bulletSpeed = 10;
  PImage bulletGraphix = new PImage();
  Bullet(float x, float y) {
    pos = new PVector( x, y);
    speed = new PVector(0, -bulletSpeed);
  }
  
  void display() {
    if (bulletGraphix.isLoaded()) {
      image(bulletGraphix, pos.x, pos.y);
    } else {
      fill(100);
      ellipse(pos.x, pos.y, hitBoxWidth, hitBoxWidth);
    }
  }
  void move() {
    pos.add(speed);
  }
}