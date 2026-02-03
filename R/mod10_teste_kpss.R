# Módulo 10: Teste KPSS
# Objetivo: Verificar estacionariedade (H0: estacionária)
# Autor: Luiz Tiago Wilcke

library(urca)
library(tidyverse)

message("Iniciando Módulo 10: Teste KPSS...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  kpss_test <- ur.kpss(dados$IPCA, type = "mu")
  
  capture.output({
    print("Resumo do Teste KPSS (Série em Nível):")
    summary(kpss_test)
  }, file = "outputs/resultado_kpss.txt")
  
  message("Resultado KPSS salvo em 'outputs/resultado_kpss.txt'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
