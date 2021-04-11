################################################################################
################################################################################
################################################################################
####################   Resolução de Atividade   ################################
####################      Análise de Dados      ################################
####################       Bhreno Vieira        ################################
####################    Prof. Hugo Medeiros     ################################
################################################################################
################################################################################
################################################################################


#### Instalando pacotes necessário ####

library(rio)
library(tidyverse)

#### Realizando as funções ####
# Os valores dos testes se referem a um teste da Lei Gamson (1961) referente ao 
# primeiro ministerio do governo Temer (12/05/2016 a 31/12/2016), essa lei afirma 
# que existe uma proporcionalidade entre a quantidade de cadeiras no Legislativo, 
# e a quantidade de ministérios de um partido. 

## indicando diretório
setwd("C:/Users/Win10/Documents")

#### Objeto Simples (vetor): ####

## carregando banco de dados

coalizao <- import("bd_coal_temer1.xlsx")

#### Conhecendo a base de dados: ####

## estatisticas de posição: 

summary(coalizao)

## natureza das variáveis: 

str(coalizao)

## tamanho da base: 
dim(coalizao)

## Objeto Complexo (teste de correlação e visualização gráfica do banco) ####

# teste de correlação: 
cor.test(coalizao$cadeiras, coalizao$ministerios)

# visualização gráfica do teste: 

a <- ggplot(coalizao, aes(cadeiras, ministerios, color = partido))+
  geom_point()+theme_minimal()


a




