class Line{
  PVector org_start;
  PVector org_end;
  PVector start;
  PVector end;
  color _color;
  int side;
  
  Line(float x0, float y0, float x1, float y1, color c, int _side) {
    org_start = new PVector(x0, y0);
    org_end = new PVector(x1, y1);
    start = org_start;
    end = org_end;
    _color = c;
    side = _side;
    jitter();
  }
  void show(){
    line(start.x, start.y, end.x, end.y);
  }
   
  float distance(float x, float y){
    float a = (start.x - end.x)*(end.y - y);
    float b = (end.x - x)*(start.y - end.y);
    float c = (start.x - end.x)*(start.x - end.x);
    float d = (start.y - end.y)*(start.y - end.y);
    return (a-b)/sqrt(c+d);
  }
  
  void jitter(){
    //start = new PVector(org_start.x + 5 - random(10), org_start.y + 5 - random(10));
    end = new PVector(org_end.x - 5 + random(10), org_end.y - 5 +random(10));
  }
  
  float distanceSeg(float x, float y){
    float x1 = start.x;
    float x2 = end.x;
    float y1 = start.y;
    float y2 = end.y;
    var A = x - x1;
    var B = y - y1;
    var C = x2 - x1;
    var D = y2 - y1;
  
    float dot = A * C + B * D;
    float len_sq = C * C + D * D;
    float param = -1;
    if (len_sq != 0) { //in case of 0 length line
        param = dot / len_sq;
    }
  
    float xx;
    float yy;
  
    if (param < 0) {
      xx = x1;
      yy = y1;
    }
    else if (param > 1) {
      xx = x2;
      yy = y2;
    }
    else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }
  
    var dx = x - xx;
    var dy = y - yy;
    return sqrt(dx * dx + dy * dy);
  }
}
