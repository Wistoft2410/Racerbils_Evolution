class GeneticAlgorithm {
  final float CONSTANT = 100; // TODO: Hvad skal denne her værdi indeholde?

  // Denne variabel fortæller antallet af hvor mange frames
  // den genetiske algoritme skal vente med at køre på populationen.
  // Grunden til at vi venter, er så bilerne har tid til at køre rundt
  // og have en chance, så deres fitness værdi kan udregnes retfærdigt

  
  public void naturalSelection() {
    // Hvis der er løbet antallet af frames som FRAMESTOWAIT indeholder
    // så vil algoritmens funktionalitet køre
    if (frameCount % FRAMESTOWAIT == 0) {
      println("Efter " + FRAMESTOWAIT + " frames har vi udviklet en ny generation!");
      calculateFitnessValue();

      carSystem.CarControllerList = mating(matingPool());
    }
  }

  private void calculateFitnessValue() {
    // Vi looper igennem hver CarController og henter 3 forskellige variabler og laver fitness værdi udregningen
    for (CarController carController : carSystem.CarControllerList) {
      int clockWiseRotationFrameCounter = (int) carController.sensorSystem.clockWiseRotationFrameCounter;
      int whiteSensorFrameCount = carController.sensorSystem.whiteSensorFrameCount;
      // Et problem med denne værdi er at den faktisk godt kan blive meget lav, ved brug af snyd.
      // Bilerne kan jo køre den modsatte vej 😑
      int lapTimeInFrames = carController.sensorSystem.lapTimeInFrames;

      // Her laver vi selve udregningen af hver bils fitness værdi.
      // Denne udregning tager hensyn til alle variabler der siger noget om hvor godt bilen "performer".
      // Vi lægger 1 til nævneren og derfor bliver vi også nødt til at lægge 1 til tælleren så det bliver pænt.
      // Grunden til at vi gør det er fordi at whiteSensorFrameCount og lapTimeInFrames kan jo være 0. Og man
      // kan jo ikke dividere med 0 så derfor lægger vi 1 for en sikkerheds skyld!
      // Vi lægger også 3x FRAMESTOWAIT til så vi sikrer os at fitnessValue aldrig kommer under 0, i løbet af en generation!
      // fitnessValue kan mindst blive 1!
      int fitnessValue = (clockWiseRotationFrameCounter + FRAMESTOWAIT * 3 + 1) / (whiteSensorFrameCount + lapTimeInFrames + 1);

      // Her sætter vi carControllerens fitness værdi:
      carController.fitnessValue = fitnessValue;
    }
  }

  private ArrayList<CarController> matingPool() {
    ArrayList<CarController> matingPool = new ArrayList<CarController>();

    int sumOfFitnessValues = 0;

    for (CarController carController : carSystem.CarControllerList) sumOfFitnessValues += carController.fitnessValue;

    for (CarController carController : carSystem.CarControllerList) {
      int numberOfClones = ceil(((float) carController.fitnessValue / (float) sumOfFitnessValues) * CONSTANT);

      for (int i = 0; i < numberOfClones; i++) matingPool.add(carController);
    }

    return matingPool;
  }

  private ArrayList<CarController> mating(ArrayList<CarController> matingPool) {
    ArrayList<CarController> newGeneration = new ArrayList<CarController>();

    for (int i = 0; i < populationSize; i++) {
      CarController parent1 = matingPool.get((int) random(matingPool.size()));
      CarController parent2 = matingPool.get((int) random(matingPool.size()));

      CarController child = crossOver(parent1, parent2);
			mutation(child);

      newGeneration.add(child);
    }

    return newGeneration;
  }

  private CarController crossOver(CarController parent1, CarController parent2) {
    CarController carController = new CarController();
    NeuralNetwork hjerne = carController.hjerne;

    // Tage første halvdel af den første forældres gener
    for (int i = 0; i < hjerne.weights.length / 2; i++) hjerne.weights[i] = parent1.hjerne.weights[i];

    // Tage anden halvdel af den anden forældres gener
    for (int i = hjerne.weights.length / 2; i < hjerne.weights.length; i++) hjerne.weights[i] = parent2.hjerne.weights[i];

    // Tage første bias fra den første forældre
    hjerne.biases[0] = parent1.hjerne.biases[0];
    // Tage gennemsnittet af forældrenes midterbias
    hjerne.biases[1] = (parent1.hjerne.biases[1] + parent2.hjerne.biases[1]) / 2;
    // Tage trejde bias fra den anden forældre
    hjerne.biases[2] = parent2.hjerne.biases[2];

    return carController;
  }

  private void mutation(CarController child) {
    // Vi ændrer alle hjernens vægte med en tilfældig værdi mellem -child.varians, og child.varians (eksklusiv).
    // Dog kun med en sandsynlighed på 1%:
    for (int i = 0; i < child.hjerne.weights.length; i++) {
      if ((int) random(1, 101) == 50) {
        child.hjerne.weights[i] = random(-child.varians, child.varians);
      }
    }

    // Vi gør præcis det samme bare for biases:
    for (int i = 0; i < child.hjerne.biases.length; i++) {
      if ((int) random(1, 101) == 50) {
        child.hjerne.biases[i] = random(-child.varians, child.varians);
      }
    }
  }
}
