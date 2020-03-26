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

#### 3. Kmeans no R ####
#### 3.1 Criando Cluster com R ####
set.seed(1987) #função pra gerar resultados iguais

## criando cluster para 3 agrupamentos
resultado_cluster <- kmeans(dados_normalizados,centers = 3)

## verificando resultado da função kmeans
resultado_cluster

## vetor com os clusters para cada registro
resultado_cluster$cluster

## dataframe com os centros para cada agrupamento para cada variavel(coluna)
resultado_cluster$centers

View(resultado_cluster$centers)

## vetor com as soma dos quadrados dentro do cluster. Espera-se que esse valor seja o mais baixo poss?vel para cada cluster, 
# porque se deseja ter homogeneidade dentro dos clusters
resultado_cluster$withinss

## Soma dos quadrados entre os clusters. Resulta a M?dia de distancia entre os centros de cada cluster,
# para se ter cluster heterogeneos, este valor deve ser o mais algo poss?vel.
resultado_cluster$betweenss  

## tamanho de cada cluster
resultado_cluster$size

#### 3.2 Plotando os clusters ####

## criando visualização dos cluster com o pacote 'cluster'
#install.packages("cluster")
library(cluster)
clusplot(x = dados_normalizados, resultado_cluster$cluster, color=TRUE, shade=TRUE)#, labels=3)#lines=3,


## criando visualização dos cluster com o pacote 'fpc'
#install.packages("fpc")
library(fpc)
plotcluster(x = dados_normalizados, resultado_cluster$cluster,ignorenum = T)


#### 3.3 Visualizando Generos nos Clusters(agrupamentos) ####

## criando gráficos com os centros
centros <- resultado_cluster$centers

#install.packages('reshape2')
library(reshape2)
centros_2 <- melt(centros) #,id.vars = 'genero')

#atribuindo novos nomes da coluna e convertendo coluna cluster para factor
colnames(centros_2) <- c('cluster','genero','centro')
centros_2$cluster   <- as.factor(centros_2$cluster)

# criando gráficos com a lib ggplot2, pra cada cluster
#install.packages('ggplot2')
library(ggplot2)
ggplot(data = centros_2 ) + 
  geom_bar(aes(x = genero,y = centro,fill = cluster),stat = 'identity') + 
  facet_grid(cluster ~ .)