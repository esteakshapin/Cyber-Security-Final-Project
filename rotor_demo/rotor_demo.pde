import java.util.*;

//dimensions of boxes
int min_padding;
int padding;
int box_size;
int width_of_array;
int gap;

boolean key_pressed = false;
int start_time;

Rotor[] rotors;
int numRotors;

//different pages
boolean menu_page, encode_page, decode_page;

//setup for each page
boolean menu_page_setup, encode_page_setup, decode_page_setup;

//set delay for key press
int key_delay = 1000;

//redraw screen
boolean screen_update;

//encrypt or decrypt (T/F)
//show process
boolean mode;
boolean process;

//Example Cipher
//input rotor
String[] alphabets = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
//rotor 1
String[] rotor1 = {"0", "4", "0", "1", "0", "0", "4", "2", "5", "4", "5", "2", "0", "1", "4", "5", "0", "4", "0", "4", "5", "2", "0", "5", "1", "0"};
//rotor 2
String[] rotor2 = {"1", "4", "4", "1", "2", "1", "0", "3", "2", "5", "4", "4", "3", "4", "5", "2", "3", "2", "2", "3", "2", "2", "4", "3", "2", "5"};
//rotor 3
String[] rotor3 = {"3", "0", "0", "4", "0", "3", "0", "2", "1", "3", "1", "2", "0", "4", "0", "2", "2", "0", "4", "0", "1", "1", "1", "1", "3", "0"};

String[][] wirings = {alphabets, rotor1, rotor2, rotor3};
int[] speeds = {0, 1, 2, 3};



void setup() {
  size(1000, 700);
  mode=true;
  process=true;
  
  //start off with menu page
  menu_page = false;
  menu_page_setup = true;
  encode_page = decode_page = false;
  encode_page_setup = decode_page_setup = false;

  min_padding = 10;
  box_size = (width - (min_padding * 2)) / 26;
  //centering the array of boxes; finding the width of the array;
  //subtracting from width and dividing by two to get the padding
  //required on either size
  width_of_array = box_size * 26;
  padding = (width - width_of_array) / 2;
  gap = (box_size + padding)*2;

  textAlign(CENTER, CENTER);
  textSize(15);

  numRotors=4;
  rotors = new Rotor[numRotors];

  //automatically setup rotors
  //y position is padding + gap * i
  for(int i=1; i<numRotors; i++){
    rotors[i] = new Rotor(padding, padding + gap * i, speeds[i], wirings[i], 13);
  }
  //setting up input rotor
  rotors[0] = new Rotor(padding, padding, 0, alphabets);

  screen_update = true;
}


void draw() {
  
  //setup menu page -- variables and background; 
  //set menu page to true so menu page is drawn
  if(menu_page_setup) {
    menu_setup();
    menu_page_setup = false;
    menu_page = true;
    return;
  }
  
  if(menu_page){
    draw_buttons();
    return;
  }
  
  //only update boxes when needed (after input)
  if (screen_update) {
    //clearing screen
    background(200);

    if(process){
      //draw rotors
      for (Rotor x : rotors) {
        if (x != null) x.rotor_draw();
      }

      //draw output box
      fill (255);
      draw_boxes(width/2-box_size/2, rotors[rotors.length - 1].y + box_size + gap, box_size, 1);
    } else{
      //draw input rotor only
      rotors[0].rotor_draw();
      //input and output text boxes
    }

    screen_update = false;
  }

  //only accept another input after the first one is finished
  if (!key_pressed && keyPressed && ((key >= 65 && key < 65 + 26) || (key >= 97 && key < 97 + 26))) {
    
    //capitalizing inputs
    int index = Character.toString(key).toUpperCase().charAt(0) - 65;
    String input = Character.toString(key);
    String output = input;

    for (Rotor r : rotors) {
      //encode or decode
      if(mode){
        output = r.encode(output, index) + "";
      } else{
        output = r.decode(output, index) + "";
      }
      //show process or not
      if(process){
        r.rotor_highlight(index, new int[]{0,0,0});
      } else {
        rotors[0].rotor_highlight(index, new int[]{0,0,0});
      }

      println("+++++");
      println(rotors[rotors.length - 1]);
      println(r);
      println(r == rotors[rotors.length - 1]);

      //only draw arrows if needed
      if(process){
        if (r == rotors[rotors.length - 1]) {
          //drawing arrow to print box
          int startingX = r.x + box_size * index + box_size / 2;
          int startingY = r.y + box_size;
          int targetX = width/2;
          int targetY = rotors[rotors.length - 1].y + box_size + gap;

          stroke(255, 0, 0);
          line((float)startingX, (float) startingY, (float) targetX, (float) targetY);
          stroke(0);
        } else {
          //drawing arrow between rotors
          drawArrow(r.x + box_size * index + box_size / 2, r.y + box_size + padding, box_size, 90);

          //drawing box + letter of outcome
          //box goes on left or right of arrow depending on which half the letter is on
          if (r.x + box_size * index + box_size > width/2) {
            fill(255);
            draw_boxes(r.x + box_size * index - box_size, r.y + box_size + padding, box_size, 1);
            fill(0);
            draw_letters(r.x + box_size * index - box_size, r.y + box_size + padding, box_size, new String[]{output});
          } else {
            fill(255);
            draw_boxes(r.x + box_size * index + box_size, r.y + box_size + padding, box_size, 1);
            fill(0);
            draw_letters(r.x + box_size * index + box_size, r.y + box_size + padding, box_size, new String[]{output});
          }
        }
      }
    }

    //draw output letter in the output box
    if(process){
      fill(255, 0, 0);
      draw_letters(width/2-box_size/2, rotors[rotors.length - 1].y + box_size + gap, box_size, new String[]{output});
    }

    key_pressed = true;
    start_time = millis();
  }


  if (key_pressed) {
    if (pause(start_time, key_delay)) {
      // println("delayed 1000ms");

      for (Rotor x : rotors) {
        x.turn();
      }
      key_pressed = false;
      screen_update = true;
    }
  }
}

void keyPressed(){
  if(key == ' '){
    println("Pressed spacebar");
    reset();
  }
}

//doesn't work yet
void reset(){
  //switch from encode to decode and vice versa
  mode = !mode;

  //reset rotors
  rotors[0] = new Rotor(padding, padding, 0, alphabets);
  for(int i=1; i<numRotors; i++){
    rotors[i] = new Rotor(padding, padding + gap * i, speeds[i], wirings[i], 13);
  }

  //flash screen then update
  background(0, 0, 0);
  screen_update = true;
}
