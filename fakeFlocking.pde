int max = 10;
float size;
PVector[] location = new PVector[max];
PVector[] velocity = new PVector[max]; 

void setup() { 

  size(720, 720); 
  fill(245); stroke(250);
  
  size = width / 32;
  for (int i = 0; i < max; i++) {
    location[i] = new PVector(random(1), random(1)); // 0, random(height) // try random(-1,1)
    velocity[i] = new PVector(0.005, 0.002);
  }

}   



void draw() {   
  
  background(255);  
  
  for (int i = 0; i < max; i++) {
    PVector particle = location[i].add(velocity[i]);
    PVector noiseMovement = new PVector(noise(particle.x) * width, noise(particle.y) * height);
    circle(noiseMovement.x, noiseMovement.y, size);
  }

}
