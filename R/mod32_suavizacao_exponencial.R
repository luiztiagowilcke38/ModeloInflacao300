# Módulo 32: Suavização Exponencial (ETS)
# Objetivo: Modelo Error-Trend-Seasonal (State Space)
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 32: Ajuste ETS...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  fit_ets <- ets(ts_ipca)
  
  capture.output({
    print("Modelo ETS Selecionado Automaticamente:")
    print(fit_ets) # Ex: ETS(A,N,A)
  }, file = "outputs/resultado_ets.txt")
  
  png("outputs/previsao_ets.png", width = 800, height = 600)
  plot(forecast(fit_ets, h = 24), main = "Previsão ETS (24 meses)")
  dev.off()
  
  saveRDS(fit_ets, "outputs/modelo_ets.rds")
  message("Modelo ETS salvo em 'outputs/modelo_ets.rds'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
