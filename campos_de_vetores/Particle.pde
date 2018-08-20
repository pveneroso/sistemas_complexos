class Particle{
  PVector position, speed, acc;
  int where;
  float max_speed; // 1.5, 5, 10 //2.5 para TWO_PI*4
  
  Particle(float _max_speed){
    max_speed = _max_speed;
    position = new PVector(random(0,width), random(0,height));
    speed = new PVector(random(-.1,.1), random(-.1,.1));
    acc = new PVector(0,0);
  }
  
  void update(PVector _in, int _where){
    //if(where != _where){
    //  where = _where;
      //speed=_in;
      
          speed.add(_in);
          //speed.limit(1.5);
      //speed.normalize();
    //}
    
    //speed = _in;
    
    //acc.add(_in);
  }
  
  void move(){
    speed.add(acc);
    speed.limit(max_speed); 
    position.add(speed);
    collision();
    display();
  }
  
  void display(){
    //stroke(180,0,0);
    stroke(60,60,220);
    //stroke(255);
    point(position.x, position.y);
  }
  
  void collision(){
    if(position.x <= 0){
      position.x = width;
    }
    else if(position.x >= width){
      position.x = 0;
    }
    if(position.y <= 0){
      position.y = height;
    }
    else if(position.y >= height){
      position.y = 0;
    }
  }
}
