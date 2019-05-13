/* wow i am trying a new thing here

QUESTIONS -
currently - boolean for circle toggle - dont want them on keyreleased because then they will only  
            stay on screen when key is pressed. however, it isn't accuarate representation of what
            sounds are being played - how to fix (only display the last two keys pressed ? - how to
            to that?

currently - currently can play any notefor both sets of tones in either order
-  should i make it that you have to play the first note in order to play the second note ? 
  force function (if firstnote played = true, then can play second note) (ask during user testing)
  
  future moves: make dictionaries for all sounds, dissonant sounds, consonant sounds
*/


// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that are global
Minim minim;
AudioOutput out;
AudioOutput out1;
//Wavetable   table;
PImage test;
//testing screenshot
//PImage[] screenshot;
int n = 8;
//circles
Circle [] circles = new Circle[13];
//integer for mode - change colors of circles
int c;
PShape rectangle;

Oscil      wave;
Oscil      wave1;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;
Frequency newFreq; //theoretically the new frequency

//--------booleans and stuff-------

//array of keys
boolean [] notes = new boolean[13];
boolean [] notess = new boolean[8];
boolean none = true;
boolean[] circleToggle = new boolean[13]; 
//not using count for anything
int count=0; //not sure if we need this

// setup is run once at the beginning
void setup()
{ 
  // initialize the drawing window
  //fullScreen();
  size(812, 900);
  //not sure how else we can slow down the rate? 
  frameRate(60);
  
 //circles
 for (int i = 0; i < circles.length; i++)
  {
    circles[i] = new Circle();
    circles[i].xpos= 30 + ((width/13)*i);  // CHANGE LATER
    circles[i].ypos = 410;
   println(circles[i].xpos);//40,106,172,238,304,370,436,502,568,634,700,766
  }
  
  //load test image
  test = loadImage("M2.png");
 //load screenshot images
 
// screenshot= new PImage[n];
// for(int i=0;i<screenshot.length;i++){
// screenshot[i]=loadImage(str(i) + ".tif");
//}
  //boolean array  
  for( int i = 0; i < notes.length-1; ++i )
  {
    notes[i]=false;
  }
 for( int i = 0; i < notess.length-1; ++i )
  {
    notess[i]=false;
  }

  // initialize the minim and out objects
  minim = new Minim(this);
  out   = minim.getLineOut();
  out1 = minim.getLineOut();

  //currentFreq = Frequency.ofPitch( "A4" );
  currentFreq = Frequency.ofHertz( 0 );
  newFreq = Frequency.ofHertz(0);
  wave = new Oscil( currentFreq, 1, Waves.SINE );
  wave1= new Oscil(newFreq, 1, Waves.SINE);
  wave.patch( out );
  wave1.patch(out1);
  
  //testing out these things
  rectangle = createShape(RECT, 0, 55, width,225);
  rectangle.setStroke(color(0,0,0)); 
   
}

