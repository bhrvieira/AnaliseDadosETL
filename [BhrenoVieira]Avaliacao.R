################################################################################
################################################################################
################################################################################
############          Eletiva de An�lise de Dados              #################
############                   Avalia��o                       #################
############                     2021.1                        #################
################################################################################
################################################################################
################################################################################

##### Extrair a base #####

covidpe <- read.csv2('https://dados.seplag.pe.gov.br/apps/basegeral.csv', sep = ';', encoding = 'UTF-8')

summary(covidpe)

##### Quest�o 2: Calcule para cada municipio: confirmados e �bitos#####

## carregando pacotes: 

library(lubridate)

library(tidyverse)

## criando a semana epidemiologica:

epiweek(covidpe$dt_notificacao)

covidpe_week <- covidpe %>% mutate("semana epidemiologica" = epiweek(covidpe$dt_notificacao))

## calculando confirmados 

confirmados <- covidpe_week %>% filter(classe == "CONFIRMADO") %>% group_by(municipio) %>% count('semana epidemiologica')

view(confirmados)

## calculando obitos 

obitos <- covidpe_week %>% filter(evolucao == "OBITO") %>% group_by(municipio) %>% count('semana epidemiologica')

View(obitos)

base_confirmados <- confirmados

base_obitos <- obitos


##### Quest�o 3: Enriquecendo a base #####

setwd("C:/Users/Win10/Downloads")

library(rio)

### pre-tratamento do banco ibge ###

ibge <- import("tabela6579.xlsx")

ibge <- ibge[-(1:4),]

ibge <- rename(ibge, municipio = `Tabela 6579 - Popula��o residente estimada`) 

ibge <- rename(ibge, populacao = `...2`) 

ibge$populacao <- as.numeric(ibge$populacao) 

trim <- function (x) gsub("^\\s+|\\s+$", "", x) 

ibge$municipio <- trim(ibge$municipio)


## Funcao para colocar em maiscula

ibge$municipio <- toupper(ibge$municipio) 

## Listar todos os acentos

unwanted_array <- list('S'='S', 's'='s', 'Z'='Z', 'z'='z', '�'='A', '�'='A', '�'='A', '�'='A', '�'='A', '�'='A', '�'='A', '�'='C', '�'='E', '�'='E','�'='E', '�'='E', '�'='I', '�'='I', '�'='I', '�'='I', '�'='N', '�'='O', '�'='O', '�'='O', '�'='O', '�'='O', '�'='O', '�'='U',
'�'='U', '�'='U', '�'='U', '�'='Y', '�'='B', '�'='Ss', '�'='a', '�'='a', '�'='a', '�'='a', '�'='a', '�'='a', '�'='a', '�'='c','�'='e', '�'='e', '�'='e', '�'='e', '�'='i', '�'='i', '�'='i', '�'='i', '�'='o', '�'='n', '�'='o', '�'='o', '�'='o', '�'='o','�'='o', '�'='o', '�'='u', '�'='u', '�'='u', '�'='y', '�'='y', '�'='b', '�'='y' )

## Funcao para retirar os acentos 
for(i in seq_along(unwanted_array))+ibge$municipio <- gsub(names(unwanted_array)[i],unwanted_array[i],ibge$municipio)

## Copiar os ultimos caracteres para criar UF

ibge$UF <- str_sub(ibge$municipio,-4, -1) # 

## Remover parenteses/substituir string por outro

ibge$UF <- gsub("[()]", " ", ibge$UF)

## Retirar os Ultimos digitos da coluna

ibge$municipio <- str_sub(ibge$municipio, 1, str_length(ibge$municipio)-4)

status (ibge)

ibge <- rename(ibge, uf = UF) 

View(ibge)

## Mergir bancos 

ibge_pe <- subset(ibge, uf == "PE")

confirmados_covidpe <- inner_join(confirmados, ibge_pe)

View(confirmados_covidpe)

obitos_covidpe <- inner_join(obitos, ibge_pe)

View(obitos_covidpe)


##### Quest�o 4: incid�ncia e letalidade #####

confirmados2 <- covidpe_week %>% filter(classe == "CONFIRMADO") %>% group_by(municipio)%>% count(`semana epidemiologica`) %>% mutate(n/100000)

obitos2 <- covidpe_week %>% filter(evolucao == "OBITO") %>% group_by(municipio) %>% 
  count(`semana epidemiologica`) %>% mutate(n/100000)








