# Módulo 22: Ajuste GARCH(1,1) Padrão
# Objetivo: Modelar a volatilidade da inflação
# Autor: Luiz Tiago Wilcke

library(rugarch)
library(tidyverse)

message("Iniciando Módulo 22: Ajuste GARCH(1,1)...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  # Usar retornos ou primeira diferença se necessário. GARCH geralmente em séries estacionárias.
  # Vamos usar a log diferença calculada no mod04 se possível, ou calcular na hora.
  
  if (file.exists("data/dados_diferenciados.csv")) {
     dados_diff <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
     serie_garch <- na.omit(dados_diff$diff_log_IPCA)
  } else {
     # Fallback
     serie_garch <- diff(log(dados$IPCA))
  }

  # Especificação do Modelo: ARMA(1,1) na média + GARCH(1,1) na variância
  spec <- ugarchspec(
    variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
    mean.model = list(armaOrder = c(1, 1), include.mean = TRUE),
    distribution.model = "norm"
  )
  
  fit_garch <- ugarchfit(spec = spec, data = serie_garch)
  
  capture.output({
    print("Modelo GARCH(1,1) Padrão:")
    show(fit_garch)
  }, file = "outputs/resultado_garch.txt")
  
  saveRDS(fit_garch, "outputs/modelo_garch.rds")
  message("Modelo GARCH salvo em 'outputs/modelo_garch.rds'.")
  
} else {
  stop("Dados não encontrados.")
}
