/*
  Diagrama de bifurcação
  
  Pedro Veneroso, 2018
  GNU GPLv3
  
  Referência:
  xt+1 = r*xt*(1-xt);
*/

PFont font;
float iterations = 80;
float offset = 50;
float spacing;
float xt0 = 0.6;

float max_r = 4.0;
float inc = 0.001;

void setup(){
  size(1000,500);
  background(200);
  font = createFont("Arial", 12);
  textFont(font);
  textSize(12);
  float r_iterations = (max_r-2.4)/inc;
  spacing = (width-offset*2)/r_iterations;
  strokeWeight(0.4);
  fill(0);
}

void draw(){
  background(200);
  stroke(0);
  PVector current_point = new PVector(0,0);
  
  for(float i = 2.4; i < max_r; i+=inc){
    current_point.x = map(i,2.4, max_r,offset,width-offset);
    
    //xt0 = 0.6;

    for(int j = 0; j < iterations; j+=1){
      float xt = i*xt0*(1-xt0);
      xt0 = xt;
      current_point.y = map(xt, 0, 1, height-50, 50);
      point(current_point.x, current_point.y);
    }
  }
  
  //iterations+=5;
  text("iterations = " + iterations, 10,20);
}
