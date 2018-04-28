float lockTime = 0;
boolean lock = false;
float lockSeconds = 0.2;
float starSize = 8;

int scene[] = new int[2];
boolean transiting = false;
boolean debug = false;

PFont font40, font20;
PFont font60;
PFont dF;

float wid5;
float hei5;

int window = -1;
float offset = 0;
float bar = 0;

void setup()
{
  size(1280,720);
  font20 = loadFont("data/font20.vlw");
  font40 = loadFont("data/font40.vlw");
  font60 = loadFont("data/font60.vlw");
  dF = loadFont("data/debug.vlw");
  
  wid5 = width/2;
  hei5 = height/2;
  
  background(0);
  textFont(font60);
  textAlign(CENTER,CENTER);
  loadData();
  background(0); text("Loading Images...",wid5,hei5);
  loadImages();
  
  scene[0] = -1;
  scene[1] = 0;
}

void draw()
{
  controlLock(); 
  background(0);

  textFont(font60);
  imageMode(CORNER);
  fill(255);
  noStroke();
  
  //
  // SCENES
  //
  float trans = 255;
  for(int i = 1; i >= 0; i--)
  {
    trans = 255;
    if(transiting && i == 0){trans = 255*(lockTime/lockSeconds);}
    if(scene[i] == 0)
    {
      tint(255,trans);
      image(background,0,0);
      fill(255,trans);
      textFont(font60);
      textAlign(CENTER,BOTTOM);
      text("INTERSTELLAR", wid5, hei5);
      textAlign(CENTER,TOP);
      text("CONSORTIUM", wid5, hei5);
      
      textAlign(CENTER,CENTER);
      textFont(font40);
      text("MAP",width*0.25,height*0.75);
      text("INFO",width*0.75,height*0.75);
    }
    if(scene[i] == 1)
    {
      tint(255,trans);
      image(background,0-offset,0);
      image(galaxies,0-offset,0);
      textFont(font40);
      textAlign(LEFT,CENTER);
      fill(255,trans);
      text("BACK",50,50);
      
      if(!transiting)
      for(int j = 0; j < grGal.size(); j++)
      {
        if( checkButton(grGal.get(j)[1]-offset,grGal.get(j)[2],50,"CIRCLE") )
        {
          imageMode(CENTER);
          image(arrowmap,grGal.get(j)[1]-offset,grGal.get(j)[2]-70);
        }
      }
      
      if(window >= 0)
      {
        if(offset<=240)offset += 12;
        fill(20,trans);
        rect(width-offset*2,0,width,height);
        textAlign(CENTER,CENTER);
        textFont(font60);
        fill(255,trans);
        text("GALAXY",width*1.2-offset*2,height*0.15);
        text(Galaxies.get(window).name,width*1.2-offset*2,height*0.25);
        textFont(font40);
        textAlign(LEFT,CENTER); text("STARS: ",width*1.05-offset*2,height*0.40); text("CLASS: ",width*1.05-offset*2,height*0.50); text("DIAM: ",width*1.05-offset*2,height*0.60);
        textAlign(RIGHT,CENTER); text(int(Galaxies.get(window).stars),width*1.35-offset*2,height*0.40); text(Galaxies.get(window).type,width*1.35-offset*2,height*0.50); text(Galaxies.get(window).size + " kp",width*1.35-offset*2,height*0.60);
        textFont(font60);
        textAlign(CENTER,CENTER);
        text("STAR MAP",width*1.2-offset*2,height*0.80);
        imageMode(CENTER);
        image(arrowmap,grGal.get(window)[1]-offset,grGal.get(window)[2]-70);
      }
    }
    
    if(scene[i] == 2)
    {
      textFont(font40);
      textAlign(LEFT,CENTER);
      fill(255,trans);
      text("BACK",50,50);
      textAlign(CENTER,CENTER);
      fill(20);
      rect(width-480,0,width,height);
      textFont(font60);
      fill(255);
      text("GALAXY",width*1.2-offset*2,height*0.15); text(Galaxies.get(window).name,width*1.2-offset*2,height*0.25);
            
      fill(0,trans);
      rect(0.67*width,0.4*height,290,380);
      rect(0.92*width,0.4*height,35,380);
      fill(127,trans);
      if(mousePressed && mouseButton == LEFT && mouseY > 0.35*height && mouseY < 0.45*height+325 && mouseX > 0.92*width && mouseX < 0.92*width+35)
      {
        bar = (mouseY-(0.4*height))/325;  
      }
      if(bar < 0)bar=0; if(bar>1)bar=1;
      rect(0.92*width,0.4*height+(325*bar),35,35);
      
      stroke(60,trans);
      noFill();
      ellipseMode(CENTER);
      ellipse(400,height/2,600,300);
      line(400,hei5,400,hei5-150); line(400,hei5,400,hei5+150); line(400,hei5,400+300,hei5); line(400,hei5,400-300,hei5);
      
      float listNumber = -1;
      for(int j = 0; j < StarsOnDemand.size(); j++)
      {
          stroke(90,trans);
          noFill();
          float x, y, z;
          x = 400+Stars.get(j).posX*(600 / Galaxies.get(window).size);
          y = hei5+Stars.get(j).posY*(300 / Galaxies.get(window).size);
          z = Stars.get(j).posZ*(300 / Galaxies.get(window).size);
          line(x,y,x,y-z);

          listNumber++;
          
          if(listNumber >= floor(bar*StarsOnDemand.size()) && listNumber < (bar*StarsOnDemand.size())+10)
          {
            float barY = 0.4*height+19+(listNumber-floor(bar*StarsOnDemand.size()))*38;//-floor(bar*StarsOnDemand.size());
            fill(getStarColor(Stars.get(j).type));
            ellipse(0.67*width+19,0.4*height+19+(listNumber-floor(bar*StarsOnDemand.size()))*38,getStarSizeList(Stars.get(j).type),getStarSizeList(Stars.get(j).type));
            fill(255,trans);
            textAlign(LEFT,CENTER);
            textFont(font20);
            text(Stars.get(j).name,0.67*width+38,barY);
            if( checkButton(0.67*width+19,0.4*height+19+(listNumber-floor(bar*StarsOnDemand.size()))*38,19,"CIRCLE") )
            {
              stroke(100,trans);
              if(abs(x-width*0.6) > abs(y-(barY)) )
              {
               line(width*0.6,barY,x+abs(barY-(y-z)),barY);
               line(x+abs(barY-(y-z)),barY,x,y-z);  
              }
              else
              {
               int ps = 1;
               if(y<(barY)){ps = -1;}
               line(width*0.6,barY,x,(barY)+ps*abs(x-width*0.6));
               line(x,y-z,x,(barY)+ps*abs(x-width*0.6)); 
              }
              noStroke();
            }
          }
          
          fill(getStarColor(Stars.get(j).type));
          noStroke();
          ellipse(x,y-z,getStarSize(Stars.get(j).type),getStarSize(Stars.get(j).type));
      }
    }
    
    tint(255,255);
  }
    
    
    
  if(debug)
  {
    textFont(dF);
    fill(255);
    textAlign(LEFT,CENTER);
    text("DEBUG: mainScene: " + scene[1] + " / overlayScene: " + scene[0],100,100);
    text("transiting: " + transiting + " / lockTime: " + lockTime,100,120);
    text("bar: " + floor(bar*80) + " / StarsOnDemand: " + StarsOnDemand.size(),100,140);
    text("mouseX: " + mouseX + " / mouseY: " + (mouseY),100,160);
  }
}

