class GeneticAlgorithm {
  // Denne variabel fortæller antallet af hvor mange frames
  // den genetiske algoritme skal vente med at køre på populationen.
  // Grunden til at vi venter, er så bilerne har tid til at køre rundt
  // og have en chance, så deres fitness værdi kan udregnes retfærdigt
  final float FRAMESTOWAIT = 10000;
  final float CONSTANT = 2; // TODO: Hvad skal denne her værdi indeholde?

  GeneticAlgorithm() {
    FRAMESTOWAIT = 10000;
  }

  public void naturalSelection() {
    // Hvis der er løbet antallet af frames som FRAMESTOWAIT indeholder
    // så vil algoritmens funktionalitet køre
    if (frameCount % FRAMESTOWAIT == 0) {
      calculateFitnessValue();
    }
  }

  private void calculateFitnessValue() {
    // Vi looper igennem hver CarController og henter 3 forskellige variabler og laver fitness værdi udregningen
    for (CarController carController : carSystem.CarControllerList) {
      int clockWiseRotationFrameCounter = (int) carController.sensorSystem.clockWiseRotationFrameCounter;
      int whiteSensorFrameCount = carController.sensorSystem.whiteSensorFrameCount;
      int lapTimeInFrames = carController.sensorSystem.lapTimeInFrames;

      // Her laver vi selve udregningen af hver bils fitness værdi.
      // Denne udregning tager hensyn til alle variabler der siger noget om hvor godt bilen "performer".
      // Vi lægger 1 til i nævneren i udregningen da både whiteSensorFrameCount og lapTimeInFrames kan være 0
      // teoretisk set. Praktist set så kan de ikke
      int fitnessValue = clockWiseRotationFrameCounter / (whiteSensorFrameCount + lapTimeInFrames + 1);

      // Her  sætter vi carControllerens fitness værdi:
      carController.fitnessValue = fitnessValue;
    }
  }

  private ArrayList<CarController> matingPool() {
    ArrayList<CarController> matingPool = new ArrayList<CarController>();

    int sumOfFitnessValues;

    for (CarController carController : CarControllerList) sumOfFitnessValues += carController.fitnessValue;

    for (CarController carController : CarControllerList) {
      int numberOfClones = (carController.fitnessValue / sumOfFitnessValues) * CONSTANT;

      for (int i = 0; i < numberOfClones; i++) {
        CarController carController = (CarController) deepCopy(carController);

        matingPool.add(carController);
      }
    }

    return matingPool;
  }

  //private ArrayList<CarController> crossOver(ArrayList<CarController> matingPool) {
  //  ArrayList<CarController> newGeneration = new ArrayList<CarController>();

  //  matingPool


  //  return newGeneration;
  //}

  // deepCopy er en metode der kan kopiere et objekt fuldstændigt,
  // hvilket vi skal bruge i forbindelse med matingPool metoden
  // Vi har metoden her fra: https://www.journaldev.com/17129/java-deep-copy-object
  private Object deepCopy(Object object) {
    try {
      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
      ObjectOutputStream outputStrm = new ObjectOutputStream(outputStream);
      outputStrm.writeObject(object);
      ByteArrayInputStream inputStream = new ByteArrayInputStream(outputStream.toByteArray());
      ObjectInputStream objInputStream = new ObjectInputStream(inputStream);
      return objInputStream.readObject();
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }
}
