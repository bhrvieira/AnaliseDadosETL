################################################################################
################################################################################
################################################################################
################            Análise de Dados            ########################
################              Atividade 7               ########################
################                2021.1                  ########################
################################################################################
################################################################################
################################################################################

##### Tipos e Fatores #####

# numérico: 

numerico <- c(1, 2, 3, 4, 5, 6, 7, 8)

class(numerico)

# inteiros:

inteiro <- c(1:50)

class(inteiro)

# caracterer 

texto <- c("Recife", "Brasília", "São Paulo", "Porto Alegre", "Manaus")

class(texto)

# factor

fator <- factor(c("NE", "CO", "SD", "SL", "NO", "NE", "SL", "CO", "SD", "NE"))

class(fator)

levels(fator)

# lógico: 

x = 1

y = 3

a = 4

z = x + a> y

z

class(z)


##### Mais fatores #####

install.packages("arules")

library(ade4)
library(arules)
library(forcats)

facebook <- read.table("bases_originais/dataset_Facebook.csv", sep=";", header = T)
str(facebook)

# Convertendo em fatores
for(i in 2:7) {facebook[,i] <- as.factor(facebook[,i])} 

# Filtrando por tipo
fatores_fb <- unlist(lapply(facebook, is.factor))  
facebook_fator <- facebook[ , fatores_fb]
str(facebook_fator)

# One hot encoding
dummy_fb <- acm.disjonctif(facebook_fator)

# discretização
inter_fb <- unlist(lapply(facebook, is.integer))  
inter_facebook <- facebook[, inter_fb]
str(inter_facebook)

inter_facebook$Page.total.likes.Disc <- discretize(inter_facebook$Page.total.likes, method = "interval", breaks = 3, labels = c("Frequente", "Médio", "Outros"))

##### Data.table #####

library(data.table)
library(aod)

bdadmit <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

# transformando em data.table

bdadmitDT <- bdadmit %>% setDT()

names(bdadmitDT)

## regressão:

bdadmitDT[ , glm(formula = admit ~ gre + gpa, family = "binomial")]



##### Dplyr ##### 

library(dplyr)

#aplicação de sumário: 

count(bdadmit, rank) 

# agrupamento

bdadmit %>% group_by(rank) %>% summarise(avg = mean(admit))

# manipulação de casos

bdadmit %>%  filter(rank == 2) %>% summarise(avg = mean(gpa))

# manipulação de colunas

bdadmit %>% select(rank, gpa, gre) %>% arrange(rank)
