ArrayList<Pair> couples = new ArrayList<Pair>();

// hsb and tint so each pair can be noticed

void setup() {

  size(720, 720);
  noStroke();
  frameRate(24);
  
  for (int i = 0; i < 5; i++) {
    couples.add(new Pair(i));
  } 

}

void draw() {

  background(255);

  // for (Pair current : couples) { current.move(); current.display(); }
  for (int i = 0; i < couples.size(); i++) {
    Pair current = couples.get(i);
    current.move();
    current.display();
    if (current.collision) {
      current.effects();
      if (current.lifeDeath()){ couples.remove(i); }
      if (!current.lifeDeath()){ couples.add(new Pair(couples.size()+1)); }
    }
  }
}



class Pair {
  
  int index;
  boolean collision;
  PVector bigLocation, smallLocation, bigVelocity, smallVelocity, gravity;
  float bigSize, smallSize;

  Pair(int passedIndex) {
    
    index = passedIndex;
    collision = false;
    bigLocation = new PVector(random(width), random(height));
    smallLocation = new PVector(random(width), random(height));
    bigVelocity = new PVector(0.3, 0.4);
    smallVelocity = new PVector(0.4, 0.5);
    gravity = new PVector(0.1, 0.2);
    bigSize = width / 8;
    smallSize = width / 16;
    
  }
  
  void display() {
    
    // FILL & CREATE BIG CIRCLE
    fill(200);
    circle(bigLocation.x, bigLocation.y, bigSize);
    fill(0); text(index, bigLocation.x-6, bigLocation.y+6);

    // FILL & CREATE SMALL CIRCLE
    if(dist(smallLocation.x, smallLocation.y, bigLocation.x, bigLocation.y) < (smallSize/2) + (bigSize/2)){
      fill(0, 200, 0);
      collision = true;
    }
    else { fill(0, 255, 0); }
    circle(smallLocation.x, smallLocation.y, smallSize);
    fill(0); text(index, smallLocation.x-6, smallLocation.y+6);

  }
  
  void effects() {
    smallSize = width/4;
    bigSize = width/2;
  }
  
  void move() {

    bigLocation.add(bigVelocity);
    smallLocation.add(smallVelocity);
    bigVelocity.add(gravity);
    smallVelocity.add(gravity);
    
    /* if ( bigLocation.x > width ) { bigLocation.x = 0; }
    if ( smallLocation.x > width ) { smallLocation.x = 0; }
    if ( bigLocation.y > height ) { bigLocation.y = 0; }
    if ( smallLocation.y > height ) { smallLocation.y = 0; } */
    
    if ( bigLocation.x + (bigSize / 2) > width ) { bigVelocity.x = abs(bigVelocity.x) * -1; }
    if ( bigLocation.x < (bigSize / 2) ) { bigVelocity.x = abs(bigVelocity.x); }
    if ( bigLocation.y + (bigSize / 2) > height ) { bigVelocity.y = abs(bigVelocity.y) * -1; } 
    if ( bigLocation.y < (bigSize / 2) ) { bigVelocity.y = abs(bigVelocity.y); }
    if ( smallLocation.x + (smallSize / 2) > width ) { smallVelocity.x = abs(smallVelocity.x) * -1; }
    if ( smallLocation.x < (smallSize / 2) ) { smallVelocity.x = abs(smallVelocity.x); }
    if ( smallLocation.y + (smallSize / 2) > height ) { smallVelocity.y = abs(smallVelocity.y) * -1; } 
    if ( smallLocation.y < (smallSize / 2) ) { smallVelocity.y = abs(smallVelocity.y); }
  
  }
  
  boolean lifeDeath() {
    int coinFlip = round(random(1));
    return boolean(coinFlip);
  }

}
