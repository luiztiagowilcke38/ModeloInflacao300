# Módulo 18: Ajuste SARIMA
# Objetivo: Ajustar modelo com componente sazonal
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 18: Ajuste SARIMA...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  # Auto ARIMA permitindo sazonalidade
  fit_sarima <- auto.arima(ts_ipca, seasonal = TRUE, stepwise = FALSE, approximation = FALSE)
  
  capture.output({
    print("Modelo SARIMA Ajustado:")
    print(fit_sarima)
  }, file = "outputs/resultado_sarima.txt")
  
  saveRDS(fit_sarima, "outputs/modelo_sarima.rds")
  message("Modelo SARIMA salvo em 'outputs/modelo_sarima.rds'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
