
import nervoussystem.obj.*;


boolean record = false;
PShape shapeGroup;
PVector v;
PVector[] vertices;
float z;
int maxvertices;
int steps = 36; //multiple of 360
int vertexAnzahl = 0;
boolean offsetTrue = false;
float zDrehung = 0;
float yDrehung = 0;
float scale = 0.1;


void setup() {
  size(800, 800, P3D);
  noStroke();
  frameRate(24);
  maxvertices = (3600*height) + 1;
  vertices = new PVector[maxvertices];
  //shapeGroup = createShape(GROUP);
  //camera();
  createSlice(z, mouseX);
  
  
  

}

void createSlice(float z, float radius) {
  
  //versetze punkte immer abwechselnd 
  float offset = (360/steps)/2;
  offset = offsetTrue ? offset : -offset;
  offsetTrue = !offsetTrue;
  
  //berechne Punkte in Kreis
  for (int i=0; i<=steps; i++) {
      
    //calculate angle
    //if circle not very round steps might be smaller, need to calculate distance
    float angle = radians((i * (360/steps)) + offset);
    PVector v = new PVector(0  + (cos(angle) * (radius)), 
    0 + (sin(angle) * (radius)), 
    z);
    vertices[vertexAnzahl] = v;
    vertexAnzahl++;
  }
  
  
}


void draw() {
  background(0);
  fill(255);
  boolean flip = false;
  //print(vertexAnzahl + "\n");
  if (vertexAnzahl < maxvertices-steps-1) {
    z=z+10;
    
    createSlice(z, mouseX*4);


    PShape currentShape;
    currentShape = createShape();
    currentShape.beginShape(TRIANGLE_STRIP);

    for (int i=0; i < vertexAnzahl-steps-1; i=i+2) {
        currentShape.vertex( vertices[i].x,  vertices[i].y,  vertices[i].z);
        currentShape.vertex( vertices[i+steps-1].x, vertices[i+steps-1].y,  vertices[i+steps-1].z);
        currentShape.vertex( vertices[i+1].x,  vertices[i+1].y,  vertices[i+1].z);
        currentShape.vertex( vertices[i+steps].x,  vertices[i+steps].y,  vertices[i+steps].z);
    }
    currentShape.endShape(CLOSE);
    
    lights();

    if (record){
      beginRaw("nervoussystem.obj.OBJExport", "/Users/tom/Desktop/bla.obj"); 
    }
    
    translate(width/2, height/1.2, 0);
    rotateX(radians(95));
    rotateX(map(mouseY,0,height, 93, 95));
    scale(scale);
    rotateZ(zDrehung=zDrehung+0.02);
   
    shape(currentShape, 0, 0);
    endRaw();
    record = false;

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
  
  void mouseDragged(){
    if (pmouseX < mouseX){
      scale = scale + 0.003;
    } else {
      scale = scale - 0.003;
    }

  }


