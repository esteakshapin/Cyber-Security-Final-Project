boolean pause(int m, int pause_duration, int a){
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
