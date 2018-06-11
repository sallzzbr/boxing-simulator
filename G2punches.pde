Hand rightPunch;
Hand leftPunch;
PImage punch_right;
PImage punch_left;

void setup(){
  size(1280, 720);
  ellipseMode(CENTER);
  rectMode(CENTER);
  punch_right = loadImage("Rpunch.png");
  punch_left = loadImage("Lpunch.png");
  rightPunch = new Hand();
  leftPunch = new Hand();
  println(leftPunch.obX);
}

void draw(){
  background(0, 0, 0);
  rightPunch.display("left");
  rightPunch.punch();
  rightPunch.randomize(int(random((width/2 - 108), (width - 108))), int(random(64, (height - 64))));
  println(width/2 + 54);
  leftPunch.display("right");
  leftPunch.punch();
  leftPunch.randomize(int(random(54, (width/2 - 108))), int(random(64, (height - 64))));
}


