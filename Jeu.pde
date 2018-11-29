
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
    rect (w, z, 25, 86);
    fill(255);
    ellipse(x, y, 20, 20);
    line(width/2, 0, width/2, height);
    stroke(153);
  }



  void bouger() {
    x=x+deplacementX;
    y=y+deplacementY;

    z=(mouseY);
  }

  void rebondir() {
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

  int decompte;

  public Compte_a_rebours() {
    super();
    decompte=3+millis()/1000;
  }
  void dessiner() {
    smooth();
    ellipseMode(CENTER);

    fill(255);
    rect (w, z, 25, 86);
    fill(255);

    line(width/2, 0, width/2, height);
  }

  void c_a_r() {

    if (temps == decompte ) {
      m=new Jeu();
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
    scoreJeu=0;
    x=width/2;
    y=height/2;
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
    if (touches.length==0){
      
    } 
    else if (touches.length==1){
    z=(touches[0].y);
    }
    else if (touches[0].x<touches[1].x) {
      z=(touches[0].y);
      z2=(touches[1].y);
    } else  {
      z=(touches[1].y);
      z2=(touches[0].y);
    }
  }

  //Permet de dessiner la balle les plateaux et la ligne centrale
  void dessiner() {
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
