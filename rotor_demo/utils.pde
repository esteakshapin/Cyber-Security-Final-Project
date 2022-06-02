//pause, drawArrow, draw_boxes, and draw_letters
boolean pause(int start_time, int pause_duration) {
  if (start_time + pause_duration < millis()) {
    return true;
  }
  return false;
}

void drawArrow(int cx, int cy, int len, float angle) {
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0, 0, len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes) {
  // println("drawing boxes");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);

  for (int i = 0; i < numberOfBoxes; i++) {
    int x = i * box_size;
    int y = 0;

    rect(x, y, box_size, box_size);
  }
  popMatrix();
}

//draw highlighted boxes
void draw_boxes(int cx, int cy, int box_size, int numberOfBoxes, int index, int[] highlightColor) {
  println(highlightColor);
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);

  for (int i = 0; i < numberOfBoxes; i++) {
    int x = i * box_size;
    int y = 0;

    if (i == index) {
      fill(highlightColor[0], highlightColor[1], highlightColor[2]);
    } else {
      fill(255);
    }
    rect(x, y, box_size, box_size);
  }
  popMatrix();
}

void draw_letters(int cx, int cy, int box_size, String[] wiring) {
  // println("drawing letters");
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);

  for (int i = 0; i < wiring.length; i++) {
    int x = i * box_size;
    int y = 0;
    // Draw the letter to the screen
    text(wiring[i], x + box_size / 2, y + box_size / 2);
  }
  popMatrix();
}

//with highlighted letter
void draw_letters(int cx, int cy, int box_size, String[] wiring, int index) {
  pushMatrix();
  translate(cx, cy);
  rectMode(CORNER);

  for (int i = 0; i < wiring.length; i++) {
    int x = i * box_size;
    int y = 0;

    if (i == index) {
      stroke(255);
      fill(255);
    } else {
      stroke(0);
      fill(0);
    }
    // Draw the letter to the screen
    text(wiring[i], x + box_size / 2, y + box_size / 2);
  }
  popMatrix();
}

void draw_text(String input, String output) {
  pushMatrix();
  //format strings
  int charsWidth = 4;
  int index = 0;

  List<String> inFormat = new ArrayList<String>();
  while (index < input.length()) {
    inFormat.add(input.substring(index, Math.min(index + charsWidth, input.length())));
    index += charsWidth;
  }

  index = 0;
  List<String> outFormat = new ArrayList<String>();
  while (index < output.length()) {
    outFormat.add(output.substring(index, Math.min(index + charsWidth, output.length())));
    index += charsWidth;
  }

  //draw text doesnt work yet
  for (int i=0; i<inFormat.size(); i++) {
    text(inFormat.get(i), 0, i * 10);
  }

  popMatrix();
}

void switchScreen(String pageName) {
  switch(pageName) {
  case "menu":
    //setup menu page
    menu_page_setup = true;

    //remove the other pages
    encode_page = encode_page_setup = false;
    decode_page = decode_page_setup = false;
    tutorial_page = tutorial_page_setup = false;
    break;
  case "encode":
    //setup encode page
    encode_page_setup = true;

    //remove the other pages
    menu_page = menu_page_setup = false;
    decode_page = decode_page_setup = false;
    tutorial_page = tutorial_page_setup = false;
    break;

  case "decode":
    //setup encode page
    decode_page_setup = true;

    //remove the other pages
    menu_page = menu_page_setup = false;
    encode_page = encode_page_setup = false;
    tutorial_page = tutorial_page_setup = false;
    break;

  case "tutorial":
    //setup encode page
    tutorial_page_setup = true;

    //remove the other pages
    menu_page = menu_page_setup = false;
    encode_page = encode_page_setup = false;
    decode_page = decode_page_setup = false;
    break;
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
    tutorial_rectOver = false;
    switchScreen("tutorial");
  }
  if (encode_rectOver) {
    encode_rectOver = false;
    switchScreen("encode");
  }
  if (menu_rectOver) {
    menu_rectOver = false;
    switchScreen("menu");
  }
  if (decode_rectOver) {
    decode_rectOver = false;
    switchScreen("decode");
  }
}

void menu_button_update() {
  if (overRect(menu_rectX, menu_rectY, rectSizeX, rectSizeY)) {
    menu_rectOver = true;
  } else {
    menu_rectOver = false;
  }
}

void draw_menu_button() {
  menu_button_update();
  stroke(255);
  if (menu_rectOver) {
    fill(rectHighlight);
  } else {
    fill(150);
  }
  rect(menu_rectX, menu_rectY, rectSizeX, rectSizeY);

  fill(255);
  draw_letters(menu_rectX + rectSizeX / 2, menu_rectY + rectSizeY / 2, 0, new String[]{"Menu"});
}
