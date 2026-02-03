# Módulo 15: Análise de Fourier
# Objetivo: Identificar ciclos via análise espectral
# Autor: Luiz Tiago Wilcke

library(stats)
library(tidyverse)

message("Iniciando Módulo 15: Análise de Fourier...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Periodograma
  spec_obj <- spectrum(dados$IPCA, plot = FALSE)
  
  png("outputs/analise_espectral.png", width = 800, height = 600)
  plot(spec_obj, main = "Periodograma (Densidade Espectral) - IPCA")
  dev.off()
  
  message("Gráfico de análise espectral salvo em 'outputs/analise_espectral.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
