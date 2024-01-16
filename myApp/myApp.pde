boolean isUpdated;
JSONObject job;
int menu;
String language;
int _Level;
int maxLevel;
String[] lines;
String[] userInput;
int userIndex;
int maxLow;
int startTime;
int clearTime;
int elapsedTime;
PImage homeIcon;
boolean timerRun;
PImage languageIcon;
PImage runIcon;
PImage ggwp;
Boolean isClear;
String[] languageMenu={"C", "Python", "C#", "PHP", "Go","Assembly"};
void setup() {
  size(1000, 560);
  getBuf();
  initialdata();
  dataLoad();
}
void getBuf(){
  userInput=new String[256];
}
void initialdata(){
  timerRun=true;
  userInput[0]="";
  language="C";
  _Level=1;
  startTime=0;
  maxLow=0;
  userIndex=0;
  menu=0;
  isUpdated=true;
  isClear=false;
  lines=loadStrings(language+_Level+".txt");
}
void dataLoad(){
  job=loadJSONObject("data.json");
  maxLevel=job.getInt("maxLevel");
  runIcon=loadImage("iconRun.png");
  ggwp=loadImage("ggwp.png");
  homeIcon=loadImage("homeIcon.png");
}
void draw() {
  if (menu==0) {
    homeMenu();
  }
  if (menu==1) {
    typingCopy();
  }
}

void homeMenu(){
  background(255);
    textSize(24);
    fill(0);
    image(homeIcon, 10, 5, 24, 24);
    text("Code Typing", 44, 24);
    line(0, 32, width, 32);

    for (int i=0; i<languageMenu.length; i++) {
      languageIcon=loadImage((languageMenu[i])+"Icon.png");
      image(languageIcon, 10, 40+i*36, 24, 24);
      text(languageMenu[i], 40, 60+i*36);
      line(0, 64+i*36, width/3*2, 64+i*36);
    }
    line(width/3*2, 0, width/3*2, height);
    text("Language :"+language, width/3*2+10, 60);
    text("Level :"+_Level, width/3*2+10, 100);
    image(runIcon, width/3*2+10, 120, 40, 40);
    text("Copying", width/3*2+60, 150);
}

void typingCopy(){
    background(255);
    textSize(20);
    fill(0);
    image(homeIcon, 10, 5, 24, 24);
    text("Code Typing", 44, 24);
    text("Lang :"+language, width/2+10, 24);
    text("Level :"+_Level, width/2+width/6+10, 24);
    
    if(isClear){
      image(ggwp,400,180,200,200);
    }

    elapsedTime=millis()-startTime;
    text((elapsedTime/60000)+":"+(elapsedTime/1000)%60, width/2+width/3+34, 24);
    line(width/2, 0, width/2, height);
    line(width/2+width/6, 0, width/2+width/6, 32);
    line(width/2+width/3, 0, width/2+width/3, 32);
    line(0, 32, width, 32);
    if (lines.length!=0) {
      typingModel();
    }
    if (userInput.length!=0) {
      for (int i=0; i<=maxLow; i++) {
        text((userInput[i])==null?"":userInput[i].replaceAll("\t", "    "), width/2+10, height/2-(maxLow+1)/2*24+28*i);
      }
    }
}

void typingModel(){
  int sameLowCount=0;
  for (int i = 0; i < lines.length; i++) {
    boolean same=false;
    if (userInput[i]!=null) {
    if (((userInput[i]).replaceAll("\t", "    ")).equals((lines[i]).replaceAll("\t", "    "))) {
      same=true;
      sameLowCount++;
      }
    }
    text("["+(same?"\\":"x")+"]"+lines[i].replaceAll("\t", "    "), 10, height/2-lines.length/2*24+28*i);
  }
  if(sameLowCount==lines.length){
    clear(language,_Level);
    clearTime=elapsedTime;
      isClear=true;
    }
    else{
      isClear=false;
    }
}

void keyTyped() {
  if (int(key)==10&&userIndex<256) { //Enter
    userIndex++;
    if (maxLow<userIndex) {
      maxLow=userIndex;
    }
    if (userInput[userIndex]==null) {
      userInput[userIndex]="";
    }
  } else if (int(key)==8) { //Back Space
    if (userIndex==0&&(userInput[0]).length()==0) {
      return;
    } else if ((userInput[userIndex]).length()==0 && maxLow >= 0) {
      userIndex--;
      maxLow--;
    } else {
      userInput[userIndex]=userInput[userIndex].substring(0, (userInput[userIndex]).length()-1);
    }
  } else {
    userInput[userIndex]=userInput[userIndex]+key;
  }
  //println("Line :"+userIndex+"Content :"+((userInput[userIndex])==null?"":userInput[userIndex]));
}
void mousePressed() {
  if (menu==1) {
    if (dist(22, 17, mouseX, mouseY)<12) {
      menu=0;
    }
  }
  if (menu==0) {
    if (mouseY>32&&Math.floor((mouseY-32)/36)<languageMenu.length&&mouseX<width/3*2) {
      language=languageMenu[(int)Math.floor((mouseY-32)/36)];
    }
    if ((mouseX>(width/3*2+10))&&mouseX<width/3*2+228) {
      if (mouseY>120&&mouseY<160) {
        println("Copying");
        lines=loadStrings(language+_Level+".txt");
        startTime=millis();
        for (int i= 0; i <256; i++) {
          userInput[i]="";
        }
        maxLow=0;
        userIndex=0;
        menu=1;
      }
    }
  }
}
void mouseWheel(MouseEvent MouseEvent) {
  float Wheel = MouseEvent.getCount();
  if (Wheel > 0) {
    if (_Level!=1) {
      _Level--;
    }
  } else {
    if (_Level!=maxLevel) {
      _Level++;
    }
  }
}
//jsonHelpers
void clear(String language, int level) {
  job=loadJSONObject("data.json");
  JSONObject object=job.getJSONObject(language);
  object.setBoolean(Integer.valueOf(level).toString(), true);
  saveJSONObject(job,"data/data.json");
}
