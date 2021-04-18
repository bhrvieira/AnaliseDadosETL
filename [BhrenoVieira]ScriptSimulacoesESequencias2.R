################################################################################
################################################################################
################################################################################
################             Atividade 2                     ###################
################       Simulações e Sequências               ###################
################               2021.1                        ###################
################################################################################
################################################################################
################################################################################



## Distribuição Normal

distNormalSimulacao <- rnorm(200)
plot(distNormalSimulacao)
summary(distNormalSimulacao)

## Distribuição Binomial 

distBinominalSimulacao <- rbinom(100, 1, 0.8)
plot(distBinominalSimulacao)
summary(distBinominalSimulacao)



indexSimulacao <- seq(1, length(distNormalSimulacao))
indexSimulacao

summary(indexSimulacao)
plot(indexSimulacao)

removeTaskCallback(tarefaSemente)
