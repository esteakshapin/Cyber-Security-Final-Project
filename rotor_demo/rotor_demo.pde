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
String[] rotor1 = {"0", "4", "0", "1", "0", "0", "4", "2", "5", "4", "5", "2", "0", "1", "4", "5", "0", "4", "0", "4", "5", "2", "0", "5", "1", "0"};
//rotor 2
String[] rotor2 = {"1", "4", "4", "1", "2", "1", "0", "3", "2", "5", "4", "4", "3", "4", "5", "2", "3", "2", "2", "3", "2", "2", "4", "3", "2", "5"};
//rotor 3
String[] rotor3 = {"-1", "0", "0", "4", "0", "3", "0", "2", "1", "3", "1", "2", "0", "4", "0", "2", "2", "0", "4", "0", "1", "1", "1", "1", "3", "0"};

String[][] wirings = {alphabets, rotor1, rotor2, rotor3};
int[] speeds = {0, 1, 2, 3};


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

  numRotors=4;
  rotors = new Rotor[numRotors];

  //setting up input rotor
  rotors[0] = new Rotor(padding, padding + rectSizeY + padding * 2, 0, alphabets);

  //automatically setup rotors
  //y position is padding + gap * i
  for (int i=1; i<numRotors; i++) {
    rotors[i] = new Rotor(rotors[0].x, rotors[0].y + gap * i, speeds[i], wirings[i], 13);
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
    screen_update = true;
    key_delay = 1000;

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
