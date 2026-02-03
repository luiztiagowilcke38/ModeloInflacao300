# Módulo 16: Transformada Wavelet
# Objetivo: Decompor série em tempo-frequência
# Autor: Luiz Tiago Wilcke

library(wavelets)
library(tidyverse)

message("Iniciando Módulo 16: Transformada Wavelet...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Wavelet Transform (MODWT)
  # Usando filtro 'd4' (Daubechies 4) para capturar características
  # Precisamos de um comprimento que potência de 2 ou usar MODWT que é mais flexível
  
  # MODWT não exige potência de 2
  wt <- modwt(dados$IPCA, filter = "d4", n.levels = 4)
  
  png("outputs/wavelet_transform.png", width = 800, height = 600)
  plot(wt, main = "Decomposição Wavelet (MODWT) - IPCA")
  dev.off()
  
  message("Gráfico Wavelet salvo em 'outputs/wavelet_transform.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
