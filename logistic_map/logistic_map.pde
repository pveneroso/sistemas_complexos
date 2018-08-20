float r = 2;
float basext = 0.2;
float xt = basext;
PFont font;
float radius = 3.2;
float inc = 0.001;
float iterations = 160;
float offset = 50;
float spacing;

//xt+1 = r*xt*(1-xt);

void setup(){
  size(1000,500);
  background(200);
  font = createFont("Arial", 12);
  textFont(font);
  textSize(12);
  spacing = (width-offset*2)/iterations;
  strokeWeight(0.4);
  fill(0);
}

void draw(){
  background(200);
  stroke(0);
  PVector current_point = new PVector(offset, map(xt, 0, 1, height-100, 100)); 
  PVector next_point = new PVector(0,0);
  ellipse(current_point.x, current_point.y, radius*2, radius*2);
  
  for(int i = 1; i<iterations; i++){
    next_point.x = offset+(i * spacing);
    float xt1 = r*xt*(1-xt);
    next_point.y = map(xt1, 0, 1, height-100, 100);
    xt = xt1;
    noStroke();
    ellipse(next_point.x, next_point.y, radius*2, radius*2);
    stroke(0);
    line(current_point.x, current_point.y, next_point.x, next_point.y);
    current_point.x = next_point.x;
    current_point.y = next_point.y;
  }
  //basext+=inc;
  //r+=inc;
  xt = basext;
  
  text("xt = " + xt, 10,20);
  text("r = " + r, 10,34);
  
}

void keyPressed(){
  if(key == 'p'){
    basext+=0.05;
    if(basext>=1){
      basext = 1;
    }
  }
  else if(key == 'o'){
    basext-=0.05;
    if(basext<=0){
      basext = 0;
    }
  }
}
