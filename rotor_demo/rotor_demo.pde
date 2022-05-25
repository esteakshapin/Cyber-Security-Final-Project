void setup(){
  size(1200,800);
  //setup number of rotors and everything else
}

void draw(){
  hi.display(); 
}

//read keyboard input
void keyPressed(){
  //check if key is letter
  String input = key;
}

//example rotor
int[] shift1 = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
Rotor hi = new Rotor(0, 50, shift1);



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
    for(int i=0; i<26; i++){
      rect(x+i*50, y, 50, 50);
      //don't know why it gives a null pointer exception
      System.out.println(shifts[i]);
    }
  }
}
