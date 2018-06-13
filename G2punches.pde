import SimpleOpenNI.*;

Hand rightPunch;
Hand leftPunch;
PImage punch_right;
PImage punch_left;

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
  context = new SimpleOpenNI(this);
  ellipseMode(CENTER);
  rectMode(CENTER);
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
  //image(context.depthImage(),0,0);
  //image(context.userImage(), 0, 0);
  rightPunch.display("left");
  rightPunch.punch();
  rightPunch.randomize(int(random((width/2 + 54), (width - 100))), int(random(32, (height - 32))));
  leftPunch.display("right");
  leftPunch.punch();
  leftPunch.randomize(int(random(54, (width/2 - 108))), int(random(32, (height - 32))));
  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++) {
    if (context.isTrackingSkeleton(userList[i])) {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
    }
  }
}

void drawSkeleton(int userId) {
  // aqui é definido qual parte do corpo vai rastrear
  PVector rightHand = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
  PVector convertedHead = new PVector();
  context.convertRealWorldToProjective(rightHand, convertedHead);
  //desenhar uma elipse sobre a parte do corpo rastreada
  fill(0, 255, 0);
  ellipse(convertedHead.x, convertedHead.y, 60, 60);
  //
  PVector leftHand = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
  context.convertRealWorldToProjective(leftHand, convertedHead);
  //desenhar uma elipse sobre a parte do corpo rastreada
  fill(0, 255, 0);
  ellipse(convertedHead.x, convertedHead.y, 60, 60);   
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

