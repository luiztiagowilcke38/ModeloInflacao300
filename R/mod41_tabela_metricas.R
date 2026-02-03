# Módulo 41: Tabela de Métricas
# Objetivo: Comparar desempenho dos modelos
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)
library(writexl)

message("Iniciando Módulo 41: Tabela de Métricas...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  # Métricas
  metricas <- data.frame(Modelo = character(), RMSE = numeric(), MAE = numeric(), MAPE = numeric())
  
  # SARIMA
  if (file.exists("outputs/modelo_sarima.rds")) {
    fit <- readRDS("outputs/modelo_sarima.rds")
    acc <- accuracy(fit)
    metricas <- rbind(metricas, data.frame(Modelo = "SARIMA", RMSE = acc[2], MAE = acc[3], MAPE = acc[5]))
  }
  
  # ETS
  if (file.exists("outputs/modelo_ets.rds")) {
    fit <- readRDS("outputs/modelo_ets.rds")
    acc <- accuracy(fit)
    metricas <- rbind(metricas, data.frame(Modelo = "ETS", RMSE = acc[2], MAE = acc[3], MAPE = acc[5]))
  }
  
  # TBATS
  # TBATS object não funciona direto com accuracy() padrão as vezes, mas vamos tentar
  
  print(metricas)
  write_xlsx(metricas, "outputs/tabela_metricas_final.xlsx")
  message("Tabela de métricas salva em 'outputs/tabela_metricas_final.xlsx'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
