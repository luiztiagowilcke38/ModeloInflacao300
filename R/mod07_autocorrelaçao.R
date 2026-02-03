# Módulo 07: Autocorrelação (ACF e PACF)
# Objetivo: Analisar dependência serial
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 07: Autocorrelação...")

if (file.exists("data/dados_diferenciados.csv")) {
  dados <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
  
  # Usar a série diferenciada para verificar se restou correlação
  ts_diff <- na.omit(dados$diff_log_IPCA)
  
  png("outputs/plot_acf_pacf.png", width = 800, height = 600)
  par(mfrow = c(2, 1))
  Acf(ts_diff, main = "Função de Autocorrelação (ACF) - Série Diferenciada")
  Pacf(ts_diff, main = "Autocorrelação Parcial (PACF) - Série Diferenciada")
  dev.off()
  
  message("Gráficos ACF/PACF salvos em 'outputs/plot_acf_pacf.png'.")
  
} else {
  stop("Dados diferenciados não encontrados.")
}
