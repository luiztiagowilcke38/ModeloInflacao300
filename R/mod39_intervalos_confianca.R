# Módulo 39: Intervalos de Confiança (Fan Chart)
# Objetivo: Visualizar incerteza crescente
# Autor: Luiz Tiago Wilcke

library(forecast)
# library(ggfan) # Removido por falha na instalação
library(tidyverse)
library(ggplot2)

message("Iniciando Módulo 39: Fan Chart...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  h_horizon <- 180
  
  fc <- forecast(fit_sarima, h = h_horizon, level = c(50, 80, 95))
  
  # Preparar dados para ggplot
  autoplot(fc) +
    labs(title = "Fan Chart - Projeção de Inflação 2026-2040", 
         x = "Ano", y = "IPCA") +
    theme_minimal()
  
  ggsave("outputs/fan_chart_inflacao.png", width = 10, height = 6)
  
  message("Fan Chart salvo em 'outputs/fan_chart_inflacao.png'.")
  
} else {
  stop("Modelo SARIMA não encontrado.")
}
