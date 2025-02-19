################################################################################
################################################################################
################################################################################
###############                Atividade 2                  ####################
###############     Fun��es + Fun��es de Repeti��o - Apply  ####################
###############                  2021.1                     ####################
################################################################################
################################################################################
################################################################################

#### chamando base:

names(mtcars)

summary(mtcars)


##### Criando uma fun��o

centralizacao <- function(x) {
  x <- x - mean(x)
}

y <- centralizacao(mtcars$cyl)

y


#### Fun��o vetorizada 

apply(mtcars[ ,-11], 2, mean)

## aplica��o a uma base de dados

par(mfrow = c(2, 2)) #formando quadrantes

mapply(hist, mtcars[ , 1:4], MoreArgs=list(main='Histograma', xlab = 'N', 
                                           ylab = 'Frequ�ncia')) #gr�ficos

