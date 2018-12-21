color[] couleurs = {color(0, 0, 0), color(230, 190, 0)}; // contient la couleur de premier plan et la couleur de fond
float[] dimBouton = new float[4]; //contient les largeurs et les hauteurs exterieures et interieures d'un bouton de menu
int[] scores = {0, 0, 0, 0, 0}; //contient les 5 meilleurs scores puis leur joueur
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
int scoreJ1;
int scoreJ2;
int nombrePoint;

// paramètres
float vitessedepX;
float vitessedepY;
float vitesseraquette;
float tailleraquette;
float incrementationballe;

void setup() {
  fullScreen();
  orientation(LANDSCAPE);
  dimBouton[0] = width/1.5;
  dimBouton[1] = height/4.5;
  dimBouton[2] = dimBouton[0] * 0.96;
  dimBouton[3] = dimBouton[1] * 0.9;
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
  scoreJ1=0;
  scoreJ2=0;
  nombrePoint=5;
  // paramètres
  vitessedepX= 6;
  vitessedepY= 3;
  vitesseraquette = 8;
  tailleraquette=50;
  incrementationballe =1.05;

  BufferedReader reader = createReader("scores");
  try {
    for (int i = 0; i<5; i++) {
      scores[i] = parseInt(reader.readLine());
    }
  }
  catch(Exception e) {
    vitesse = 10;
  }
  background(couleurs[1]);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(sqrt(width*height)/15);
} 


void draw() {
  m.afficher();
  m.interagir();
}
