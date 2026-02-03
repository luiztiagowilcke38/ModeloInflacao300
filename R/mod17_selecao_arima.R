# Módulo 17: Seleção ARIMA
# Objetivo: Identificar melhores parâmetros (p,d,q)
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 17: Seleção Automática ARIMA...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  # Auto ARIMA
  fit_arima <- auto.arima(ts_ipca, seasonal = FALSE, stepwise = FALSE, approximation = FALSE, trace = TRUE)
  
  capture.output({
    print("Melhor Modelo ARIMA Selecionado:")
    print(fit_arima)
  }, file = "outputs/resultado_arima_selection.txt")
  
  saveRDS(fit_arima, "outputs/modelo_arima_otimo.rds")
  message("Modelo ARIMA salvo em 'outputs/modelo_arima_otimo.rds'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
