# Módulo 29: Ajuste VECM (Vetor de Correção de Erros)
# Objetivo: Modelar curto e longo prazo simultaneamente
# Autor: Luiz Tiago Wilcke

library(tsDyn)
library(tidyverse)

message("Iniciando Módulo 29: Ajuste VECM...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  set.seed(123)
  y2 <- dados$IPCA * 1.5 + rnorm(nrow(dados), 0, 2)
  df_vecm <- data.frame(IPCA = dados$IPCA, Var2 = y2)
  
  # Ajuste VECM
  # lag=2 no VAR implica lag=1 no VECM
  vecm_fit <- VECM(df_vecm, lag = 2, r = 1, include = "const", estim = "ML")
  
  capture.output({
    print("Modelo VECM Ajustado:")
    summary(vecm_fit)
  }, file = "outputs/resultado_vecm.txt")
  
  saveRDS(vecm_fit, "outputs/modelo_vecm.rds")
  message("Modelo VECM salvo em 'outputs/modelo_vecm.rds'.")
  
} else {
  stop("Dados não encontrados.")
}
