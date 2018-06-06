class RightHand {
  
  float obY;
  float obX;
  float handWidth;
  float handHeight;
  float accel;
  
  RightHand() {
    //tempX e tempY é para na hora de implementar conseguir usar o random
    obX = int(random(54, 586));
    obY = int(random(32, 448));
    handWidth = 108;
    handHeight = 64;
    accel = random(1.01, 1.05);
  }
  
  void run(){
    display();
    punch();
  }
  
  void display(){
    rect(obX, obY, handWidth, handHeight);
    fill(255, 255, 255);
  }
  
  void punch(){
    handWidth = handWidth * accel;
    handHeight = handHeight * accel;
  }
  
}
