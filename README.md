# Attack plan - Stepwise 
### Givet information
Hvor mange individer der er tilbage efter at ArrayList<Car> bliver reduceret pr. 200 frame
int lapTimeinFrames


### Manglende information





### Muligheder
Time individernes lap og derfra oprette et nyt “fit” arraylist med dem. Organiseret kronologisk efter deres lap times 

### Fitness value

Følgende udregning anvendes til at beregne hvert individs fitness værdi:

clockWiseRotationFrameCounterwhiteSensorFrameCount + lapTimeInFrames + 1=Fitness value

Det smarte med den her udregning er, at den tager hver variabel der har noget at gøre med hvor godt individet præsterer i betragtning og udregner en samlet værdi ud fra det. Altså, er der tre variabler, som hver især siger noget om bilens performance og dem bruger vi alle sammen.

Grunden til at clockWiseRotationFrameCounter er i tælleren er fordi at jo højere den variabel er jo bedre. Og grunden til at whiteSensorFrameCount og lapTimeInFrames er i nævneren er fordi, jo lavere værdien er for de variabler, desto bedre. Så brøken/udregningen tager hensyn for henholdsvis jo større værdien er, og jo lavere værdien er for variablerne og beregner en optimeret fitness værdi.

Vi lægger også 1 til i nævneren da whiteSensorFrameCount og lapTimeInFrames teoretisk set godt kan være 0 og man kan jo ikke dividere med 0. Praktisk set vil variablerne nok ikke ramme 0.

Det skal dog lige siges at clockWiseRotationFrameCounter er et navn der ikke passer godt til hvad variablen bruges til. Den burde hedde counterClockWiseRotationFrameCounter. Ellers så bør funktionaliteten ændres til hvad variablen siger den er!

### Mating pool
Vi ganger med et tal der giver et pænt antal af forældre der skal tilføjes til mating poolen. Selve tallet vi vil gange med kan vi ikke definere endnu da vi ikke har kendskab til nævneren (summen af alle lap times).

Den måde vi udregner antallet af et specifik individ der skal tilføjes i mating poolen er følgende:

Fitness valuei(Fitness value1+ Fitness value2+ Fitness value3 ... + Fitness valuen)*K =antallet af individer

Som sagt ved vi ikke hvad k skal være endnu da det er noget vi skal lege med når vi udvikler programmet.

antallet af individerbestemmer hvor mange gange det individ skal klones/tilføjes til mating poolen. Jo større antallet af individerjo større er sandsynligheden for at de bliver valgt som forældre til og få et “godt” afkom.

### Crossover (To forældre)
Vi vælger to tilfældige forældre for mating poolen og parrer dem så de får et afkom. Det skal gøres flere gange indtil der er det samme antal af afkom som der var i generationen for før!

Vægtene skal blandes. Det hentes fra de neurale netværk, som hvert individ har.
Der i alt 8 vægte og 3 biases per individ.
Lige nu koncentrerer vi os kun om at blande vægtene.

Den måde de skal blandes på er ved at tage halvdelen af fra den ene forældre og halvdelen fra den anden forældre.

### Mutation

Mutationen skal være hvor vi vælger en tilfældig vægt som vi justerer en smule på, det gør vi med en 1% sandsynlighed. Grunden til at vi har mutation med er så vi kan tilføje noget variation i de gener/vægte vi arbejder med, så det ikke hele tiden er de samme gener/vægte der bliver givet videre til næste generation.

Hvordan virker det så?

Bare have programmet kørende i lang nok tid til at du ser en forskel eller en tendens af bilerne! Det tager nok ca. 20 minutter eller sådan noget.

BARE VENT!

Prøv at gætte hvorfor alle bilerne er i en stor bunke ved den grønne streg 🤨
