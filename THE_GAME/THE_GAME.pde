/////////////////////////
//Global Vars
/////////////////////////

//class variables
Car player1;
ArrayList<Obstacle> deerList; //list to store all deers
ArrayList<Obstacle> studentList; //list to store all students

//variables related to importing sound files
import processing.sound.* ;
SoundFile backgroundMusic;
SoundFile deerOuch;
SoundFile studentOuch;
SoundFile carCrash;
SoundFile deerCrash;
SoundFile carUp;
SoundFile carDown;
SoundFile carBoom;

//variables for collision in relation to sound
boolean deerCollision1 = false;
boolean studentCollision1 = false;
boolean deerCollision2 = false;
boolean studentCollision2 = false;


//variables to track the game's time
int startTime; //this will track when an obstacle spawns
int currentTime; //this tracks the current time?
int interval = 2000; //time interval between obstacle spawns (two seconds)

//variables to track the games state
int state = 0;//starting on the menu screen which is case 0
int deerHit = 0; // hit
int studentHit = 0;
int deerCount = 0; // number of deers in the current level, mainly to keep track of how many are dodged.
int studentCount = 0; // number of students in the current level, mainly to keep track of how many are dodged.
boolean hitDeerOnce = false;  // boolean to track if the player hit a deer once
boolean showScratchMessage = false;


//my timer interval vars
int lastDeerSpawnTime;
int deerSpawnInterval;

int lastStudentSpawnTime;
int studentSpawnInterval;

//player and obstacle images vars
PImage deer;


//background image vars
PImage backgroundImg1;
PImage backgroundImg2;
int backgroundX1;
int backgroundX2;
int backgroundY;
int scrollSpeed = 1; 

PImage menuBackground;
PImage levelOne;
PImage levelTwo;
PImage levelThree;
PImage deerCrashScreen;
PImage carCrashScreen;
PImage winningScreen;
PImage clickSpace;

//dialogue vars
PImage lateToCSC;
PImage driveSafe;
PImage justAScratch;

//car vars
PImage kiaImage;
PImage subaruImage;
PImage truckImage;
PImage teslaImage;
PImage rootbeerImage;
PImage hummerImage;
PImage civicImage;


void setup(){
  size(800,598);
  rectMode(CENTER);
  
  //background images scrolling
  backgroundImg1 = loadImage("finalBackgroundArt1.png");
  backgroundImg2 = loadImage("finalBackgroundArt2.png");
  backgroundY = height/2;
  backgroundX1 = width/2;
  backgroundX2 = backgroundX1 + backgroundImg1.width;
  
  //other images loaded in
  menuBackground = loadImage("menuBackground.png");
  menuBackground.resize(800,600);
  
  clickSpace = loadImage("clickSpace.png");
  clickSpace.resize(400,400);
  
  levelOne = loadImage("levelOne.png");
  levelOne.resize(800,800);
  
  levelTwo = loadImage("levelTwo.png");
  levelTwo.resize(800,800);
 
  levelThree = loadImage("levelThree.png");
  levelThree.resize(800,800);
  
  carCrashScreen = loadImage("carCrashScreen.png");
  carCrashScreen.resize(800,600);
  
  deerCrashScreen = loadImage("deerCrashScreen.png");
  deerCrashScreen.resize(800,600);
  
  winningScreen = loadImage("winningScreen.png");
  winningScreen.resize(800,600);
   
  lateToCSC = loadImage("lateToCSC.png");
  lateToCSC.resize(800, 800);
  
  driveSafe = loadImage("driveSafe.png");
  driveSafe.resize(800, 800);
  
  justAScratch = loadImage("justAScratch.png");
  justAScratch.resize(400, 400);
  
  //initializecar images
   kiaImage = loadImage("kiaSoul.png");  
   subaruImage = loadImage("subaruCar.png");
   truckImage = loadImage("truckImage.png");
   teslaImage = loadImage("teslaImageNew.png");
   rootbeerImage = loadImage("rootbeerImageNew.png");
   hummerImage = loadImage("hummerImage.png");
   civicImage = loadImage("hondaPixel.png");


  
  
   //initialize the player
   player1 = new Car(20, height/2, 75);
 
  
   //initialize the array list for obstacle variables.
   deerList = new ArrayList<Obstacle>();
   studentList = new ArrayList<Obstacle>();
 
   //initialize sound variable
    backgroundMusic = new SoundFile(this, "stayinAlive.mp3");
    backgroundMusic.amp(0.8);
   //WORK ON THIS, need to fix volume
    deerOuch = new SoundFile(this, "ouchDeer.mp3");
    studentOuch = new SoundFile(this, "studentOuch.mp3");
    carCrash = new SoundFile(this, "wompWomp.mp3");
    deerCrash = new SoundFile(this, "sadViolin.mp3");
    carUp = new SoundFile(this, "nyoomAudio.mp3");
    carUp.rate(1.2);
    carDown = new SoundFile(this, "skrrtAudio.mp3");
    carDown.rate(1.8);
    carBoom = new SoundFile (this, "boom.mp3");
    carBoom.rate(2);
  
    //set the start timer
    startTime = millis();
  
  
 
}


