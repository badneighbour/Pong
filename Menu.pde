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
      text(scores[i], (2*width+dimBouton[2])/4, (i+1)*height/10);
    }
    text("1er", (2*width-dimBouton[2])/4, height/10);
    text("2e",(2*width-dimBouton[2])/4, 2*height/10);
    text("3e",(2*width-dimBouton[2])/4, 3*height/10);
    text("4e",(2*width-dimBouton[2])/4, 4*height/10);
    text("5e",(2*width-dimBouton[2])/4, 5*height/10);
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
      if (super.cliqueBouton(1)) {
        m=new MenuDifficulte();
      }
    }
    super.interagir();
  }



  //
  public class MenuDifficulte extends Menu {
    public void afficher() {

      super.afficheBouton(1, "Facile");
      super.afficheBouton(2, "Moyen");
      super.afficheBouton(3, "Difficile");
    }

    public void interagir() {
      if (mousePressed && !mouseHasBeenPressed) {
        if (super.cliqueBouton(1)) {
          vitessedepX= 4;
          vitessedepY= 2;
          vitesseraquette = 10;
          tailleraquette=60;
          incrementationballe =1.05;
          m = new MenuDepart();
        }
        if (super.cliqueBouton(2)) {
          vitessedepX= 6;
          vitessedepY= 3;
          vitesseraquette = 8;
          tailleraquette=50;
          incrementationballe =1.1;
          m = new MenuDepart();
        }
        if (super.cliqueBouton(3)) {
          vitessedepX= 8;
          vitessedepY= 4;
          vitesseraquette = 5;
          tailleraquette=45;
          incrementationballe =1.15;
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
      } else if (super.cliqueBouton(2)) {
        m = new Compte_a_rebours(2);
      }
    }
    super.interagir();
  }
}
