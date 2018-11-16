public class Jeu extends Ecran{
  

boolean gameOver;
public Jeu (){super(); 
              scoreJeu=0;
              gameOver=false;
              x=width/2;
              y=height/2;
           }


public void  afficher (){
nettoyer();
bouger();
rebondir();
dessiner();
}

public void interagir(){
 
  
}

void nettoyer(){
  background(0);
}

void dessiner(){
smooth();
ellipseMode(CENTER);

fill(255);
rect (w,z,25,86);
fill(255);
ellipse(x,y,20,20);
line(200,0,200,400);
}

void bouger(){
x=x+deplacementX;
y=y+deplacementY;

z=(mouseY);
}

void rebondir(){
//trop a droite et deplacement horizontal positif
if (x> width-10 && deplacementX>0)
{
deplacementX=-deplacementX;

}

// si on est trop haut
if (y<10 && deplacementY<0)
{
 deplacementY=-deplacementY; 
}

//si on est trop bas
if (y>height-10 && deplacementY>0)
{
 deplacementY=-deplacementY; 
}

// quand on touche le plateau
if ( x-10 < w+25 && (y > z-43 && y< z+43))
{
  deplacementX=-deplacementX;
  scoreJeu+=1;
}

//si on depasse le plateau
if (x<10){
  m=new GameOver();
  
  
}
}
}

public class GameOver extends Ecran{
public GameOver(){super();}
public void afficher(){text("Game Over, votre score est de :"+scoreJeu,width/2,height/2);};
public void interagir(){if (mousePressed){
m=new MenuDepart();
}
};
}