void draw(){
   background(42);
    
 
  
  backgroundX1 -= scrollSpeed;
  backgroundX2 -= scrollSpeed;
  
  int backgroundImgWidth = backgroundImg1.width;
  
  // if image 1 goes completely offscreen to the left
  if (backgroundX1 <= -backgroundImgWidth / 2) {
    backgroundX1 = backgroundX2 + backgroundImgWidth;
  }
  
  // if image 2 goes completely offscreen to the left
  if (backgroundX2 <= -backgroundImgWidth / 2) {
    backgroundX2 = backgroundX1 + backgroundImgWidth;
  }

   
  //replay the background sound. 
  if (backgroundMusic.isPlaying() == false){  // if you're not playing the background music, play it.   
  backgroundMusic.play();
  backgroundMusic.amp(1);
 
  
  }

  levelHandler();
}


void levelHandler(){
  
      
  switch (state){
   ///////////////////////////////////////////MENU SCREEN////////////////////////////////////////////
    
    case 0: //menu screen
    deerCrash.stop(); // stop playing deerCrash
    carCrash.stop();
    imageMode(CENTER);
    image(menuBackground, width/2, height/2);
   
    deerHit = 0;
  
    break;
   ///////////////////////////////////////////DIALOGUE 1////////////////////////////////////////////
    case 1: //first dialogue screen
    imageMode(CENTER);
    image(backgroundImg1, backgroundX1, backgroundY);
    image(backgroundImg2, backgroundX2, backgroundY);
    image(lateToCSC, width/2, height/2 - 100);
    
    
    player1.render();
 
    break;
  ///////////////////////////////////////////DIALOGUE 2////////////////////////////////////////////
  
    case 2: //second dialogue screen with instructions
    image(backgroundImg1, backgroundX1, backgroundY);
    image(backgroundImg2, backgroundX2, backgroundY);
    image(driveSafe, width/2, height/2 - 100);
    image(clickSpace, width/2, height/2 + 90);
    player1.render();
    break;
  
  ///////////////////////////////////////////LEVEL ONE////////////////////////////////////////////
    case 3: // level one
    imageMode(CENTER);
    image(backgroundImg1, backgroundX1, backgroundY);
    image(backgroundImg2, backgroundX2, backgroundY);
    image(levelOne, width/2, height/2 + 80);
    
    levelOne();
    
    break;
    
///////////////////////////////////////////LEVEL TWO////////////////////////////////////////////
    case 4: 
    imageMode(CENTER);
    scrollSpeed = 2;
    image(backgroundImg1, backgroundX1, backgroundY);
    image(backgroundImg2, backgroundX2, backgroundY);
    image(levelTwo, width/2, height/2 + 80);
    levelTwo(); 
    
    break;

///////////////////////////////////////////LEVEL THREE////////////////////////////////////////////
    case 5:
    imageMode(CENTER);
    scrollSpeed = 3;
    image(backgroundImg1, backgroundX1, backgroundY);
    image(backgroundImg2, backgroundX2, backgroundY);
    image(levelThree, width/2, height/2 + 80);
    levelThree();
    
    break;

    
  
///////////////////////////////////////////VICTORY////////////////////////////////////////////
    case 6: //winning screen
    imageMode(CENTER);
    image(winningScreen, width/2, height/2);
  
     break;
     
    case 7:
      backgroundMusic.pause();
      imageMode(CENTER);
      image(deerCrashScreen, width/2, height/2 );
        if (!deerCrash.isPlaying()) {  // Only play the sound if it's not already playing
          deerCrash.play();
          deerCrash.amp(0.4);
        }
  
    break;
    
    case 8:
      backgroundMusic.pause();
      imageMode(CENTER);
      image(carCrashScreen, width/2, height/2 );
            if (!carCrash.isPlaying()) {  // Only play the sound if it's not already playing
          carCrash.play();
          carCrash.amp(0.2);
        }
  
    break;
 
  }

}



