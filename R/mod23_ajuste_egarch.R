# Módulo 23: Ajuste EGARCH
# Objetivo: Modelar efeitos assimétricos na volatilidade
# Autor: Luiz Tiago Wilcke

library(rugarch)
library(tidyverse)

message("Iniciando Módulo 23: Ajuste EGARCH...")

if (file.exists("data/dados_diferenciados.csv")) {
  dados_diff <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
  serie_garch <- na.omit(dados_diff$diff_log_IPCA)

  spec_egarch <- ugarchspec(
    variance.model = list(model = "eGARCH", garchOrder = c(1, 1)),
    mean.model = list(armaOrder = c(1, 1), include.mean = TRUE),
    distribution.model = "norm"
  )
  
  fit_egarch <- ugarchfit(spec = spec_egarch, data = serie_garch)
  
  capture.output({
    print("Modelo EGARCH (Exponencial):")
    show(fit_egarch)
  }, file = "outputs/resultado_egarch.txt")
  
  saveRDS(fit_egarch, "outputs/modelo_egarch.rds")
  message("Modelo EGARCH salvo em 'outputs/modelo_egarch.rds'.")
  
} else {
  stop("Dados diferenciados não encontrados.")
}
