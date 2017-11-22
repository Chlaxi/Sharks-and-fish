//By Chloe Parbst  //<>//

static boolean debugMode; //Debug mode. //<>// //<>// //<>//
ArrayList<Fish> fishList = new ArrayList<Fish>();  //The arraylist, which contains the fishes
ArrayList<Shark> sharkList = new ArrayList<Shark>();;                        //The arraylist, which contains the sharks


void setup() {
  size(800, 600);      //Sets the size of the screen.
  sharkList.add(new Shark());      //adds a shark
  for (int i=0; i < 100; i++) {            //Loops a hundred times.
    //Adds a Fish object to the fishList. The Fish gets a random position.
    fishList.add(new Fish(round(10+random(width-10)), round(10+random(height-10))));
  }
}

void draw() {
  background(160, 205, 255);  //Draws the background in a watery colour.
  for (Fish f : fishList) {    // For each Fish in fishList..
    f.update();              //Call the update function..
    f.drawFish();          //..And the drawFish() function.
  }
  for (int i = 0; i < sharkList.size(); i++) {  //Runs through the sharkList
    Shark shark = sharkList.get(i);             //Gets the shark in the list.
    shark.update();                             //Calls the shark's update function.
    applyRepeller(shark);                       //calls the applyRepeller, using the shark as the argument.
    if(shark.isDead){                            //Checks whether the shark is dead.
     sharkList.remove(shark);                      //If it is, remove it from the list.
     sharkList.add(new Shark());
    }
  }

}

void applyRepeller(Shark s) {
  for (Fish f : fishList) {    //For each fish in fishList
    PVector push = s.repel(f);     //call the repel function from the shark.
    f.applyForce(push);          //And apply the force.
  }
}

//Debugging
void mouseReleased() {
  if (mouseButton== LEFT) {    //Spawn a fish
    fishList.add(new Fish(mouseX, mouseY));

  }
  if (mouseButton== RIGHT) {    //Spawn a shark.
    sharkList.add(new Shark());
  }
}

void keyReleased() {  
  if(key == 'r'){
        sharkList.clear();
  }
  if (key == 'd') {  //Toggles debugmode, when the d key is released.
    debugMode = !debugMode;
  }
}