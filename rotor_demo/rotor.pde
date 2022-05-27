class Rotor{
  int x;
  int y;
  int speed;
  String[] wiring;
  
  Rotor(int x, int y, int speed, String[] wiring){
    this.x=x;
    this.y=y;
    this.speed=speed;
    this.wiring=wiring;
  }
  
  void test(){
    System.out.println("x: "+ x+","+"y: " + y + "," + "speed: "+ speed);
    for(int i=0; i<26; i++){
      System.out.print(wiring[i] + ",");
    }
  }
  
  void rotor_draw(){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size, wiring.length);
    
    fill(0);
    draw_letters(x, y, box_size, wiring);
  }
  
  char encode(String input, int index){
    rotor_highlight(index);
    char output = input.toUpperCase().charAt(0);
    try {
      //if rotor has a number
      int temp = output + Integer.parseInt(this.wiring[index]);
      
      //make sure output is not greater than alphabets
      temp = (temp - 65) % 26 + 65;
      
      output = char(temp);
      
    }
    catch(Exception e) {
      // print out the exception. We expect a numberFormat exception when we input the input rotor
      if(e instanceof NumberFormatException == false){
        println("error "+ e);
      }
    }
    return output;
  }
  
  void rotor_highlight(int index){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size, wiring.length, index);
    
    fill(0);
    draw_letters(x, y, box_size, wiring, index);
  }
  
  //using char or int?
  //char substit(char input){
  //  int num = input-64;
  //  return (char) ((input+wiring[num]) % 26 + 65);
  //}
}
