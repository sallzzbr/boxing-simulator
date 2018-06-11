Hand rightPunch;
Hand leftPunch;
PImage punch_right;

void setup(){
  size(1280, 720);
  ellipseMode(CENTER);
  rectMode(CENTER);
  punch_right = loadImage("Rpunch.png");
  rightPunch = new Hand(int(random((width/2 + 54), (width - 54))));
  leftPunch = new Hand(int(random(54, (width/2 - 54))));
  println(leftPunch.obX);
}

void draw(){
  background(0, 0, 0);
  rightPunch.run();
  rightPunch.randomize(int(random((width/2 + 54), (width - 54))), int(random(324, (height - 32))));
  leftPunch.run();
  leftPunch.randomize(int(random(54, (width/2 - 54))), int(random(324, (height - 32))));
  image(punch_right, 0, 0);
}


