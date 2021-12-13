Line line1;
Line line2;
boolean changed;
int samples_num;
int seed;
ArrayList<Line> lines;


void setup(){
    size(2000, 2000);
  init();
}

color darken(color c, float val){
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  r = r * val;
  g = g * val;
  b = b * val;
  return color(r, g, b);
}

void init(){
  seed = (int) random(10000000);
  randomSeed(seed); // 7080139, 1009137, 299721, 6613111, 3957097

  println(seed);
  samples_num = 50;
  lines = new ArrayList<Line>();
  stroke(255);
  PVector point1 = new PVector(random(width), random(height));
  PVector point2 = new PVector(random(width), random(height));
  PVector point3 = new PVector(random(width), random(height));
  line1 = new Line(point2.x, point2.y, point1.x, point1.y, color(random(255), random(150),0), -1);
  line2 = new Line(point2.x, point2.y, point3.x, point3.y, color(0, random(150), random(255)), 1);
  background(0);
  changed = false;
  lines.add(line1);
  lines.add(line2);
}


void draw(){
    loadPixels();
    float size = random(40, 60);
    for (int x = 0; x < width; x++){
      for (int y = 0; y < height; y++) {
        float r = 0;
        float g = 0;
        float b = 0;
        for (int sample = 0; sample < samples_num; sample++){
         color final_color = color(0,0,0);
         float shading = 0;
         for (Line _line : lines){
           _line.jitter();
           float dist = _line.distanceSeg(x, y);
           float c = 255 - dist / (0.1*random(size));
           final_color += darken(_line._color, c/255);
         }
         for (Line _line : lines){
           float side = _line.distance(x, y);
           float onSide = (side*_line.side > 0) ? 1: 0.6;
           shading = onSide;
           if (onSide != 1){
             break;
           }
         }
         color c = darken(final_color, shading);
         r += red(c);
         g += green(c);
         b += blue(c);
        }
        color new_color = color(r/samples_num, g/samples_num, b/samples_num);
        pixels[x+y*width] += new_color;    
      }
    }

    updatePixels();
    save("C:/Users/bassi/Pictures/lumination/graphic_lumination_"+str(seed)+".tif");
    init();
}
