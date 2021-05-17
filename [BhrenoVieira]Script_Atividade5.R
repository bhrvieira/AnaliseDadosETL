################################################################################
################################################################################
################################################################################
##################            Atividade 5                   ####################
##################                ETL                       ####################
##################             2021.1                       ####################
################################################################################
################################################################################
################################################################################

#### Criando banco de dados #####

setwd("C:/Users/Win10/Documents/GitHub/AnaliseDadosETL/AnaliseDadosETL/AnaliseDadosETL")


library(data.table)

casos= 9e6

largeData1 = data.table(a=rpois(casos, 3),
                        b=rbinom(casos, 1, 0.7),
                        c=rnorm(casos),
                        d=sample(c("fogo","agua","terra","ar"), casos, replace=TRUE),
                        e=rnorm(casos),
                        f=rpois(casos, 3)
)

object.size(largeData1) 

head(largeData1) 

write.table(largeData1,"largeData13.csv",sep=",",row.names=FALSE,quote=FALSE) 

#### extraindo #####

enderecoBase <- ("largeData13.csv")

# read.csv

system.time(extracaoLD1 <- read.csv2(enderecoBase))

# função fread:

system.time(extracaoLD3 <- fread(enderecoBase))


##### função ff #####

library(ff)
library(ffbase)

system.time(extracaoLD4 <- read.csv.ffdf(file=enderecoBase))

### operações

## amostra:

extracaoLD4Amostra <- extracaoLD4[sample(nrow(extracaoLD4), 100000) , ]

## estatística descritiva:

summary(extracaoLD4Amostra)

## inferencial (regresão linear)
 
reg1 <- lm(a ~ b + d, data = extracaoLD4Amostra)

summary(reg1)




