# Módulo 24: Ajuste TGARCH (GJR-GARCH)
# Objetivo: Modelar efeitos de limiar na volatilidade
# Autor: Luiz Tiago Wilcke

library(rugarch)
library(tidyverse)

message("Iniciando Módulo 24: Ajuste TGARCH...")

if (file.exists("data/dados_diferenciados.csv")) {
  dados_diff <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
  serie_garch <- na.omit(dados_diff$diff_log_IPCA)

  # No rugarch, GJR-GARCH é equivalente ao Threshold GARCH
  spec_tgarch <- ugarchspec(
    variance.model = list(model = "gjrGARCH", garchOrder = c(1, 1)),
    mean.model = list(armaOrder = c(1, 1), include.mean = TRUE),
    distribution.model = "norm"
  )
  
  fit_tgarch <- ugarchfit(spec = spec_tgarch, data = serie_garch)
  
  capture.output({
    print("Modelo TGARCH (GJR-GARCH):")
    show(fit_tgarch)
  }, file = "outputs/resultado_tgarch.txt")
  
  saveRDS(fit_tgarch, "outputs/modelo_tgarch.rds")
  
  # Plotar comparação de volatilidade
  png("outputs/comparacao_volatilidade_garch.png", width = 800, height = 600)
  plot(sigma(fit_tgarch), type = "l", col = "red", main = "Volatilidade Condicional (TGARCH)")
  dev.off()
  
  message("Modelo TGARCH salvo em 'outputs/modelo_tgarch.rds'.")
  
} else {
  stop("Dados diferenciados não encontrados.")
}
