import processing.opengl.*;

Icosahedron ico1;
Icosahedron ico2;
Icosahedron ico3;

void setup(){
  size(600, 600, OPENGL);
  ico1 = new Icosahedron(width/4);
}

void draw(){
  //ortho();
  beginCamera();
  camera(width/2.0, height/2.0, 450, width/2.0, height/2.0, 0, 0, 1, 0);
  endCamera();

  background(25);
  lights();
  smooth();
  strokeWeight(2);

  pushMatrix();
    translate(width/2, height/2);
    rotateX(PI/2);
    rotateZ(TWO_PI*norm(mouseX, 0, width) * -1);
    stroke(127, 0, 0);
    fill(255, 0, 0);
    ico1.create();
  popMatrix();
}





class Dimension3D{
   float w, h, d;
   
   Dimension3D(float w, float h, float d){
     this.w=w;
     this.h=h;
     this.d=d;
  }
}




class Icosahedron extends Shape3D{
  
// original Icosohedra code by Ira Greenberg
// http://processing.org/learning/3d/icosahedra.html

  // icosahedron
  PVector topPoint;
  PVector[] topPent = new PVector[5];
  PVector bottomPoint;
  PVector[] bottomPent = new PVector[5];
  float angle = 0, radius = 150;
  float triDist;
  float triHt;
  float a, b, c;

  // constructor
  Icosahedron(float radius){
    this.radius = radius;
    init();
  }

  Icosahedron(PVector v, float radius){
    super(v);
    this.radius = radius;
    init();
  }

  // calculate geometry
  void init(){
    c = dist(cos(0)*radius, sin(0)*radius, cos(radians(72))*radius,  sin(radians(72))*radius);
    b = radius;
    a = (float)(Math.sqrt(((c*c)-(b*b))));

    triHt = (float)(Math.sqrt((c*c)-((c/2)*(c/2))));

    for (int i=0; i<topPent.length; i++){
      topPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new PVector(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottomPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottomPoint = new PVector(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  void create(){
    for (int i=0; i<topPent.length; i++){
      // icosahedron top
      beginShape();
      if (i<topPent.length-1){
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
      } 
      else {
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
      }
      endShape(CLOSE);

      // icosahedron bottom
      beginShape();
      if (i<bottomPent.length-1){
        vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
      } 
      else {
        vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
      }
      endShape(CLOSE);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      if (i<topPent.length-2){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
        endShape(CLOSE);
      }
    }
  }

  // overrided methods fom Shape3D
  void rotZ(float theta){
    float tx=0, ty=0, tz=0;
    // top point
    tx = cos(theta)*topPoint.x+sin(theta)*topPoint.y;
    ty = sin(theta)*topPoint.x-cos(theta)*topPoint.y;
    topPoint.x = tx;
    topPoint.y = ty;

    // bottom point
    tx = cos(theta)*bottomPoint.x+sin(theta)*bottomPoint.y;
    ty = sin(theta)*bottomPoint.x-cos(theta)*bottomPoint.y;
    bottomPoint.x = tx;
    bottomPoint.y = ty;

    // top and bottom pentagons
    for (int i=0; i<topPent.length; i++){
      tx = cos(theta)*topPent[i].x+sin(theta)*topPent[i].y;
      ty = sin(theta)*topPent[i].x-cos(theta)*topPent[i].y;
      topPent[i].x = tx;
      topPent[i].y = ty;

      tx = cos(theta)*bottomPent[i].x+sin(theta)*bottomPent[i].y;
      ty = sin(theta)*bottomPent[i].x-cos(theta)*bottomPent[i].y;
      bottomPent[i].x = tx;
      bottomPent[i].y = ty;
    }
  }

  void rotX(float theta){
  }

  void rotY(float theta){
  }


}




abstract class Shape3D{
  float x, y, z;
  float w, h, d;

  Shape3D(){
  }

  Shape3D(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Shape3D(PVector p){
    x = p.x;
    y = p.y;
    z = p.z;
  }


  Shape3D(Dimension3D dim){
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  Shape3D(float x, float y, float z, float w, float h, float d){
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }

  Shape3D(float x, float y, float z, Dimension3D dim){
    this.x = x;
    this.y = y;
    this.z = z;
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  Shape3D(PVector p, Dimension3D dim){
    x = p.x;
    y = p.y;
    z = p.z;
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  void setLoc(PVector p){
    x=p.x;
    y=p.y;
    z=p.z;
  }

  void setLoc(float x, float y, float z){
    this.x=x;
    this.y=y;
    this.z=z;
  }


  // override if you need these
  void rotX(float theta){
  }

  void rotY(float theta){
  }

  void rotZ(float theta){
  }


  // must be implemented in subclasses
  abstract void init();
  abstract void create();
}
