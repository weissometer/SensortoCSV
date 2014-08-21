void setup(){
 size(640,600); 
 
// String currentDay = nf(day(),0)+nf(month(),0)+nf(year(),0);

 
 String[] currentDate = new String[3];
 
currentDate[0]= nf(month(),1);
currentDate[1]= nf(day(),1);
currentDate[2]= nf(year(),0);

String joinedDate = join( currentDate, "");

String[] origURL = new String[3];

origURL[0] = "//sdcard//Android/RecordAll";
origURL[1] = joinedDate;
origURL[2] = "mygyro";
//origURL[3] = now();

String gyroURL=join( origURL,"/");

println(gyroURL);
 println(joinedDate);
 println(now());
 
 
}

String[] now(){
 
  String[] currentTime = new String[3];
  
  currentTime[0] = nf(hour(),0);
  currentTime[1] = nf(minute(),0);
  currentTime[2] = nf(second(),0);
  
  String[] joinedTime = join(currentTime,"");
  return joinedTime;
}