// draw is run many times
void draw()
{
  background(0,0,0);
 // println(frameCount); //figure out if i can reset framecount
  stroke( 255, 255, 255 );
  strokeWeight(1); //play around with stroke weight
  textSize(16);
  // WAVE DETAIL TEXT ---------------------------------------------------
  text("Difference in Frequency of the notes: "+(abs(currentFreq.asHz()-newFreq.asHz())),5,45);
  text( "Current Frequency of 1st note in Hertz: " + currentFreq.asHz(), 5, 15 );
  text( "Current Frequency of 2nd note in Hertz: " + newFreq.asHz(),5, 30 );
  text("Press the space bar to clear sounds. \nPress two keys at the same time for the interval",5,700);
// -------------------------------------------------------------------------------------------

// -------- DRAW THE WAVE FORMS --------------------------------------------------------------
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
  //waveform for second note
  for( int i = 0; i < out1.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out1.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out1.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    //line( x1, 49 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
 //  line( x1, 49 + out1.left.get(i)*50, x2, 50 + out1.left.get(i+1)*50);
   stroke(255,113,206);
   line( x1, 150 + out1.right.get(i)*50, x2, 150 + out1.right.get(i+1)*50);
  }  
// ---------------------------------------------------------------------------------------------

// ----------------DISPLAY CIRCLES--------------------------------------------------------------
  //for (int i = 0; i < circles.length; i++)
  //{ 
  //  circles[i].display();
  //}
//circle booleans
  if (circleToggle[0]){
    text("C",30-5,380);
    //fill(255,255,0);
    circles[0].display();
  }
  if (circleToggle[1]){
    text("C#",92-5,380);
    //fill(255,255,0);
    circles[1].display();
  }
  if (circleToggle[2]){
    text("D",154-5,380);
    //fill(255,255,0);
    circles[2].display();
  }
  if (circleToggle[3]){
    text("D#",216-5,380);
    //fill(255,255,0);
    circles[3].display();
  }
  if (circleToggle[4]){
    text("E",278-5,380);
    //fill(255,255,0);
    circles[4].display();
  }
  if (circleToggle[5]){
    text("F",340-5,380);
    //fill(255,255,0);
    circles[5].display();
  }
  if (circleToggle[6]){
    text("F#",402-5,380);
    //fill(255,255,0);
    circles[6].display();
  }
  if (circleToggle[7]){
    text("G",464-5,380);
    //fill(255,255,0);
    circles[7].display();
  }
   if (circleToggle[8]){
    text("G#",526-5,380);
    //fill(255,255,0);
    circles[8].display();
  }
   if (circleToggle[9]){
    text("A",588-5,380);
    //fill(255,255,0);
    circles[9].display();
  }
    if (circleToggle[10]){
    text("A#",650-5,380);
    //fill(255,255,0);
    circles[10].display();
  }
    if (circleToggle[11]){
    text("B",712-5,380);
    //fill(255,255,0);
    circles[11].display();
  }
    if (circleToggle[12]){
    text("C",774-5,380);
    //fill(255,255,0);
    circles[12].display();
  }


// INTERVAL COMBOS -----------------------------------------------------------------------------
  /*THIS IS ALL THE POSSIBLE INTERVAL COMBINATIONS THAT ARE CATEGORIZED BY 
  EITHER DISSONANCE OR CONSONANCE. 
  CONSONANCE = BLUE; P4,P5,m6,M6,octave
  IMPERFECT CONSONANCE = YELLOW; m3, M3, m6, M6
  DISSONANCE = RED; m2,M2,tritone,m7,M7
  */
  
  //same note
  if ((notes[0]) && (notess[0])) {
 rectangle.setFill(color(0,153,255,70));
 shape(rectangle);
  text("INTERVAL: SAME NOTE!",width/3,height/2);
  //retake screenshot!!! for some reason doesn't like this one
  //image(screenshot[0],0,500,width,height);
    }
    
   //Major third
if ((notes[0]) && (notess[2])) {
 rectangle.setFill(color(255,255,102,70));
 shape(rectangle);
  text("INTERVAL: MAJOR THIRD (imperfect)!",width/3,height/2);
//image(screenshot[2],0,500,width,height);
}
 
  //perfect 4th
if ((notes[0]) && (notess[3])) {
 rectangle.setFill(color(0,153,255,70));
 shape(rectangle);
  text("INTERVAL: PERFECT FOURTH!",width/3,height/2);
//testing image load
// image(screenshot[3],0,500,width,height);
}
  
  //perfect fifth
  if ((notes[0]) && (notess[4])) {
  rectangle.setFill(color(0,153,255,70));
  shape(rectangle);
  text("INTERVAL: PERFECT FIFTH!",width/3,height/2);
  //image(screenshot[4],0,500,width,height);

}
  
  //M6
  if ((notes[0]) && (notess[5])) {
  rectangle.setFill(color(255,255,102,70));
  shape(rectangle);
  text("INTERVAL: Major 6th (imperfect)!",width/3,height/2);
 // image(screenshot[5],0,500,width,height);

}
  //octave
  if ((notes[0]) && (notess[7])) {
  rectangle.setFill(color(0,153,255,70));
  shape(rectangle);
  text("INTERVAL: OCTAVE!!",width/3,height/2);
 // image(screenshot[7],0,500,width,height);
}
  
  //---------------dissonant combinations---------------
  // Major 2nd
   if ((notes[0])&&(notess[1])){
   // text("INTERVAL: Major 2nd",width/3,height/2);
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
    image(test,150,300,width/2,height/2);
  //  image(screenshot[1],0,500,width,height);
  }
  
  //major 7
  if ((notes[0])&&(notess[6])){
    text("INTERVAL: Major 7th",width/3,height/2);
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
   //  image(screenshot[6],0,500,width,height);
  } 

}
  
