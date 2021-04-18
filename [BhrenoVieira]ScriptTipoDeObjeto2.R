################################################################################
################################################################################
################################################################################
############                   Exercício 2                ######################
############               Tipos de Objetos               ######################
############                     2021.1                   ######################
################################################################################
################################################################################
################################################################################

### instalando e solicitando pacote ###

if(require(eeptools) == F) install.packages('eeptools'); require(eeptools)

### criando banco de dados ###

presidente <- c("Cardoso 1", "Cardoso 2", "Lula 1", "Lula 2", "Rousseff 1", 
                "Rousseff2", "Temer")

coalescencia <- c("57,05", "65,06", "52,68", "65,0", "59,62", "61,9", "63,95")

partido <- c("PSDB", "PSDB", "PT", "PT", "PT", "PT", "MDB")

## criando DataFrame

govbr <- data.frame(
  presidente = presidente, 
  coalescencia = coalescencia,
  partido = partido
   )

View(govbr)  

is.data.frame(govbr)  
  