# Módulo 26: Teste de Causalidade de Granger
# Objetivo: Verificar precedência temporal entre variáveis
# Autor: Luiz Tiago Wilcke

library(vars)
library(tidyverse)

message("Iniciando Módulo 26: Causalidade de Granger...")

if (file.exists("data/dados_diferenciados.csv")) {
  dados <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
  
  # Precisamos de pelo menos 2 variáveis. Vamos criar uma dummy ou usar outra se houver.
  # Como só coletamos IPCA, vamos simular uma variável exógena (ex: Câmbio) para demonstração ou placeholder.
  # Em projeto real, mod01 deveria coletar mais variáveis.
  
  set.seed(123)
  cambio_simulado <- dados$diff_log_IPCA + rnorm(nrow(dados), 0, 0.01)
  
  df_var <- data.frame(
    IPCA = na.omit(dados$diff_log_IPCA),
    Cambio = na.omit(cambio_simulado) # Alinhando tamanhos
  )
  
  # Teste de Granger
  # H0: Cambio não causa IPCA
  granger_test <- var(df_var) # var() é variância, vars::VAR é o modelo
  
  modelo_var <- VAR(df_var, p = 2, type = "const")
  causality_result <- causality(modelo_var, cause = "Cambio")
  
  capture.output({
    print("Teste de Causalidade de Granger (Cambio -> IPCA):")
    print(causality_result)
  }, file = "outputs/resultado_granger.txt")
  
  message("Resultado Granger salvo em 'outputs/resultado_granger.txt'.")
  
} else {
  stop("Dados diferenciados não encontrados.")
}
