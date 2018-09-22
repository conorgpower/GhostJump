import javax.swing.*;

//Objects for programme
Player player;

//Game Data
PImage gameBackground, ghost1, ghost2, ghost3, ghost4, barriers;
int gameScreen = 0, startScreen = 1, manualScreen = 2;
int gamestate = 1, score = 0, highScore = 0, x = -200, y, vy = 0;
int bx[] = new int[2];
int by[] = new int[2];

void setup() {
  size(600, 800);
  fill(0);
  textSize(40);  
  gameBackground =loadImage("gameBackground.png");                                    //Load images
  ghost1 =loadImage("0.png");
  ghost2 =loadImage("1.png");
  ghost3 =loadImage("2.png");
  ghost4 =loadImage("3.png");
  barriers =loadImage("http://i.imgur.com/4SUsUuc.png");
  player = new Player(JOptionPane.showInputDialog("Enter the player name: "));       //Calling new player, declaring new player using JOptionPane
}

void draw() { 
  if (gamestate == gameScreen) {
    imageMode(CORNER);
    image(gameBackground, x, -120);
    image(gameBackground, x+gameBackground.width, -120);
    x -= 6;                                                                           //Moves background
    vy += 1;                                                                          //Velocity
    y += vy;                                                                          //Adds velocity to drop
    if (x == -1500) x = 0;                                                            //Resets background
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      image(barriers, bx[i], by[i] - (barriers.height/2+100));                        //Draw barriers
      image(barriers, bx[i], by[i] + (barriers.height/2+100));
      if (bx[i] < 0) {
        by[i] = (int)random(200, height-200);                                         //Barrier y coordinate random value between 200 & 600
        bx[i] = width;                                                                //barrier x coordinate is width 
      }
      if (bx[i] == width/2) highScore = max(++score, highScore);                      //If sprite passes barrier score +1
      if (y>height||y<0||(abs(width/2-bx[i])<25 && abs(y-by[i])>100)) gamestate=1;    //Collision detection
      bx[i] -= 6;
    }
    image(ghost1, width/2, y);
    text(""+score, width/2-15, 700);
  } else { 
    imageMode(CORNER);
    textAlign(CORNER);
    image(gameBackground, 0, -120);
    text("High Score: "+highScore+ " by "+player.getPlayerName(), 20, height-750);     //Display high score and playername(player.getPlayerName)
    textAlign(CENTER);
    textSize(40);
    text("Ghost Jump", width/2, height/3);
    textAlign(RIGHT);
    textSize(30);
    text("Play \n Manual", width-10, height-60);
    imageMode(CENTER);
    image(ghost1, width*.125, height/2, 100, 100);
    image(ghost2, width*.375, height/2, 100, 100);
    image(ghost3, width*.625, height/2, 100, 100);
    image(ghost4, width*.875, height/2, 100, 100);
  }

  if (gamestate == manualScreen) {
    imageMode(CENTER);
    image(gameBackground, width/2, height/2-50);
    fill(100);
    rectMode(CORNER);
    rect(0, 0, 180, 65);
    fill(255);
    textSize(30);
    textAlign(CORNER);
    text("< BACK", 10, 40);
        if (mousePressed && mouseX >= 0 && mouseX <= 180 && mouseY >= 0 && mouseY <= 65) {
      gamestate=startScreen;
    }
    fill(0);
    textAlign(CENTER);
    text("Manual: \n\n The goal of the game is to score as \n high as you can by jumping through \n barriers. The controls are simple, just \n click the mouse to jump. You can die \n by crashing into the floor or walls.", width/2, height/3);
  }
}

void mousePressed() {
  vy = -17;
  if (gamestate==1) {
    bx[0] = 600;
    by[0] = y = height/2;
    bx[1] = 900;
    by[1] = 600;
    x = score = 0;
    if (mouseX >= width - 140 && mouseX <= width && mouseY >= height - 80 && mouseY <=height - 50) {       //If you click 'Options'
      gamestate=0;
    }
    if (mouseX >= width - 190 && mouseX <= width && mouseY >= height -35 && mouseY <=height) {             //If you click 'High Scores'
      gamestate=2;
    }
  }
}