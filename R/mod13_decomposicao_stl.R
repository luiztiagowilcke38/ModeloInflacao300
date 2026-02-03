# Módulo 13: Decomposição STL
# Objetivo: Separar Sazonalidade, Tendência e Resíduo
# Autor: Luiz Tiago Wilcke

library(tidyverse)
library(forecast)

message("Iniciando Módulo 13: Decomposição STL...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Criar objeto TS (mensal)
  # Assumindo início em 2000
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  stl_decomp <- stl(ts_ipca, s.window = "periodic")
  
  png("outputs/decomposicao_stl.png", width = 800, height = 600)
  plot(stl_decomp, main = "Decomposição STL do IPCA")
  dev.off()
  
  message("Gráfico de decomposição salvo em 'outputs/decomposicao_stl.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
