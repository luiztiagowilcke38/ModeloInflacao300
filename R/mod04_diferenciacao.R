# Módulo 04: Diferenciação
# Objetivo: Tornar a série estacionária
# Autor: Luiz Tiago Wilcke

library(tidyverse)

message("Iniciando Módulo 04: Diferenciação...")

if (file.exists("data/dados_transformados.csv")) {
  dados <- read_csv("data/dados_transformados.csv", show_col_types = FALSE)
  
  # Primeira diferença no log IPCA
  # diff() retorna vetor menor, precisamos preencher ou ajustar
  dados$diff_log_IPCA <- c(NA, diff(dados$log_IPCA))
  
  # Segunda diferença (se necessário, mas calculamos aqui por precaução)
  dados$diff2_log_IPCA <- c(NA, NA, diff(diff(dados$log_IPCA)))

  # Salvar removendo NAs iniciais se desejar, mas para manter alinhamento temporal, mantemos NA
  write_csv(dados, "data/dados_diferenciados.csv")
  message("Dados diferenciados salvos em 'data/dados_diferenciados.csv'.")
  
} else {
  stop("Arquivo de dados transformados não encontrado.")
}
