class Hand {
  
  float obY;
  float obX;
  float handWidth;
  float handHeight;
  float accel;
  String hand;
  
  Hand(){
    obX = -1000;
    handWidth = 108;
    handHeight = 64;
    accel = random(1.01, 1.05);
  }
  
//  void run(){
//    display();
//    punch();
//  }
  
  void display(String hand){
    if ( hand == "right" ) {
      image(punch_right, obX, obY, handWidth, handHeight);
    } else {
      image(punch_left, obX, obY, handWidth, handHeight);
    }
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
