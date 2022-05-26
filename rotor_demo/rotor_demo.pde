
int min_padding;
int padding;
int box_size;
int key_pressed = 0;

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
    println(box_size);
    
    screen_update = true;
    
}

void draw() {
  
  if(screen_update){
    background(200);
    fill(255);
    draw_boxes(padding, padding, box_size);
    fill(0);
    draw_letters(padding, padding, box_size);
    
    screen_update = false;
  }
  
  if(keyPressed && key > 65 && key < 65 + 37+ 26){
    fill(0);
    draw_letters(padding, padding, box_size, key);
    delay(500);
    //screen_update = true;
  }
    
}

boolean pause(int m, int pause_duration){
  return true;
}
//void keyPressed() {
//  key_pressed = key;
//}

//void keyReleased(){
//  key_pressed = 0;
//}

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();

}

void draw_boxes(int cx, int cy, int box_size){
  println("drawing boxes");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < 26; i++){
    int x = i * box_size;
    int y = 0;
    
    rect(x, y,box_size, box_size);
    
  }
  
  popMatrix();
  
}

void draw_letters(int cx, int cy, int box_size){
  
  println("drawing letters");
  
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < 26; i++){
    int x = i * box_size;
    int y = 0;
    char letter = char(i + 65);
    
    // Draw the letter to the screen
    text(letter, x + box_size / 2, y + box_size / 2);
    
  }
  
  popMatrix();

}

//with highlighted letter
void draw_letters(int cx, int cy, int box_size, char highlight){
  
  println("drawing highlighted letters");
  println(highlight);
  
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);
  
  for(int i = 0; i < 26; i++){
    int x = i * box_size;
    int y = 0;
    char letter = char(i + 65);
    
    if(highlight == letter || highlight == letter + 32){
      println("letter " + letter);
      stroke(255);
      fill(255);
    }else{
      stroke(0);
      fill(0);
    }
    
    // Draw the letter to the screen
    text(letter, x + box_size / 2, y + box_size / 2);
    
  }
  
  popMatrix();

}
