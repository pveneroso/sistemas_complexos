PVector[] vector_field;
int lin, col;
int cell_size = 10;
Particle[] particles;
float inc = .2;
float z = 0;
boolean enabled = false;
String path = "";
int framecounter = 0;
//PImage lastframe;

String format = ".tif";
int numparticles = 5400;
int twopi = 2; //2
float max_speed = 1.5;//1.5
float zoff = 0.005; // 0.005
String folder = "13";

void setup(){
  size(1000,1000, P2D);
  background(0);
  lin = height/cell_size;
  col = width/cell_size;
  vector_field = new PVector[lin*col];
  //for(int i = 0; i < lin*col; i++){
  //  //int angle = int(random(0,360));
  //  int x = i%col;
  //  int y = floor(i/col);
  //  float angle = noise(x*inc, y*inc) * TWO_PI ;
  //  vector_field[i] = PVector.fromAngle(angle);
  //  //vector_field[i].mult(2);
  //}
  particles = new Particle[numparticles];
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle(max_speed);
  }
  
  path = "data/"+folder+"/NUM_" + numparticles + "_TWO_PI_" + twopi + "_MAX_SPEED_" +
         max_speed + "_ZOFF_" + zoff + "_INC_" + inc + "_";
  //lastframe = createImage(width,height,RGB);
  //println(TWO_PI);
}

void draw(){
  println(frameRate);
  noStroke();
  fill(0, 4);
  rect(0,0,width,height);
  for(int i = 0; i < lin*col; i++){
    //int angle = int(random(0,360));
    int x = i%col;
    int y = floor(i/col);
    float angle = noise(x*inc, y*inc, z) * TWO_PI * twopi;
    vector_field[i] = PVector.fromAngle(angle);
    //vector_field[i].setMag(15);
  }
  z+=zoff; //0.0005 (para TWO_PI*4)
  
  //background(0, 90);
  for(int i = 0; i < particles.length; i++){
    int x = floor(particles[i].position.x/cell_size);
    int y = floor(particles[i].position.y/cell_size);
    int index = (y*col)+x;
    if(index >= 0 && index < vector_field.length){
      particles[i].update(vector_field[index], index);
    }
    particles[i].move();
  }

  //showVectorField();
  framecounter++;
  saveFrame(enabled);
}

void showVectorField(){
  for(int i = 0; i < vector_field.length; i++){
    int x = i%col;
    int y = floor(i/col);
    stroke(255, 255, 0, 30);
    pushMatrix();
    translate(x*cell_size+(cell_size/2) , y*cell_size+(cell_size/2));
    rotate(vector_field[i].heading());
    line(-5,0,5,0);
    popMatrix();
  }
}

void saveFrame(boolean enabled){
  if(enabled){
    save(path+nfs(framecounter,6)+format);
  }
}
