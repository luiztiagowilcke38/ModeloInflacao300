# Módulo 36: Geração de Cenário Otimista
# Objetivo: Simular cenário de inflação baixa
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 36: Cenário Otimista...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  
  # Horizonte: até 2040. Assumindo dados até 2025 aprox. 
  # 2026 a 2040 = 15 anos = 180 meses.
  h_horizon <- 180 
  
  # Otimista: Usar limite inferior do intervalo de 80% ou impor choque negativo
  fc <- forecast(fit_sarima, h = h_horizon, level = c(80, 95))
  
  # Construir série otimista (limite inferior 80%)
  cenario_otimista <- fc$lower[, "80%"]
  
  # Ajuste para não ser negativo se não fizer sentido ecônomico (deflação persistente é raro no BR, mas possível)
  # Vamos manter como está estatisticamente.
  
  df_otimista <- data.frame(
    Data = seq(max(time(fit_sarima$x)) + 1/12, by = 1/12, length.out = h_horizon),
    IPCA_Otimista = as.numeric(cenario_otimista)
  )
  
  write_csv(df_otimista, "outputs/cenario_otimista_2026_2040.csv")
  
  png("outputs/plot_cenario_otimista.png", width = 800, height = 600)
  plot(fc, main = "Cenário Otimista (2026-2040)", showgap = FALSE)
  lines(ts(cenario_otimista, start = start(fc$mean), frequency = 12), col = "green", lwd = 2)
  legend("topleft", legend = c("Previsão Base", "Otimista (Low 80)"), col = c("blue", "green"), lty = 1)
  dev.off()
  
  message("Cenário otimista salvo em 'outputs'.")
  
} else {
  stop("Modelo SARIMA não encontrado.")
}
