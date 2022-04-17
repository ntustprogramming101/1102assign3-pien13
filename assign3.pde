final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage life, soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;
PImage soldier, cabbage;

boolean downPressed  = false;
boolean leftPressed  = false;
boolean rightPressed = false;

int soldierX;
float soldierY, initSoldierY;
int cabbageX;
float cabbageY, initCabbageY;
int playerHealth = 2;

float groundhogX;
float groundhogY;
float groundhogSpeed = 80;

int down = 0;
int right = 0;
int left = 0;
float step = 80.0;
int frames = 15;
int floorSpeed = 0;
float downMove = 0;

// For debug function; DO NOT edit or remove this!
//int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");

  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");

  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogX = 320;
  groundhogY = 80;
  
  soldier = loadImage("img/soldier.png");  
  soldierX = -80;
  soldierY = floor(random(2, 6))*80;
  initSoldierY = soldierY; 
  
  
  cabbage = loadImage("img/cabbage.png");
  cabbageX = floor(random(0, 8))*80;
  cabbageY = floor(random(2, 6))*80;
  initCabbageY = cabbageY;

  life = loadImage("img/life.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);

    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT + downMove, width, GRASS_HEIGHT);

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int x = 0; x < 8; x ++){
      for(int y = 0; y < 24 ; y++){
        if(y < 4){
          image(soil0, x * 80, 160+y*80+downMove);
          image(stone1, y * 80, 160+y*80+downMove); // stone pattern 1-8
        }else if(y < 8){
          image(soil1, x * 80, 160+y*80+downMove);
          image(stone1, y * 80, 160 + y * 80 + downMove); // stone pattern 1-8
        }else if(y < 12){
          image(soil2, x * 80, 160 + y * 80 + downMove);
        }else if(y < 16){
          image(soil3, x * 80, 160 + y * 80 + downMove);
        }else if(y < 20){
          image(soil4, x * 80, 160 + y * 80 + downMove);
        }else if(y < 24){
          image(soil5, x * 80, 160 + y * 80 + downMove);
        }
      }
    }
    
    //stone pattern 9-16
    for(int octagonX = 0; octagonX < 2; octagonX++){
      for(int octagonY = 0; octagonY < 2; octagonY++){
      pushMatrix();
      translate(octagonX * 4 * 80, octagonY * 4 * 80);
      for(int x = 0; x < 4; x++){
        for(int y = 0; y < 4; y+=3){
          if(x % 3 != 0){
          image(stone1, x * 80, 8 * 80 + 160 + y * 80 + downMove);
          }
        }
      }
       for(int x = 0; x < 4; x++){
         for(int y = 1; y < 3; y++){
           if(x % 3 == 0){
             image(stone1, x * 80, 8 * 80 + 160 + y * 80 + downMove);
           }         
         }
       }
       popMatrix();
      }
     }
     
    //stone pattern 17-24
    for(int x = 0; x < 15; x++){
      for(int y = 0; y < 8; y++){
        if(x % 3 != 0){
          image(stone1, x * 80 - y * 80, 16 * 80 + 160 + y * 80 + downMove);
        }
        if(x % 3 == 2){
          image(stone2, x * 80 - y * 80, 16 * 80 + 160 + y * 80 + downMove);
        }
      }
    }

    // Player
    //groundhog move
    //down
    if (down > 0 && downMove > -1600) {
      floorSpeed -=1;
      if (down == 1) {
        downMove = round(step/frames*floorSpeed);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        downMove = step/frames*floorSpeed;
        image(groundhogDown, groundhogX, groundhogY);
      }
      down -=1;
    }

    if (down > 0 && downMove == -1600) {
      if (down == 1) {
        groundhogY = round(groundhogY + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogY = groundhogY + step/frames;
        image(groundhogDown, groundhogX, groundhogY);
      }
      down -=1;
    }

    //left
    if (left > 0) {
      if (left == 1) {
        groundhogX = round(groundhogX - step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX - step/frames;
        image(groundhogLeft, groundhogX, groundhogY);
      }
      left -=1;
    }

    //right
    if (right > 0) {
      if (right == 1) {
        groundhogX = round(groundhogX + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX + step/frames;
        image(groundhogRight, groundhogX, groundhogY);
      }
      right -=1;
    }

    //no move
    if (down == 0 && left == 0 && right == 0 ) {
      image(groundhogIdle, groundhogX, groundhogY);
    }

    // Health UI
    for(int x = 0; x < playerHealth; x++){
      pushMatrix();
      translate(x*70, 0);
      image(life, 10, 10);
      popMatrix();
    }
    
      //soldier
  soldierY = initSoldierY + downMove; 
  soldierX = soldierX + 1;
  if (soldierX > 640){
    soldierX = -80;
  }
  image(soldier, soldierX++, soldierY); 
  
  //encounter soldier
  if (soldierX - 80 < groundhogX && groundhogX < soldierX + 80 && soldierY + 80 > groundhogY && groundhogY > soldierY - 80){
  groundhogX = 320;
  groundhogY = 80; 
  playerHealth -= 1;
  down = 0;
  left = 0;
  right = 0;
  downMove = 0;
  floorSpeed = 0;
 }   
  
  //encounter cabbage
  cabbageY = initCabbageY + downMove;
  image(cabbage, cabbageX, cabbageY);
  if (cabbageX - 80 < groundhogX && groundhogX < cabbageX + 80 && cabbageY + 80 > groundhogY && groundhogY > cabbageY - 80){
    cabbageX = -80;
    cabbageY = 0;
    playerHealth += 1;
  }    
  if (playerHealth == 0){
    gameState = GAME_OVER;
  }
    break;

    case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        //mousePressed = false;
        // Remember to initialize the game here!
          mousePressed = false;
          groundhogX = 320;
          groundhogY = 80;
          soldierX = -80;
          soldierY = floor(random(2,6))*80;  
          cabbageX = floor(random(0,8))*80;
          cabbageY = floor(random(2,6))*80;          
          playerHealth = 2;
      }
    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here
    //groundhogMoveLock
  if(down>0 || left>0 || right>0){
    return;
  }
  if(key == CODED){
    switch(keyCode){
    case DOWN:
      if(groundhogY < 400){
        downPressed = true;
        down = 15;
      }
      break;
    case LEFT:
      if(groundhogX > 0){
        leftPressed = true;
        left = 15;
      }
      break;
    case RIGHT:
      if(groundhogX < 560){
        rightPressed = true;
        right = 15;
      }
      break; 
    }
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
