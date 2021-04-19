################################################################################
################################################################################
################################################################################
############                 Atividade 2                   #####################
############                 Calculando                    #####################
############                   2021.1                      #####################
################################################################################
################################################################################
################################################################################

#### Centralizando base de dados ####

## Criando base de dados (tipo de poisson)

bdpoisson <- rpois(400, 3)

## conhecendo a base

summary(bdpoisson)

## histograma

h1 <- hist(bdpoisson)

## gráfico de densidade: 

d1 <- density(bdpoisson) 

plot(d1)

## centralizando a base criada

bdpoissoncentral <- bdpoisson - mean(bdpoisson)

h2 <- hist(bdpoissoncentral)

d2 <- density(bdpoissoncentral) 

plot(d2)


