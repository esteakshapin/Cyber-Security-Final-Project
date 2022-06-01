int encode_rectX, encode_rectY;      // Position of encode button
int decode_rectX, decode_rectY;      // Position of decode button
int tutorial_rectX, tutorial_rectY;      // Position of decode button
boolean encode_rectOver, decode_rectOver, tutorial_rectOver = false;

void menu_setup() {  
  //encode rect offset is from the middle buttonw with a 10 px gap
  encode_rectX = width/2 - rectSizeX / 2;
  encode_rectY = height/2 - rectSizeY / 2 - 10 - rectSizeY;
  
  //decode rect; should be in the middle of the screen
  decode_rectX = encode_rectX;
  decode_rectY = height/2 - rectSizeY / 2;
  
  //tutorial rec; offset below the middle button with a 10 px gap
  tutorial_rectX = encode_rectX;
  tutorial_rectY = decode_rectY + rectSizeY + 10;
}

//check if mouse is over either button
void update(int x, int y) {
  
  //see if mouse is over envode rect
  if(overRect(encode_rectX, encode_rectY, rectSizeX, rectSizeY)){
    encode_rectOver = true;
    decode_rectOver = tutorial_rectOver = false;
  }else if(overRect(decode_rectX, decode_rectY, rectSizeX, rectSizeY)){
    decode_rectOver = true;
    encode_rectOver = tutorial_rectOver = false;
  }else if(overRect(tutorial_rectX, tutorial_rectY, rectSizeX, rectSizeY)){
    tutorial_rectOver = true;
    encode_rectOver = decode_rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  if (tutorial_rectOver) {
    switchScreen("tutorial");
  }
  if (encode_rectOver) {
    encode_rectOver = false;
    switchScreen("encode");
  }
  
}

void draw_buttons() {
  background(currentColor);
  update(mouseX, mouseY);

  stroke(255);
  if (encode_rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  rect(encode_rectX, encode_rectY, rectSizeX, rectSizeY);
  
  if (decode_rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  rect(decode_rectX, decode_rectY, rectSizeX, rectSizeY);
  
  if (tutorial_rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  rect(tutorial_rectX, tutorial_rectY, rectSizeX, rectSizeY);
  
  stroke(0);
  
  fill(255);
  draw_letters(encode_rectX + rectSizeX / 2, encode_rectY + rectSizeY / 2, 0, new String[]{"Encode"});
  draw_letters(decode_rectX + rectSizeX / 2, decode_rectY + rectSizeY / 2, 0, new String[]{"Decode"});
  draw_letters(tutorial_rectX + rectSizeX / 2, tutorial_rectY + rectSizeY / 2, 0, new String[]{"Tutorial"});

}
