color[] couleurs = {color(0, 0, 0), color(230, 190, 0)}; // contient la couleur de premier plan et la couleur de fond
float[] dimBouton = new float[4]; //contient les largeurs et les hauteurs exterieures et interieures d'un bouton de menu
String[] scores = {"0", "0", "0", "0", "0", "-", "-", "-", "-", "-"}; //contient les 5 meilleurs scores puis leur joueur
int vitesse = 10;
Ecran m = new MenuDepart();
int deplacementX;
int deplacementY;
int x; //position de la balle
int y;
float w; // position du plateau du joueur 1 sur l'axe x
float z;// position du plateau du joueur 1 sur l'axe y
float w2;// position du plateau du joueur 2 sur l'axe x
float z2;// position du plateau du joueur 2 sur l'axe y
int scoreJeu;
int temps;

void setup(){
  fullScreen();
  dimBouton[0] = width/1.5;
  dimBouton[1] = height/4.5;
  dimBouton[2] = dimBouton[0] * 0.96;
  dimBouton[3] = dimBouton[1] * 0.9;
  x=width/2;
  y=height/2;
  deplacementX=6;
  deplacementY=-3;
  w=15;
  w2=width-15;
  z=60;
  z2=60;
  scoreJeu=0;
  temps = millis();
  BufferedReader reader = createReader("scores");
  try{
    for(int i = 0; i<10; i++){
        scores[i] = reader.readLine();
      }
    }
  catch(IOException e){
    vitesse = 10;
  }
  background(couleurs[1]);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(sqrt(width*height)/15);
} 


void draw(){
  m.afficher();
  m.interagir();
}
