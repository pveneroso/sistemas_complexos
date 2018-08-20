class Particle {
  PVector position, speed, acc;
  int where;
  float max_speed; // 1.5, 5, 10 //2.5 para TWO_PI*4

  Particle(float _max_speed) {
    max_speed = _max_speed;
    position = new PVector(random(0, width), random(0, height));
    speed = new PVector(random(-.1, .1), random(-.1, .1));
    acc = new PVector(0, 0);
  }

  void update(PVector _in, int _where) {
    // para reconhecer quando a partícula entra na célula afetada por um novo vetor
    //if(where != _where){
    //  where = _where;
    //  speed.add(_in);
    //}

    //speed = _in;  // vetor da partícula é igualado ao vetor do campo
    speed.add(_in); // vetor afeta velocidade da partícula diretamente
    //acc.add(_in); // vetor afeta aceleração da partícula (afeta velocidade indiretamente)
  }

  void move() {
    speed.add(acc);
    speed.limit(max_speed); 
    position.add(speed);
    boundaries();
    display();
  }

  void display() {
    stroke(180,0,0);
    point(position.x, position.y);
  }

  void boundaries() {
    if (position.x <= 0) {
      position.x = width;
    } else if (position.x >= width) {
      position.x = 0;
    }
    if (position.y <= 0) {
      position.y = height;
    } else if (position.y >= height) {
      position.y = 0;
    }
  }
}
