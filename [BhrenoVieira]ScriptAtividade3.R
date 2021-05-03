################################################################################
################################################################################
################################################################################
###################  Atividade 3 - processos do ETL ############################
###################         Análise de Dados        ############################
###################              2021.1             ############################
################################################################################
################################################################################
################################################################################

#### 1) ETL Prática ####

## Extraindo base de dados do site ##

sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')


sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

names(sinistrosRecife2019Raw)
names(sinistrosRecife2020Raw)
names(sinistrosRecife2021Raw)

## tratando base de 2019 ##

sinistrosRecife2019Raw1 <- sinistrosRecife2019Raw[,-c(10, 11, 12)]

dim(sinistrosRecife2019Raw1)

## renomeando variável ## 

names(sinistrosRecife2019Raw1)[c(1)] <- c("data")

names(sinistrosRecife2019Raw1)

## unificando bases ## 

sinistrosRecifeRaw <- rbind(sinistrosRecife2020Raw, sinistrosRecife2021Raw, sinistrosRecife2019Raw1)

## conhecendo a base ## 

dim(sinistrosRecifeRaw)
str(sinistrosRecifeRaw)

## transformando em factor ##
sinistrosRecifeRaw$sentido_via <- as.factor(sinistrosRecifeRaw$sentido_via)

is.factor(sinistrosRecifeRaw$sentido_via)



#### 2) Extração #### 

## Função NAZero

naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

## observando quais são os objetos:

ls()

## quais ocupam mais espaços:

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

# o objeto que ocupa mais espaço é a base criada "sinistrosRecifeRaw" que possui
# a junção de informações de 2019,2020 e 2021.

## Olhando o espaço 

gc()

## deixando apenas a base utilizada: 

rm(list=(ls()[ls()!="sinistrosRecifeRaw", "naZero"]))


##### 3) Leitura #####

## instalando pacotes necessários: 

install.packages("microbenchmark")

library(microbenchmark)

install.packages("foreign")

library(foreign)

library(rio)

## exportando as bases: 

saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv")


## carregando as bases

a <- sinistrosRecife <- readRDS('sinistrosRecife.rds')


b <- sinistrosRecife <- read.csv2('sinistrosRecife.csv', sep = ';')

## comparando 

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv"), times = 30L)

# nota-se com o pacote microbenchmark, a base de dados que mais demora é a base 
# de dados em formato csv, isso acontece pq a base de dados em .rds é uma base nativa, 
# e seguindo ao que foi mencionado na sala, por se está utilizando o R, é bem mais vantajoso, # utilizar esse formato para a leitura e análise futura dos dados. Dito isso, ao 
# realizar o processo do ETL no R, é bem mais eficiente armazenar os dados tratados
# em uma base nativa.


