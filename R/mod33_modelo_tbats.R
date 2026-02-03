# Módulo 33: Modelo TBATS
# Objetivo: Sazonalidade complexa/múltipla
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 33: Ajuste TBATS...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  fit_tbats <- tbats(ts_ipca)
  
  png("outputs/componentes_tbats.png", width = 800, height = 600)
  plot(fit_tbats, main = "Decomposição TBATS")
  dev.off()
  
  # Previsão
  fc_tbats <- forecast(fit_tbats, h = 24)
  
  png("outputs/previsao_tbats.png", width = 800, height = 600)
  plot(fc_tbats, main = "Previsão TBATS")
  dev.off()
  
  message("Modelo TBATS processado e gráficos salvos.")
  
} else {
  stop("Dados limpos não encontrados.")
}
