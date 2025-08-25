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

dados_padronizados <- scale(dados)
