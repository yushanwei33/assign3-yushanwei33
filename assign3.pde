final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int downState = 1;

boolean upPressed=false;
boolean downPressed=false;
boolean rightPressed=false;
boolean leftPressed=false;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int STONE1COUNT =8;
float stoneSpacingX=640/STONE1COUNT;
float stoneSpacingY=640/STONE1COUNT;

final int SOILCOUNT = 4;

float soldierX,soldierY;
float cabbageX,cabbageY;
float groundhogX,groundhogY,groundhogSpeed;


PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage stone1 , stone2 ;
PImage bg, soil0 ,soil1 ,soil2, soil3, soil4,soil5 ,life;
PImage groundhog,soldier,cabbage;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
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
	soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life=loadImage("img/life.png");
  groundhog=loadImage("img/groundhogIdle.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  
  //soldierPosition
  soldierX=floor(random(0,560));
  soldierY=160+80*floor(random(0,4));
  
  //cabbagePosition
  cabbageX=80*floor(random(0,8));
  cabbageY=160+80*floor(random(0,4));
  
  //groundhog
  groundhogX =320;
  groundhogY =80;
  groundhogSpeed =80;
  
  //life
  playerHealth=2;
  
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
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
     //1to4
      for(int y=0 ; y<SOILCOUNT*80; y+=80){
      for(int x=0 ; x<width; x+=80){
	  	image(soil0, x, y+160);
      image(soil1, x, y+480);
      image(soil2, x, y+800);
      image(soil3, x, y+1120);
      image(soil4, x, y+1440);
      image(soil5, x, y+1760);      
      }
    }

		// Health UI
     if(playerHealth<=5){
    for(int i=0; i<playerHealth; i++){
        int x =10+i*70;
        int y =10;
          image(life,x,y);
    }
    }
        

    // Stone
       //1to8
      float stone1to8X=0 ,stone1to8Y=160;    
      for(int i=0; i<STONE1COUNT; i++){
        stone1to8X=i*stoneSpacingX;
        image(stone1,stone1to8X,stone1to8Y);
        stone1to8Y += stoneSpacingY;
      }     
                   
       //9tp16       
      for(int y=0 ; y<STONE1COUNT*80 ; y+=320){
        for(int x=80 ; x<width+320; x+=320){
          image(stone1,x, y+800);
          image(stone1,x+80, y+800);
          image(stone1,x-160, y+880);
          image(stone1,x-80, y+880);
          image(stone1,x-160, y+960);
          image(stone1,x-80, y+960);
          image(stone1,x, y+1040);
          image(stone1,x+80, y+1040);
          }
       }
        //17to24
        for(int y=0 ; y<STONE1COUNT*80 ; y+=240){
        for(int x=80 ; x<width+320; x+=240){
          image(stone1,x, y+1440);
          image(stone1,x+80, y+1440);
          image(stone1,x, y+1520);
          image(stone1,x-80,y+1520);
          image(stone1,x-80, y+1600);
          image(stone1,x-160, y+1600);
          //stone2
          image(stone2,x+80, y+1440);
          image(stone2,x, y+1520);
          image(stone2,x-80, y+1600);
          }
       }
       
    // Player
    //cabbage&groundhog&soldier
    image(cabbage,cabbageX,cabbageY);    
    image(groundhog,groundhogX,groundhogY);
    image(soldier,soldierX,soldierY);
    soldierX+=3;
    if (soldierX>width){
        soldierX=-80;
    }
    
    //groundhogEatCabbage
    if(groundhogX==cabbageX  &&  groundhogY==cabbageY){
      cabbageX=-100;
      cabbageY=-100;
      playerHealth++;
    }
    
    //groundhogTouchSolider
    if(groundhogX<soldierX+80 && groundhogX+80>soldierX 
        && groundhogY<soldierY+80 && groundhogY+80>soldierY){
          groundhogX=320;
          groundhogY=80;
          playerHealth--;
        }
        
        if(playerHealth==0){
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
				mousePressed = false;
				// Remember to initialize the game here!
        gameState = GAME_RUN;
        playerHealth=2;
        groundhogX =320;
        groundhogY =80;
        cabbageX=80*floor(random(0,8));
        cabbageY=160+80*floor(random(0,4));
        soldierX=floor(random(0,560));
        soldierY=160+80*floor(random(0,4));
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
  if(key ==CODED){
  switch(keyCode){
    case DOWN:
    groundhogY+=groundhogSpeed;
    if(groundhogY+80>height){
       groundhogY=height-80;
    }
    break;
    case RIGHT:
    groundhogX+=groundhogSpeed;
    if(groundhogX+80>width){
       groundhogX=width-80;
    }
    break;
    case LEFT:
    groundhogX-=groundhogSpeed;
    if(groundhogX<=0){
       groundhogX=0; 
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
    switch(keyCode){
    case UP:
    upPressed = false;
    break;
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
