# Módulo 02: Limpeza de Dados
# Objetivo: Tratar valores nulos e outliers
# Autor: Luiz Tiago Wilcke

library(tidyverse)
library(imputeTS)

message("Iniciando Módulo 02: Limpeza de Dados...")

if (file.exists("data/dados_brutos_ipca.csv")) {
  dados <- read_csv("data/dados_brutos_ipca.csv", show_col_types = FALSE)
  
  # Verificar e tratar valores nulos
  if (any(is.na(dados$IPCA))) {
    message("Valores nulos encontrados. Realizando imputação (interpolação linear)...")
    dados$IPCA <- na_interpolation(dados$IPCA)
  }
  
  # Identificação simples de outliers (apenas para log, sem remoção drástica)
  # Regra de 3 desvios padrão
  media <- mean(dados$IPCA)
  desvio <- sd(dados$IPCA)
  outliers <- which(abs(dados$IPCA - media) > 3 * desvio)
  
  if (length(outliers) > 0) {
    message(paste("Identificados", length(outliers), "outliers potenciais."))
    # Em séries temporais de inflação, outliers são importantes (choques), mantemos por enquanto.
  }
  
  write_csv(dados, "data/dados_limpos.csv")
  message("Dados limpos salvos em 'data/dados_limpos.csv'.")
  
} else {
  stop("Arquivo 'data/dados_brutos_ipca.csv' não encontrado. Execute o Modulo 01.")
}
