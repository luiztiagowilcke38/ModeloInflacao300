# Módulo 34: Regressão Dinâmica (ARIMAX)
# Objetivo: ARIMA com variáveis exógenas
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 34: ARIMAX...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  ts_ipca <- ts(dados$IPCA, start = c(2000, 1), frequency = 12)
  
  # Simulando variável exógena (ex: taxa de juros defasada ou gap do produto)
  set.seed(999)
  xreg_sim <- dados$IPCA + rnorm(length(ts_ipca), 0, 0.5)
  ts_xreg <- ts(xreg_sim, start = c(2000, 1), frequency = 12)
  
  fit_arimax <- auto.arima(ts_ipca, xreg = ts_xreg)
  
  capture.output({
    print("Modelo ARIMAX Ajustado:")
    print(fit_arimax)
  }, file = "outputs/resultado_arimax.txt")
  
  # Para prever, precisamos dos valores futuros do xreg
  # Aqui simulamos futuros
  xreg_future <- ts(rep(mean(xreg_sim), 24), start = end(ts_xreg)+c(0,1), frequency=12)
  fc_arimax <- forecast(fit_arimax, xreg = xreg_future, h = 24)
  
  png("outputs/previsao_arimax.png")
  plot(fc_arimax, main = "Previsão ARIMAX (com regressor exógeno simulado)")
  dev.off()
  
  message("ARIMAX salvo em 'outputs/previsao_arimax.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
