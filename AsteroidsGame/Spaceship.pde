/*
  Spaceship class
 Should extend Mover class and implement show.
 You may add additional methods to this class, for example "rotate" and "accelerate" 
 might be useful.
 */
class Spaceship extends Mover {  

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getDirection() {
    return direction;
  }

  float getSpeed() {
    return speed;
  }

  float getYSpeed() {
    return y_speed;
  }

  float getXSpeed() {
    return x_speed;
  }

  float getRadius() {
    return radius;
  }
  void setDirection(float newDirectionInDegrees) {
  }
  void setSpeed(float newSpeed) {
  }

  float health = 100;
  float exp = 0;
  int extraLives = 3;
  Spaceship(float Spas_x, float Spas_y) {
    super(Spas_x, Spas_y);
    x = Spas_x;
    y = Spas_y;
    
    speed = 1;
    direction = 0;
    x = x + speed*(float)Math.cos(radians(direction));
    y = y + speed*(float)Math.sin(radians(direction));
    health = 100;
    exp = 0;
    extraLives = 3;
  }

  void move() {
    if (ROTATE_LEFT)
      direction -= 1.0;
    if (ROTATE_RIGHT)
      direction += 1.0;

    if (MOVE_FORWARD == true) {
      if (speed<3) {
        speed += 0.3;
      }
    }
  }

  void show() {
    pushMatrix();
    noStroke();
    fill(251, 255, 227);
    translate(x, y);
    rotate(radians(direction));

    triangle(-10, -10, -10, 10, 20, 0);
    popMatrix();
  }
}
