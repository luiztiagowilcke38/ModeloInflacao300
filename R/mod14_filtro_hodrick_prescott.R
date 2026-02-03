# Módulo 14: Filtro Hodrick-Prescott (HP)
# Objetivo: Extrair tendência suave
# Autor: Luiz Tiago Wilcke

library(mFilter)
library(tidyverse)

message("Iniciando Módulo 14: Filtro HP...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Lambda = 14400 para dados mensais
  hp_filter <- hpfilter(dados$IPCA, freq = 14400, type = "lambda")
  
  png("outputs/filtro_hp.png", width = 800, height = 600)
  plot(hp_filter)
  title(main = "Filtro Hodrick-Prescott - IPCA")
  dev.off()
  
  message("Gráfico do filtro HP salvo em 'outputs/filtro_hp.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
