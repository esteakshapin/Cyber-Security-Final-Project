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

//redraw screen
boolean screen_update;

//screens from 0 to 2: education, encode, decode
int mode;

void setup() {
  size(1000, 700);
  mode=1;
  
  min_padding = 10;
  box_size = (width - (min_padding * 2)) / 26;
  //centering the array of boxes; finding the width of the array; 
  //subtracting from width and dividing by two to get the padding
  //required on either size
  width_of_array = box_size * 26;
  padding = (width - width_of_array) / 2;
  gap = box_size*2 + padding*2;

  textAlign(CENTER, CENTER);
  textSize(15);
  
  numRotors=3;
  rotors = new Rotor[numRotors];
  
  //initializing rotor arrays
  //setting up input array
  String[] alphabets = new String[26];
  for (int i = 0; i < 26; i++) {
    alphabets[i] = String.valueOf(char(i + 65));
  }
  Rotor inputRotor = new Rotor(padding, padding, 0, alphabets);
  rotors[0] = inputRotor;
  //rotor 1
  String[] numbers = new String[26];
  for (int i = 0; i < 26; i++) {
    numbers[i] = String.valueOf(i);
  }
  numbers[25] = "3";
  //rotor 2
  String[] numRev = numbers.clone();
  Collections.reverse(Arrays.asList(numRev));
  
  //array of wirings
  //preset wirings should be supplied already 
  String[][] wirings = {alphabets, numbers, numRev};
  int[] speeds = {0,1,2};
  
  //automatically setup rotors (doesn't work yet)
  //y position is padding + gap * i
  for(int i=0; i<numRotors; i++){
    rotors[i] = new Rotor(padding, padding + gap * i, speeds[i], wirings[i]);
  }
  /* old assigning Rotors to array
  Rotor r1 = new Rotor(padding, padding + gap, 1, numbers);
  rotors[1] = r1;
  Rotor r2 = new Rotor(padding, padding + gap * 2, 2, numbers);
  rotors[2] = r2;
  */
  screen_update = true;
}

void draw() {
  //normal state
  //only update boxes when needed (after input)
  if (screen_update) {
    //clearing screen
    background(200);

    if(mode==0){
      //draw rotors
      for (Rotor x : rotors) {
        if (x != null) x.rotor_draw();
      }
      //draw output box
      fill (255);
      draw_boxes(width/2-box_size/2, height-box_size-padding, box_size, 1);
    } else{
      //draw input rotor only
      rotors[0].rotor_draw();
      //draw output box
      fill (255);
      draw_boxes(width/2-box_size/2, height-box_size-padding, box_size, 1);
    }

    screen_update = false;
  }

  //only accept another input after the first one is finished
  if (!key_pressed && keyPressed && ((key >= 65 && key < 65 + 26) || (key >= 97 && key < 97 + 26))) {
    //capitalizing inputs
    int index = Character.toString(key).toUpperCase().charAt(0) - 65;
    String input = Character.toString(key);

    for (Rotor r : rotors) {
      if(mode==0){
        //encoding letters
        input = r.encode(input, index) + ""; 
        r.rotor_highlight(index);
      } else if(mode==1){
        input = r.encode(input, index) + "";
        rotors[0].rotor_highlight(index);
      } else {
        input = r.decode(input, index) + ""; 
      }

      println("+++++");
      println(rotors[rotors.length - 1]);
      println(r);
      println(r == rotors[rotors.length - 1]);      
      
      //draw arrows if in education mode
      if(mode==0){
        if (r == rotors[rotors.length - 1]) {
          //drawing arrow to print box
          int startingX = r.x + box_size * index + box_size / 2;
          int startingY = r.y + box_size;
          int targetX = width/2;
          int targetY = height-box_size-padding;

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
            draw_letters(r.x + box_size * index - box_size, r.y + box_size + padding, box_size, new String[]{input});
          } else {
            fill(255);
            draw_boxes(r.x + box_size * index + box_size, r.y + box_size + padding, box_size, 1);
            fill(0);
            draw_letters(r.x + box_size * index + box_size, r.y + box_size + padding, box_size, new String[]{input});
          }
        }
      } else if(mode==1){
        
      }
    }

    //draw output in the output box
    fill(0, 255, 0);
    draw_letters(width/2-box_size/2, height-box_size-padding, box_size, new String[]{input});

    key_pressed = true;
    start_time = millis();
  }

  if (key_pressed) {
    if (pause(start_time, 1000)) {
      // println("delayed 1000ms");

      for (Rotor x : rotors) {
        x.turn();
      }
      key_pressed = false;
      screen_update = true;
    }
  }
}
