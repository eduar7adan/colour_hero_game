
/*
Colores activos :
  red ->  0 
  green ->  1 
  blue -> 2 
  orange -> 3 
  white -> 4 
*/
final int quads = 0 ;
final int quads_snake = 1 ;


final int top_level_quads  = 1;
final int initial_v = 4;
import processing.sound.*;
/*
class Ccircle{
   
  int x , y , addone =0 , circle_colour;
  Ccircle(){
   x = x_control ; 
   y = sin(y_control) ; 
   circle_colour = get_rand_colour() ;
  }
  
  void paint_circle(){
   load_colour(circle_colour);
   ellipse(x ,y ,100 ,100);
   y+=v;
   if((y > 20)&&(addone== 0)){
     array_circle.add(new Ccircle());  //crea otro rectangulo
     addone= 1 ; 
    } 
  }
  
}
*/

class Cslice{
 
  float x , y , addone = 0 ;
  float a;
  int slice_colour ;
  
  Cslice(){
    x = x_control ;
    y = -100; 
    slice_colour = get_rand_colour();
    a=0 ;
  }
  
  void paint_slice(){
    load_colour(slice_colour);
    rect(x-100, y, 200, 100); 
    if(round ==quads)
      y+=v;
   
    if(round == quads_snake){
      x=x_control+ amp*sin(a);
      a+=0.1;
      y+=v;
     
    }
    
   // println(x);
    if((y > 20)&&(addone== 0)){
      array_slice.add(new Cslice());  //crea otro rectangulo
      addone= 1 ; 
    } 
  } 
}
//multivariables
int round = 0 ,amp = 120  ;

//variables de la round 1 

int  colour_state, colour_next ,colour_next2 , change_main_colour = 0 , life = 3 , level_quads = 1 ,score=0 , wins=0 ,v=initial_v , count_yes=0 , count_no=0;
int x_control=375 , y_control = 400 ;
ArrayList<Cslice> array_slice ; 
PImage gameover , i_life1 , i_life2  , i_life3, i_yes, i_no ; 
boolean yes_semaphore= false , no_semaphore = false ;
SoundFile music_round1 , music_over , music_win , music_wrong;

//variables de la round 2 

void setup(){
  
  size(800,600);
  ellipse(x_control , y_control , 50 , 50);
  background(0);
  array_slice = new ArrayList<Cslice>();
  array_slice.add(new Cslice());
  i_life1 = loadImage ("life.png");
  i_life2 = loadImage ("life.png");
  i_life3 = loadImage ("life.png");
  i_yes = loadImage ("yes.png");
  i_no = loadImage ("error.png");
  
  music_round1 = new SoundFile(this, "edudoso.mp3");
  music_round1.play();
  
  colour_state = get_rand_colour();
  colour_next = get_rand_colour();
  
  
}

void draw(){
  
  switch(round){
    case quads :
      round1_play();
      if(level_quads == top_level_quads){
        round = quads_snake ;
        restart_variables();
        music_round1.stop();
        
      }
    break ;
    
      case quads_snake :
        round2_play();
  }
}

void round2_play(){
  
    //delay(5000);    
    round1_play() ;  //No es lo mismo ya que ahora se moveran realizando un seno
}
void restart_variables(){
  v = initial_v;
  level_quads = 1 ; 
}
void round1_play(){
  background(0);
  score_and_level_text();
  stroke(204, 102, 0);
  if(round == quads)
    line(x_control -200 , y_control ,x_control+ 200 , y_control);
  else if (round == quads_snake){
    line(0 , y_control , x_control-200 , y_control);
    noFill();
    ellipse(x_control-200 , y_control , 20,20);
    stroke(0,255,255);
    ellipse(x_control-200 ,y_control ,2 ,2);
  }
  colour_transition_main_quad();  
  for(int i = 0 ; i < array_slice.size();i++){
     array_slice.get(i).paint_slice(); 
  }
  paint_result_images();   
}

void paint_result_images(){
   //comprobación de la pulsación
  if(yes_semaphore){
    image(i_yes , x_control-200 , y_control-60);
    count_yes++;
    if(count_yes == 20){
      yes_semaphore = false ;
      count_yes=0;
    }
  }
  
  if(no_semaphore){
    image(i_no , x_control-200 , y_control-60);
    count_no++;
    if(count_no == 20){
      no_semaphore = false ;
      count_no=0;
    }
  } 
}

void score_and_level_text(){
  //dibujar textos score y level
  paint_life();
  textSize(24);
  text("Level :", 40, 40);
  text(level_quads ,120 ,40);
  
  textSize(24);
  text("SCORE :", 40, 80);
  text(score,140 ,80);
}

void colour_transition_main_quad(){
   //transición cuadrado principal
  if(change_main_colour==1){     
    colour_state = colour_next ;
    colour_next = colour_next2;
    colour_next2 = get_rand_colour();
    change_main_colour = 0 ;
  }
  load_colour(colour_state); 
  rect(700, 200, 55, 55, 7);
  load_colour(colour_next);
  rect(700, 175, 20, 20, 7);
  load_colour(colour_next2);
  rect(700, 150, 20, 20, 7);
}

void paint_life(){
  
  int x= 700 , y= 40 ;
  if(life==1 )
    image(i_life1 ,x ,y);
  else if(life== 2){
    image(i_life1 , x , y );
    image(i_life2 , x +30 , y );
  }else if(life == 3 ){
    image(i_life1 , x , y );
    image(i_life2 , x +30 , y );
    image(i_life3 , x +60 , y);
  }
}

int get_rand_colour(){
  int c;
  c = int (random(5));  
  return c;
}

void load_colour(int var){
  noStroke();
  switch (var){
    case 0 :
      fill(255,0,0);  //red
      break;
    case 1 :
      fill(0,255,0);  //green
      break;
    case 2 :
      fill(0,0,255);  //blue
      break;
    case 3 :
      fill(255,164,32);  //orange
      break;
    case 4 :
      fill(255);  //white
      break;       
  } 
}

void keyPressed(){
   color c_line , c_quad;
   c_line = get(x_control, y_control);
   c_quad = get(720,220);
    
  switch (round){
    case quads :
   // get_rand_colour();
   
    c_line = get(x_control, y_control);
    c_quad = get(720,220);
    
    
    break;
    case quads_snake :
     c_line = get(x_control-200+2, y_control);
     c_quad = get(720,220);
     
    break;
  } 
    if(c_line == c_quad){
      change_main_colour= 1 ;  //permito que cambie el color del cuadrado principal
      music_win = new SoundFile(this , "win_music.mp3");
      music_win.play();
      yes_semaphore = true ;
      score++;
      wins++;  //para avanzar de nivel cuando haces 3 presiones correctas
    }else{
      life--;
      music_wrong = new SoundFile(this , "wrong_music.mp3");
      music_wrong.play(1.5);
      no_semaphore = true ;
      wins=0;
    }
    
    if(life == 0 ){
      fill(0);
      rect(600 ,40 , 24 ,24);  //para borrar la ultima vida 
      gameover = loadImage ("gameover.png");
      image(gameover , x_control-125 , y_control-300);
      music_round1.stop();
      music_over = new SoundFile(this, "musicgameover.mp3");
      music_over.play();
    
      stop();
    }
    
    //aumentamos la velocidad
    if(wins ==3 ){
       wins =0;
       level_quads++;
      if(round == quads )
         v++;
      else if (round == quads_snake )
         amp -=7;
       
       
    }
  
}