class Rotor{
  float x;
  float y;
  int speed;
  int[] wiring;
  
  Rotor(float x, float y, int speed, int[] wiring){
    this.x=x;
    this.y=y;
    this.speed=speed;
    this.wiring=wiring;
  }
  
  void test(){
    System.out.println(x+","+y+","+speed+","+wiring);
    for(int i=0; i<26; i++){
      System.out.print(wiring[i] + ",");
    }
    substit('a');
  }
  
  //using char or int?
  char substit(char input){
    int num = input-65;
    return (char) ((input+wiring[num]) % 26 + 65);
  }
  
  void turn(){
    int last = wiring[wiring.length];
    for(int i=0; i<wiring.length-1; i++){
      wiring[(i+speed)%26] = wiring[i];
    }
    wiring[0] = last;
  }
  
  //displays own boxes and symbols, connections handled separately?
  void display(){
    
  }
  
  
}
