################################################################################
################################################################################
################################################################################
############                  Análise de Dados                    ##############
############                    Atividade 6                       ##############
############                      2021.1                          ##############
################################################################################
################################################################################
################################################################################


#### Descoberta ####

# 1) para essa questão vou utilizar os dados do pacote electionsBR

library(electionsBR)

## analisando eleições de deputado federal de 2018

e2018 <- details_mun_zone_fed(2018)

library(funModeling) 

library(tidyverse) 

## analisando as características 

glimpse(e2018) 

status(e2018) 

freq(e2018) 

plot_num(e2018) 

profiling_num(e2018) 


#### Estruturação ####

library(data.table)
library(dplyr)
library(tidyverse)

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

mercosul_countries<-c("Argentina", "Brazil",  "Paraguay", "Uruguay") 

mercosul<- general_data %>% filter(location %in% mercosul_countries) # filtra casos apenas no vetor

mcsul <- mercosul %>% group_by(location) %>% mutate(row = row_number()) %>% select(location, new_cases, row) 


result <- mcsul %>% group_by(location) %>% filter(row == max(row))

mcsul <- mcsul  %>% filter(row<=min(result$row)) 

# pivota o data frame de long para wide

mcsulw <- mcsul %>% pivot_wider(names_from = row, values_from = new_cases) %>% remove_rownames %>% column_to_rownames(var="location") 

head(mcsulw)




#### Limpeza ####

## base utilizada: 

head(mercosul)


mercosul <- mercosul %>% select(location, new_cases, new_deaths)

status(mercosul) 
freq(mercosul) 
plot_num(mercosul)+theme_bw()

profiling_num(mercosul) 

mercosul %>% filter(new_cases < 0)

mercosul <- mercosul %>% filter(new_cases>=0)




#### Validação ####

install.packages("validate")

library(validate)

## recriando a base:

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") 

mercosul_countries<-c("Argentina", "Brazil",  "Paraguay", "Uruguay") 

mercosul<- general_data %>% filter(location %in% mercosul_countries) # filtra casos apenas no vetor

names(mercosul)

mercosul <- mercosul %>% select(location, new_cases, new_deaths)

regras_mercosul <- validator(new_cases >= 0, new_deaths >= 0)

validacao_mercosul <- confront(mercosul, regras_mercosul)

summary(validacao_mercosul)

plot(validacao_mercosul)



#### Enriquecimento ####

## chamando bases de dados

setwd("C:/Users/Win10/Documents/GitHub/AnaliseDadosETL/AnaliseDadosETL/AnaliseDadosETL")

dir()
library(rio)

proExe <- read.csv2("IniLegExe9520.csv")
executivo <- import("executivo.xlsx")

## enriquecendo as informações

propExe <- (join.dplyr <- inner_join(proExe, executivo))

names(propExe)

head(propExe)
