## Análise de Clusters
# Curso: MBA Data Science INFNET

# Instalação e carregamento dos pacotes utilizados
pacotes <- c("plotly", 
             "tidyverse", 
             "ggrepel", 
             "knitr", 
             "kableExtra", 
             "reshape2", 
             "misc3d", 
             "plot3D", 
             "cluster",
             "factoextra",
             "readr",
             "sf",
             "ade4",
             "readxl",
             "dplyr")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Carregamento dos dados
dados <- read_excel("Pumpkin_Seeds_Dataset.xlsx")

#Exclusão da coluna Class
dados <- dados %>% select(-Class)


head(dados)        # Mostra as primeiras linhas
str(dados)         # Estrutura das variáveis
summary(dados)     # Estatísticas básicas

#Normalização dos dados
dados_padronizados <- scale(dados)

set.seed(223)
# Método do cotovelo (WSS)
fviz_nbclust(dados_padronizados, kmeans, method = "wss") +
  ggplot2::geom_vline(xintercept = 2, linetype = 2, color = "red") +
  ggplot2::labs(title = "Elbow Method (WSS)")


# Método da silhueta
fviz_nbclust(dados_padronizados, kmeans, method = "silhouette") +
  ggplot2::labs(title = "Silhouette Method")


# executar kmeans (nstart alto para evitar mínimos locais)
set.seed(223)
km_res <- kmeans(dados_padronizados, centers = 2, nstart = 25)
print(km_res)

# Visualização
fviz_cluster(km_res, data = dados_padronizados, ellipse.type = "convex",
             ggtheme = theme_minimal(), main = "K-means (k=2)")


# Comparar com classes reais
print(table(Cluster = km_res$cluster, TrueClass = iris$Species))
