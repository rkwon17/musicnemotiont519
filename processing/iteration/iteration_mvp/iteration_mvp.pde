/* wow i am trying a new thing here

QUESTIONS - how do you slow down waves??? plz help
*/

// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that are global
Minim minim;
AudioOutput out;
AudioOutput out1;

Oscil      wave;
Oscil      wave1;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;
Frequency newFreq; //theoretically the new frequency

//booleans and stuff
boolean iscChordpressed = false;
boolean isRect = false;
boolean isInterval = false;
int count=0;
//how many keys are being pressed - convert to arduino roip


// setup is run once at the beginning
void setup()
{
  // initialize the drawing window
  size(812, 800);
  //not sure how else we can slow down the rate? 
  frameRate(40);
  
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
  
  //intervals  do i want to use this as a global variable instead?
  

}

// draw is run many times
void draw()
{

  background( 0, 0, 0 );
  stroke( 255, 255, 255 );
  //count stuff
  text(count, 5, 40);
  //count 
  

  text( "Current Frequency of 1st note in Hertz: " + currentFreq.asHz(), 5, 15 );
  //doesn't have one for pitch - probably need to make an array of all the different notes
 // text("Current Pitch of 1st note: " + currentFreq.FrequencyasPitch(),5,20);
  text( "Current Frequency of 2nd note in Hertz: " + newFreq.asHz(), 5, 30 );
  text("Press the space bar to clear sounds",5,700);
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
    if(key=='a' && key=='t') iscChordpressed= true;
  if (iscChordpressed) println("nice!");
  if(isRect)rect(50,500,40,40);
  if(isInterval)text("interval: major third",100,300);
  
  //keypressed
  keyPressed();
  //if(key == 'a') text("C3",50,460);
 // if(key=='a')rect(50,350,50,50,50);
  //if(key == 's') text("D3",50,460);
  //if(key == 'd') text("E3",50,460);
  //if(key == 'f') text("F3",50,460);
  //if(key == 'g') text("G3",50,460);
  //if(key == 'h') text("A3",50,460);
  //if(key == 'j') text("B3",50,460);
  //if(key == 'k') text("C4",50,460);
  
  
}

// change the midi note when pressing keys on the keyboard

void keyPressed()
{
  count +=1;
  //started on A4 not sure if I want to keep it as so.
  if ( key == 'z' ){ currentFreq = Frequency.ofPitch( "C4" );
  //draw a rectangle
  //rect(150,350,40,40);
  isRect = true;}
  if ( key == 's' ) currentFreq = Frequency.ofPitch( "C#4" );
  if ( key == 'x' ){currentFreq = Frequency.ofPitch( "D4" );
  }
  if ( key == 'd' ) currentFreq = Frequency.ofPitch( "D#4" );
  if ( key == 'c' ) currentFreq = Frequency.ofPitch( "E4" );
  if ( key == 'v' ) currentFreq = Frequency.ofPitch( "F4" );
  if ( key == 'g' ) currentFreq = Frequency.ofPitch( "F#4" );
  if ( key == 'b' ) currentFreq = Frequency.ofPitch( "G4" );
  if ( key == 'h' ) currentFreq = Frequency.ofPitch( "G#4" );
  if ( key == 'n' ) currentFreq = Frequency.ofPitch( "A4" );
  if ( key == 'j') currentFreq = Frequency.ofPitch( "A#4" );
  if ( key == 'm') currentFreq = Frequency.ofPitch( "B4" );
  if ( key == ',') currentFreq = Frequency.ofPitch( "C5" );
 if (key == ' ') {currentFreq= Frequency.ofHertz(0);
   isInterval = false;
    isRect = false;
 }
 if (key == 'p') newFreq= Frequency.ofHertz(340);
  //test new Freq
  //if (key == 'w') newFreq=Frequency.ofHertz(300);
  if ( key == 'q' ) newFreq = Frequency.ofPitch( "C4" );
  if ( key == 'w' ) newFreq = Frequency.ofPitch( "D4" );
  if ( key == 'e' ) {newFreq = Frequency.ofPitch( "E4" );
  isInterval = true;
  }
  if ( key == 'r' ) newFreq = Frequency.ofPitch( "F4" );
  if ( key == 't' ) newFreq = Frequency.ofPitch( "G4" );
  if ( key == 'y' ) newFreq = Frequency.ofPitch( "A4" );
  if ( key == 'u' ) newFreq= Frequency.ofPitch( "B4" );
  if ( key == 'i' ) newFreq = Frequency.ofPitch( "C5" );
 // if ( key == 'o' ) newFreq = Frequency.ofPitch( "B4" );
  //if ( key == 'p' ) newFreq = Frequency.ofPitch( "C#4" );
  //if ( key == '[') newFreq = Frequency.ofPitch( "E4" );
  if (key == ' '){ newFreq= Frequency.ofHertz(0);
  isInterval = false;
  isRect = false;
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

//void keyReleased(){
// // if(key=='a') iscChordpressed = false;
//}
