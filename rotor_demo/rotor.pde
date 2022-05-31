class Rotor{
  int x;
  int y;
  int speed;
  int counter;
  String[] wiring;
  
  Rotor(int x, int y, int speed, String[] wiring){
    this.x=x;
    this.y=y;
    this.speed=speed;
    this.wiring=wiring.clone();
    this.counter=0;
  }
  
  void test(){
    System.out.println("x: "+ x+","+" y: " + y + "," + " speed: "+ speed);
    for(int i=0; i<26; i++){
      System.out.print(wiring[i] + ",");
    }
  }
  
  void rotor_draw(){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size, this.wiring.length);
    
    fill(0);
    draw_letters(x, y, box_size, this.wiring);
  }
  
  //draw rotor with highlighted letter
  void rotor_highlight(int index){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size,this. wiring.length, index);
    
    fill(0);
    draw_letters(x, y, box_size, this.wiring, index);
  }
  
  char encode(String input, int index){
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
  
  char decode(String input, int index){
    char output = input.toUpperCase().charAt(0);
    try {
      //if rotor has a number
      int temp = 26 + output - Integer.parseInt(this.wiring[index]);
      
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

  //need to change - speed shud determine when rotors turn i.e 0,1,2 inputs after
  void turn(){
    this.counter++;
    this.test();
    println(" \n -----");
    if(this.counter == speed){
      println("shifting");
      String first = wiring[0];
          for(int i=0; i<this.wiring.length-1; i++){
            wiring[i] = wiring[i+1];
          }
      this.wiring[this.wiring.length - 1] = first;
      this.counter = 0;
    }
    if(this.counter > this.speed ) counter = 0;

    println(String.format("speed: %s | counter: %s", speed, counter));
  }
}
