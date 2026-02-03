# Módulo 09: Teste Augmented Dickey-Fuller (ADF)
# Objetivo: Verificar raiz unitária (estacionariedade)
# Autor: Luiz Tiago Wilcke

library(urca)
library(tidyverse)

message("Iniciando Módulo 09: Teste ADF...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Teste na série em nível
  adf_test <- ur.df(dados$IPCA, type = "drift", selectlags = "AIC")
  
  capture.output({
    print("Resumo do Teste ADF (Série em Nível):")
    summary(adf_test)
  }, file = "outputs/resultado_adf.txt")
  
  message("Resultado ADF salvo em 'outputs/resultado_adf.txt'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
