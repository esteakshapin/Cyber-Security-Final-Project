//pause, drawArrow, draw_boxes, and draw_letters
boolean pause(int start_time, int pause_duration){
  if (start_time + pause_duration < millis()){
  return true;
  }
  return false;
}

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes){
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
void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes, int index){
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

void draw_letters(int cx, int cy, int box_size, String[] wiring){
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
void draw_letters(int cx, int cy, int box_size, String[] wiring, int index){
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

void draw_text(String input, String output){
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
