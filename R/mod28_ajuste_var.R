# Módulo 28: Ajuste VAR (Vetores Autorregressivos)
# Objetivo: Modelar interdependência de curto prazo
# Autor: Luiz Tiago Wilcke

library(vars)
library(tidyverse)

message("Iniciando Módulo 28: Ajuste VAR...")

if (file.exists("data/dados_diferenciados.csv")) {
  dados <- read_csv("data/dados_diferenciados.csv", show_col_types = FALSE)
  
  # Usando placeholder para multivariado
  set.seed(123)
  cambio_simulado <- dados$diff_log_IPCA + rnorm(nrow(dados), 0, 0.01)
  df_var <- data.frame(IPCA = na.omit(dados$diff_log_IPCA), Cambio = na.omit(cambio_simulado))
  
  # Seleção de defasagem (lag)
  lag_select <- VARselect(df_var, lag.max = 10, type = "const")
  p_opt <- lag_select$selection["AIC(n)"]
  
  # Ajuste do modelo
  modelo_var <- VAR(df_var, p = p_opt, type = "const")
  
  capture.output({
    print("Modelo VAR Ajustado:")
    summary(modelo_var)
  }, file = "outputs/resultado_var.txt")
  
  saveRDS(modelo_var, "outputs/modelo_var.rds")
  message("Modelo VAR salvo em 'outputs/modelo_var.rds'.")
  
} else {
  stop("Dados diferenciados não encontrados.")
}
