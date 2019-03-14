/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 All objects in this world that move must implemnt the Movalbe interface.
 */
interface Movable {
  /*
    Return the x location of the Movable
   */
  float getX();

  /*
    Return the y location of the Movable
   */
  float getY();

  /*
    Return the direction of the Movable in degrees.
   */
  float getDirection();

  /*
   Return the speed of the Movable.
   The speed you use is a relative value and will
   feel different for different frame rates. For example,
   if frameRate is set to 48, then a speed of 1 would move 48 pixels 
   per second.
   */
  float getSpeed();

  float getYSpeed();

  float getXSpeed();

  /*
   Return the radius of influence. If you could draw a circle
   around your object, then what would this radius be.
   */
  float getRadius();

  /* 
   Sets the direction of the Movable
   */
  void setDirection(float newDirectionInDegrees);

  /* 
   Sets the speed of the Movable
   */
  void setSpeed(float newSpeed);

  /*
   Update the internals of the instance
   */
  void update(); 

  /*
    Display the isntance
   */
  void show();

  /*
   Return true if the instance of Movable is "colliding with" 
   the movable referred to by object.  *Note* An object should not
   be able to collide with iteself.
   */
  boolean collidingWith(Movable object);
}
//END OF Movable Interface




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Abstract base class Mover 
 */
abstract class Mover implements Movable {

  protected float x, y;
  protected float speed;
  protected float direction;
  protected int myColor;
  protected float radius;  

  /*
    Default Mover, not actually moving and directionless
   */
  Mover(float x, float y) {
    //The line below shows how we can 
    //link this constructor to the constructor below through "this"
    this(x, y, 0, 0);
  }

  /*
    Mover constructor specifying x, y position along with its speed and
   direction (in degrees)
   */
  float x_speed= 0;
  float y_speed= 0;
  Mover(float x, float y, float speed, float direction) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.direction = direction;
    myColor = 225;
    radius = 0.0;
  }

  /*
    Most of your movalbe objects should follow this pattern.
   */
  void update() {
    x = x + speed*(float)Math.cos(radians(direction));
    y = y + speed*(float)Math.sin(radians(direction));




    //todo: You need to decide what to do when X is less than 0 or greater than width
    if (x<-radius)x=width+radius;
    if (x>width+radius)x=-radius;

    //todo: You need to decide what to do when Y is less than 0 or greater than height
    if (y<-radius)y=height+radius;
    if (y>height+radius)y=-radius;
  }

  void keyPressed() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        ROTATE_LEFT = true;
      } else {
        ROTATE_LEFT = false;
      }
    }
    if (keyCode == RIGHT) {
      ROTATE_RIGHT = true;
    } else {
      ROTATE_RIGHT = false;
    }

    if (keyCode == UP) {
      MOVE_FORWARD = true;
    }
  }


  /*
    Save this for your subclasses to override.
   but notice how it is tagged with abstract, meaning 
   it is incomplete. (It's like an I.O.U.)
   */
  abstract void show();


  /*
    TODO: Part 4: Implement collision detection
   */
  boolean collidingWith(Movable m) {
    boolean WorldsCollide = false;
    int time = 100;
    double collisionDistance = 0;
    
    if (x + radius + m.getRadius() > m.getX() 
      && x < m.getX() + radius + m.getRadius()
      && y + radius + m.getRadius() > m.getY()
      && y < m.getY() + radius + m.getRadius())
    {
      collisionDistance = Math.sqrt(
        ((x - m.getX()) * (x - m.getX()))
        + ((y - m.getY()) * (y - m.getY()))
        );
      if (collisionDistance+2 <radius + m.getRadius())
      {
        
        float d = dist(x, y, m.getX(), m.getY());

        if (time == 100) {
          if (d <= radius + m.getRadius()) {
            if (x< m.getX()) {
              WorldsCollide = true;
              time--;
            }
            if (y>m.getY()) {
              WorldsCollide = true;
              time--;
            }
            if (y< m.getY()) {
              WorldsCollide = true;
              time--;
            }
            if (y> m.getY()) {
              WorldsCollide = true;
              time--;
            }
          }
        }
      }
    }
    return WorldsCollide;
  }

  //TODO: Part I: implement the methods of Moveable interface - delete this comment
}
