class Bullet extends Mover {
  float getX() {
    return xb;
  }
  float getY() {
    return yb;
  }
  float getDirection() {
    return direction;
  }

  float getSpeed() {
    return speed;
  }

  float getYSpeed() {
    return 0;
  }
  float getXSpeed() {
    return 0;
  }

  float getRadius() {
    return radius;
  }
  void setDirection(float newDirectionInDegrees) {
  }
  void setSpeed(float newSpeed) {
  }



  float xb = -800;//initial x
  float yb = -800;//initial y
  float angb = 0;//initial angle
  float radiusb = 5; //movement speed for bullet
  boolean bullet_showing = false;

  Bullet(float sx, float sy, float angs) {
    super(sx, sy);
    xb = sx;
    yb = sy;
    angb = angs;
    
    
  }
  void move() {


    if (xb<-5)bullet_showing = false;
    if (xb>width+5)bullet_showing = false;

    //todo: You need to decide what to do when Y is less than 0 or greater than height
    if (yb<-5)bullet_showing = false;
    if (yb>height+5)bullet_showing = false;
  }
  void show() {


    //draw bullet
    //move it first
    if (angb != -100) {
      //convert polar coordinates to cartesian in order to move (towards pointing angle)
      float moveX = radiusb * sin(radians(angb)); 
      float moveY = -radiusb * cos(radians(angb));

      xb += moveX;
      yb += moveY;
    }
    pushMatrix();
    fill(255, 0, 0);

    ellipse(xb, yb, 10, 10);
    bullet_showing = true;
    popMatrix();
  }
}
