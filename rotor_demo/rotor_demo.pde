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
int numRotors=4;

//Array of pages
boolean menu_page, encode_page, decode_page, tutorial_page;

//setup for each page
boolean menu_page_setup, encode_page_setup, decode_page_setup, tutorial_page_setup;

//set delay for key press
int key_delay = 500;

//redraw screen
boolean screen_update;

//encrypt or decrypt (T/F)
//show process
boolean mode;
boolean process;

//Example Cipher
//input rotor
String[] alphabets = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

//rotor 1
String[] rotor1  = new String[alphabets.length];
String[] rotor1_reverse = new String[alphabets.length];
;
//rotor 2
String[] rotor2 = new String[alphabets.length];
;
String[] rotor2_reverse = new String[alphabets.length];
;
//rotor 3
String[] rotor3 = new String[alphabets.length];
;
String[] rotor3_reverse = new String[alphabets.length];
;

String[][] wirings = {alphabets, rotor1, rotor2, rotor3};
String[][] wirings_reverse = {alphabets, rotor1_reverse, rotor2_reverse, rotor3_reverse};

int[] speeds = {0, 1, 2, 3};

int[] temp_rotor;
int[] temp_rotor_reverse;
ArrayList<Integer> reserve;

//button global constants
int menu_rectX, menu_rectY;      // Position of menu button
boolean menu_rectOver;

int rectSizeX;     // Width of encode_rect
int rectSizeY;   //height of encode_rect
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;


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

  //button setup
  rectColor = color(0);
  rectHighlight = color(51);
  baseColor = color(102);
  currentColor = baseColor;
  rectSizeX  = 200;
  rectSizeY = 50;
  screen_update = true;
  menu_rectX = menu_rectY = padding;



  Random generator = new Random(112);

  for (int x = 1; x < wirings.length; x++) {
    temp_rotor = new int[alphabets.length];
    temp_rotor_reverse = new int[temp_rotor.length];
    reserve = new ArrayList<Integer>();

    //adding all the indexes to arraylist
    for (int i = 0; i < temp_rotor.length; i++) {
      reserve.add(i);
    }

    for (int i = 0; i < temp_rotor.length; i++) {

      int index = generator.nextInt(reserve.size());
      //println("index " + index);
      //println("value " + reserve.get(index));
      temp_rotor[i] = reserve.get(index) - i;
      temp_rotor_reverse[reserve.get(index)] = temp_rotor[i] * -1;

      //println("++++++");
      reserve.remove(index);
    }

    for (int i = 0; i < temp_rotor.length; i++) {
      wirings[x][i] = String.valueOf(temp_rotor[i]);
      wirings_reverse[x][i] = String.valueOf(temp_rotor_reverse[i]);
    }
    
  }
}


void draw() {

  //setup menu page -- variables and background; 
  //set menu page to true so menu page is drawn
  if (menu_page_setup) {    
    //setup menu page
    menu_setup();
    menu_page_setup = false;

    //render menu page
    menu_page = true;
    return;
  }

  //render menu page
  if (menu_page) {
    draw_buttons();
    return;
  }

  //setup tutorial page
  if (tutorial_page_setup) { 
    //tutorial setup
    setup_tutorial_page();

    //render tutorial page
    tutorial_page = true;
    tutorial_page_setup = false;

    return;
  }

  if (tutorial_page) {
    render_tutorial_page();
  }

  //setup encode page
  if (encode_page_setup) { 
    //encode setup
    setup_encode_page();

    //render tutorial page
    encode_page = true;
    encode_page_setup = false;

    return;
  }

  if (encode_page) {
    render_encode_page();
  }

  //decode
  if (decode_page_setup) { 
    //decode setup
    setup_decode_page();

    //render tutorial page
    decode_page = true;
    decode_page_setup = false;

    return;
  }

  if (decode_page) {
    render_decode_page();
  }
}

//void keyPressed() {
//  if (key == ' ') {
//    println("Pressed spacebar");
//    reset();
//  }
//}

////doesn't work yet
//void reset() {
//  //switch from encode to decode and vice versa
//  mode = !mode;

//  //reset rotors
//  rotors[0] = new Rotor(padding, padding, 0, alphabets);
//  for (int i=1; i<numRotors; i++) {
//    rotors[i] = new Rotor(padding, padding + gap * i, speeds[i], wirings[i], 13);
//  }

//  //flash screen then update
//  background(0, 0, 0);
//  screen_update = true;
//}
