package processing.test.pong;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ketai.ui.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pong extends PApplet {

PApplet papplet = this;
int[] couleurs = {color(0, 0, 0), color(230, 190, 0)}; // contient la couleur de premier plan et la couleur de fond
float[] dimBouton = new float[4]; //contient les largeurs et les hauteurs exterieures et interieures d'un bouton de menu
String[] scores = {"0", "0", "0", "0", "0", "-", "-", "-", "-", "-"}; //contient les 5 meilleurs scores puis leur joueur
int vitesse = 10;
Ecran m = new MenuDepart();
float deplacementX;
float deplacementY;
float x; //position de la balle
float y;
float w; // position du plateau du joueur 1 sur l'axe x
float z;// position du plateau du joueur 1 sur l'axe y
float w2;// position du plateau du joueur 2 sur l'axe x
float z2;// position du plateau du joueur 2 sur l'axe y
int scoreJeu;
int temps;
String pseudo;

// paramètres
float vitessedepX;
float vitessedepY;
float vitesseraquette;
float tailleraquette;
float incrementationballe;

public void setup() {
  
  dimBouton[0] = width/1.5f;
  dimBouton[1] = height/4.5f;
  dimBouton[2] = dimBouton[0] * 0.96f;
  dimBouton[3] = dimBouton[1] * 0.9f;
  x=width/2;
  y=height/2;
  deplacementX=6;
  deplacementY=3;
  w=15;
  w2=width-15;
  z=60;
  z2=60;
  scoreJeu=0;
  temps = millis();
  // paramètres
  vitessedepX= 6;
  vitessedepY= 3;
  vitesseraquette = 8;
  tailleraquette=50;
  incrementationballe =1.05f;

  BufferedReader reader = createReader("scores");
  try {
    for (int i = 0; i<10; i++) {
      scores[i] = reader.readLine();
    }
  }
  catch(IOException e) {
    vitesse = 10;
  }
  background(couleurs[1]);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(sqrt(width*height)/15);
} 


public void draw() {
  m.afficher();
  m.interagir();
}
//Classe qui regroupe tous les écrans qui s'affichent dans l'application pong
public abstract class Ecran{
  public Ecran(){

  }
  //méthode appelée dans Draw qui affiche l'écran
  public abstract void afficher();
  
  //méthode appelée dans Draw qui permet d'interragir avec l'écran en vérifiant si l'utilisateur touche l'écran ou pas
  public abstract void interagir();
}

// classe du jeu 1 joueur
public class Jeu extends Ecran {




  /**
   *constructeur de Jeu
   */
  public Jeu () {
    super(); 
    scoreJeu=0;
    x=width/2;
    y=height/2;
    deplacementX=vitessedepX;
    deplacementY=-vitessedepY;
  }


  public void  afficher () {
    nettoyer();
    bouger();
    rebondir();
    dessiner();
  }

  public void interagir() {
  }
  /**
   *permet d'effacer ce qui a été afficher avant de réafficher
   */
  public void nettoyer() {
    background(0);
  }

  public void dessiner() {
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 2*tailleraquette);
    fill(255);
    ellipse(x, y, 20, 20);
    line(width/2, 0, width/2, height);
    stroke(153);
  }



  public void bouger() {
    x=x+deplacementX;
    y=y+deplacementY;
    if (touches.length==0) {
    } else if (touches.length==1) {
      if (touches[0].y<=z-vitesseraquette) {
        z=z-vitesseraquette;
      } else if (touches[0].y>=z+vitesseraquette) {
        z=z+vitesseraquette;
      }
    }
  }

  public void rebondir() {
    //trop a droite et deplacement horizontal positif
    if (x> width-10 && deplacementX>0)
    {
      deplacementX=-deplacementX;
      deplacementX=deplacementX*incrementationballe;
      deplacementY=deplacementY*incrementationballe;
      deplacementY = deplacementY + random(-1, 1);
    }

    // si on est trop haut
    if (y<10 && deplacementY<0)
    {
      deplacementY=-deplacementY;
      deplacementY = deplacementY + random(-1, 1);
    }

    //si on est trop bas
    if (y>height-10 && deplacementY>0)
    {
      deplacementY=-deplacementY;
      deplacementY = deplacementY + random(-1, 1);
    }

    // quand on touche le plateau
    if ( x-10 < w+25 && (y > z-tailleraquette && y< z+tailleraquette))
    {
      deplacementX=-deplacementX;
      scoreJeu+=1;
      deplacementY = deplacementY + random(-1, 1);
    }

    //si on depasse le plateau
    if (x<10) {
      m=new GameOver();
    }
  }
}


