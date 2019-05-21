PGraphics pg;



void setup(){
  size(100, 100, P2D);
  background(255);
  pg = createGraphics(100, 100, P2D);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();
}


void draw(){
  image(pg, 0, 0);
}

void keyPressed(){
  println("key pressed");
  pg.loadPixels();
  pg.beginDraw();
  for(int i=0;i<pg.width*pg.width; i++){
    pg.set(i% pg.width, i/pg.width, color(random(0, 255)));
  }
  pg.endDraw();
  pg.updatePixels();
}