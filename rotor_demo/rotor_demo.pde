void setup(){
  size(1200,800);
}

class Rotor{
  float x;
  float y;
  int[] shifts;
  
  Rotor(float x, float y, int[] shifts){
    x = this.x;
    y = this.y;
    shifts = this.shifts;
  }
  
  void turn(){
    int last = shifts[shifts.length];
    for(int i=0; i<shifts.length-1; i++){
      shifts[i+1] = shifts[i];
    }
    shifts[0] = last;
  }
  
  void display(){
    
  }
}
