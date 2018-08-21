class Particle {
  PVector position, speed, acc;
  int where;
  float max_speed; // 1.5, 5, 10 //2.5 para TWO_PI*4
  ArrayList<PVector> states = new ArrayList<PVector>(); // array de posições das partículas do rastro
  int limit = 50; // limite de partículas do rastro

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
    
    // acrescenta partículas no rastro e remove do início se 
    // o tamanho do array list for maior que o limite
    states.add(new PVector(position.x, position.y));
    if(states.size() >= limit){
      states.remove(0);
    }
  }
  
  color addColor(color c1, color c2){
    // método para tirar a média simples entre soma da cor da partícula
    // ou do rastro com a cor atual de determinado pixel no pixels[]
    int r = int((red(c1)+red(c2))/2);
    int g = int((green(c1)+green(c2))/2);
    int b = int((blue(c1)+blue(c2))/2);
    return color(r, g, b);
  }

  void display() {
    int index = 0;
    
    // desenha o rastro
    for(int i = 0; i < states.size(); i++){
      PVector pos = states.get(i);
      index = (int(pos.y)*(width))+int(pos.x);
      pixels[index] = addColor(color(map(i, 0, limit-1, 0, 180),0,0), pixels[index]);
    }
    
    // desenha a partícula na posição atual
    index = (int(position.y)*(width))+int(position.x);
    pixels[index] = addColor(color(230,230,180), pixels[index]);
  }

  void boundaries() {
    // checa se a partícula está dentro da tela
    if (position.x <= 0) {
      position.x = width-1;
    } else if (position.x >= width) {
      position.x = 0;
    }
    if (position.y <= 0) {
      position.y = height-1;
    } else if (position.y >= height) {
      position.y = 0;
    }
  }
}
