void setup_tutorial_page() {
  setup_rotors();

  screen_update = true;
  key_delay = 5000;
}

void render_tutorial_page() {
  draw_menu_button();
  //only update boxes when needed (after input)
  if (screen_update) {
    //clearing screen
    background(200);

    if (process) {
      //draw rotors
      for (Rotor x : rotors) {
        if (x != null) x.rotor_draw();
      }

      //draw output box
      fill (255);
      draw_boxes(width/2-box_size/2, rotors[rotors.length - 1].y + box_size + gap, box_size, 1);
    } else {
      //draw input rotor only
      rotors[0].rotor_draw();
      //input and output text boxes
    }

    screen_update = false;
  }

  ///only accept another input after the first one is finished
  if (!key_pressed && keyPressed && ((key >= 65 && key < 65 + 26) || (key >= 97 && key < 97 + 26))) {

    //capitalizing inputs
    int index = Character.toString(key).toUpperCase().charAt(0) - 65;
    String input = Character.toString(key);
    String output = input;

    for (Rotor r : rotors) {
      
      //show process or not
      if (process) {
        r.rotor_highlight(index, new int[]{0, 0, 0});
      } else {
        rotors[0].rotor_highlight(index, new int[]{0, 0, 0});
      }
      //encode or decode
      if (mode) {
        String temp = output.toUpperCase();
        output = r.encode(output, index) + "";
        
        int difference = output.charAt(0) - temp.charAt(0);
        
        index += difference;
        
        while(index > r.wiring.length) {
          index = index - r.wiring.length;
        }
        
        println("difference: " + difference);
        println("index: " + index);
        
      } else {
        output = r.decode(output, index) + "";
      }

      //only draw arrows if needed
      if (process) {
        if (r == rotors[rotors.length - 1]) {
          //drawing arrow to print box
          int startingX = r.x + box_size * index + box_size / 2;
          int startingY = r.y + box_size;
          int targetX = width/2;
          int targetY = rotors[rotors.length - 1].y + box_size + gap;

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

    //draw output letter in the output box
    if (process) {
      fill(255, 0, 0);
      draw_letters(width/2-box_size/2, rotors[rotors.length - 1].y + box_size + gap, box_size, new String[]{output});
    }

    key_pressed = true;
    start_time = millis();
  }


  if (key_pressed) {
    if (pause(start_time, key_delay)) {
      // println("delayed 1000ms");

      for (Rotor x : rotors) {
        x.turn();
      }
      key_pressed = false;
      screen_update = true;
    }
  }
}
