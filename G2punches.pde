
RightHand rightPunch = new RightHand();

void setup(){
  size(640, 480);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw(){
  background(0, 0, 0);
  rightPunch.run();
}


