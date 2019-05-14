// change the midi note when pressing keys on the keyboard
void keyPressed()
{
  //count +=1;
  if ( key == 'z' ){ currentFreq = Frequency.ofPitch( "C4" );
  notes[0] = true;
  text("C",30-5,380);
  //circleToggle[0] = !circleToggle[0];
  
  /*
  if  notes[0] == false {
    circleToggle[0] = true
  }
  */
}
  if ( key == 'a' ) {newFreq = Frequency.ofPitch( "C#4" );
    //this is an option - play note for a set duration(have to figure out math for wave)
   // out.playNote(0,1,"C4");
    notess[0]=true;
  circleToggle[1] = !circleToggle[1];
  }
  //if ( key == 'x' ){currentFreq = Frequency.ofPitch( "D4" );
  //  notes[2]=true;
  // circleToggle[2] = !circleToggle[2];
  //}
  if ( key == 'd' ){ newFreq = Frequency.ofPitch( "D#4" );
   notess[2]=true;
  circleToggle[3] = !circleToggle[3];
  }
  //if ( key == 'c' ) {currentFreq = Frequency.ofPitch( "E4" );
  // notes[4]=true;
  //  circleToggle[4] = !circleToggle[4];
  //}
  //if ( key == 'v' ) {currentFreq = Frequency.ofPitch( "F4" );
  //  notes[5]=true;
  //  circleToggle[5] = !circleToggle[5];
  //}
  if ( key == 'g' ){ newFreq = Frequency.ofPitch( "F#4" );
    notess[5]=true;
     circleToggle[6] = !circleToggle[6];
  }
  //if ( key == 'b' ){currentFreq = Frequency.ofPitch( "G4" );
  //  notes[7]=true;
  // circleToggle[7] = !circleToggle[7];
  //}
  if ( key == 'h' ) {newFreq = Frequency.ofPitch( "G#4" );
  notess[7]=true;
   circleToggle[8] = !circleToggle[8];
  }
  //if ( key == 'n' ) {currentFreq = Frequency.ofPitch( "A4" );
  //  notes[9]=true;
  //  circleToggle[9] = !circleToggle[9];
  //}
  if ( key == 'j') {newFreq = Frequency.ofPitch( "A#4" );
  notess[9]=true;
  circleToggle[10] = !circleToggle[10];
  }
  //if ( key == 'm'){currentFreq = Frequency.ofPitch( "B4" );
  //notes[11]=true;
  //circleToggle[11] = !circleToggle[11];
  //}
  //if ( key == ',') {currentFreq = Frequency.ofPitch( "C5" );
  //notes[12]=true;
  //circleToggle[12] = !circleToggle[12];
  //}
 if (key == ' ') {currentFreq= Frequency.ofHertz(0);
    notes[0]=false;
   // saveFrame();
 }
 //second tone
 //trying to do same keys
  //if ( key == 'q' ) {newFreq = Frequency.ofPitch( "C4" );
  //  notess[0]=true;
  // //circleToggle[0] = !circleToggle[0];
  // // circles[1].display();
  //}
  if ( key == 'w' ){ newFreq = Frequency.ofPitch( "D4" );
  notess[1]=true;
 circleToggle[2] = !circleToggle[2];
  }
  if ( key == 'e' ) {newFreq = Frequency.ofPitch( "E4" );
    notess[3]=true;
    circleToggle[4] = !circleToggle[4];
  }
  if ( key == 'r' ){ newFreq = Frequency.ofPitch( "F4" );
     notess[4]=true;
    circleToggle[5] = !circleToggle[5];
  }

  if ( key == 't' ){ newFreq = Frequency.ofPitch( "G4" );
    notess[6]=true;
   circleToggle[7] = !circleToggle[7];
  }
  if ( key == 'y' ){ newFreq = Frequency.ofPitch( "A4" );
    notess[5]=true;
   circleToggle[9] = !circleToggle[9];
  }
  if ( key == 'u' ){ newFreq= Frequency.ofPitch( "B4" );
    notess[10]=true;
   circleToggle[11] = !circleToggle[11];
  }
  if ( key == 'i' ) {newFreq = Frequency.ofPitch( "C5" );
    notess[11]=true;
    circleToggle[12] = !circleToggle[12];
   }
  if (key == ' '){ newFreq= Frequency.ofHertz(0);
 //function - clear button - clears all the booleans
 for( int i = 0; i < notes.length-1; ++i )
  {
    notes[i]=false;
  }
   for( int i = 0; i < notess.length-1; ++i )
  {
    notess[i]=false;
  }
  //toggle
    for (int i=0; i<circleToggle.length; i++) {
      circleToggle[i] = false;
    }
}
 //updates the frequency
  wave.setFrequency( currentFreq );
  wave1.setFrequency(newFreq);   
}
