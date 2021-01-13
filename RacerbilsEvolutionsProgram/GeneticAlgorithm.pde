class GeneticAlgorithm {
  // Denne variabel fortæller antallet af hvor mange frames
  // den genetiske algoritme skal vente med at køre på populationen.
  // Grunden til at vi venter, er så bilerne har tid til at køre rundt
  // og have en chance, så deres fitness værdi kan udregnes retfærdigt
  final float FRAMESTOWAIT;

  GeneticAlgorithm() {
    FRAMESTOWAIT = 10000;
  }

  public void naturalSelection() {
    // Hvis der er løbet antallet af frames som FRAMESTOWAIT indeholder
    // så vil algoritmens funktionalitet køre
    if (frameCount % FRAMESTOWAIT == 0) {
      // TODO: Tilføje algoritmens funktionalitet med hensyn på private metoder der har hver deres funktionalitet
      // som så skal eksekveres her inde
    }
  }
}
