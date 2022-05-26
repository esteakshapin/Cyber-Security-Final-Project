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
  }
  
  //using char or int?
  char substit(char input){
    int num = input-64;
    return (char) ((input+wiring[num]) % 26 + 65);
  }
}
