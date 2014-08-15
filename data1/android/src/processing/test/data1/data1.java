package processing.test.data1;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ketai.sensors.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class data1 extends PApplet {




KetaiSensor sensor;
float rotationX, rotationY, rotationZ;
boolean buttonOver=false;
Boolean isCapturing = false;

Table gyrotable;
Table acceltable;
//Table gpstable;

float[] gyroxxx={0.00f};
float[] gyronext;

int rectWidth=width/4;
int rectHeight=width/4;
int rectX=width/2;
int rectY=height/2;

public void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(36);
  
  fill(0,255,255);
  rect(rectX, rectY, rectWidth, rectHeight);
  
  gyrotable = new Table();
  
  gyrotable.addColumn("time");
  gyrotable.addColumn("GyroX");
  gyrotable.addColumn("GyroY");
  gyrotable.addColumn("GyroZ");
  
  acceltable = new Table();
  
  acceltable.addColumn("time");
  acceltable.addColumn("AccelX");
 acceltable.addColumn("AccelY");
 acceltable.addColumn("AccelZ");

//gpstable=new Table();
//  gpsacceltable.addColumn("gpsX");
// gpstable.addColumn("gpsY");
// gpstable.addColumn("gpsZ");
}

public void draw()
{
  
  background(78, 93, 75);
  text("Gyroscope: \n" + 
    "x: " + nfp(rotationX, 1, 3) + "\n" +
    "y: " + nfp(rotationY, 1, 3) + "\n" +
    "z: " + nfp(rotationZ, 1, 3), 0, 0, width/2, height/2);
    
    
    if(mousePressed ){
    text("Is pressing",width/2,height/2,width/2,height/2);
    } else{
      text("No Pressure",width/2,height/2,width/2,height/2);
    }
    
    if( isCapturing){
      text("RECORDING DATA (touch to stop)",3*width/4,3*height/4,width/4,height/4);
      
    }else{
        text("Not Recording (touch to start)",3*width/4,3*height/4,width/4,height/4);
saveTable(gyrotable,"//sdcard//data/mygyro.csv");
saveTable(acceltable,"//sdcard//data/myaccel.csv");
//saveTable(gpstable,"//sdcard//data/mygps.csv");


//   if(gyronext != null){
//   println(gyronext[1]);
//   saveStrings("//sdcard//newfolder/myarray.txt", gyronext);
//   }
  }
}
public void mousePressed()
{
  if (isCapturing)
    isCapturing = false;
  else
    isCapturing = true;
}
public void onGyroscopeEvent(float x, float y, float z)
{
  rotationX = x;
  rotationY = y;
  rotationZ = z;
  
  if(isCapturing){
//   gyronext= append(gyroxxx, rotationX);
  TableRow newRow = gyrotable.addRow();
newRow.setInt("time", millis());
newRow.setFloat("GyroX", x);
newRow.setFloat("GyroY", y);
newRow.setFloat("GyroZ", z);
  }


}

public void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  
   TableRow newRow = acceltable.addRow();
newRow.setInt("time", millis());
newRow.setFloat("AccelX", x);
newRow.setFloat("AccelY", y);
newRow.setFloat("AccelZ", z);
}

public boolean overButton ( int x, int Y, int width, int height){
  if (mouseX >= x && mouseX <= x+rectWidth &&
  mouseY >= Y && mouseY <= Y+rectHeight){
    return true;}
    else {
      return false;}
}

}
