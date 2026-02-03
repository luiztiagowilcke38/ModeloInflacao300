# Módulo 08: Teste de Normalidade
# Objetivo: Verificar distribuição dos dados
# Autor: Luiz Tiago Wilcke

library(tseries)
library(tidyverse)

message("Iniciando Módulo 08: Testes de Normalidade...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Teste na série original
  jb_test <- jarque.bera.test(dados$IPCA)
  shapiro_test <- shapiro.test(dados$IPCA)
  
  capture.output({
    print("Teste Jarque-Bera:")
    print(jb_test)
    print("Teste Shapiro-Wilk:")
    print(shapiro_test)
  }, file = "outputs/resultados_normalidade.txt")
  
  # QQ Plot
  png("outputs/qqplot_normalidade.png")
  qqnorm(dados$IPCA, main = "Q-Q Plot - IPCA")
  qqline(dados$IPCA, col = "red")
  dev.off()
  
  message("Resultados de normalidade salvos em 'outputs'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
