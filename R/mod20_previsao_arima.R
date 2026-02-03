# Módulo 20: Previsão ARIMA
# Objetivo: Previsão pontual de curto/médio prazo
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)
library(ggplot2)

message("Iniciando Módulo 20: Previsão com SARIMA...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  
  # Previsão para 24 meses (apenas ilustrativo aqui, o projeto pede até 2040 depois)
  forecast_sarima <- forecast(fit_sarima, h = 24)
  
  png("outputs/previsao_sarima_curto_prazo.png", width = 800, height = 600)
  plot(forecast_sarima, main = "Previsão SARIMA (24 meses)")
  dev.off()
  
  # Salvar dados previstos
  df_forecast <- data.frame(
    Data = seq(max(time(fit_sarima$x)) + 1/12, by = 1/12, length.out = 24),
    Ponto = as.numeric(forecast_sarima$mean),
    Lo80 = as.numeric(forecast_sarima$lower[,1]),
    Hi80 = as.numeric(forecast_sarima$upper[,1]),
    Lo95 = as.numeric(forecast_sarima$lower[,2]),
    Hi95 = as.numeric(forecast_sarima$upper[,2])
  )
  
  write_csv(df_forecast, "outputs/previsao_sarima_24m.csv")
  message("Previsão salva em 'outputs/previsao_sarima_24m.csv'.")
  
} else {
  stop("Modelo SARIMA não encontrado.")
}
