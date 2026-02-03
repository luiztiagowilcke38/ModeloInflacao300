# Módulo 25: Simulação de Volatilidade
# Objetivo: Simular caminhos futuros da volatilidade
# Autor: Luiz Tiago Wilcke

library(rugarch)
library(tidyverse)

message("Iniciando Módulo 25: Simulação de Volatilidade...")

if (file.exists("outputs/modelo_garch.rds")) {
  fit_garch <- readRDS("outputs/modelo_garch.rds")
  
  # Simular 100 trajetórias para 24 meses
  sim_garch <- ugarchsim(fit_garch, n.sim = 24, m.sim = 100)
  
  png("outputs/simulacao_volatilidade.png", width = 800, height = 600)
  plot(sim_garch, which = "all") # Pode ser interativo, cuidado. Melhor plotar manualmente.
  # Plotar média das simulações da série
  plot(sim_garch@simulation$seriesSim[,1], type = 'l', col = 'gray', 
       ylim = range(sim_garch@simulation$seriesSim),
       main = "Simulação de Trajetórias (GARCH)", ylab = "Retornos Simulados")
  for(i in 2:20) lines(sim_garch@simulation$seriesSim[,i], col = 'gray')
  lines(rowMeans(sim_garch@simulation$seriesSim), col = "red", lwd = 2)
  dev.off()
  
  message("Gráfico de simulação salvo em 'outputs/simulacao_volatilidade.png'.")
  
} else {
  stop("Modelo GARCH não encontrado.")
}
