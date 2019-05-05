
//t519 final project
//rachel & jenny

//mvp - get wave visualizations and frequency of sounds working


//minim libraries
import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
//interesting library - play around with this later
import xyscope.*;
Minim minim;
//asking minim for audio output - we need this in order to play the synth sounds!!!
AudioOutput out;
//Oscil wave;

void setup()
{
    size(512,300, P3D);
  
  minim = new Minim(this);
  //establish the buffer size - lmao don't know exactly what this is
  out = minim.getLineOut(Minim.STEREO);
  out.setDurationFactor( 3f );
  out.pauseNotes();

 //  wave = new Oscil( 440, 0.5f, Waves.SINE );
}
 
void draw()
{
  background(0);
 // stroke(1,205,254);
  //draw wavez
 // frameRate(1);
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    stroke(1,205,254);
    text("wave frequency goes here", 10, 100); 
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    stroke(255,113,206);
    line(x1,150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
  
  keyPressed();
}
 
void keyPressed()
{
  //child! my children
  SineWave mySine;
  MyNote newNote;

  float pitch = 0;
  switch(key) {
    //the freqeuncies aren't super correct - will change them
    case 'z': pitch = 262; break;
    case 's': pitch = 277; break;
    case 'x': pitch = 294; break;
    case 'd': pitch = 311; break;
    case 'c': pitch = 330; break;
    case 'v': pitch = 349; break;
    case 'g': pitch = 370; break;
    case 'b': pitch = 392; break;
    case 'h': pitch = 415; break;
    case 'n': pitch = 440; break; // A4 
    case 'j': pitch = 466; break;
    case 'm': pitch = 494; break;
    case ',': pitch = 523; break;
    case 'l': pitch = 554; break;
    case '.': pitch = 587; break;
    case ';': pitch = 622; break;
    case '/': pitch = 659; break;
  }
  
   if (pitch > 0) {
     //amplitude 0.2  
      newNote = new MyNote(pitch, 0.75);
   }
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

//class MyNote implements AudioSignal
//{
//     private float freq;
//     private float level;
//     private float alph;
//     private SineWave sine;
     
//     MyNote(float pitch, float amplitude)
//     {
//         freq = pitch;
//         level = amplitude;
//         sine = new SineWave(freq, level, out.sampleRate());
//         alph = 0.9;
//         out.addSignal(this);
//     }

//     void updateLevel()
//     {
//         level = level * alph;
//         sine.setAmp(level);
         
//         if (level < 0.01) {
//             out.removeSignal(this);
//         }
//     }
     
//     void generate(float [] samp)
//     {
//         sine.generate(samp);
//         updateLevel();
//     }
     
//    void generate(float [] sampL, float [] sampR)
//    {
//        sine.generate(sampL, sampR);
//        updateLevel();
//    }

//}
