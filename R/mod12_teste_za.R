# Módulo 12: Teste Zivot-Andrews
# Objetivo: Verificar estacionariedade com quebra estrutural
# Autor: Luiz Tiago Wilcke

library(urca)
library(tidyverse)

message("Iniciando Módulo 12: Teste Zivot-Andrews...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Teste ZA para quebra na tendência
  za_test <- ur.za(dados$IPCA, model = "trend", lag = NULL)
  
  capture.output({
    print("Resumo do Teste Zivot-Andrews:")
    summary(za_test)
  }, file = "outputs/resultado_za.txt")
  
  # Plotar resultado
  png("outputs/plot_za_test.png")
  plot(za_test)
  dev.off()
  
  message("Resultado ZA salvo em 'outputs/resultado_za.txt' e gráfico gerado.")
  
} else {
  stop("Dados limpos não encontrados.")
}