// classe permettant d'afficher le game over
public class GameOver extends Ecran {
  public GameOver() {
    super();
  }
  public void afficher() {
    text("Game Over, votre score est de :"+scoreJeu, width/2, height/2);
  };
  public void interagir() {
    if (mousePressed) {
      m=new EnregistrementScore();
    }
  };
}

// classe pour le compte à rebours

public class Compte_a_rebours extends Ecran {
  int modesuivant;

  int decompte;

  public Compte_a_rebours(int mode) {
    super();
    decompte=3+millis()/1000;
    modesuivant = mode;  }
  public void dessiner() {
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 86);
    fill(255);

    line(width/2, 0, width/2, height);
    if (modesuivant==2){
    fill(255);
    rect(w2, z2, 25, 86);}
  }

  public void c_a_r() {

    if (temps == decompte ) {
      if(modesuivant==1){
      m=new Jeu();}
      else{m=new JeuDeux();}
    } else {
      temps=millis()/1000;
    };
  }
  public void interagir() {
  }
  public void nettoyer() {
    background(0);
  }

  public void afficher() {
    nettoyer();
    dessiner();
    c_a_r();
    text((decompte-temps), width/2, height/2);
  }
}

public class JeuDeux extends Ecran {
  public JeuDeux () {
    super(); 
    scoreJeu=0;
    x=width/2;
    y=height/2;
    deplacementX=vitessedepX;
    deplacementY=-vitessedepY;
  }

  public void interagir() {
  }
  public void  afficher () {
    nettoyer();
    bouger();
    rebondir();
    dessiner();
  }

  /**
   *permet d'effacer ce qui a été afficher avant de réafficher
   */
  public void nettoyer() {
    background(0);
  }

  //permet de déplacer la balle et les plateaux
  public void bouger() {
    x=x+deplacementX;
    y=y+deplacementY;
    if (touches.length==0) {
    } else if (touches.length==1) {
      if (touches[0].x <=width/2) {
        if (touches[0].y<=z-5) {
          z=z-5;
        } else if (touches[0].y>=z+5) {
          z=z+5;
        }
      } else {
        if (touches[0].y<=z2-5) {
          z2=z2-5;
        } else if (touches[0].y>=z2+5) {
          z2=z2+5;
        }
      }
    } else if (touches[0].x<touches[1].x) {
      if (touches[0].y<=z-5) {
        z=z-5;
      } else if (touches[0].y>=z+5) {
        z=z+5;
      }
      if (touches[1].y<=z2-5) {
        z2=z2-5;
      } else if (touches[1].y>=z2+5) {
        z2=z2+5;
      }
    } else {
      if (touches[1].y<=z-5) {
        z=z-5;
      } else if (touches[1].y>=z+5) {
        z=z+5;
      }
      if (touches[0].y<=z2-5) {
        z2=z2-5;
      } else if (touches[0].y>=z2+5) {
        z2=z2+5;
      }
    }
  }

