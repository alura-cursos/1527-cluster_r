library(dplyr)

dir()
setwd("/home/gabriel.gomes/r_cluster")


#### 1.2 Conhecendo a base de dados/ Definindo o problema ####

filmes <- read.csv('movies.csv',stringsAsFactors = F)
View(filmes)

## lendo os dados pre-processados
filmes_transf <- read.csv2('movies_transf.csv')
View(filmes_transf)

#### 2.2 Preparando a base de dados####

## normalizando a base de dados
dados_normalizados <- scale(filmes_transf) ## execu??o com erro

## excluindo as colunas movieId e Titulo da base 
filmes_transf <- filmes_transf %>% 
  select(-movieId, -titulo)

## normalizando a base de dados
dados_normalizados <- scale(filmes_transf)
dados_normalizados <- data.frame(dados_normalizados)