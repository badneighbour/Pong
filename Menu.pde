public abstract class Menu extends Ecran{
  
  private int compteur;
  protected boolean mouseHasBeenPressed;
  
  public Menu(){
    super();
    compteur = round(frameRate/6);
    mouseHasBeenPressed = true;
  }
  
  public void interagir(){
    if(compteur > 0){
      compteur--;
      background(couleurs[1]);
    }
    else if(!mousePressed){
      mouseHasBeenPressed = false;
    }
  }
  
  public void afficheBouton(int numeroBouton, String message){
    fill(couleurs[0]);
    rect(width/2, numeroBouton*height/4, dimBouton[0], dimBouton[1], 10);
    fill(couleurs[1]);
    rect(width/2, numeroBouton*height/4, dimBouton[2], dimBouton[3], 10);
    fill(couleurs[0]);
    text(message, width/2, numeroBouton*height/4, dimBouton[2], dimBouton[3]);
  }
  
  public boolean cliqueBouton(int numeroBouton){
    boolean boutonX = (width-dimBouton[0]<2*mouseX) && (2*mouseX<width+dimBouton[0]);
    boolean boutonY = (numeroBouton*height/2-dimBouton[1]<2*mouseY) && (2*mouseY<numeroBouton*height/2+dimBouton[1]);
    if(boutonX && boutonY){
      background(couleurs[1]);
    }
    return (boutonX && boutonY);
  }
}

public class MenuDepart extends Menu{
  public MenuDepart(){
    super();
  }
  
  public void afficher(){
    
    super.afficheBouton(1, "Jouer");
    super.afficheBouton(2, "Options");
    super.afficheBouton(3, "Scores");
  }
  
  public void interagir(){
    if(mousePressed && !mouseHasBeenPressed){
      if(super.cliqueBouton(1)){
        m = new MenuModesDeJeu();
      }
      else if(super.cliqueBouton(2)){
        m =  new MenuOptions();
      }
      else if(super.cliqueBouton(3)){
        m = new MenuScores();
      }
    }
    super.interagir();
  }  
}

public class MenuScores extends Menu{
  public MenuScores(){
    super();
  }
  
  public void afficher(){
    super.afficheBouton(3, "Retour");
    for(int i = 0; i<5; i++){
      text(scores[i], (2*width-dimBouton[2])/4, (i+1)*height/10);
      text(scores[i+5], (2*width+dimBouton[2])/4, (i+1)*height/10);
    }
  }
  
  public void interagir(){
    if(mousePressed && !mouseHasBeenPressed){
      if(super.cliqueBouton(3)){
        m = new MenuDepart();
      }
    }
    super.interagir();
  }

}

public class MenuOptions extends Menu{
    public void afficher(){
    
    super.afficheBouton(1, "Vitesse");
    super.afficheBouton(2, "Réinitialiser les scores");
    super.afficheBouton(3, "Retour");
  }
  
  public void reinitialiserScores(){
    PrintWriter output = createWriter("scores");
    for(int i = 0; i < 5; i++){
      scores[i] = "0";
      output.println("0");
    }
    for(int i = 0; i < 5; i++){
      scores[i+5] = "-";
      output.println("-");
    }
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
  }
  
  public void interagir(){
    if(mousePressed && !mouseHasBeenPressed){
      if(super.cliqueBouton(3)){
        m = new MenuDepart();
      }
      if(super.cliqueBouton(2)){
        this.reinitialiserScores();
      }
    }
    super.interagir();
  }
}

public class MenuModesDeJeu extends Menu{
  public void afficher(){
    
    super.afficheBouton(1, "Un Joueur");
    super.afficheBouton(2, "Deux Joueurs");
    super.afficheBouton(3, "Retour");
  }
  
  public void interagir(){
    if(mousePressed && !mouseHasBeenPressed){
      if(super.cliqueBouton(3)){
        m = new MenuDepart();
      }
      else if (super.cliqueBouton(1)){
      m = new Jeu();}
    }
    super.interagir();
  }
}
