class Hand {
  
  float obY;
  float obX;
  float handWidth;
  float handHeight;
  float accel;
  
  Hand(int obX){
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
  
  void randomize(int tempObX, int tempObY){
    if(handWidth >= 324){
      obX = tempObX;
      obY = tempObY;
      handWidth = 108;
      handHeight = 64;
      accel = random(1.01, 1.05);
    }
  }
  
}
