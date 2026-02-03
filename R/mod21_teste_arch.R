# Módulo 21: Teste ARCH
# Objetivo: Verificar heterocedasticidade condicional (efeitos ARCH)
# Autor: Luiz Tiago Wilcke

library(FinTS)
library(tidyverse)
library(forecast)

message("Iniciando Módulo 21: Teste ARCH...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  residuos <- residuals(fit_sarima)
  
  # Teste LM para efeitos ARCH
  arch_test <- ArchTest(residuos, lags = 12)
  
  capture.output({
    print("Teste LM para Efeitos ARCH:")
    print(arch_test)
  }, file = "outputs/teste_arch.txt")
  
  # Quadrado dos resíduos
  png("outputs/residuos_quadrado.png")
  plot(residuos^2, main = "Quadrado dos Resíduos (Volatilidade Proxy)")
  dev.off()
  
  message("Resultado ARCH salvo em 'outputs/teste_arch.txt'.")
  
} else {
  stop("Modelo SARIMA não encontrado para extração de resíduos.")
}