  //Permet de dessiner la balle les plateaux et la ligne centrale
  public void dessiner() {
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 86);
    fill(255);
    rect(w2, z2, 25, 86);
    fill(255);
    ellipse(x, y, 20, 20);
    line(width/2, 0, width/2, height);
    stroke(153);
  }

  public void rebondir() {



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

    // quand on touche le plateau du joueur 1
    if ( x-10 < w+25 && (y > z-43 && y< z+43))
    {
      deplacementX=-deplacementX;
      scoreJeu++;
    }
    //quand on touche le plateau du joueur 2
    if ( x+10 > w2-25 && (y > z2-43 && y< z2+43))
    {
      deplacementX=-deplacementX;
      scoreJeu++;
    }
    //si on depasse le plateau
    if (x<=0 || x>= width) {
      m=new GameOver();
    }
  }
}

//La classe Menu représente les menus qui s'affichent à l'écran avant d'entrer dans le jeu
public abstract class Menu extends Ecran {

  private int compteur; //utile pour laisser quelques images avant de changer de menu lors d'un clique, comme on a une fréquence de rafraichissement égale à 60Hz
  protected boolean mouseHasBeenPressed; //de même que pour compteur, permet de vérifier si un bouton a déjà été cliqué une demi seconde avant

  public Menu() {
    super();
    compteur = round(frameRate/6);
    mouseHasBeenPressed = true;
  }

  public void interagir() {
    if (compteur > 0) {
      compteur--;
      background(couleurs[1]);
    } else if (!mousePressed) {
      mouseHasBeenPressed = false;
    }
  }
  //méthode qui affiche les boutons du menus sous forme de rectangle contenant le message avec i indiquant que c'est soit le bouton du haut, soit le bouton du milieu, soit celui du bas 
  public void afficheBouton(int numeroBouton, String message) {
    fill(couleurs[0]);
    rect(width/2, numeroBouton*height/4, dimBouton[0], dimBouton[1], 10);
    fill(couleurs[1]);
    rect(width/2, numeroBouton*height/4, dimBouton[2], dimBouton[3], 10);
    fill(couleurs[0]);
    text(message, width/2, numeroBouton*height/4, dimBouton[2], dimBouton[3]);
  }
  //méthode qui regarde lorsqu'il y a un clique si celui-ci se situe sur le bouton  numéro "numéroBouton" et renvoie vrai si c'est le cas 
  public boolean cliqueBouton(int numeroBouton) {
    boolean boutonX = (width-dimBouton[0]<2*mouseX) && (2*mouseX<width+dimBouton[0]);
    boolean boutonY = (numeroBouton*height/2-dimBouton[1]<2*mouseY) && (2*mouseY<numeroBouton*height/2+dimBouton[1]);
    if (boutonX && boutonY) {
      background(couleurs[1]);
    }
    return (boutonX && boutonY);
  }
}
//menu de départ qui renvoie vers le choix du mode de jeu, le menu affichant les scores ou le menu des paramètres
public class MenuDepart extends Menu {
  public MenuDepart() {
    super();
  }

  public void afficher() {

    super.afficheBouton(1, "Jouer");
    super.afficheBouton(2, "Options");
    super.afficheBouton(3, "Scores");
  }

  public void interagir() {
    if (mousePressed && !mouseHasBeenPressed) {
      if (super.cliqueBouton(1)) {
        m = new MenuModesDeJeu();
      } else if (super.cliqueBouton(2)) {
        m =  new MenuOptions();
      } else if (super.cliqueBouton(3)) {
        m = new MenuScores();
      }
    }
    super.interagir();
  }
}
//Menu qui affiche les scores et qui possède un seul bouton qui renvoie au menu de départ
public class MenuScores extends Menu {
  public MenuScores() {
    super();
  }

  public void afficher() {
    super.afficheBouton(3, "Retour");
    for (int i = 0; i<5; i++) {
      text(scores[i], (2*width-dimBouton[2])/4, (i+1)*height/10);
      text(scores[i+5], (2*width+dimBouton[2])/4, (i+1)*height/10);
    }
  }

