int x;
int y;
int width2 = 28;
color c = color(0);
float[] bwPixels = new float[705600];
float[] smallPixels = new float[width2*width2];
float[] newBwPixels = new float[width2*width2];
PGraphics pg;
float values;
ArrayList<Float>[][] newData = new ArrayList[width2][width2];
Table table;

void setup() {
  size(840, 840, P2D);
  background(255);
  table = new Table();
  table.addColumn("color");
  pg = createGraphics(width2, width2, P2D);
  pg.beginDraw();
  pg.background(255, 0, 0);
  pg.endDraw();

}


void draw() {
  x = mouseX;
  y = mouseY;
  image(pg, 0, 0);
}

void mouseDragged() {
  strokeWeight(20);
  //stroke(10, 203, 20);
  line(x, y, mouseX, mouseY);
}

void keyPressed() {
  if (key == 'r') {
    pixelConvert();
    background(255);
    dataToImage();
    output();
    println("done");
  } else {
    pg.beginDraw();
    pg.background(255);
    pg.endDraw();
  }
}

void pixelConvert() {
  loadPixels();

  for (int i=0; i<pixels.length; i++) {
    bwPixels[i] = map(brightness(pixels[i]), 0, 255, 0, 1);
  }

  for (int i=0; i<bwPixels.length; i++) {
    int x = i % width;
    int y = i/width;
    int newX = int(map(x, 0, width-1, 0, width2-1));
    int newY = int(map(y, 0, height-1, 0, width2-1));

    if (newData[newX][newY] == null) {
      newData[newX][newY] = new ArrayList();
    }

    newData[newX][newY].add(bwPixels[i]);
  }

  arrayAvg();

  //println(newData);
}

void arrayAvg() {
  for (int x=0; x<newData.length; x++) {
    for (int y=0; y<newData[x].length; y++) {
      int z = 0;
      values = 0;
      for (z=0; z<newData[x][y].size(); z++) {
        values += newData[x][y].get(z);
      }
      smallPixels[y*28 + x] = values/z;
    }
  }

}

void dataToImage(){
  for (int i=0; i<smallPixels.length; i++) {
    newBwPixels[i] = map(smallPixels[i], 0, 1, 0, 255);
  }
  pg.loadPixels();
  pg.beginDraw();
  for (int i=0; i<smallPixels.length; i++){
    color newPixels = color(newBwPixels[i]);
    //println(i % pg.width, i/pg.width, randColor);
    pg.set(i % pg.width, i/pg.width, newPixels);
  }
  pg.endDraw();
  pg.updatePixels();
}


void output(){
  for(int i=0;i<smallPixels.length;i++){
    TableRow newRow = table.addRow();
    newRow.setFloat("color", smallPixels[i]);
  }
  saveTable(table, "data.csv");
  
}