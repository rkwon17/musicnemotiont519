/* wow i am trying a new thing here

QUESTIONS - how do you slow down waves??? plz help
current bugs: lines keep moving - try to understand how waves are being drawn
to figure out what is happening.

booleans are still kinda buggy  - doesn't always understand that both keys are released?

future moves: make dictionaries for all sounds, dissonant sounds, consonant sounds
*/

// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that are global
Minim minim;
AudioOutput out;
AudioOutput out1;
PImage smiley;
PShape rectangle;

Oscil      wave;
Oscil      wave1;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;
Frequency newFreq; //theoretically the new frequency

//booleans and stuff

//array of keys
boolean [] notes = new boolean[13];
boolean [] notess = new boolean[8];
//boolean isZ = false;
//boolean isR = false;

int count=0;
//how many keys are being pressed - convert to arduino roip
//FUTURE: dictionaries
IntDict dissonance;

// setup is run once at the beginning
void setup()
{
  // initialize the drawing window
  size(812, 800);
  //not sure how else we can slow down the rate? 
  frameRate(60);
  
  
  //boolean array
  //for loop all of this
  notes[0] = false;
  notes[1] = false;
  notes[2] = false;
  notes[3] = false;
  notes[4] = false;
  notes[5] = false;
  notes[6] = false;
  notes[7] = false;
  notes[8] = false;
  notes[9] = false;
  notes[10] = false;
  notes[11] = false;
  notes[12] = false;
  //dissonant sounds array
  //diss[0] = false;
  //diss[1] = false;
  notess[0]=false;
  notess[1]=false;
  notess[2]=false;
  notess[3]=false;
  notess[4]=false;
  notess[5]=false;
  notess[6]=false;
  notess[7]=false;
  
  
  //image
  smiley = loadImage("smiley.png");
  // initialize the minim and out objects
  minim = new Minim(this);
  out   = minim.getLineOut();
  out1 = minim.getLineOut();

  //currentFreq = Frequency.ofPitch( "A4" );
  currentFreq = Frequency.ofHertz( 0 );
  newFreq = Frequency.ofHertz(0);
  wave = new Oscil( currentFreq, 0.80f, Waves.SINE );
  wave1= new Oscil(newFreq, 0.80f, Waves.SINE);
  //line(1,1,512,400);
   //wave = new Oscil( currentFreq, 0.9f, Waves.SINE );
  wave.patch( out );
  wave1.patch(out1);
  
  //testing out these things
  rectangle = createShape(RECT, 400, 500, 400, 400);
  rectangle.setStroke(color(0,0,0)); 
  
  //dictionary:
  dissonance = new IntDict();
  

}

