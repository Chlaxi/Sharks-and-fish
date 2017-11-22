//By Chloe Parbst

public class Fish {
  PVector pos, direction, acc, velocity;
  Waypoint waypoint;
  float maxSpeed, dist, angle;
  color colour;
  float mass;
  PImage img = loadImage("fish.png");

  Fish(int x, int y) {  //The constructor for the Fish object, requires to integers. x and y
    pos = new PVector(x, y);  //Sets the pos Vector's values to x and y.
    colour = color(random(255), random(255), random(255));  //Generates a random colour
    waypoint = new Waypoint(pos);  //A new Waypoint object is created, at the position of the fish.
    mass = random(0.5, 2);    //They get a random mass, which affects their maximum speed, acceleration, and size.
    maxSpeed = 1/mass;          //The max speed is calulated based on the mass. It gets faster, the smaller it is.
    velocity = new PVector();   //Creates the velocity vector, as an empty vector.
    acc = new PVector();      //The acc (acceleration) is now an empty vector.
  }

  public void update() {
    dist = pos.dist(waypoint.pos);  //Gets the remaining distance to the waypoint.
    checkOutOfBounds();             //Calls the checkOutOfBounds function.
    applyForce(waypoint.pull(this));  //Calls the applyForce from the waypoint, using this object as the parameter.
    //Adds the acceleration vector to the velocity vector.
    velocity.add(acc);         //This makes sure, that the fish can accelerate, instead of having a fixed speed
    velocity.limit(maxSpeed);      //Limits the velocity vectors length to the maximum speed.
    pos.add(velocity);            //Adds the velocity to the position, which moves the fish.
    acc.mult(0);    //Resets the acceleration, so it only uses it to accelerate, and not continously increases the acc.
    angle = velocity.heading();  //Gets the angle the fish is currently moving in.
    if (dist < 30*maxSpeed) {    //If the distance to the waypoint is less than 30 pixels..
      waypoint.newWaypoint(pos);    //Create a new waypoint.
    }
  }

  public void drawFish() {
    imageMode(CENTER);      //Sets the origin of the image to its center.
    pushMatrix();      //Makes sure, the fish is updated at the same time, allowing scaling and rotation.
    translate(pos.x, pos.y);  //Sets the origin of the fish to it's position. This is the point, where rotations around.
    rotate(angle);      //Rotates the fish, based on its angle.
    scale(mass);          //Scales the fish, based on the mass.
    tint(colour); //Sets the colour of the Fish
    image(img,0,0);      //Draws the fish at the translate position.
   
    popMatrix();    //Updates the matrix.
    //DEBUGGING
    if (debugMode) {  //If debugging is toggled on:
      ellipse(waypoint.pos.x, waypoint.pos.y, 30*maxSpeed, 30*maxSpeed);  //The hitbox for the waypoint.
      ellipse(waypoint.pos.x, waypoint.pos.y, 10, 10);  //Shows the waypoint as an ellipse.

      fill(0);                                          //The text and lines are coloured black.
      text("max: "+maxSpeed, pos.x, pos.y);             //Displays a text, representing the maximum speed..
      text("cur: "+velocity.mag(), pos.x, pos.y+14);    //.. and the current velocity.
      line(pos.x, pos.y, waypoint.pos.x, waypoint.pos.y);  //Draws a line between the fish and the waypoint.
    }
  }

  void applyForce(PVector force) {
    acc.add(force.div(mass));  //Based on Newton's 2nd law, F = M*a, we divide the force with the mass, to get the accelration.
  }

//Adds a force, if the fish leaves the screen.
  void checkOutOfBounds() {
    if (pos.x < -10) applyForce(new PVector(1, 0)); 
    if (pos.x > width+10) applyForce(new PVector(-1, 0));
    if (pos.y < -10) applyForce(new PVector(0, 1));
    if (pos.y > height+10) applyForce(new PVector(0, -1));
  }
}