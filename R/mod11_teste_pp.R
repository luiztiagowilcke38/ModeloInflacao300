# Módulo 11: Teste Phillips-Perron (PP)
# Objetivo: Verificar estacionariedade (alternativa ao ADF)
# Autor: Luiz Tiago Wilcke

library(urca)
library(tidyverse)

message("Iniciando Módulo 11: Teste PP...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  pp_test <- ur.pp(dados$IPCA, type = "Z-tau", model = "constant", lags = "short")
  
  capture.output({
    print("Resumo do Teste PP (Série em Nível):")
    summary(pp_test)
  }, file = "outputs/resultado_pp.txt")
  
  message("Resultado PP salvo em 'outputs/resultado_pp.txt'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
