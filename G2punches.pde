import SimpleOpenNI.*;

Hand rightPunch;
Hand leftPunch;
PImage punch_right;
PImage punch_left;
int points; 
PFont americanFont;
float maoEsqX;
float maoDirX;
float maoEsqY;
float maoDirY;
boolean gameStart = false;

SimpleOpenNI context;
color[] userClr = new color[] {  
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};
PVector com = new PVector(); 
PVector com2d = new PVector();

void setup(){
  size(640, 360);
  americanFont = loadFont("AmericanTypewriter-CondensedLight-100.vlw");
  context = new SimpleOpenNI(this);
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  punch_right = loadImage("Rpunch.png");
  punch_left = loadImage("Lpunch.png");
  rightPunch = new Hand();
  leftPunch = new Hand();
  context.setMirror(true);
  if (context.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  // enable depthMap generation 
  context.enableDepth();
  // enable skeleton generation for all joints
  context.enableUser();
  smooth();
}

void draw(){
  context.update();
  background(0, 0, 0);
  textFont(americanFont);
  textAlign(CENTER);
  pressStart();
  if (gameStart){
    startGame();
  }
  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++) {
    if (context.isTrackingSkeleton(userList[i])) {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
    }
  }
}

void startGame(){
  textSize(14);
  text("Pontos: " + points, 40,20);
  //image(context.depthImage(),0,0);
  //image(context.userImage(), 0, 0);
  rightPunch.display("left");
  rightPunch.punch();
  rightPunch.randomize(int(random((width/2 + 54), (width - 100))), int(random(32, (height - 32))));
  leftPunch.display("right");
  leftPunch.punch();
  leftPunch.randomize(int(random(54, (width/2 - 108))), int(random(32, (height - 32))));
  collision();
}

void pressStart() {
  textSize(28);
  text("TOUCH HERE TO START", 320, 180);
  if(maoEsqX >= (220) && maoEsqX <=  (420) && maoEsqY >= (140) && maoEsqY <= (220)){
    background(0);
    gameStart = true;
  }
  if(maoDirX >= (220) && maoDirX <=  (420) && maoDirY >= (140) && maoDirY <= (220)){
    background(0);
    gameStart = true;
  }
  
}

void drawSkeleton(int userId) {
  // aqui é definido qual parte do corpo vai rastrear
  PVector rightHand = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
  PVector convertedRightH = new PVector();
  context.convertRealWorldToProjective(rightHand, convertedRightH);
  //desenhar uma elipse sobre a parte do corpo rastreada
  fill(0, 255, 0);
  ellipse(convertedRightH.x, convertedRightH.y, 60, 60);
  //
  PVector leftHand = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
  PVector convertedLeftH = new PVector();
  context.convertRealWorldToProjective(leftHand, convertedLeftH);
  //desenhar uma elipse sobre a parte do corpo rastreada
  fill(0, 255, 0);
  ellipse(convertedLeftH.x, convertedLeftH.y, 60, 60); 
  maoEsqX = convertedLeftH.x;
  maoDirX = convertedRightH.x;
  maoEsqY = convertedLeftH.y;
  maoDirY = convertedRightH.y;
  println("mao", maoEsqX);
  println("soco", leftPunch.obX);
}

void collision() {  
 //mao esquerda
  if(maoEsqX >= (leftPunch.obX - 45) && maoEsqX <=  (leftPunch.obX + 45) && maoEsqY >= (leftPunch.obY - 16) && maoEsqY <= (leftPunch.obY + 16)){
    points = points + 1;
    leftPunch.restart(int(random(54, (width/2 - 108))), int(random(32, (height - 32))));
  }
  if(maoEsqX >= (rightPunch.obX - 45) && maoEsqX <=  (rightPunch.obX + 45) && maoEsqY >= (rightPunch.obY - 16) && maoEsqY <= (rightPunch.obY + 16)){
    points = points + 1;
    rightPunch.restart(int(random(54, (width/2 - 108))), int(random(32, (height - 32))));
  }
  //mao direita
  if(maoDirX >= (leftPunch.obX - 45) && maoDirX <=  (leftPunch.obX + 45) && maoDirY >= (leftPunch.obY - 16) && maoDirY <= (leftPunch.obY + 16)){
    points = points + 1;
    leftPunch.restart(int(random((width/2 + 54), (width - 100))), int(random(32, (height - 32))));
  }
  if(maoDirX >= (rightPunch.obX - 45) && maoDirX <=  (rightPunch.obX + 45) && maoDirY >= (rightPunch.obY - 16) && maoDirY <= (rightPunch.obY + 16)){
    points = points + 1;
    rightPunch.restart(int(random((width/2 + 54), (width - 100))), int(random(32, (height - 32))));
  }
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

  

