# Módulo 35: Validação Janela Deslizante (Rolling Window)
# Objetivo: Testar estabilidade da previsão
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 35: Rolling Window...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  # Usar tsCV para validação cruzada
  # Modelo ARIMA fixo ou reestimado
  # Reestimar demora, então vamos usar um modelo fixo simples para demonstração
  
  # Otimização: Ajustar um modelo base e reutilizar os parâmetros (muito mais rápido)
  # e validar apenas nos últimos 5 anos (60 meses)
  fit_base <- auto.arima(ts_ipca, stepwise=TRUE, approximation=TRUE)
  
  f <- function(y, h) {
    # Reutiliza o modelo ajustado (não re-seleciona ordens)
    Arima(y, model = fit_base) %>% forecast(h=h)
  }
  
  # initial defines the starting point. Let's do last 60 observations.
  initial_window <- length(ts_ipca) - 60
  error_metrics <- tsCV(ts_ipca, f, h=1, initial = initial_window)
  
  mae <- mean(abs(error_metrics), na.rm = TRUE)
  rmse <- sqrt(mean(error_metrics^2, na.rm = TRUE))
  
  write_lines(paste("MAE (Cross-Validation 1-step):", mae), "outputs/resultado_cv.txt")
  write_lines(paste("RMSE (Cross-Validation 1-step):", rmse), "outputs/resultado_cv.txt", append = TRUE)
  
  png("outputs/erros_cv.png")
  plot(error_metrics, main = "Erros de Previsão (Cross-Validation)", ylab = "Erro")
  abline(h=0, col="red")
  dev.off()
  
  message("Validação cruzada concluída. Resultados em outputs.")
  
} else {
  stop("Dados limpos não encontrados.")
}
