import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;


class GeneticAlgorithm {
  final int CONSTANT = 2; // TODO: Hvad skal denne her værdi indeholde?

  // Denne variabel fortæller antallet af hvor mange frames
  // den genetiske algoritme skal vente med at køre på populationen.
  // Grunden til at vi venter, er så bilerne har tid til at køre rundt
  // og have en chance, så deres fitness værdi kan udregnes retfærdigt
  final float FRAMESTOWAIT = 10000;

  
  public void naturalSelection() {
    // Hvis der er løbet antallet af frames som FRAMESTOWAIT indeholder
    // så vil algoritmens funktionalitet køre
    if (frameCount % FRAMESTOWAIT == 0) {
      calculateFitnessValue();

      carSystem.CarControllerList = mating(matingPool());
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

    int sumOfFitnessValues = 0;

    for (CarController carController : carSystem.CarControllerList) sumOfFitnessValues += carController.fitnessValue;

    for (CarController carController : carSystem.CarControllerList) {
      int numberOfClones = (carController.fitnessValue / sumOfFitnessValues) * CONSTANT;

      for (int i = 0; i < numberOfClones; i++) {
        carController = (CarController) deepCopy(carController);

        matingPool.add(carController);
      }
    }

    return matingPool;
  }

  private ArrayList<CarController> mating(ArrayList<CarController> matingPool) {
    ArrayList<CarController> newGeneration = new ArrayList<CarController>();

    for (int i = 0; i < populationSize; i++) {
      // Find to tilfældige forældre fra mating poolen:
      CarController parent1 = matingPool.get((int) random(matingPool.size()));
      CarController parent2 = matingPool.get((int) random(matingPool.size()));

      // TODO: Lav crossover og mutations metoderne
      //CarController child = crossOver(parent1, parent2);
			//child = mutation(child);

      //newGeneration.add(child);
    }

    return newGeneration;
  }

  // TODO: Her skal selve cross over funktionaliteten foregå:

  //private CarController crossOver(CarController parent1, CarController parent2) {
  //}


  // TODO: Her skal selve mutations funktionaliteten foregå:

  //private CarController mutation(CarController child) {
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
