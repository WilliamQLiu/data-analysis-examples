
DATASET ACTIVATE DataSet2.
GLM beerpos beerneg beerneut winepos wineneg wineneut waterpos waterneg waterneut
  /WSFACTOR=Drink 3  Imagery 3 
 /EMMEANS = TABLES(Drink*Imagery) COMPARE(Imagery).


