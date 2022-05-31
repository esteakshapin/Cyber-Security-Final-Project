import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class rotor_demo extends PApplet {



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
int maxRotors;

//redraw screen
boolean screen_update;

//encrypt or decrypt (T/F)
//show process
boolean mode;
boolean process;

//input and output logs
String inputText;
String outputText;

public void setup() {
  
  mode=false;
  process=true;

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

  numRotors=3;
  maxRotors=5;
  rotors = new Rotor[numRotors];

  //initializing rotor arrays
  //input array
  String[] alphabets = new String[26];
  for (int i = 0; i < 26; i++) {
    alphabets[i] = String.valueOf(PApplet.parseChar(i + 65));
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

  //automatically setup rotors
  //y position is padding + gap * i
  for(int i=0; i<numRotors; i++){
    rotors[i] = new Rotor(padding, padding + gap * i, speeds[i], wirings[i]);
  }

  screen_update = true;
}


public void draw() {
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
      draw_boxes(width/2-box_size/2, height-box_size-padding, box_size, 1);
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
        r.rotor_highlight(index);
      } else {
        rotors[0].rotor_highlight(index);
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

    //draw output in the output box
    if(process){
      fill(0, 255, 0);
      draw_letters(width/2-box_size/2, height-box_size-padding, box_size, new String[]{output});
    }

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
  
  public void test(){
    System.out.println("x: "+ x+","+" y: " + y + "," + " speed: "+ speed);
    for(int i=0; i<26; i++){
      System.out.print(wiring[i] + ",");
    }
  }
  
  public void rotor_draw(){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size, this.wiring.length);
    
    fill(0);
    draw_letters(x, y, box_size, this.wiring);
  }
  
  //draw rotor with highlighted letter
  public void rotor_highlight(int index){
    //drawing background box
    fill(255);
    draw_boxes(x, y, box_size,this. wiring.length, index);
    
    fill(0);
    draw_letters(x, y, box_size, this.wiring, index);
  }
  
  public char encode(String input, int index){
    char output = input.toUpperCase().charAt(0);
    try {
      //if rotor has a number
      int temp = output + Integer.parseInt(this.wiring[index]);
      
      //make sure output is not greater than alphabets
      temp = (temp - 65) % 26 + 65;
      
      output = PApplet.parseChar(temp);
    }
    catch(Exception e) {
      // print out the exception. We expect a numberFormat exception when we input the input rotor
      if(e instanceof NumberFormatException == false){
        println("error "+ e);
      }
    }
    return output;
  }
  
  public char decode(String input, int index){
    char output = input.toUpperCase().charAt(0);
    try {
      //if rotor has a number
      int temp = 26 + output - Integer.parseInt(this.wiring[index]);
      
      //make sure output is not greater than alphabets
      temp = (temp - 65) % 26 + 65;
      
      output = PApplet.parseChar(temp);
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
  public void turn(){
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
//pause, drawArrow, draw_boxes, and draw_letters
public boolean pause(int start_time, int pause_duration){
  if (start_time + pause_duration < millis()){
  return true;
  }
  return false;
}

public void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

public void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes){
  // println("drawing boxes");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < numberOfBoxes; i++){
    int x = i * box_size;
    int y = 0;
    
    rect(x, y,box_size, box_size);
  }  
  popMatrix();
}

//draw highlighted boxes
public void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes, int index){
  // println("drawing highlighted box");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
   
  for(int i = 0; i < numberOfBoxes; i++){
    int x = i * box_size;
    int y = 0;
    
    if(i == index){
      fill(0);
    }else{
      fill(255);
    }
    rect(x, y,box_size, box_size); 
  }
  popMatrix();
}

public void draw_letters(int cx, int cy, int box_size, String[] wiring){
  // println("drawing letters");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < wiring.length; i++){
    int x = i * box_size;
    int y = 0;
    // Draw the letter to the screen
    text(wiring[i], x + box_size / 2, y + box_size / 2);
  }
  popMatrix();
}

//with highlighted letter
public void draw_letters(int cx, int cy, int box_size, String[] wiring, int index){
  // println("drawing highlighted letters");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < wiring.length; i++){
    int x = i * box_size;
    int y = 0;
    
    if(i == index){
      stroke(255);
      fill(255);
    }else{
      stroke(0);
      fill(0);
    }
    // Draw the letter to the screen
    text(wiring[i], x + box_size / 2, y + box_size / 2); 
  }
  popMatrix();
}

public void draw_text(String input, String output){
  //format strings
  int charsWidth = 4;
  int index = 0;
  
  List<String> inFormat = new ArrayList<String>();
  while(index<input.length()){
   inFormat.add(input.substring(index, Math.min(index + charsWidth, input.length())));
   index += charsWidth;
  }
  
  index = 0;
  List<String> outFormat = new ArrayList<String>();
  while(index<output.length()){
   outFormat.add(output.substring(index, Math.min(index + charsWidth, output.length())));
   index += charsWidth;
  } 
  
  //draw text
}
  public void settings() {  size(1000, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "rotor_demo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
