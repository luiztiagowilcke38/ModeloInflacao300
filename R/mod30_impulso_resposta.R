# Módulo 30: Funções de Resposta ao Impulso (IRF)
# Objetivo: Analisar choques exógenos
# Autor: Luiz Tiago Wilcke

library(vars)
library(tidyverse)

message("Iniciando Módulo 30: Resposta ao Impulso...")

if (file.exists("outputs/modelo_var.rds")) {
  modelo_var <- readRDS("outputs/modelo_var.rds")
  
  # Choque no Cambio afetando IPCA
  irf_res <- irf(modelo_var, impulse = "Cambio", response = "IPCA", n.ahead = 24, boot = TRUE)
  
  png("outputs/impulso_resposta.png", width = 800, height = 600)
  plot(irf_res, main = "Resposta do IPCA ao Choque no Câmbio")
  dev.off()
  
  message("Gráfico IRF salvo em 'outputs/impulso_resposta.png'.")
  
} else {
  stop("Modelo VAR não encontrado.")
}
