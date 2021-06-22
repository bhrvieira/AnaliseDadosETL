################################################################################
################################################################################
################################################################################
##################          Análise de Dados             #######################
##################           Atividades 9                #######################
##################              2021.1                   #######################
################################################################################
################################################################################
################################################################################

##### Trabalhando com Textos #####

### Carregando os pacotes

library(dplyr)
library(pdftools)
library(textreadr)
library(stringr)

setwd("C:/Users/Win10/Downloads")

ementa <- read_pdf("C:/Users/Win10/Downloads/PPI2020.pdf", ocr = T)

View(ementa)

# juntando as partes

ementa <- ementa %>%
  group_by(element_id) %>%
  mutate(all_text = paste(text, collapse = " | ")) %>%
  select(element_id, all_text) %>%
  unique()

# coletando as datas e reorganizando as informações: 

data <- str_extract_all(ementa$all_text, "\\d{2}/\\d{2}")

View(data)

ementa_datanova <- gsub("04/02", "04-02", ementa$all_text)

ementa_datanova <- str_extract_all(ementa_datanova, "\\d{2}-\\d{2}")

View(ementa_datanova)

#### Juntando e buscando textos #####

proposicao20 <- read.csv2('http://dadosabertos.camara.leg.br/arquivos/proposicoes/csv/proposicoes-2020.csv', sep = ';', encoding = 'UTF-8')

autores20 <- read.csv2('http://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/csv/proposicoesAutores-2020.csv', sep = ';', encoding = 'UTF-8')

names(autores20)
names(proposicao20)

head(autores20)
head(proposicao20)

# reduzindo o tamanho da base

bdautores20 <- select(autores20, uriProposicao, idDeputadoAutor, siglaPartidoAutor, 
                      uriPartidoAutor)
bdproposicao20 <- select(proposicao20, uri, siglaTipo, numero, codTipo, ementa)

names(bdautores20)[1] <- "uri"


## unindo as bases: 

library(fuzzyjoin)

bdprop20 <- fuzzyjoin::stringdist_join(bdproposicao20, bdautores20, mode='left')

## realizando busca

bdprop20 <- bdprop20 %>% filter(siglaPartidoAutor == 'PT')





