
//import processing.dxf.*;


boolean record = false;
PShape shapeGroup;
PVector v;
PVector[] vertices;
float z;
int maxvertices;
int steps = 36; //multiple of 360
int vertexAnzahl = 0;



void setup() {
  size(1200, 1000);
  noStroke();
  frameRate(30);
  maxvertices = (3600*height) + 1;
  vertices = new PVector[maxvertices];
  //shapeGroup = createShape(GROUP);
  //camera();
  createVertices(z, mouseX/2);

}

void createVertices(float z, float radius) {
  //berechne Punkte in Kreis
  for (int i=0; i<=steps; i++) {
    
    //calculate angle
    //if circle not very round steps might be smaller, need to calculate distance
    float angle = radians(i * (360/steps));
    PVector v = new PVector((width/2)  + (cos(angle) * (radius)), 
    (height/2) + (sin(angle) * (radius)), 
    z);
    vertices[vertexAnzahl] = v;
    vertexAnzahl++;
  }
}


void draw() {
  background(150);

  //print(vertexAnzahl + "\n");
  if (vertexAnzahl < maxvertices-steps-1) {
    z=z+1;
    createVertices(z, mouseX/50);


    PShape currentShape;
    currentShape = createShape();
    currentShape.beginShape(TRIANGLE_FAN);

    for (int i=0; i < vertexAnzahl-3; i++) {
      currentShape.vertex(vertices[i].x, vertices[i].y, vertices[i].z);
      currentShape.vertex(vertices[i].x, vertices[i].y, vertices[i].z);
      currentShape.vertex(vertices[i].x, vertices[i].y, vertices[i].z);
    }
    currentShape.endShape(CLOSE);
    
    lights();

       
    rotateX(radians(50));
    //translate(0, , 0);
    
    shape(currentShape, 0, height/2.5);

    //shapeGroup.addChild(currentShape);
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 'r') {
    record = true;
  }
}
  
  void mousePressed(){
   
  }



