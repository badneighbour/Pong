//Classe qui regroupe tous les écrans qui s'affichent dans l'application pong
public abstract class Ecran{
  public Ecran(){

  }
  //méthode appelée dans Draw qui affiche l'écran
  public abstract void afficher();
  
  //méthode appelée dans Draw qui permet d'interragir avec l'écran en vérifiant si l'utilisateur touche l'écran ou pas
  public abstract void interagir();
}
