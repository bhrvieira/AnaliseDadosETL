################################################################################
################################################################################
################################################################################
############          Eletiva de Análise de Dados              #################
############                   Avaliação                       #################
############                     2021.1                        #################
################################################################################
################################################################################
################################################################################

##### Extrair a base #####

covidpe <- read.csv2('https://dados.seplag.pe.gov.br/apps/basegeral.csv', sep = ';', encoding = 'UTF-8')

summary(covidpe)

##### Questão 2: Calcule para cada municipio: confirmados e óbitos#####

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


##### Questão 3: Enriquecendo a base #####

setwd("C:/Users/Win10/Downloads")

library(rio)

### pre-tratamento do banco ibge ###

ibge <- import("tabela6579.xlsx")

ibge <- ibge[-(1:4),]

ibge <- rename(ibge, municipio = `Tabela 6579 - População residente estimada`) 

ibge <- rename(ibge, populacao = `...2`) 

ibge$populacao <- as.numeric(ibge$populacao) 

trim <- function (x) gsub("^\\s+|\\s+$", "", x) 

ibge$municipio <- trim(ibge$municipio)


## Funcao para colocar em maiscula

ibge$municipio <- toupper(ibge$municipio) 

## Listar todos os acentos

unwanted_array <- list('S'='S', 's'='s', 'Z'='Z', 'z'='z', 'À'='A', 'Á'='A', 'Â'='A', 'Ã'='A', 'Ä'='A', 'Å'='A', 'Æ'='A', 'Ç'='C', 'È'='E', 'É'='E','Ê'='E', 'Ë'='E', 'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I', 'Ñ'='N', 'Ò'='O', 'Ó'='O', 'Ô'='O', 'Õ'='O', 'Ö'='O', 'Ø'='O', 'Ù'='U',
'Ú'='U', 'Û'='U', 'Ü'='U', 'Ý'='Y', 'Þ'='B', 'ß'='Ss', 'à'='a', 'á'='a', 'â'='a', 'ã'='a', 'ä'='a', 'å'='a', 'æ'='a', 'ç'='c','è'='e', 'é'='e', 'ê'='e', 'ë'='e', 'ì'='i', 'í'='i', 'î'='i', 'ï'='i', 'ð'='o', 'ñ'='n', 'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o','ö'='o', 'ø'='o', 'ù'='u', 'ú'='u', 'û'='u', 'ý'='y', 'ý'='y', 'þ'='b', 'ÿ'='y' )

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


##### Questão 4: incidência e letalidade #####

confirmados2 <- covidpe_week %>% filter(classe == "CONFIRMADO") %>% group_by(municipio)%>% count(`semana epidemiologica`) %>% mutate(n/100000)

obitos2 <- covidpe_week %>% filter(evolucao == "OBITO") %>% group_by(municipio) %>% 
  count(`semana epidemiologica`) %>% mutate(n/100000)








