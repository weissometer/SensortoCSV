
import ketai.sensors.*;

KetaiSensor sensor;
float rotationX, rotationY, rotationZ;
float accelX, accelY, accelZ;
boolean buttonOver=false;
Boolean isCapturing = false;

Table gyrotable;
Table acceltable;
Table gpstable;

float longitude, latitude, altitude; //was a double origiinally, not float
KetaiLocation location;

float[] gyroxxx={0.00};
float[] gyronext;

int rectWidth=width/4;
int rectHeight=width/4;
int rectX=width/2;
int rectY=height/2;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(36);
  
  fill(0,255,255);
  rect(rectX, rectY, rectWidth, rectHeight);
  
  location = new KetaiLocation(this);
  // Create separate tables
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

gpstable=new Table();
gpstable.addColumn("time");
  gpstable.addColumn("longitude");
 gpstable.addColumn("latitude");
 gpstable.addColumn("altitude");



}

void draw()
{
  
  background(78, 93, 75);
  // display gyro why not top left
  text("Gyroscope: \n" + 
    "x: " + nfp(rotationX, 1, 3) + "\n" +
    "y: " + nfp(rotationY, 1, 3) + "\n" +
    "z: " + nfp(rotationZ, 1, 3), 0, 0, width/2, height/2);
    
    // display Accelerometer top right quadrent?
    text( "Accelerometer: \n"+
    "x: "+ nfp(accelX,1,3)+ "\n"+
    "y: "+ nfp(accelY,1,3)+ "\n"+
    "z: "+ nfp(accelZ,1,3),width/2,0,width/2,height/2);
        
    // display GPS bottom left
     if (location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.",  0,height/2,width/2,height/2);
  else
    text("Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Provider: " + location.getProvider(),  0,height/2,width/2,height/2);  
  // getProvider() returns "gps" if GPS is available
  // otherwise "network" (cell network) or "passive" (WiFi MACID)
  
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
saveTable(gpstable,"//sdcard//data/mygps.csv");


//   if(gyronext != null){
//   println(gyronext[1]);
//   saveStrings("//sdcard//newfolder/myarray.txt", gyronext);
//   }
  }
  
}
void mousePressed()
{
  if (isCapturing)
    isCapturing = false;
  else
    isCapturing = true;
}
void onGyroscopeEvent(float x, float y, float z)
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

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  accelX=x;
  accelY=y;
  accelZ=z;
  
  if(isCapturing){
   TableRow newRow = acceltable.addRow();
newRow.setInt("time", millis());
newRow.setFloat("AccelX", x);
newRow.setFloat("AccelY", y);
newRow.setFloat("AccelZ", z);
}}

boolean overButton ( int x, int Y, int width, int height){
  if (mouseX >= x && mouseX <= x+rectWidth &&
  mouseY >= Y && mouseY <= Y+rectHeight){
    return true;}
    else {
      return false;}
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
 
  longitude = (float)_longitude;// conversion to float is suspicious at absolute best
  latitude = (float)_latitude;
  altitude = (float)_altitude;
  println("lat/lon/alt: " + latitude + "/" + longitude + "/" + altitude);
  if(isCapturing){
     TableRow newRow = gpstable.addRow();
newRow.setInt("time", millis());
newRow.setFloat("longitude", longitude);
newRow.setFloat("latitude", latitude);
newRow.setFloat("altitude", altitude);
  }
}