void keyPressed(){
  //move the car up
    if (key == 'w'){
      player1.isMovingUp = true;    
      if (!carUp.isPlaying()){      
        carUp.play();
        carUp.amp(0.3);
      }
    }
  
  //move the car down
    if (key == 's'){
      player1.isMovingDown = true;
      if (!carDown.isPlaying()){      
        carDown.play();
        carDown.amp(0.3);
      }  
    }
  
  
    if (key == ' '){
      if (state == 0){ //if we're on the menu screen
        state = 1; //move to the first dialogue screen.
      }
      
      else if (state == 1){ // if we're on the first dialogue screen
        state = 2; // move to the second dialogue screen ("drive safe")
      }
      
      else if (state == 2){ // if we're on the second dialogue screen
        state = 4; // begin level 1
      }
    }
    
    //restart screen
    if (key == 'r' && state == 6){
      deerHit = 0;
      studentHit = 0;
      state = 0; 
      
    }
  //restart
    if (key == 'r' && state == 7){
      deerHit = 0;
      studentHit = 0;
      showScratchMessage = false;
      state = 0; 
      studentList.clear();  
      deerList.clear();   
    }
    
    if (key == 'r' && state == 8){
      deerHit = 0;
      studentHit = 0;
      showScratchMessage = false;
      state = 0; 
      studentList.clear();  
      deerList.clear();
      
      
    }
  
}


void keyReleased(){
    if (key == 'w'){
      player1.isMovingUp = false;   
      
    }
    
    if (key == 's'){
      player1.isMovingDown = false;
      
    }
    
    if (key == 'r' && state == 6){
      state = 0;    
    }
    
    if (key == 'r' && state == 7){
      deerHit = 0;
      studentHit = 0;
      showScratchMessage = false;
      state = 0; 
      studentList.clear();  
      deerList.clear();
      
      
    }
    
    if (key == 'r' && state == 8){
      deerHit = 0;
      studentHit = 0;
      showScratchMessage = false;
      state = 0; 
      studentList.clear();  
      deerList.clear();
      
      
    }
  
}


void levelOne(){   
  // -- player render and move -- //
  player1.render();
  player1.move();
  
  
  // -- adding to deerList to spawn one -- // 
  //if there are no obstacles on the screen and the deerCount is less than 10, spawn a new obstacle.
  if (deerCount < 20){
    int currentTime = millis(); // get the current time in milliseconds
    int deerSpawnInterval = 500;
  
      if (currentTime - lastDeerSpawnTime > deerSpawnInterval) {   // check if enough time has passed since the last deer spawn
        // create a new obstacle deer
        Obstacle deer = new Obstacle(width, int(random(200, height - 50)), 25, 25, 9, 0);
        deerList.add(deer);  // assuming you're using a separate list or a shared list with type
        lastDeerSpawnTime = currentTime;
   }
    
}
  
  

    // -- deer render and move. -- //
    //CHATGPT helped me with this, I added its comments. 
    // ChatGPT: Iterate through the obstacles in reverse order (starting from the last one). My original code also caused an indexoutofboundsexception due to multiple remove statements.
    // -- moving and rendering deer --
       for (int i = deerList.size() - 1; i >= 0; i--) {
      //get the current obstacle at index i
          Obstacle d = deerList.get(i); 
      //call the render method of the obstacle and display it on the screen
           d.render();
      //call the render method of the obstacle and display it on the screen
            d.move();
  
    if (player1.enemyDetection(d)) {
      if (deerHit < 1) { //if the deerHit count is less that two 
        deerList.remove(i); //remove the deer from the screen
        deerHit++; //add one to the deerHit
        showScratchMessage = true; //show the message
        deerOuch.play();  // mark that the deer sound has been played for this collision. reset the sound. this basically turns it off.
            continue;  // this will skip the rest of the code below for this loop, moving to the next item in the loop after the else statement. 
      } else {
        state = 7; //this means its more than two
        deerCount = 0; //reset the deer
        deerList.clear();
        deerOuch.play();
        break; // stop the loop, game is over
      }
    }

    if (d.x + d.w / 2 < 0 && d.type == 0) { // if the deer has moved off of the screen
      deerList.remove(i);  // remove the deer from the list  
      deerCount++; //increase the deerCount by 1
      println("Deer dodged, count: " + deerCount); //this was for debugging but I want to keep it
    }
  }

  // show "just a scratch" message while deerHit == 1
    if (showScratchMessage && deerHit == 1) {
      image(justAScratch, width/2, height/2 - 25);
    }
    
  
    // -- changing levels -- //  
    //when 20 deer have been dodged, move to the next state
    if (deerCount > 20 && deerList.isEmpty()) {
     println("Level 1 completed, moving to Level 2..."); // debugging thing
     state = 4;  // go to second level
     deerCount = 0;  // reset deer count
     deerList.clear();  // clear the list for the next level
  }
  
}

