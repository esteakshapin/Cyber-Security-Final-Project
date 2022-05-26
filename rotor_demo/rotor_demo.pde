
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
