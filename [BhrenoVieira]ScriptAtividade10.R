################################################################################
################################################################################
################################################################################
#############             An�lise de Dados                    ##################
#############               Atividade 10                      ##################
#############                  2021.1                         ##################
################################################################################
################################################################################
################################################################################

##### Introdu��o a Datas e Tempo #####

## Carregando pacotes ##

library(lubridate)

## conver��es ## 

(str(data1 <- as.Date(c("1995-02-02", "2005-01-04", "1943-01-26")) ) )

(str(date2 <- as.POSIXct(c("1995-02-02 23:30", "2005-01-04 09:00", "1943-01-26 12:34")) ) )

(str(data3 <- as.POSIXlt(c("1995-02-02 23:30", "2005-01-04 09:00", "1943-01-26 12:34")) ) )


## Extra��es de componentes ## 

(str(data1 <- as.Date(c("1995-02-02", "2005-01-04", "1943-01-26")) ) )

year(data1)

month(data1)

wday(data1, label = T, abbr = T)



##### Data na Pr�tica #####

url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' 

covidBR = read.csv2(url, encoding='latin1', sep = ',') 

covidPE <- subset(covidBR, state == 'PE') 

str(covidPE) # observar as classes dos dados

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d") 

str(covidPE) 

covidPE$dia <- seq(1:length(covidPE$date)) 

predDia = data.frame(dia = covidPE$dia) 
predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+180)) 

predDia <- rbind(predDia, predSeq)  

install.packages("drc")

library(drc) 

fitLL <- drm(vaccinated ~ dia, fct = LL2.5(),
             data = covidPE, robust = 'mean') 

plot(fitLL, log="", main = "Log logistic") 

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) 

predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia))

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) 

library(plotly) 

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Casos - Predi��o") %>% add_trace(x = ~data, y = ~vaccinated, name = "Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predi��o de Vacinados de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Vacinados Acumulados por Dia', showgrid = FALSE),
  hovermode = "compare") 

