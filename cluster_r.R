library(dplyr)

dir()
setwd("/home/gabriel.gomes/r_cluster")


#### 1.2 Conhecendo a base de dados/ Definindo o problema ####

filmes <- read.csv('movies.csv',stringsAsFactors = F)
View(filmes)

## lendo os dados pre-processados
filmes_transf <- read.csv2('movies_transf.csv')
View(filmes_transf)