// change the midi note when pressing keys on the keyboard
void keyPressed()
{
  //count +=1;
  if ( key == 'z' ){ currentFreq = Frequency.ofPitch( "C4" );
  notes[0] = true;
  circleToggle[0] = !circleToggle[0];
  //circles[1].display();
}
  if ( key == 's' ) {currentFreq = Frequency.ofPitch( "C#4" );
    //this is an option - play note for a set duration(have to figure out math for wave)
   // out.playNote(0,1,"C4");
    notes[1]=true;
  circleToggle[1] = !circleToggle[1];
  }
  if ( key == 'x' ){currentFreq = Frequency.ofPitch( "D4" );
    notes[2]=true;
   circleToggle[2] = !circleToggle[2];
  }
  if ( key == 'd' ){ currentFreq = Frequency.ofPitch( "D#4" );
   notes[3]=true;
  circleToggle[3] = !circleToggle[3];
  }
  if ( key == 'c' ) {currentFreq = Frequency.ofPitch( "E4" );
   notes[4]=true;
    circleToggle[4] = !circleToggle[4];
  }
  if ( key == 'v' ) {currentFreq = Frequency.ofPitch( "F4" );
    notes[5]=true;
    circleToggle[5] = !circleToggle[5];
  }
  if ( key == 'g' ){ currentFreq = Frequency.ofPitch( "F#4" );
    notes[6]=true;
     circleToggle[6] = !circleToggle[6];
  }
  if ( key == 'b' ){currentFreq = Frequency.ofPitch( "G4" );
    notes[7]=true;
   circleToggle[7] = !circleToggle[7];
  }
  if ( key == 'h' ) {currentFreq = Frequency.ofPitch( "G#4" );
  notes[8]=true;
   circleToggle[8] = !circleToggle[8];
  }
  if ( key == 'n' ) {currentFreq = Frequency.ofPitch( "A4" );
    notes[9]=true;
    circleToggle[9] = !circleToggle[9];
  }
  if ( key == 'j') {currentFreq = Frequency.ofPitch( "A#4" );
  notes[10]=true;
  circleToggle[10] = !circleToggle[10];
  }
  if ( key == 'm'){currentFreq = Frequency.ofPitch( "B4" );
  notes[11]=true;
  circleToggle[11] = !circleToggle[11];
  }
  if ( key == ',') {currentFreq = Frequency.ofPitch( "C5" );
  notes[12]=true;
  circleToggle[12] = !circleToggle[12];
  }
 if (key == ' ') {currentFreq= Frequency.ofHertz(0);
    notes[0]=false;
   // saveFrame();
 }
 //second tone
 //trying to do same keys
  if ( key == 'q' ) {newFreq = Frequency.ofPitch( "C4" );
    notess[0]=true;
   //circleToggle[0] = !circleToggle[0];
   // circles[1].display();
  }
  if ( key == 'w' ){ newFreq = Frequency.ofPitch( "D4" );
  notess[1]=true;
 circleToggle[2] = !circleToggle[2];
  }
  if ( key == 'e' ) {newFreq = Frequency.ofPitch( "E4" );
    notess[2]=true;
    circleToggle[4] = !circleToggle[4];
  }
  if ( key == 'r' ){ newFreq = Frequency.ofPitch( "F4" );
     notess[3]=true;
    circleToggle[5] = !circleToggle[5];
  }

  if ( key == 't' ){ newFreq = Frequency.ofPitch( "G4" );
    notess[4]=true;
   circleToggle[7] = !circleToggle[7];
  }
  if ( key == 'y' ){ newFreq = Frequency.ofPitch( "A4" );
    notess[5]=true;
   circleToggle[9] = !circleToggle[9];
  }
  if ( key == 'u' ){ newFreq= Frequency.ofPitch( "B4" );
    notess[6]=true;
   circleToggle[11] = !circleToggle[11];
  }
  if ( key == 'i' ) {newFreq = Frequency.ofPitch( "C5" );
    notess[7]=true;
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
