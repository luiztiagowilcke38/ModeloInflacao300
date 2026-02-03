# Módulo 38: Projeção de Longo Prazo (Bootstrap)
# Objetivo: Simular trajetórias considerando incerteza
# Autor: Luiz Tiago Wilcke

library(forecast)
library(tidyverse)

message("Iniciando Módulo 38: Projeção Longo Prazo (Bootstrap)...")

if (file.exists("outputs/modelo_sarima.rds")) {
  fit_sarima <- readRDS("outputs/modelo_sarima.rds")
  
  h_horizon <- 180 # 2026-2040
  
  # Simulação via Bootstrap
  simulacoes <- matrix(NA, nrow = h_horizon, ncol = 100)
  for(i in 1:100) {
    simulacoes[,i] <- simulate(fit_sarima, nsim = h_horizon, bootstrap = TRUE)
  }
  
  # Calcular média e intervalos das simulações
  media_sim <- rowMeans(simulacoes)
  
  df_longo_prazo <- data.frame(
    Data = seq(max(time(fit_sarima$x)) + 1/12, by = 1/12, length.out = h_horizon),
    IPCA_Medio = media_sim
  )
  
  write_csv(df_longo_prazo, "outputs/projecao_longo_prazo_bootstrap.csv")
  
  png("outputs/plot_bootstrap_2040.png", width = 800, height = 600)
  plot(fit_sarima$x, xlim = c(2020, 2040 + 15/12), main = "Projeção Bootstrap (2026-2040)", ylab="IPCA", ylim = range(simulacoes))
  for(i in 1:20) lines(ts(simulacoes[,i], start = end(fit_sarima$x), frequency = 12), col = alpha("grey", 0.5))
  lines(ts(media_sim, start = end(fit_sarima$x), frequency = 12), col = "blue", lwd = 2)
  dev.off()
  
  message("Projeção longo prazo salva em 'outputs'.")
  
} else {
  stop("Modelo SARIMA não encontrado.")
}