void levelTwo(){  
    // -- player render and move -- //
    player1.render();
    player1.move(); 
      
    // -- adding students and deers to the lists-- //
    // -- adding to deerList to spawn one -- // 
    //if there are no obstacles on the screen and the deerCount is less than 10, spawn a new obstacle.
    if (deerCount < 20){
      int currentTime = millis();
      int deerSpawnInterval = 600;
  
      if (currentTime - lastDeerSpawnTime > deerSpawnInterval) {
        Obstacle deer = new Obstacle(width, int(random(200, height - 50)), 25, 25, 12, 0);
        deerList.add(deer);  // assuming you're using a separate list or a shared list with type
  
   
        lastDeerSpawnTime = currentTime;
    }
   }
  
  
    // -- adding to studentList to spawn one -- // 
    //if there are no obstacles on the screen and the students is less than 10, spawn a new obstacle.
    if (studentCount < 7){
    int currentTime = millis();
    int studentSpawnInterval = 2000;
    
    println(studentList.size());
    if (currentTime - lastStudentSpawnTime > studentSpawnInterval) {
      Obstacle student = new Obstacle(width, int(random(200, height - 50)), 100, 80, 13, int (random(2,9))); //int (random(2,8))
      studentList.add(student);  // or obstacles.add(student)
  
     
      lastStudentSpawnTime = currentTime;
    }
   }
  
  
    // -- deer render and move. -- //
    //CHATGPT helped me with this, I added its comments. 
    // ChatGPT: Iterate through the obstacles in reverse order (starting from the last one). My original code also caused an indexoutofboundsexception due to multiple remove statements.
    // -- moving and rendering deer --
       for (int i = deerList.size() - 1; i >= 0; i--) {
      //get the current obstacle at index i
          Obstacle d = deerList.get(i); 
      //call the render method of the obstacle and display it on the screen
           d.render();
      //call the render method of the obstacle and display it on the screen
            d.move();
  
    if (player1.enemyDetection(d)) {
      if (deerHit < 1) { //if the deerHit count is less that two 
        deerList.remove(i); //remove the deer from the screen
        deerHit++; //add one to the deerHit
        showScratchMessage = true; //show the message
        deerOuch.play();
        continue;  // this will skip the rest of the code below for this loop, moving to the next item in the loop after the else statement. 
      } else {
        state = 7; //this means its more than two
        deerCount = 0; //reset the deer
        deerList.clear();
        deerOuch.play();
        break; // stop the loop, game is over
      }
    }
  
    if (d.x + d.w / 2 < 0 && d.type == 0) { // if the deer has moved off of the screen
      deerList.remove(i);  // remove the deer from the list  
      deerCount++; //increase the deerCount by 1
      //println("Deer dodged, count: " + deerCount); //this was for debugging but I want to keep it
    }
  }

  // show "just a scratch" message while deerHit == 1
    if (showScratchMessage && deerHit == 1) {
      image(justAScratch, width/2, height/2 - 25);
    }
      
      
      // -- student render and move. -- //
    //CHATGPT helped me with this, I added its comments. 
    // ChatGPT: Iterate through the obstacles in reverse order (starting from the last one)
    // -- moving and rendering student --
     for (int i = studentList.size() - 1; i >= 0; i--) {
       //get the current obstacle at index i
       Obstacle s = studentList.get(i);
       //call the render method of the obstacle and display it on the screen
       s.render();
       //call the move method to get it to move on the screen.
       s.move();
  
     if (s.x + s.w / 2 < 0 && s.type >= 2 && s.type <= 7) {  // check if student has moved off the screen
        studentList.remove(i);  // remove the student from the list
        studentCount++;  // increment student count
        //println("Student dodged, count: " + deerCount);  // debugging message
     }
     
     //student collision detection
     if (player1.enemyDetection(s)) {
        carBoom.play();
        carBoom.amp(0.5);
       state = 8;
        
      
        }
   
  }


    // -- changing levels -- //
    //when 20 deer and 10 students have been dodged, move to the next state
    if (deerCount >= 20 && studentCount >= 7 && deerList.isEmpty() && studentList.isEmpty()) {
      println("Level 2 completed, moving to Level 3...");
      state = 5;  // move to the second level
      deerCount = 0;  // reset deer count
      studentCount = 0;  // reset student count
      deerList.clear();  // clear the deer list for the next level
      studentList.clear();  // clear the student list for the next level
  }  
}

