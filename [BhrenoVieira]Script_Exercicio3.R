################################################################################
################################################################################
################################################################################
#################     Eletiva de Análise de Dados     ##########################
#################           Exercício 3               ##########################
#################              2021.1                 ##########################
################################################################################
################################################################################
################################################################################

##### Extraindo base do site #####

covidpe <- read.csv("https://dados.seplag.pe.gov.br/apps/basegeral.csv", 
                    sep = ";", na.strings = "")


##### NA e imputação randomica #####

## carregando pacotes

library(Hmisc)
library(funModeling)

## verificando valores ausentes

status(covidpe)

## imputação randomica

covidpe$sintomas <- impute(covidpe$sintomas, "random")

## verificando quantidade

status(covidpe)


##### Calculando total por municípios ##### 

## carregando pacotes

library(tidyverse)

## variavel binaria confirmados

covidpe$confirmados <- ifelse(covidpe$classe == "CONFIRMADO", 1, 0)

## variavel binaria negativos

covidpe$negativos <- ifelse(covidpe$classe == "NEGATIVO", 1, 0)

## Calculando casos confirmados por município

covidpe <- covidpe %>% group_by(cd_municipio) %>% mutate(casos_confirmados = sum(confirmados))

## Calculando os totais de casos negativos por município

covidpe <- covidpe %>% group_by(cd_municipio) %>% mutate(casos_negativos = sum(negativos))


##### Variavel Tosse #####

## chamando o pacote

library(stringr)

## Dummy com "tosse"

covidpe <- covidpe %>% mutate(tosse = ifelse(grepl(paste("TOSSE", collapse="|"), sintomas), 'Sim', 'Não'))

## Calculando os casos com tosse

covidpe <- covidpe %>% group_by(tosse) %>% mutate(tosse_confirmado = sum(confirmados))

## Confirmados com tosse: 399.832 casos; negativos com tosse: 115.921

##### Média Móvel #####

## Carregando pacotes

library(zoo)

library(lubridate)

# Transformando a coluna dt_notificacao para as.Date

covidpe$dt_notificacao <- as.Date(covidpe$dt_notificacao, format = "%Y-%m-%d") 

# Criando variável PE

covidpe <- covidpe %>% mutate(estado = "PE")

# Agrupando casos confirmados por dia

covidpe <- covidpe %>% group_by(estado) %>% group_by(dt_notificacao) %>% mutate(soma_casos_dia = sum(confirmados))

# Agrupando casos negativos por dia

covidpe <- covidpe %>% group_by(estado) %>% group_by(dt_notificacao) %>% mutate(soma_negativos_dia = sum(negativos))

# Média móvel de casos confirmados

covidpe <- covidpe %>% mutate(confirmados_mm = round(rollmean(x = soma_casos_dia, 7, align = "right", fill = NA), 2))

# Média móvel de casos negativos

covidpe <- covidpe %>% mutate(negativos_mm = round(rollmean(x = soma_negativos_dia, 7, align = "right", fill = NA), 2))