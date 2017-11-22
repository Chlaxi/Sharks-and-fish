//By Chloe Parbst

public class Waypoint {
  PVector pos;
  float strength = 100;

  public Waypoint(PVector pos) {
    this.pos = pos.copy();  //Copies the value of the given vector.
  }

  public void newWaypoint(PVector loc) {    
    //generates a random position for the waypoint
    int x = round(loc.y+random(-150, 150));
    int y = round(loc.y+random(-150, 150));
    //Makes sure, that the waypoint is within the screen.
    if (x < 0) x = 10;  
    if (x > width) x = width-10;
    if (y < 0) y = 10;  
    if (y > height) y = height-10;
    pos = new PVector(x, y);
  }

  PVector pull(Fish f) {

    PVector dir = PVector.sub(pos, f.pos);  //Gets the vector from the fish to the waypoint
    float d = dir.mag();                    //Gets the magnitude of the vector, and stores it in a variable.
    dir.normalize();                        //Normalizes the vector
    d = constrain(d, 20, strength);    //The force multiplier is based on the remaining distance.
                                   //It is constrained by the strength variable, and gets stronger the closer it gets.
    float force = strength / (d * d);  //The closer the fish is to the waypoint, the stronger the pull is.
    dir.mult(force);                //The vector is mulitplied by the force.
                            //The force ranges from 0.04 to 0.01.
    return dir;          //The vector is the returned.
  }
}