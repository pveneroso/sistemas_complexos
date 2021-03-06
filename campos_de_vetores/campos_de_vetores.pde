/*
  Interação de sistema de partículas com campo
  de vetores manipulado por perlin noise
  
  Pedro Veneroso, 2018
  GNU GPLv3
*/

PVector[] vector_field;
int lin, col;
Particle[] particles;

// CONFIGURAÇÕES
int numparticles = 5400; // ref. 5400
int cell_size = 10; // ref. 10
float max_speed = 1.5; // ref. 1.5
float inc = .2; // ref. 0.2
float z = 0; // ref. 0
float zoff = 0.005; // ref. 0.005
int twopi = 2; // ref. 2

// SALVAR IMAGENS
boolean enabled = false; // setar em verdadeiro para salvar
String path = "";
int framecounter = 0;
String format = ".tif";
String folder = "01"; // nome da pasta onde as imagens devem ser salvas

void setup(){
  size(1000,1000, P2D);
  background(0);
  lin = height/cell_size;
  col = width/cell_size;
  vector_field = new PVector[lin*col];

  particles = new Particle[numparticles];
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle(max_speed);
  }
  
  // Caminho para salvar imagens e nome do arquivo
  path = "data/"+folder+"/NUM_" + numparticles + "_TWO_PI_" + twopi + "_MAX_SPEED_" +
         max_speed + "_ZOFF_" + zoff + "_INC_" + inc + "_";
}

void draw(){
  noStroke();
  fill(0, 4);
  rect(0,0,width,height);
  
  // Atualização do campo de vetores
  for(int i = 0; i < lin*col; i++){
    int x = i%col;
    int y = floor(i/col);
    float angle = noise(x*inc, y*inc, z) * TWO_PI * twopi;
    vector_field[i] = PVector.fromAngle(angle);
    //vector_field[i].setMag(15); // possibilidade de setar magnitude do vetor
  }
  z+=zoff; // comentar para que o campo de vetores permaneça fixo
  
  // Atualização do sistema de partículas
  for(int i = 0; i < particles.length; i++){
    int x = floor(particles[i].position.x/cell_size);
    int y = floor(particles[i].position.y/cell_size);
    int index = (y*col)+x;
    if(index >= 0 && index < vector_field.length){
      particles[i].update(vector_field[index], index);
    }
    particles[i].move();
  }

  //showVectorField(); // mostrar campo de vetores
  //println(frameRate);
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
