//By Chloe Parbst  //<>//

public class Shark {
  boolean isDead = false;
  float strength; //Strength functions as both the pushing strength and the radius.
  PVector pos, dir;  //Position and direction
  float angle, speed;  //Angle and speed
  PImage img = loadImage("shark.png");

  public Shark() {
    strength = 200;    //Sets the 
    spawn();
    dir = new PVector();
    speed = 0.2+random(0.8);
    dir = dir.fromAngle(angle);
    dir = dir.mult(speed);
    
  }

  //The spawner
  void spawn() {
    
    int direction = int(random(4));  //Generates a random integer, which choses spawn area of the shark
    switch(direction)
    {
    case 0 :   //If direction is 0..
      // print("south"); //Spawn the shark to the south..
      pos = new PVector(30+int(random(width-30)), height);  //..By giving it a random x position, at the bottom of the screen.
      angle = 225+int(random(90));        //Also give it a random angle, in which it moves, which goes towards the opposite side.
      angle = radians(angle);            //And change the angle to radians.
      break;        
    case 1:       //North
      // print("north");
      pos = new PVector(30+int(random(width-30)), 0);
      angle = 45+int(random(90));
      angle = radians(angle);
      break;
    case 2 :      //East 
     // print("east");
      pos = new PVector(width, 30+int(random(height-30)));
      angle = 135+int(random(90));
      angle = radians(angle);
      break;
    case 3: 
     // print("west");    //West
      pos = new PVector(0, 30+int(random(height-30)));
      angle = 315+int(random(90));
      angle = radians(angle);
      break;
    }
  }

  void update() {
    pos.add(dir);  //Adds the direction vector to the position vector, causing movement.
    drawShark();    //Calls the drawShark function.
    isDead = checkOutOfBounds();      //Checks whether the shark is dead or not. The value is returned from the function.
  }

  void drawShark() {
    imageMode(CENTER);    //Centers the image's origin.
    pushMatrix();    //Creates a pushMatrix, so the shark is visually updated at the same time, in the same way as the Fish.
    translate(pos.x, pos.y);  //Sets the translation's origin to the Shark's center.
    scale(2);        //Scales the shark up
    rotate(angle);  //rotates it by its angle
    tint(125);        //Tints the image in a grey colour.
    image(img, 0, 0);    //Draws the image, at the translate position.
    popMatrix();      //Pops the martix, drawing the shark.
    if (debugMode) {    //DEBUGGING
      line(pos.x, pos.y, pos.x+dir.x*10, pos.y+dir.y*10);  //A line facing the direction, i which the shark moves.
      noFill(); 
      ellipse(pos.x, pos.y, strength*2, strength*2);    //Shows a circle, in which the shark affects the fish.
    }
  }

  PVector repel(Fish f) {  //the shark's repelling "aura"
    PVector dir = PVector.sub(pos, f.pos);  //Gets the vector pointing from the fish to the shark.
    float d = dir.mag();                    //Gets the magnitude, and stores it in a variable.
    dir.normalize();                        //Normalizes the vector.
    d = constrain(d, 1, strength);          //Constrains the d value, so it can't go above a certain threshold, based on it's strength.
    if (d < strength) {                     //The distance to the fish is within the shark's strength..
      float force = -2 * strength / (d * d);  //Set a force, by dividing the strength with the distince multiplied by itself.
      //This is multiplied by -1, so the force is negative, and repels them, rather than attracts them.
      dir.mult(force);                      //The force is then applied to the 
      if (debugMode) {                        //DEBUGGING
        line(pos.x, pos.y, f.pos.x, f.pos.y);  //Draws a line between the affected fish.
      }
      return dir;                  //Returns the vector.
    } else {                        //If the fish is out of range..
      return new PVector(0, 0);    //..Return an empty vector.
    }
  }

  //Checks if the shark is out of bounds, and returns a boolean based on the return value.
  boolean checkOutOfBounds() {
    return pos.x < -10
      || pos.x > width+10 
      || pos.y < -10 
      || pos.y > height+10;
  }
}