# Módulo 05: Análise Descritiva
# Objetivo: Estatísticas básicas
# Autor: Luiz Tiago Wilcke

library(tidyverse)
library(psych)
library(writexl)

message("Iniciando Módulo 05: Análise Descritiva...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  stats <- describe(dados$IPCA)
  
  print(stats)
  
  # Salvar tabela de estatísticas
  stats_df <- as.data.frame(stats)
  write_xlsx(stats_df, "outputs/estatisticas_descritivas.xlsx")
  message("Estatísticas salvas em 'outputs/estatisticas_descritivas.xlsx'.")
  
  # Histograma básico
  png("outputs/histograma_ipca.png")
  hist(dados$IPCA, main = "Histograma IPCA", xlab = "IPCA", col = "skyblue", border = "white")
  dev.off()
  
} else {
  stop("Arquivo de dados não encontrado.")
}