void lockPlayer(float extraTime)
{
  lockTime += extraTime;
  lock = true;
}

void controlLock()
{
  if(lockTime <= 0){
    lock = false;
    lockTime = 0;
    scene[0] = -1;
    transiting = false;
  }
  
  else if(lockTime > 0){
    lockTime -= 1/frameRate;
  }
}

void mouseClicked()
{
  if(mouseButton == LEFT && !lock)
  {
    if(scene[1] == 0)
    {
      if(checkButton(width*0.25,height*0.75,50,"CIRCLE"))
      {
        lockPlayer(lockSeconds);
        transiting = true;
        scene[0] = 0;
        scene[1] = 1;
        println("> Going to Galaxies Map");
      }
    }
    
    if(scene[1] == 1)
    {
      if(checkButton(100,50,100,"CIRCLE"))
      {
        lockPlayer(lockSeconds);
        transiting = true;
        scene[0] = 1;
        scene[1] = 0;
        window = -1; offset = 0;
        println("> Going back to Menu");
      }
      if(checkButton(width*1.2-offset*2,height*0.80,50,"CIRCLE") && window >= 0)
      {
        lockPlayer(lockSeconds);
        transiting = true;
        scene[0] = 1;
        scene[1] = 2;
        println("> Opening " + Galaxies.get(window).name + "'s Star Map");
        
        for(int j = 0; j < Stars.size(); j++)
        {
          if(Stars.get(j).host.equals( Galaxies.get(window).name) == true)
          {
            println("  - Detected star: " + Stars.get(j).name + " | Host: " + Stars.get(j).host);
            StarsOnDemand.add(Stars.get(j));
          }
        }
      }
      for(int j = 0; j < grGal.size(); j++)
      {
        if( checkButton(grGal.get(j)[1]-offset,grGal.get(j)[2],50,"CIRCLE") )
        {
          println("> Opening Info of Galaxy " + Galaxies.get(j).name + " (" + j + ")");
          boolean change = false;
          if(window == 0)change = true;
          window = j;
          if(window == 0 && change == true)change = false;
          
          if(change){
            lockPlayer(lockSeconds);
            transiting = true;
          }
        }
      }
    }
    
    if(scene[1] == 2)
    {
      if(checkButton(100,50,100,"CIRCLE"))
      {
        lockPlayer(lockSeconds);
        transiting = true;
        scene[0] = 2;
        scene[1] = 1;
        println("> Going back to Galaxies Map, clearing StarsOnDemand");
        bar = 0;
        StarsOnDemand.clear();
      }
    }
  }
}

boolean checkButton(float x, float y, float r, String mode)
{
  boolean output = false;
  
  if(mode == "CIRCLE" && sqrt( pow(x-mouseX,2) + pow(y-mouseY,2 )) < r)output = true;
  else if(mode == "SQUARE" && sqrt( pow(x-mouseX,2) + pow(y-mouseY,2 )) < r)output = true;
  
  return output;
}

void keyReleased()
{
  if(key == 'd') debug = !debug;
}