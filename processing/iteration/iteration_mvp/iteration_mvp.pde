/* current status - images are not loading in ???????? need to fix this
wow i am trying a new thing here

MAKEYMAKEY VERSION 

(keyboard version does provide multiple note ability)
QUESTIONS -
currently - boolean for circle toggle - dont want them on keyreleased because then they will only  
            stay on screen when key is pressed. however, it isn't accuarate representation of what
            sounds are being played - how to fix (only display the last two keys pressed ? - how to
            to that?
  future moves: make dictionaries for all sounds, dissonant sounds, consonant sounds
  
*/


// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that are global
Minim minim;
AudioOutput out;
AudioOutput out1;
//PImage[] screenshot;
//int n = 8;

PImage[] intervals;
PImage frequenc;
PImage soundKey;
int a = 11;

Circle [] circles = new Circle[13]; //circles
//integer for mode - change colors of circles
int c;
PShape rectangle;
PShape note;

Oscil      wave;
Oscil      wave1;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;
Frequency newFreq; 

//--------booleans and stuff-------

//array of keys

boolean [] notes = new boolean[1];
boolean [] notess = new boolean[13];
boolean recent_note = true;
boolean[] circleToggle = new boolean[13]; 
//count the number of keys
int count_key=0; //not sure if we need this

void setup()
{ 
  fullScreen();
  //size(812, 900);
  //not sure how else we can slow down the rate? 
  frameRate(60);
  
  //load title
  frequenc = loadImage("frequenC.png");
  soundKey = loadImage("key519.png");

 //circles
 for (int i = 0; i < circles.length; i++)
  {
    circles[i] = new Circle();
    circles[i].xpos= 30 + ((width/13)*i);  // CHANGE LATER
    circles[i].ypos = 410;
   println(circles[i].xpos);
  }
  
  intervals = new PImage[a];
//load images of intervals
 for(int i=0;i<intervals.length;i++){
intervals[i]=loadImage(str(i) + ".png");
}
 
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
  
  //note yellow
  note = createShape(ELLIPSE, 0, 55, circles[1].xpos,circles[1].ypos);
 
}

// draw is run many times
void draw()
{
  
  
  background(0,0,0);
 // println(frameCount); //figure out if i can reset framecount
  stroke( 255, 255, 255 );
  strokeWeight(1); //play around with stroke weight
  image(frequenc,0,height-300);
  image(soundKey,width/2+250,height/2+160);
  textSize(17);
  // WAVE DETAIL TEXT ---------------------------------------------------
  text("Difference in Frequency of the notes: "+(abs(currentFreq.asHz()-newFreq.asHz())),850,45+10);
  text( "Current Frequency of 1st note in Hertz: " + currentFreq.asHz(),850, 15+10);
  text( "Current Frequency of 2nd note in Hertz: " + newFreq.asHz(),850, 30+10 );
  //text("Press the space bar to clear sounds. \nPress two keys at the same time for the interval",850,700);
// ---------------------------------------------
// }
// -------- DRAW THE WAVE FORMS --------------------------------------------------------------
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
   line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
  //waveform for second note
  for( int i = 0; i < out1.bufferSize() - 1; i++ )
  {
    float x1  =  map( i, 0, out1.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out1.bufferSize(), 0, width );
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

//if (recent_note == true){
//  note.setFill(color(255,255,102,60));
//  shape(note);
//}


  if (circleToggle[0]){
    text("C",30-5,380);
    //fill(255,255,0);
    circles[0].display();
  }
  if (circleToggle[1]){
    text("C#",128-5,380);
    //fill(255,255,0);
    circles[1].display();
  }
  if (circleToggle[2]){
    text("D",226-5,380);
    //fill(255,255,0);
    circles[2].display();
  }
  if (circleToggle[3]){
    text("D#",324-5,380);
    //fill(255,255,0);
    circles[3].display();
  }
  if (circleToggle[4]){
    text("E",422-5,380);
    //fill(255,255,0);
    circles[4].display();
  }
  if (circleToggle[5]){
    text("F",520-5,380);
    //fill(255,255,0);
    circles[5].display();
  }
  if (circleToggle[6]){
    text("F#",618-5,380);
    //fill(255,255,0);
    circles[6].display();
  }
  if (circleToggle[7]){
    text("G",716-5,380);
   //fill(255,255,0);
    circles[7].display();
  }
   if (circleToggle[8]){
    text("G#",814-5,380);
    //fill(255,255,0);
    circles[8].display();
  }
   if (circleToggle[9]){
    text("A",912-5,380);
    //fill(255,255,0);
    circles[9].display();
  }
    if (circleToggle[10]){
    text("A#",1010-5,380);
    //fill(255,255,0);
    circles[10].display();
  }
    if (circleToggle[11]){
    text("B",1108-5,380);
    //fill(255,255,0);
    circles[11].display();
  }
    if (circleToggle[12]){
    text("C",1206-5,380);
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
    }
    
   //Major third - imperfect
if ((notes[0]) && (notess[3])) {
 rectangle.setFill(color(255,255,102,70));
 shape(rectangle);
  image(intervals[2],150,300,width/2,height/2);
}

// minor third - imperfect
if ((notes[0]) && (notess[2])) {
 rectangle.setFill(color(255,255,102,70));
 shape(rectangle);
  image(intervals[3],150,300,width/2,height/2);
}
 
  //perfect 4th
if ((notes[0]) && (notess[4])) {
 rectangle.setFill(color(0,153,255,70));
 shape(rectangle);
 image(intervals[4],150,300,width/2,height/2);
}
  
  //perfect fifth
  if ((notes[0]) && (notess[6])) {
  rectangle.setFill(color(0,153,255,70));
  shape(rectangle);
  image(intervals[5],150,300,width/2,height/2);

}
  
  //M6
  if ((notes[0]) && (notess[5])) {
  rectangle.setFill(color(255,255,102,70));
  shape(rectangle);
 image(intervals[6],150,300,width/2,height/2);
//  text("INTERVAL: Major 6th (imperfect)!",width/3,height/2);
 // image(screenshot[5],0,500,width,height);
}

  //m6 - imperfect
  if ((notes[0]) && (notess[7])) {
  rectangle.setFill(color(255,255,102,70));
  shape(rectangle);
 image(intervals[7],150,300,width/2,height/2);
}
  //octave
  if ((notes[0]) && (notess[11])) {
  rectangle.setFill(color(0,153,255,70));
  shape(rectangle);
 image(intervals[10],150,300,width/2,height/2);
 // image(screenshot[7],0,500,width,height);
}
  
  //---------------dissonant combinations---------------
  // Major 2nd
   if ((notes[0])&&(notess[1])){
   // text("INTERVAL: Major 2nd",width/3,height/2);
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
    image(intervals[0],150,300,width/2,height/2);
  //  image(screenshot[1],0,500,width,height);
  }
    // minor second
   if ((notes[0])&&(notess[0])){
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
    image(intervals[1],150,300,width/2,height/2);
  }
  //major 7
  if ((notes[0])&&(notess[10])){
    //text("INTERVAL: Major 7th",width/3,height/2);
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
   image(intervals[8],150,300,width/2,height/2);
   //  image(screenshot[6],0,500,width,height);
  } 
 //minor 7
  if ((notes[0])&&(notess[9])){
    //text("INTERVAL: Major 7th",width/3,height/2);
    rectangle.setFill(color(255,0,51,80));
    shape(rectangle);
   image(intervals[9],150,300,width/2,height/2);
   //  image(screenshot[6],0,500,width,height);
  } 
}
  
