## Análise de Clusters
# Curso: MBA Data Science INFNET

# Instalação e carregamento dos pacotes utilizados
pacotes <- c("plotly", 
             "tidyverse", 
             "cluster",
             "factoextra",
             "ClusterR",
             "OpenImageR"
)

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}


img = readImage('lena_original.jpg')

imageShow(img)

img2 = apply(img, 3, as.vector)


dim_img <- dim(img)
pixels <- matrix(as.vector(img), ncol = 3, byrow = TRUE)
colnames(pixels) <- c("R", "G", "B")

library(cluster)

# Para 3 cores
clara_3 <- clara(pixels, k = 3)
# Para 5 cores
clara_5 <- clara(pixels, k = 5)
# Para 10 cores
clara_10 <- clara(pixels, k = 10)


recolor <- function(clara_result, dim_img) {
  clustered <- clara_result$clustering
  medoids <- clara_result$medoids
  new_pixels <- medoids[clustered, ]
  array(new_pixels, dim = dim_img)
}

img_3 <- recolor(clara_3, dim_img)
img_5 <- recolor(clara_5, dim_img)
img_10 <- recolor(clara_10, dim_img)


library(grid)
grid.raster(img_3)
grid.raster(img_5)
grid.raster(img_10)








