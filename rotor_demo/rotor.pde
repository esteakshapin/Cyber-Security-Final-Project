class Rotor{
  int x;
  int y;
  int speed;
  int counter;
  int marker = -1;
  String[] wiring;

  Rotor(int x, int y, int speed, String[] wiring){
    this.x=x;
    this.y=y;
    this.speed=speed;
    this.wiring=wiring.clone();
    this.counter=0;
  }

  Rotor(int x, int y, int speed, String[] wiring, int marker){
    this.x=x;
    this.y=y;
    this.speed=speed;
    this.wiring=wiring.clone();
    this.counter=0;
    this.marker = marker;
  }
  
  void test(){
    System.out.println("x: "+ x+","+" y: " + y + "," + " speed: "+ speed);
    for(int i=0; i<wiring.length; i++){
      //System.out.print(wiring[i] + ",");
    }
  }

  void rotor_draw(){
    //println("draw");
    //marker provided -- draw highlighted boxes
    if(marker != -1){
      this.rotor_highlight(marker, new int[]{255,0,0});
    }else{
      //give out of bound index -- no highlight
      this.rotor_highlight(-1, new int[]{});
    }
  }

  //draw rotor with highlighted letter
  void rotor_highlight(int index, int [] highlight_color){
    //println("Highlight ");
    //drawing background box
    draw_boxes(x, y, box_size,this. wiring.length, index, highlight_color);

    draw_letters(x, y, box_size, this.wiring, index);
  }

  char encode(String input, int index){
    char output = input.toUpperCase().charAt(0);
    try {
      //if rotor has a number
      int temp = output + Integer.parseInt(this.wiring[index]);

      //make sure output is not greater than alphabets
      temp = (temp - 65 + 26) % 26 + 65;

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
    //this.test();
    //println(" \n -----");
    if(this.counter == speed){
      //println("shifting");
          if(this.marker != -1) {
      if(marker == 0) marker = 25;
      else marker -= 1;
    }
      String first = wiring[0];
          for(int i=0; i<this.wiring.length-1; i++){
            wiring[i] = wiring[i+1];
          }
      this.wiring[this.wiring.length - 1] = first;
      this.counter = 0;
    }
    if(this.counter > this.speed ) counter = 0;

    //println(String.format("speed: %s | counter: %s", speed, counter));
  }
}
