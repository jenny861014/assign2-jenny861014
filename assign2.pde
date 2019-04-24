PImage title,startHovered,startNormal;
PImage bg,soil,cabbage,soldier,life;
PImage groundhogIdle,groundhogDown,groundhogLeft,groundhogRight;
PImage gameOver,restartHovered,restartNormal;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState;


final int MOVE_STOP = 0;
final int MOVE_DOWN = 1;
final int MOVE_LEFT = 2;
final int MOVE_RIGHT = 3;
int moveState = MOVE_STOP;
int point = 80;
float SPD;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

float groundhogIdleX,groundhogIdleY;
float groundhogWidth = 80;

float soldierX,soldierY;
float cabbageX,cabbageY;
int life1X,life2X,life3X;

void setup() {
	size(640, 480, P2D);
  //Game Start
  gameState=GAME_START;
  title = loadImage("img/title.jpg");
  startHovered = loadImage("img/startHovered.png"); 
  startNormal = loadImage("img/startNormal.png"); 
  //Game Run
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  life = loadImage("img/life.png");
  //groundhog
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogIdleX = 320;
  groundhogIdleY = 80;
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  SPD = 60 / 15;
  //Game Lose
  gameOver = loadImage("img/gameOver.jpg"); 
  restartHovered = loadImage("img/restartHovered.png"); 
  restartNormal = loadImage("img/restartNormal.png"); 
  //soldier
  soldier=loadImage("img/soldier.png");
  soldierX = 0; 
  soldierY = floor(random(2,6))*80;
  //cabbage
  cabbageX=floor(random(0,8))*80;
  cabbageY=floor(random(2,6))*80;
  //life
  life1X=10;
  life2X=80;
  life3X=800;
}


void draw() {

  switch(gameState){
    case GAME_START:
      image(title,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT&&
         mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal,248,360);
      }
    break;
    
    case GAME_RUN:
      image(bg,0,0);
      image(soil,0,160);
      image(life,life1X,10);
      image(life,life2X,10);
      image(life,life3X,10);
      //grass
      colorMode(RGB);
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      //sun
      fill(255,255,0); 
      ellipse(590,50,130,130); 
      fill(253,184,19); 
      ellipse(590,50,120,120);
      //groundhogIdle
      switch(moveState){
       case MOVE_STOP:
        image(groundhogIdle,groundhogIdleX,groundhogIdleY);
        break;
       case MOVE_DOWN:
        if (groundhogIdleY < 160+80*4-groundhogWidth){
          image(groundhogDown,groundhogIdleX,groundhogIdleY);
          groundhogIdleY += SPD;
          if (groundhogIdleY % point == 0){
            moveState = MOVE_STOP;
          }
        }else{image(groundhogIdle,groundhogIdleX,160+80*4-groundhogWidth);}
        break;
       case MOVE_LEFT:
        if (groundhogIdleX>0){
          image(groundhogLeft,groundhogIdleX,groundhogIdleY);
          groundhogIdleX -= SPD;
          if (groundhogIdleX % point == 0){
            moveState = MOVE_STOP;
          }
        }else{image(groundhogIdle,0,groundhogIdleY);}
        break;
       case MOVE_RIGHT:
        if (groundhogIdleX < 640-groundhogWidth){
          image(groundhogRight,groundhogIdleX,groundhogIdleY);
          groundhogIdleX += SPD;
          if (groundhogIdleX % point == 0){
            moveState = MOVE_STOP;
          }
        }else{image(groundhogIdle,640-groundhogWidth,groundhogIdleY);}
        break;
      }
      //cabbage
      image(cabbage,cabbageX,cabbageY);
      if(cabbageX < groundhogIdleX+80 && cabbageX+80 > groundhogIdleX &&
      cabbageY < groundhogIdleY+80 && cabbageY+80 > groundhogIdleY && life2X == 800){
          cabbageX = 800;
          life2X = 80;
        }
      if(cabbageX < groundhogIdleX+80 && cabbageX+80 > groundhogIdleX &&
      cabbageY < groundhogIdleY+80 && cabbageY+80 > groundhogIdleY && life2X == 80){
          cabbageX = 800;
          life3X = 150;
        }
        
      //soldier
      image(soldier,soldierX,soldierY);
      soldierX+=5;
      if(soldierX >= 640){
        soldierX = -80;}
      if(soldierX < groundhogIdleX+80 && soldierX+80 > groundhogIdleX &&
         soldierY < groundhogIdleY+80 && soldierY+80 > groundhogIdleY && life3X == 150){
          groundhogIdleX = 320;
          groundhogIdleY = 80;
          life3X=800;}
      else if(soldierX < groundhogIdleX+80 && soldierX+80 > groundhogIdleX &&
         soldierY < groundhogIdleY+80 && soldierY+80 > groundhogIdleY && life2X == 80){
          groundhogIdleX = 320;
          groundhogIdleY = 80;
          life2X=800;}
      else if(soldierX < groundhogIdleX+80 && soldierX+80 > groundhogIdleX &&
         soldierY < groundhogIdleY+80 && soldierY+80 > groundhogIdleY && life1X == 10){
          gameState = GAME_OVER;
      }
    break;
        
    case GAME_OVER:
      image(gameOver,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT&&
         mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
          life1X=10;
          life2X=80;
          groundhogIdleX = 320;
          groundhogIdleY = 80;
          soldierX = -80; 
          soldierY = floor(random(2,6))*80;
          cabbageX =floor(random(0,8))*80;
          cabbageY=floor(random(2,6))*80;
        }
      }else{
        image(restartNormal,248,360);}
    break;
 }
    
}

void keyPressed(){
  if(key == CODED){
    if(groundhogIdleX%point==0 && groundhogIdleY%point==0)
    switch(keyCode){
      case DOWN:
      moveState = MOVE_DOWN;
      break;
      case RIGHT:
      moveState = MOVE_RIGHT;
      break;
      case LEFT:
      moveState = MOVE_LEFT;
      break;
    }
  }
}
