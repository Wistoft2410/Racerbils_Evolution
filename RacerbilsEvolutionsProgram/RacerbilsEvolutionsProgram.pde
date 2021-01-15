// PopulationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer.
// Det er meget vigtigt at denne her værdi er minimum 2
int populationSize = 2;

// Denne variabel fortæller antallet af hvor mange frames
// den genetiske algoritme skal vente med at køre på populationen.
// Grunden til at vi venter, er så bilerne har tid til at køre rundt
// og have en chance, så deres fitness værdi kan udregnes retfærdigt
int FRAMESTOWAIT = 800;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem = new CarSystem(populationSize);
GeneticAlgorithm geneticAlgorithm = new GeneticAlgorithm();
//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("../images/track.png");
}

void draw() {
  clear();
  fill(255);
  rect(0,50,1000,1000);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();
  geneticAlgorithm.naturalSelection();

  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
  //if (frameCount%200==0) {
  //  println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
  //  for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
  //    SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
  //    if(s.whiteSensorFrameCount > 0){
  //      carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
  //    }
  //  }
  //}
}
