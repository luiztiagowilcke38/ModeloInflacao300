# Módulo 27: Teste de Cointegração de Johansen
# Objetivo: Verificar relação de longo prazo
# Autor: Luiz Tiago Wilcke

library(urca)
library(tidyverse)

message("Iniciando Módulo 27: Teste de Johansen...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Simulando variável I(1) cointegrada para teste
  set.seed(123)
  y2 <- dados$IPCA * 1.5 + rnorm(nrow(dados), 0, 2)
  
  df_cointegracao <- data.frame(IPCA = dados$IPCA, Var2 = y2)
  
  johansen_test <- ca.jo(df_cointegracao, type = "trace", ecdet = "const", K = 2)
  
  capture.output({
    print("Resumo do Teste de Johansen:")
    summary(johansen_test)
  }, file = "outputs/resultado_johansen.txt")
  
  message("Resultado Johansen salvo em 'outputs/resultado_johansen.txt'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
