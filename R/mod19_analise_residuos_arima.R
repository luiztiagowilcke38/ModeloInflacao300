# Módulo 19: Análise de Resíduos (ARIMA)
# Objetivo: Diagnóstico do modelo
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 19: Diagnóstico de Resíduos...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  
  png("outputs/diagnostico_residuos_sarima.png", width = 800, height = 600)
  checkresiduals(fit_sarima)
  dev.off()
  
  # Teste de Ljung-Box formal
  lb_test <- Box.test(residuals(fit_sarima), type = "Ljung-Box")
  
  capture.output({
    print("Teste de Ljung-Box nos Resíduos:")
    print(lb_test)
  }, file = "outputs/teste_ljung_box.txt", append = TRUE)
  
  message("Diagnóstico salvo em 'outputs'.")
  
} else {
  stop("Modelo SARIMA não encontrado. Execute o Modulo 18.")
}