// draw is run many times
void draw()
{

  background( 0, 0, 0 );
  stroke( 255, 255, 255 );
  //count stuff
  //text(count, 5, 40);
  textSize(15);
  text("Difference in Frequency of the notes: "+(abs(currentFreq.asHz()-newFreq.asHz())),5,45);
  //count 
  
  text( "Current Frequency of 1st note in Hertz: " + currentFreq.asHz(), 5, 15 );
  //doesn't have one for pitch - probably need to make an array of all the different notes
 // text("Current Pitch of 1st note: " + currentFreq.FrequencyasPitch(),5,20);
  text( "Current Frequency of 2nd note in Hertz: " + newFreq.asHz(), 5, 30 );
  text("Press the space bar to clear sounds. \nPress two keys at the same time for the interval",5,700);
 // text( "Current Frequency as MIDI note: " + currentFreq.asMidiNote(), 5, 30 );
  
  // draw the waveforms for sound 1
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    //line( x1, 49 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
   //line( x1, 49 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
   line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
  //second sound
  for( int i = 0; i < out1.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out1.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out1.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    //line( x1, 49 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
   // line( x1, 49 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
   stroke(255,113,206);
   line( x1, 150 + out1.right.get(i)*50, x2, 150 + out1.right.get(i+1)*50);
  }  
  
  //boolean stuff - testing
 
  //if(isRect)rect(50,500,40,40);
  //if(isInterval)text("interval: major third",100,300);

  
 //keypressed
 // keyPressed();
// if (notes[0]) text("note:C4",300,200);

//make this a whole class!! don't want to do this yet bc arduino
if ( key == 'z' ){ 
  text("note:C4",100,300);
  //isRect = true;
}
  //keyReleased();
  
  //boolean stuff
  /*THIS IS ALL THE POSSIBLE INTERVAL COMBINATIONS THAT ARE CATEGORIZED BY 
  EITHER DISSONANCE OR CONSONANCE. 
  CONSONANCE = BLUE; m3,M3,P4,P5,m6,M6,octave
  
  DISSONANCE = RED; m2,M2,tritone,m7,M7
  
  */
  //same note
  if ((notes[0]) && (notess[0])) {
  //background(255,0,0,0);
  //fill(255,106,213);
 // rect(0,400,812,450);
 rectangle.setFill(color(0,153,255));
 shape(rectangle);
  text("INTERVAL: SAME NOTE!",width/3,height/2);}
    //Major third
if ((notes[0]) && (notess[2])) {
  //background(255,0,0,0);
  //fill(255,106,213);
 // rect(0,400,812,450);
 rectangle.setFill(color(0,153,255));
 shape(rectangle);
  text("INTERVAL: MAJOR THIRD!",width/3,height/2);}
  //image(smiley,450,350,width/8,height/8);
  //perfect fifth
  //perfect 4th
if ((notes[0]) && (notess[3])) {
  //background(255,0,0,0);
  //fill(255,106,213);
 // rect(0,400,812,450);
 rectangle.setFill(color(0,153,255));
 shape(rectangle);
  text("INTERVAL: PERFECT FOURTH!",width/3,height/2);}
  //image(smiley,450,350,width/8,height/8);
  //perfect fifth
  if ((notes[0]) && (notess[4])) {
  //background(255,0,0,0);
   //fill(255,106,213);
  rectangle.setFill(color(0,153,255));
  shape(rectangle);
  //image(smiley,450,350,width/8,height/8);
  text("INTERVAL: PERFECT FIFTH!",width/3,height/2);}
  
  //M6
  if ((notes[0]) && (notess[5])) {
  //background(255,0,0,0);
   //fill(255,106,213);
  rectangle.setFill(color(0,153,255));
  shape(rectangle);
  //image(smiley,450,350,width/8,height/8);
  text("INTERVAL: Major 6th!",width/3,height/2);}
  //octave
  if ((notes[0]) && (notess[7])) {
  //background(255,0,0,0);
  rectangle.setFill(color(0,153,255));
  shape(rectangle);
 // image(smiley,450,350,width/8,height/8);
  text("INTERVAL: OCTAVE!!",200,height/2);}
  
  //dissonant combinations
  // Major 2nd
   if ((notes[0])&&(notess[1])){
    text("INTERVAL: Major 2nd",300,450);
    rectangle.setFill(color(255,0,51));
    shape(rectangle);
  }
  
  //major 7
  if ((notes[0])&&(notess[6])){
    text("INTERVAL: Major 7th",300,450);
    rectangle.setFill(color(255,0,51));
    shape(rectangle);
  }
  
  
}
  
  


// change the midi note when pressing keys on the keyboard