void levelThree(){
    // -- player render and move -- //
    player1.render();
    player1.move(); 
      
    // -- adding students and deers to the lists-- //
    // -- adding to deerList to spawn one -- // 
    //if there are no obstacles on the screen and the deerCount is less than 23, spawn a new obstacle.
    if (deerCount < 23){
    int currentTime = millis();
    deerSpawnInterval = 600;
    
    if (currentTime - lastDeerSpawnTime > deerSpawnInterval) {
      Obstacle deer = new Obstacle(width, int(random(200, height - 50)), 25, 25, 15, 0);
      deerList.add(deer);  // assuming you're using a separate list or a shared list with type
  
   
      lastDeerSpawnTime = currentTime;
    }
  }

  
  
    // -- adding to studentList to spawn one -- // 
    //if there are no obstacles on the screen and the students is less than 18, spawn a new obstacle.
    if (studentCount < 8){
    int currentTime = millis();
    int studentSpawnInterval = 1800;
    
    println(studentList.size());
    if (currentTime - lastStudentSpawnTime > studentSpawnInterval) {
      Obstacle student = new Obstacle(width, int(random(200, height - 50)), 100, 80, 13, int (random(2,8))); //int (random(2,8))
      studentList.add(student);  // or obstacles.add(student)
  
     
      lastStudentSpawnTime = currentTime;
    }
   }


  
  
    // -- deer render and move. -- //
    //CHATGPT helped me with this, I added its comments. 
    // ChatGPT: Iterate through the obstacles in reverse order (starting from the last one). My original code also caused an indexoutofboundsexception due to multiple remove statements.
    // -- moving and rendering deer --
       for (int i = deerList.size() - 1; i >= 0; i--) {
      //get the current obstacle at index i
          Obstacle d = deerList.get(i); 
      //call the render method of the obstacle and display it on the screen
          d.render();
      //call the render method of the obstacle and display it on the screen
          d.move();
  
    if (player1.enemyDetection(d)) {
      if (deerHit < 1) { //if the deerHit count is less that two 
        deerList.remove(i); //remove the deer from the screen
        deerHit++; //add one to the deerHit
        showScratchMessage = true; //show the message
        continue;  // this will skip the rest of the code below for this loop, moving to the next item in the loop after the else statement. 
      } 
      else {
        state = 7; //this means its more than two
        deerCount = 0; //reset the deer
        deerList.clear();
        break; // stop the loop, game is over
        }
      }
  
      if (d.x + d.w / 2 < 0 && d.type == 0) { // if the deer has moved off of the screen
        deerList.remove(i);  // remove the deer from the list  
        deerCount++; //increase the deerCount by 1
        //println("Deer dodged, count: " + deerCount); //this was for debugging but I want to keep it
       }
    }
  
        // show "just a scratch" message while deerHit == 1
      if (showScratchMessage && deerHit == 1) {
         image(justAScratch, width/2, height/2 - 25);
       }
  
  
  
  
  
  
      
     // -- student render and move. -- //
    //CHATGPT helped me with this, I added its comments. 
    // ChatGPT: Iterate through the obstacles in reverse order (starting from the last one)
    // -- moving and rendering student --
     for (int i = studentList.size() - 1; i >= 0; i--) {
       //get the current obstacle at index i
       Obstacle s = studentList.get(i);
       //call the render method of the obstacle and display it on the screen
       s.render();
       //call the move method to get it to move on the screen.
       s.move();
  
     if (s.x + s.w / 2 < 0 && s.type >= 2 && s.type <= 7) {  // check if student has moved off the screen
        studentList.remove(i);  // remove the student from the list
        studentCount++;  // increment student count
        //println("Student dodged, count: " + deerCount);  // debugging message
     }
     
     //student collision detection
     if (player1.enemyDetection(s)) {
       carBoom.play();
       carBoom.amp(0.5);
        state = 8;
        
      
        }
      
    
  }
  
  
    // -- changing levels -- //
    //when 25 deer and 18 students have been dodged, move to the next state
  if (deerCount >= 23 && studentCount >= 8 && deerList.isEmpty() && studentList.isEmpty()) {
      //println("Level 2 completed, moving to Level 3...");
      state = 6;  // move to the second level
      deerCount = 0;  // reset deer count
      studentCount = 0;  // reset student count
      deerList.clear();  // clear the deer list for the next level
      studentList.clear();  // clear the student list for the next level
  }
  
  
  
}
