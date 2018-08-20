/*
  Mapa logístico
  
  Pedro Veneroso, 2018
  GNU GPLv3
  
  Referência:
  xt+1 = r*xt*(1-xt);
*/

float r = 2; // equivale a r na fórmula de referência
float basext = 0.2; // equivale a xt na fórmula de referência
float xt = basext; // valor a ser atualizado

float inc = 0.001;
float iterations = 160; // resolução do gráfico (maior para mais pontos)

PFont font;
float radius = 3.2; // raio dos pontos no gráfico
float offset = 50; // deslocamento básico do gráfico em relação à origem 0,0
float spacing; // para cálculo do espaçamento entre cada ponto para distribuir
               // os pontos uniformemente na tela

void setup(){
  size(1000,500);
  background(200);
  font = createFont("Arial", 12);
  textFont(font);
  textSize(12);
  spacing = (width-offset*2)/iterations; // cálculo do espaçamento
  strokeWeight(0.4);
  fill(0);
}

void draw(){
  background(200);
  stroke(0);
  
  // para inicialização do gráfico (plotagem do primeiro ponto)
  PVector current_point = new PVector(offset, map(xt, 0, 1, height-100, 100)); 
  PVector next_point = new PVector(0,0);
  ellipse(current_point.x, current_point.y, radius*2, radius*2);
  
  // plotagem dos pontos seguintes segundo número de iterações configurado
  for(int i = 1; i<iterations; i++){
    // cálculo de xt a cada momento e conversão para posição no canvas
    next_point.x = offset+(i * spacing);
    float xt1 = r*xt*(1-xt);
    next_point.y = map(xt1, 0, 1, height-100, 100);
    xt = xt1;
    
    // desenho do ponto no gráfico
    noStroke();
    ellipse(next_point.x, next_point.y, radius*2, radius*2);
    
    // traça uma linha entre o ponto atual e o próximo
    stroke(0);
    line(current_point.x, current_point.y, next_point.x, next_point.y);
    current_point.x = next_point.x;
    current_point.y = next_point.y;
  }
  
  //basext+=inc; // descomentar para atualizar o xt de referência a cada
                 // iteração do draw() com base na variável inc
                 // - Mostra evolução do gráfico em relação a um valor base de xt crescente
  
  //r+=inc;      // descomentar para atualizar o valor de r a cada
                 // iteração do draw() com base na variável inc
                 // - Mostra evolução do gráfico em relação a um valor de r crescente
  
  xt = basext; // reseta o xt em relação ao valor configurado no cabeçalho
  
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
