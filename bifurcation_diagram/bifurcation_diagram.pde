
PFont font;
float radius = 3.2;
float iterations = 80;
float offset = 50;
float spacing;
float xt0 = 0.6;
float xt00 = xt0;

float max_r = 4.0;
float inc = 0.001;
//xt+1 = r*xt*(1-xt);

void setup(){
  size(1000,500);
  background(200);
  font = createFont("Arial", 12);
  textFont(font);
  textSize(12);
  float it = (max_r-2.4)/inc;
  spacing = (width-offset*2)/it;
  //println(spacing);
  strokeWeight(0.4);
  fill(0);
}

void draw(){
  background(200);
  stroke(0);
  //PVector current_point = new PVector(offset, map(xt, 0, 1, height-100, 100)); 
  PVector next_point = new PVector(0,0);
  //ellipse(current_point.x, current_point.y, radius*2, radius*2);
  
  for(float i = 2.4; i < max_r; i+=inc){
    next_point.x = map(i,2.4, max_r,offset,width-offset);
    //xt0 = 0.6;

    for(int j = 0; j < iterations; j+=1){
      float xt1 = i*xt0*(1-xt0);
      xt0 = xt1;
      next_point.y = map(xt1, 0, 1, height-50, 50);
      point(next_point.x, next_point.y);
    }
  }
  //iterations+=5;
  //xt0=xt00+0.01;
  //println(xt0);
  text("iterations = " + iterations, 10,48);
  
}
