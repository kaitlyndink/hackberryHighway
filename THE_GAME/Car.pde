class Car{
  
  /////////////////////////
  //variables
  ///////////////////////// 
  int x;
  int y;
  int size;
  color aColor;
  
  boolean isMovingUp;
  boolean isMovingDown;
  
  int speed;
  
  PImage carImage;
  PImage carImageUp;
  PImage carImageDown;
  
  /////////////////////////
  //constructor
  /////////////////////////   
  Car(int squareX, int squareY, int squareSize){
    x = squareX;
    y = squareY;
    size = squareSize;
    aColor = aColor;
    
    
    isMovingUp = false;
    isMovingDown = false;
    
    speed = 13;
    
    carImage = loadImage("mainCar.png");
    carImage.resize(size + 10, size + 100);
    
    carImageUp = loadImage("carUp.png");
    carImageUp.resize(size + 10, size + 100);

    carImageDown = loadImage("carDown.png");
    carImageDown.resize(size + 10, size + 100);
  }
  
  /////////////////////////
  //functions
  ///////////////////////// 
  
  
  void move(){
    if (isMovingUp == true && y > 160 + size/2){
      y = y - speed;
      
      
    }
    if (isMovingDown == true && y < height - size/2){
      y = y + speed;
      
    }
    
   
  }
  
  
  void render(){
    
    if (isMovingUp == true){
      image(carImageUp, x + 40, y);
      
      
    } else if(isMovingDown == true){
      image(carImageDown, x + 40, y);
      
      
    } else{
      image(carImage, x + 40, y);
      
    }
    
    
    
  }
  

  
  boolean enemyDetection(Obstacle obs){
    //car hitboxes
    int carX = x;
    int carY = y;
    int carW = size;
    int carH = size;
    
    //obstacle hitboxes
    int obsX = obs.hitBoxX;
    int obsY = obs.hitBoxY;
    int obsW = obs.hitBoxW;
    int obsH = obs.hitBoxH;
    
    
  if (carX + carW/2 > obsX - obsW/2 // the right side of the car colliding with the left side of the obstacle.
        && carX - carW/2 < obsX + obsW/2  // the left side of the car colliding with the left side of the obstacle. (even though it doesnt happen)
          && carY + carH/2 >= obsY  - obsH/2 //the bottom of the car colliding with the top of the obstacle.
            && carY - carH/2 < obsY + obsH/2){ // the top of the car colliding with the bottom of the obstacle.
      return true; // collision detected
      
    }
    else{
    return false; // no collision
    
  }
    
    
}


}
  
  
  
  