  public void interagir() {
    if (mousePressed && !mouseHasBeenPressed) {
      if (super.cliqueBouton(3)) {
        m = new MenuDepart();
      }
    }
    super.interagir();
  }
}
//Menu qui gère les paramètres. En cours de construction.
public class MenuOptions extends Menu {
  public void afficher() {
    super.afficheBouton(1, "Difficulte");
    super.afficheBouton(2, "Reinitialiser les scores");
    super.afficheBouton(3, "Retour");
  }
  //Méthode qui permet de réinitialiser les scores dans la session de jeu actuelle et aussi dans le fichier de sauvegarde pour les sessions suivantes
  public void reinitialiserScores() {
    PrintWriter output = createWriter("scores");
    for (int i = 0; i < 5; i++) {
      scores[i] = "0";
      output.println("0");
    }
    for (int i = 0; i < 5; i++) {
      scores[i+5] = "-";
      output.println("-");
    }
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
  }

  public void interagir() {
    if (mousePressed && !mouseHasBeenPressed) {
      if (super.cliqueBouton(3)) {
        m = new MenuDepart();
      }
      if (super.cliqueBouton(2)) {
        this.reinitialiserScores();
      }
      if (super.cliqueBouton(1)){m=new MenuDifficulte();}
    }
    super.interagir();
  }



//
public class MenuDifficulte extends Menu{
  public void afficher() {

    super.afficheBouton(1, "Facile");
    super.afficheBouton(2, "Moyen");
    super.afficheBouton(3, "Difficile");
  }
  
  public void interagir(){
    if (mousePressed && !mouseHasBeenPressed) {
      if (super.cliqueBouton(1)) {
          vitessedepX= 4;
          vitessedepY= 2;
          vitesseraquette = 10;
          tailleraquette=60;
          incrementationballe =1.05f;
          m = new MenuDepart();
      }
      if (super.cliqueBouton(2)) {
          vitessedepX= 6;
          vitessedepY= 3;
          vitesseraquette = 8;
          tailleraquette=50;
          incrementationballe =1.1f;
          m = new MenuDepart();
      }
      if (super.cliqueBouton(3)){
          vitessedepX= 8;
          vitessedepY= 4;
          vitesseraquette = 5;
          tailleraquette=45;
          incrementationballe =1.15f;
          m = new MenuDepart();
    }
    }
    super.interagir();
  }

  
  }
  

}


//Menu qui permet au joueur de choisir le mode de jeu. En construction ...
public class MenuModesDeJeu extends Menu {
  public void afficher() {

    super.afficheBouton(1, "Un Joueur");
    super.afficheBouton(2, "Deux Joueurs");
    super.afficheBouton(3, "Retour");
  }

  public void interagir() {
    if (mousePressed && !mouseHasBeenPressed) {
      if (super.cliqueBouton(3)) {
        m = new MenuDepart();
      } else if (super.cliqueBouton(1)) {
        m = new Compte_a_rebours(1);
      }
      else if (super.cliqueBouton(2)){
      m = new Compte_a_rebours(2);
      }
    }
    super.interagir();
  }
}

//Ecran qui sert à enregistrer le score si besoin 
public class EnregistrementScore extends Ecran {
  
  public EnregistrementScore() {
    super();
    pseudo = "";
    KetaiKeyboard.toggle(papplet);
  }
  public void afficher() {
    background(couleurs[1]);
    text(pseudo, width/2, height/4, dimBouton[2], dimBouton[3]);
  }

  public void interagir() {
    
  }
}

public void keyPressed() {
  Character touche = (Character) key;
    /*if ((key <= 'a' && key >= 'z') ||(key >= '0' && key <= '9'))
      pseudo += key;
    else if(key == BACKSPACE)
      pseudo = pseudo.substring(0, pseudo.length() - 1);
    else if(key == ENTER || key == RETURN)
      m = new MenuDepart();*/
    text(touche.toString(), width/2, height/4, dimBouton[2], dimBouton[3]);
}
  public void settings() {  fullScreen(); }
}
