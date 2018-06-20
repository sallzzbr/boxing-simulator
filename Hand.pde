class Hand {
  
  float obY;
  float obX;
  float handWidth;
  float handHeight;
  float accel;
  String hand;
  int strikes;
  
  Hand(){
    obX = -1000;
    handWidth = 54;
    handHeight = 32;
    accel = random(1.01, 1.05);
    strikes = -1;
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
    if(handWidth >= 216){
      obX = tempObX;
      obY = tempObY;
      handWidth = 54;
      handHeight = 32;
      accel = random(1.01, 1.10);
      strikes = strikes + 1;
    }
  }
  
  void restart(int tempObX, int tempObY){
      obX = tempObX;
      obY = tempObY;
      handWidth = 54;
      handHeight = 32;
  }
  
}
