# Módulo 37: Geração de Cenário Pessimista
# Objetivo: Simular cenário de inflação alta
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 37: Cenário Pessimista...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  
  h_horizon <- 180 # 2026-2040
  
  fc <- forecast(fit_sarima, h = h_horizon, level = c(80, 95))
  
  # Pessimista: Usar limite superior do intervalo de 80%
  cenario_pessimista <- fc$upper[, "80%"]
  
  df_pessimista <- data.frame(
    Data = seq(max(time(fit_sarima$x)) + 1/12, by = 1/12, length.out = h_horizon),
    IPCA_Pessimista = as.numeric(cenario_pessimista)
  )
  
  write_csv(df_pessimista, "outputs/cenario_pessimista_2026_2040.csv")
  
  png("outputs/plot_cenario_pessimista.png", width = 800, height = 600)
  plot(fc, main = "Cenário Pessimista (2026-2040)", showgap = FALSE)
  lines(ts(cenario_pessimista, start = start(fc$mean), frequency = 12), col = "red", lwd = 2)
  legend("topleft", legend = c("Previsão Base", "Pessimista (High 80)"), col = c("blue", "red"), lty = 1)
  dev.off()
  
  message("Cenário pessimista salvo em 'outputs'.")
  
} else {
  stop("Modelo SARIMA não encontrado.")
}
