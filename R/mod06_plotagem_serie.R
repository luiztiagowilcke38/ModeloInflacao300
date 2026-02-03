# Módulo 06: Plotagem da Série
# Objetivo: Visualizar comportamento histórico
# Autor: Luiz Tiago Wilcke

library(tidyverse)
library(ggplot2)

message("Iniciando Módulo 06: Plotagem da Série...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Converter para objeto ts ou manter df para ggplot
  # Supondo que temos uma coluna de data. Se não, criamos baseada no início (2000-01)
  if (!"date" %in% names(dados)) {
    # Tentar criar datas se não existirem
    dados$date <- seq(as.Date("2000-01-01"), by = "month", length.out = nrow(dados))
  }
  
  p <- ggplot(dados, aes(x = date, y = IPCA)) +
    geom_line(color = "darkblue", size = 1) +
    labs(title = "Evolução Histórica da Inflação (IPCA)",
         subtitle = "Período: 2000 - Presente",
         x = "Data", y = "IPCA Mensal (%)") +
    theme_minimal()
  
  ggsave("outputs/plot_serie_historica.png", plot = p, width = 10, height = 6)
  message("Gráfico salvo em 'outputs/plot_serie_historica.png'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
