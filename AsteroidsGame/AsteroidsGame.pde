/* * * * * * * * * * * * * * * * * * * * * * *
 Class variable declarations here
 */
//Star[] starField;
Star star1;
Star[] stars;

Spaceship player1;
//Asteroid[] asteroids;

ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets; 


/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing <-
boolean ROTATE_RIGHT; //User is pressing ->
boolean MOVE_FORWARD; //User is pressing ^ arrow
boolean SPACE_BAR;    //User is pressing space bar


float speed_average = 0;
/* * * * * * * * * * * * * * * * * * * * * * *
 Initialize all of your variables and game state here
 */
public void setup() {
  fullScreen();
  bullets = new ArrayList<Bullet>();
  asteroids = new ArrayList<Asteroid>();
  int maxAsteroid = 4;
  //initialize starfield
  stars = new Star[1000];
  for (int i=0; i< stars.length; i++) {
    int x = (int) (2*width*Math.random());
    int y = (int) (2*height*Math.random());
    int r = (int) (2*Math.random())+1;

    stars[i] = new Star(x, y, r);
  }

  star1 = new Star(width/2, height/2, 3);

  //initialize your asteroid array and fill it

  for (int i = 0; i <= maxAsteroid; i++) { 
    int Ast_x = (int) (width*Math.random());
    int Ast_y = (int) (height*Math.random());
    int Ast_r = (int) (50*Math.random())+5;
    float speedNum= (random(-3, 3));        
    float newDirection = (random(0, 360));
    Asteroid tempA = new Asteroid(Ast_x, Ast_y, speedNum, newDirection, Ast_r);
    asteroids.add(tempA);
  }






  //initialize ship
  int SpaS_x = (int) (width*Math.random());
  int SpaS_y = (int) (height*Math.random());
  player1 = new Spaceship(SpaS_x, SpaS_y);
  int collision = 0;
}


/* * * * * * * * * * * * * * * * * * * * * * *
 Drawing work here
 */
public void draw() {
  //your code here
  star1.show();
  background(0);

  textSize(32);
  text(bullets.size(), 10, 30); 
  fill(0, 102, 153);
  text(asteroids.size(), 10, 60);
  fill(0, 255, 153, 51);
  text(player1.health, 10, 90);
  fill(0, 40, 170, 51);
  text(player1.exp, 10, 120);
  fill(0, 479, 170, 51);
  text(player1.extraLives, 10, 150);
  fill(0, 479, 170, 51);
  


  //Draw Starfield first 
  //TODO: Part I


  //Check bullet collisions
  //TODO: Part III or IV - for not just leave this comment
  maxSpeed();
  removeToLimit(100);
  displayAll();//displays All
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.move();

    if (bullet.bullet_showing == false)bullets.remove(i);
  }


  //TODO: Part II, Update each of the Asteroids internals

  for (int i = asteroids.size()-1; i >= 0; i--) {
    Asteroid asteroid = asteroids.get(i);

    for (int o = asteroids.size()-1; o >= 0; o--) {
      Asteroid asteroidO = asteroids.get(o);


      if (asteroid.collidingWith(asteroidO)== true) {

        asteroid.collision = 1;
        asteroid.speed = (asteroid.speed * (asteroid.radius - asteroidO.radius) + (2 * asteroidO.radius * asteroidO.speed)) / (asteroid.radius + asteroidO.radius);


        pushMatrix();
        translate(asteroid.x, asteroid.y);
        color c = color(255, 204, 0);  // Define color 'c'
        textSize(32);
        fill(c);
        text(asteroid.speed, 10, 30);
        popMatrix();
      }

      if (asteroidO.collidingWith(asteroid)== true) {

        asteroid.collision = 1;

        asteroidO.speed = (asteroidO.speed * (asteroidO.radius - asteroid.radius) + (2 * asteroid.radius * asteroid.speed)) / (asteroid.radius + asteroidO.radius);

        pushMatrix();
        translate(asteroidO.x, asteroidO.y);
        color c = color(255, 204, 0);  // Define color 'c'
        textSize(32);
        fill(c);
        text(asteroidO.speed, 10, 30);
        popMatrix();
      }
      asteroid.update();
      asteroid.update();

      if (player1.collidingWith(asteroid)==true) {
        player1.health = player1.health - asteroid.radius;
        if (player1.health < 0) {
          player1.health = 100;
          player1.extraLives--;
        }
        if (player1.health == 0 && player1.extraLives == 0) {
        }
      }
      for (int bi = bullets.size()-1; bi >= 0; bi--) {
        Bullet bullet = bullets.get(bi);
        if (asteroid.collidingWith(bullet)== true) {
          if (asteroid.radius<60) {
            asteroid.radius = asteroid.radius*.95;
          }
          if (asteroid.radius<40) {
             asteroid.radius = asteroid.radius*.90;
          }
          bullets.remove(bullet);
          player1.exp = player1.exp + (asteroid.radius*.02);
          if (asteroid.radius < 5) {
            asteroids.remove(asteroid);
            player1.exp = player1.exp + 5;
            asteroid.update();
            asteroid.show();
          }
        }
      }
    }
  }

  //Check for asteroid collisions against other asteroids and alter course
  //TODO: Part III, for now keep this comment in place

  //Draw asteroids
  //TODO: Part II

  //Update spaceship
  //TODO: Part I

  player1.show();
  player1.keyPressed();
  player1.update();
  player1.move();

  //Check for ship collision agaist asteroids
  //TODO: Part II or III

  //Draw spaceship & and its bullets
  //TODO: Part I, for now just render ship
  //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
  //so for now we'll just leave this comment and come back to it in a bit. 

  //Update score
  //TODO: Keep track of a score and output the score at the top right
}

void displayAll()
{
  for (Bullet temp : bullets)
  {
    temp.show();
  }
  for (Asteroid asteroid : asteroids)
  {
    asteroid.show();
    asteroid.update();
  }
  for (int i=0; i< stars.length; i++) {
    stars[i].show();
  }
}

void removeToLimit(int maxLength)
{
  while (bullets.size() > maxLength )
  {
    bullets.remove(0);
  }
}
void maxSpeed() {
  for (Asteroid asteroid : asteroids) {
    if (asteroid.speed > 5) {
      asteroid.speed -= 5;
    }
    if (asteroid.speed < -5) {
      asteroid.speed += -5;
    }
  }
}
/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent key presses for our game
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      ROTATE_LEFT = true;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = true;
    } else if (keyCode == UP) {
      MOVE_FORWARD = true;
    }
  }

  //32 is spacebar
  if (keyCode == ' ') { 
    Bullet temp = new Bullet(player1.x, player1.y, player1.direction + 90);
    bullets.add(temp);
  }
}



/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevant key releases for our game.
 */
void keyReleased() {  
  if (key == CODED) { 
    if (keyCode == LEFT) {
      ROTATE_LEFT = false;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = false;
    } else if (keyCode == UP) {
      MOVE_FORWARD = false;
    }
  }
  if (keyCode == ' ') {
    SPACE_BAR = false;
  }
}
