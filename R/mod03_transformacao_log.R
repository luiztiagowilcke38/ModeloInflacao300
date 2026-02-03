# Módulo 03: Transformação Logarítmica
# Objetivo: Estabilizar a variância da série
# Autor: Luiz Tiago Wilcke

library(tidyverse)

message("Iniciando Módulo 03: Transformação Logarítmica...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Para inflação, log(1 + x/100) é comum, ou apenas log se x > 0.
  # O IPCA pode ser negativo (deflação), então log direto pode ser problemático.
  # Vamos verificar mínimos.
  min_val <- min(dados$IPCA)
  
  if (min_val <= 0) {
    message("Série contém valores <= 0. Aplicando transformação constante + log.")
    constante <- abs(min_val) + 0.1
    dados$log_IPCA <- log(dados$IPCA + constante)
  } else {
    dados$log_IPCA <- log(dados$IPCA)
  }
  
  write_csv(dados, "data/dados_transformados.csv")
  message("Dados com log salvos em 'data/dados_transformados.csv'.")
  
} else {
  stop("Arquivo de entrada não encontrado.")
}
