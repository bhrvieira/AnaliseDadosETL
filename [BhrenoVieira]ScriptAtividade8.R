################################################################################
################################################################################
################################################################################
#############             Análise de Dados             #########################
#############                Atividade 8               #########################
#############                  2021.1                  #########################
################################################################################
################################################################################
################################################################################

##### Valores Ausentes #####

library(tidyverse)
library(data.table)
library(funModeling) 

#para realizar a atividade estou utilizando a base de dados starwars, essa base 
# de dados apresenta informações sobre o perfil dos personagens da saga.

View(starwars)

attach(starwars)

is.na.data.frame(starwars)

# a base de dados há casaos e valores com "NA"

## criando a matriz sombras:

shadowmatrix <- as.data.frame(abs(is.na(starwars)))

head(shadowmatrix)

## apenas as colunas com NA

y <- shadowmatrix[which(sapply(shadowmatrix, sd) > 0)]

cor(y)

head(y)

#com base nos testes, dois valores estão mais correlacionados como as variaveis
# de height e homeworld. Logo, acredito que seja os valores MAR (que corresponde
# a dificuldade de relacionar algo para preencher os casos)



##### Outliers #####

library(dplyr)
library(data.table)
library(plotly)

names(starwars)

summary(starwars$height)

## transformando e acrescentando estruturas na base: 

#optei por analisar a variável altura (height)

starwars2 <- starwars %>% mutate(casos2 = sqrt(mass), casosLog = log10(mass))

names(starwars2)

plot_ly(y = starwars2$mass, type = "box", text = starwars2$name, boxpoints = "all", jitter = 0.3)

# utilizei a variável massa (mass) e o personagem que possui a massa maior é Jabba. 

lower_bound <- median(starwars2$mass) - 3 * mad(starwars2$mass, constant = 1)
upper_bound <- median(starwars2$mass) + 3 * mad(starwars2$mass, constant = 1)
(outlier_ind <- which(starwars2$mass < lower_bound | starwars2$mass > upper_bound))

# buscando em outras variáveis ajustadas:

plot_ly(y = starwars2$casos2, type = "box", text = starwars2$name, boxpoints = "all", jitter = 0.3)

plot_ly(y = starwars2$casosLog, type = "box", text = starwars2$name, boxpoints = "all", jitter = 0.3)

#em ambos os testes, apenas Jabba possui a maior massa. 



##### Imputação ##### 

# tendência central
library(Hmisc) 

starwars2$mass <- impute(starwars2$mass, fun = mean) 
starwars2$mass <- impute(starwars2$mass, fun = median) 

is.imputed(starwars2$mass) 

table(is.imputed(starwars2$mass))

#confirmando que os valores foram imputados

summary(starwars2$mass)

# tendencia HOT DECK
(starwars$mass <- impute(starwars$mass, "random")) 

summary(starwars$mass)




