
// classe du jeu 1 joueur
public class Jeu extends Ecran {




  /**
   *constructeur de Jeu
   */
  public Jeu () {
    super(); 
    
    x=width/2;
    y=height/2;
    deplacementX=vitessedepX;
    deplacementY=-vitessedepY;
    scoreJeu=0;
    
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
  void nettoyer() {
    background(0);
  }

  void dessiner() {
    
    smooth();
    ellipseMode(CENTER);
    fill(255);
    text(scoreJeu,width/2, height/10);
    rect (w, z, 25, 2*tailleraquette);
    ellipse(x, y, 20, 20);
    line(width/2, 0, width/2, height);
    stroke(153);
    
  }



  void bouger() {
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

  void rebondir() {
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
      m=new MenuDepart();
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
    modesuivant = mode;
  }
  void dessiner() {
   if (modesuivant==2){
        text(scoreJ1,width/2-width/10, height/10);
        text(scoreJ2,width/2+width/10, height/10);}
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 2*tailleraquette);
    fill(255);

    line(width/2, 0, width/2, height);
    if (modesuivant==2) {
      fill(255);
      rect(w2, z2, 25, 2*tailleraquette);
      
    }
  }

  void c_a_r() {

    if (temps == decompte ) {
      if (modesuivant==1) {
        m=new Jeu();
      } else {
        m=new JeuDeux();
      }
    } else {
      temps=millis()/1000;
    };
  }
  void interagir() {
  }
  void nettoyer() {
    background(0);
  }

  void afficher() {
    nettoyer();
    dessiner();
    c_a_r();
    text((decompte-temps), width/2, height/2);
  }
}

public class JeuDeux extends Ecran {
  public JeuDeux () {
    super(); 
    
    x=width/2;
    y=height/2;
    float p= random(1);
    if (p>0.5) {deplacementX=-vitessedepX ;} else {deplacementX=vitessedepX ;}
    float r= random(1);
    if (r>0.5) {deplacementY=-vitessedepY ;} else {deplacementY=vitessedepY ;}
    
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
  void nettoyer() {
    background(0);
  }

  //permet de déplacer la balle et les plateaux
  void bouger() {
    x=x+deplacementX;
    y=y+deplacementY;
    if (touches.length==0) {
    } else if (touches.length==1) {
      if (touches[0].x <=width/2) {
        if (touches[0].y<=z-vitesseraquette) {
          z=z-vitesseraquette;
        } else if (touches[0].y>=z+vitesseraquette) {
          z=z+vitesseraquette;
        }
      } else {
        if (touches[0].y<=z2-vitesseraquette) {
          z2=z2-vitesseraquette;
        } else if (touches[0].y>=z2+vitesseraquette) {
          z2=z2+vitesseraquette;
        }
      }
    } else if (touches[0].x<touches[1].x) {
      if (touches[0].y<=z-vitesseraquette) {
        z=z-vitesseraquette;
      } else if (touches[0].y>=z+vitesseraquette) {
        z=z+vitesseraquette;
      }
      if (touches[1].y<=z2-vitesseraquette) {
        z2=z2-vitesseraquette;
      } else if (touches[1].y>=z2+vitesseraquette) {
        z2=z2+vitesseraquette;
      }
    } else {
      if (touches[1].y<=z-vitesseraquette) {
        z=z-vitesseraquette;
      } else if (touches[1].y>=z+vitesseraquette) {
        z=z+vitesseraquette;
      }
      if (touches[0].y<=z2-vitesseraquette) {
        z2=z2-vitesseraquette;
      } else if (touches[0].y>=z2+vitesseraquette) {
        z2=z2+vitesseraquette;
      }
    }
  }

  //Permet de dessiner la balle les plateaux et la ligne centrale
  void dessiner() {
    text(scoreJ1,width/2-width/10, height/10);
    text(scoreJ2,width/2+width/10, height/10);
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 2*tailleraquette);
    rect(w2, z2, 25, 2*tailleraquette);
    ellipse(x, y, 20, 20);
    line(width/2, 0, width/2, height);
    stroke(153);
    
  }

  void rebondir() {



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
    if ( x-10 < w+25 && (y > z-tailleraquette && y< z+tailleraquette))
    {
      deplacementX=-deplacementX;
      deplacementX=deplacementX*incrementationballe;
      deplacementY=deplacementY*incrementationballe;
      deplacementY = deplacementY + random(-1, 1);
    }
    //quand on touche le plateau du joueur 2
    if ( x+10 > w2-25 && (y > z2-tailleraquette && y< z2+tailleraquette))
    {
      deplacementX=-deplacementX;
      deplacementX=deplacementX*incrementationballe;
      deplacementY=deplacementY*incrementationballe;
      deplacementY = deplacementY + random(-1, 1);
      
    }
    //si on depasse le plateau
    if (x<=0){scoreJ2++;if (scoreJ2<nombrePoint){
    m = new Compte_a_rebours(2);}
  else {m = new GameOver();}}
    if (x>width){scoreJ1++;if (scoreJ1<nombrePoint){
    m = new Compte_a_rebours(2);}
  else {m = new GameOver();}}
    
  }
}
