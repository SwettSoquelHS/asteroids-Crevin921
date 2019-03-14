/*
  Asteroid class
 Should extend Mover class and implement show.
 
 Initially, your asteroid may just be a simple circle or square
 but the final program should use "beginShap(), vertex(), and endShape()"
 to render the asteroid.
 */
class Asteroid extends Mover {   
  //your code here


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
    return y_Speed;
  }
  float getXSpeed() {
    return x_Speed;
  }

  float getRadius() {
    return radius;
  }
  void setDirection(float newDirectionInDegrees) {
  }
  void setSpeed(float newSpeed) {
  }
  float x_Speed;
  float y_Speed;
  float collision = 0;

  // constructor: creates instance of the class Asteroid
  Asteroid(float x_pos, float y_pos, float news_speed, float newDirection, float radius) {
    super(x_pos, y_pos);
    
    x = x_pos;
    y = y_pos;
    
    speed = news_speed;
    x_speed = speed;
    y_speed = speed;
    this.radius = radius;    
    direction = newDirection;
  }
  void show() {
    pushMatrix();
    float move = radius + 15;
    translate(x, y);
    
    if (collision == 1) {
      color c = color(255, 204, 0);  // Define color 'c'
      textSize(32);
      fill(c);
      text(speed, 10, 30);
      
     
      translate(9,30);
      color e = color(157, 204, 60);  // Define color 'c'
      textSize(32);
      fill(e);
      text(radius, 10, 30);
      
    }
    stroke(204, 200, 0);
    fill(251, 255, 227);
    ellipse(0, 0, radius, radius);

    popMatrix();
  }
}
