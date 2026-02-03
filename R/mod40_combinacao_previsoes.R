# Módulo 40: Combinação de Previsões (Ensemble)
# Objetivo: Média ponderada de múltiplos modelos
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)
library(prophet)

message("Iniciando Módulo 40: Ensemble...")

# Carregar modelos salvos ou previsões
modelos <- list()
h <- 180 # 2026-2040

previsoes <- matrix(NA, nrow = h, ncol = 0)
nomes_modelos <- c()

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  fc_sarima <- forecast(fit_sarima, h = h)$mean
  previsoes <- cbind(previsoes, as.numeric(fc_sarima))
  nomes_modelos <- c(nomes_modelos, "SARIMA")
}

if (file.exists("outputs/modelo_ets.rds")) {
  fit_ets <- readRDS("outputs/modelo_ets.rds")
  fc_ets <- forecast(fit_ets, h = h)$mean
  previsoes <- cbind(previsoes, as.numeric(fc_ets))
  nomes_modelos <- c(nomes_modelos, "ETS")
}

if (file.exists("outputs/modelo_prophet.rds")) {
  # Prophet requer dataframe de datas futuras
  # Assumindo mod31 rodou e temos o objeto m
  m <- readRDS("outputs/modelo_prophet.rds")
  future <- make_future_dataframe(m, periods = h, freq = "month")
  # Precisamos filtrar apenas o futuro (últimos h)
  fc_prophet <- predict(m, future)$yhat
  fc_prophet <- tail(fc_prophet, h) 
  
  previsoes <- cbind(previsoes, as.numeric(fc_prophet))
  nomes_modelos <- c(nomes_modelos, "Prophet")
}

if (length(nomes_modelos) > 0) {
  colnames(previsoes) <- nomes_modelos
  
  # Ensemble: Média Simples
  ensemble_forecast <- rowMeans(previsoes)
  
  df_ensemble <- data.frame(
    Data = seq(as.Date("2026-01-01"), by = "month", length.out = h), # Ajustar data conforme ultimo dado real
    Ensemble = ensemble_forecast
  )
  
  # Adicionar previsões individuais
  df_combined <- cbind(df_ensemble, previsoes)
  
  write_csv(df_combined, "outputs/previsao_ensemble_2026_2040.csv")
  
  # Plot
  png("outputs/comparacao_ensemble.png", width = 1000, height = 600)
  plot(ts(ensemble_forecast, start = 2026, frequency = 12), 
       lwd = 3, col = "black", main = "Comparação de Modelos e Ensemble (2026-2040)",
       ylim = range(previsoes), ylab = "IPCA Previsto")
  
  cores <- rainbow(length(nomes_modelos))
  for(i in 1:length(nomes_modelos)) {
    lines(ts(previsoes[,i], start = 2026, frequency = 12), col = cores[i], lty = 2)
  }
  legend("topleft", legend = c("Ensemble (Média)", nomes_modelos), 
         col = c("black", cores), lty = c(1, rep(2, length(nomes_modelos))), lwd = c(3, rep(1, length(nomes_modelos))))
  dev.off()
  
  message("Ensemble calculado e salvo.")
  
} else {
  message("Nenhum modelo disponível para ensemble.")
}
