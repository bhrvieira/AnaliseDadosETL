################################################################################
################################################################################
################################################################################
############                Atividade 4              ###########################
############                 EXTRAÇÃO                ###########################
############                  2021.1                 ###########################
################################################################################
################################################################################
################################################################################

##### Extração Básica #####

## Extração em .json

install.packages("rjson")
library(rjson)

govfederal <- fromJSON(file = "http://estruturaorganizacional.dados.gov.br/doc/estrutura-organizacional/resumida.json")

govfederal <- as.data.frame(govfederal)

View(govfederal)

## Extração .csv

frentesparlamentares <- read.csv2('http://dadosabertos.camara.leg.br/arquivos/frentes/csv/frentes.csv', sep = ';', encoding = 'UTF-8')

frentesparlamentares <- as.data.frame(frentesparlamentares)

View(frentesparlamentares)

## Extração xlsx

library(rio)

legislaturas <- import('http://dadosabertos.camara.leg.br/arquivos/legislaturas/xlsx/legislaturas.xlsx')

View(legislaturas)



#### Implementação ####

proposicao20 <- read.csv2('http://dadosabertos.camara.leg.br/arquivos/proposicoes/csv/proposicoes-2020.csv', sep = ';', encoding = 'UTF-8')
  
proposicao19 <- read.csv2('http://dadosabertos.camara.leg.br/arquivos/proposicoes/csv/proposicoes-2019.csv', sep = ';', encoding = 'UTF-8')

proposicao56 <- rbind(proposicao19, proposicao20)

View(proposicao56)


#### WebScraping #### 

library(rvest)
library(dplyr)

url <- "https://pt.wikipedia.org/wiki/Minist%C3%A9rios_do_Brasil"

urlTables <- url %>% read_html %>% html_nodes("table")

urlLinks <- url %>% read_html %>% html_nodes("link")

ministerios <- as.data.frame(html_table(urlTables[2]))

View(ministerios)

write.csv2(ministerios, 'ministerios.csv')