void keyPressed()
{
  //count +=1;
  //started on A4 not sure if I want to keep it as so.
  if ( key == 'z' ){ currentFreq = Frequency.ofPitch( "C4" );
  //draw a rectangle
  //rect(150,350,40,40);
 // count +=1;
  notes[0] = true;
  //isRect = true;
}
  if ( key == 's' ) {currentFreq = Frequency.ofPitch( "C#4" );
    //diss[1]=true;
    notes[1]=true;
  }
  if ( key == 'x' ){currentFreq = Frequency.ofPitch( "D4" );
    notes[2]=true;
  }
  if ( key == 'd' ){ currentFreq = Frequency.ofPitch( "D#4" );
   notes[3]=true;
  }
  if ( key == 'c' ) {currentFreq = Frequency.ofPitch( "E4" );
   notes[4]=true;
  }
  if ( key == 'v' ) {currentFreq = Frequency.ofPitch( "F4" );
    notes[5]=true;
  }
  if ( key == 'g' ){ currentFreq = Frequency.ofPitch( "F#4" );
    notes[6]=true;
  }
  if ( key == 'b' ){currentFreq = Frequency.ofPitch( "G4" );
    notes[7]=true;
  }
  if ( key == 'h' ) {currentFreq = Frequency.ofPitch( "G#4" );
  notes[8]=true;
  }
  if ( key == 'n' ) {currentFreq = Frequency.ofPitch( "A4" );
    notes[9]=true;
  }
  if ( key == 'j') {currentFreq = Frequency.ofPitch( "A#4" );
  notes[10]=true;
  }
  if ( key == 'm'){currentFreq = Frequency.ofPitch( "B4" );
  notes[11]=true;
  }
  if ( key == ',') {currentFreq = Frequency.ofPitch( "C5" );
  notes[12]=true;
  }
 if (key == ' ') {currentFreq= Frequency.ofHertz(0);
   //isInterval = false;
    //isRect = false;
    notes[0]=false;
 }
 if (key == 'p') newFreq= Frequency.ofHertz(340);
  //test new Freq
  //if (key == 'w') newFreq=Frequency.ofHertz(300);
  if ( key == 'q' ) {newFreq = Frequency.ofPitch( "C4" );
    notess[0]=true;
  }
  if ( key == 'w' ){ newFreq = Frequency.ofPitch( "D4" );
  notess[1]=true;
  }
  if ( key == 'e' ) {newFreq = Frequency.ofPitch( "E4" );
  //isInterval = true;
  notess[2]=true;
  }
  if ( key == 'r' ){ newFreq = Frequency.ofPitch( "F4" );
   // notes[1]=true;
   notess[3]=true;
  }

  if ( key == 't' ){ newFreq = Frequency.ofPitch( "G4" );
  //  notes[2]=true;
  notess[4]=true;
  }
  if ( key == 'y' ){ newFreq = Frequency.ofPitch( "A4" );
  notess[5]=true;
  }
  if ( key == 'u' ){ newFreq= Frequency.ofPitch( "B4" );
  notess[6]=true;
  }
  if ( key == 'i' ) {newFreq = Frequency.ofPitch( "C5" );
  notess[7]=true;
   // notes[3]=true;
   }
 // if ( key == 'o' ) newFreq = Frequency.ofPitch( "B4" );
  //if ( key == 'p' ) newFreq = Frequency.ofPitch( "C#4" );
  //if ( key == '[') newFreq = Frequency.ofPitch( "E4" );
  if (key == ' '){ newFreq= Frequency.ofHertz(0);
 // isInterval = false;
 // isRect = false;
 //function - clear button
  notes[1]=false;
  notes[2] = false;
  notes[3] = false;
  notes[4]=false;
  notes[5] = false;
  notes[6] = false;
  notes[7]=false;
  notes[8] = false;
  notes[9] = false;
  notes[10] = false;
  notes[11] = false;
  notess[0] = false;
  notess[1] = false;
  notess[2] = false;
  notess[3] = false;
  notess[4] = false;
  notess[5] = false;
  notess[6] = false;
  notess[7] = false;
}
  
  //count stuff
  
  //testing this new stuff here
  //if(key == 'a') text("C4",50,100);
  //if(key == 's') text("C#4",50,100);
  
  //boolean test - this isn't really working
  //if(key=='a' && key=='t') iscChordpressed= true;
  
  // note that there are two other static methods for constructing Frequency objects
  // currentFreq = Frequency.ofHertz( 440 );
  // currentFreq = Frequency.ofMidiNote( 69 ); 
  //updates the frequency
  wave.setFrequency( currentFreq );
  wave1.setFrequency(newFreq);
  
  //if((key=='a')&&(key=='t')){
  //  rect(45,45,50,200);
  //}
   
   
}

void keyReleased(){
  if(key=='z') notes[0] = false;
  if(key=='s') notes[1] = false;
  if(key=='x')notes[2] = false;
  if(key=='d')notes[3] = false;
  if(key=='c') notes[4] = false;
  if(key=='v') notes[5] = false;
  if(key=='g')notes[6] = false;
  if(key=='b')notes[7] = false;
   if(key=='h')notes[8] = false;
  if(key=='n')notes[9] = false;
  if(key=='j')notes[10] = false;
  if(key=='m')notes[11] = false;
  if(key==',')notes[12] = false;
  if(key=='q')notess[0]=false;
  if(key=='w')notess[1]=false;
  if(key=='e')notess[2]=false;
  if(key=='r')notess[3]=false;
  if(key=='t')notess[4]=false;
  if(key=='y')notess[5]=false;
    if(key=='u')notess[6]=false;
  if(key=='i')notess[7]=false;
  
}
