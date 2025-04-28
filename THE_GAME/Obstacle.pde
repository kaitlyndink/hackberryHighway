class Obstacle {
  /////////////////////////
  //variables
  /////////////////////////
  int x;
  int y;
  int w;
  int h;
  int speed;
  int type;
  //hitbox vars

  int hitBoxX;
  int hitBoxY;
  int hitBoxW;
  int hitBoxH;

//images and animation vars
  Animation deerAnimation;
  PImage[] deerImages = new PImage [9];
  
  
  PImage img;
  
  
  
  //collision variable to help with sound playing once

  /////////////////////////
  //constructor
  /////////////////////////
  Obstacle(int startX, int startY, int obsWidth, int obsHeight, int obsSpeed, int obsType) {
    x = startX;
    y = startY;
    w = obsWidth;
    h = obsHeight;
    speed = obsSpeed;
    type = obsType;

    //loop for all of my images
    imageMode(CENTER);
    for (int index=0; index<deerImages.length; index++) {
      deerImages[index] = loadImage("pixelDeer" + index + ".png"); //when index =, itll say alien 0.png, it goes up all the way to the last one (if katherine did 16)
    }

    //create the animation, give it the image array, the speed and the scale
    
    deerAnimation = new Animation(deerImages, 0.05, 0.6);
    deerAnimation.isAnimating = true; //repetitively animate the image
    
  
    if (obsType == 2){
      img = kiaImage;
      kiaImage.resize(100,80);
      
    }
    
    else if (obsType == 3){
      img = subaruImage;
      subaruImage.resize(100,80);
    }
    
    else if (obsType == 4){
      img = truckImage;
      truckImage.resize(100,80);
    }
    
    else if (obsType == 5){
      img = teslaImage;
      teslaImage.resize(120,75);
    }
    
    else if(obsType == 6){
      img = rootbeerImage;
      rootbeerImage.resize(110,80);
    }
    
    else if(obsType == 7){
      img = hummerImage;
      hummerImage.resize(100,80);   
    }
     else if(obsType == 8){
       img = civicImage;
       civicImage.resize(100,80);
     }
    
    
   
    
    
  }

  /////////////////////////
  //functions
  /////////////////////////
  void move() {
    x = x - speed;

    //when the obstacle moves off the left side of the screen, i want to reset its position.
    if (x + w < 0) {
      //x = width; // move it back to the right side of the screen
      //y = int(random(height - h)); //randomize the Y position
      // type = int(random(2)); //randomly select the type, whether its a deer (0) or a student (1)
    }

    //i initialized these in the move function so that they update as the obstacle is moving.
    hitBoxX = x;
    hitBoxY = y;
    hitBoxW = w;
    hitBoxH = h;
  }

  void render() {
    if (type == 0) {
      fill(0, 0, 255);  // Blue for deer
      deerAnimation.display(x, y); //display it wherever the mouse is at
    } else if(type == 1){
      fill(0, 255, 0);  // student  
      rect(x,y,w,h);
    }
    else if(type == 2){
      image(kiaImage, x, y);
      //rect(x,y,w,h);
    } else if(type == 3){
      image(subaruImage, x, y);  //subaru 
      
    } else if(type == 4){
      image(truckImage, x, y);
    //  truckImage.resize(w,h);
    } else if(type == 5){
      image(teslaImage, x, y);
    //  teslaImage.resize(w,h);//tesla
    } else if(type ==6){
       image(rootbeerImage, x, y);
    //  rootbeerImage.resize(w,h); //rootbeer
    } else if(type ==7){
      image(hummerImage, x, y);
    //  hummerImage.resize(w,h);//hummer
    } else if(type ==8){
      image(civicImage, x, y);
    //  wranglerImage.resize(w,h);  //pink jeep
    } 

  }
}
