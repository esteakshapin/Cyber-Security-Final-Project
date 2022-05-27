
int min_padding;
int padding;
int box_size;
boolean key_pressed = false;
int start_time;
Rotor[] rotors;

//redraw screen
boolean screen_update;

void setup() {
    size(1000, 300);
    min_padding = 10;
    box_size = (width - (min_padding * 2)) / 26;
    
    
    //centering the array of boxes; finding the width of the array; 
    //subtracting from width and dividing by two to get the padding
    //required on either size
    int width_of_array = box_size * 26;
    padding = (width - width_of_array) / 2;
    
    
    
    textAlign(CENTER, CENTER);
    textSize(15);
    println("box_size" + box_size);
    
    //initializing rotor array
    rotors = new Rotor[3];
    
    //setting up input array
    String[] alphabets = new String[26];
    for(int i = 0; i < 26; i++){
      alphabets[i] = String.valueOf(char(i + 65));
    }
    Rotor inputRotor = new Rotor(padding, padding, 0, alphabets);
    rotors[0] = inputRotor;
    
    //adding rotor 1
    String[] numbers = new String[26];
    for(int i = 0; i < 26; i++){
      numbers[i] = String.valueOf(i);
    }
    
    numbers[25] = "3";
    
    int r1_y = padding + box_size + padding * 2;
    
    Rotor r1 = new Rotor(padding, r1_y, 1, numbers);
    rotors[1] = r1;
    
    Rotor r2 = new Rotor(padding, r1_y + box_size +padding * 2, 1, numbers);
    rotors[2] = r2;
    
    
    screen_update = true;
    
}

void draw() {
  
  if(screen_update){
    //clearing screen
    background(200);
    
    for(Rotor x:rotors){
      if(x != null){
        x.test();
        x.rotor_draw();
      }
    }
    
    fill (255);
    draw_boxes(width/2-box_size/2, height-box_size-padding, box_size, 1);
    
    screen_update = false;
  }
  
  //only accept another input after the first one is finished
  if(!key_pressed && keyPressed && ((key >= 65 && key < 65 + 26) || (key >= 97 && key < 97 + 26))){
    
    
    //capitalizing inputs
    int index = Character.toString(key).toUpperCase().charAt(0) - 65;
    String input = Character.toString(key);
    
    for(Rotor r:rotors){
      //enciding letters
      input = r.encode(input, index) + "";
      
      //drawing arrow
      drawArrow(r.x + box_size * index + box_size / 2, r.y + box_size, padding * 2, 90);
    }
    
    //draw output in the output box
    fill(0,255,0);
    draw_letters(width/2-box_size/2, height-box_size-padding, box_size, new String[]{input});
    println(input);
    
    key_pressed = true;
    start_time = millis();
    
  }
  
  if(key_pressed){
    if(pause(start_time, 1000)){
      println("delayed 1000ms");
      key_pressed = false;
      screen_update = true;
    }
  }
    
}
