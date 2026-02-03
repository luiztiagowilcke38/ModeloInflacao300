# Módulo 31: Modelo Prophet
# Objetivo: Previsão com componentes de sazonalidade robustos
# Autor: Luiz Tiago Wilcke

library(prophet)
library(tidyverse)

message("Iniciando Módulo 31: Ajuste Prophet...")

if (file.exists("data/dados_limpos.csv")) {
  dados <- read_csv("data/dados_limpos.csv", show_col_types = FALSE)
  
  # Prophet exige colunas 'ds' (data) e 'y' (valor)
  if (!"date" %in% names(dados)) {
    dados$ds <- seq(as.Date("2000-01-01"), by = "month", length.out = nrow(dados))
  } else {
    dados$ds <- dados$date
  }
  dados$y <- dados$IPCA
  
  # Ajuste
  m <- prophet(dados, daily.seasonality = FALSE, weekly.seasonality = FALSE)
  
  # Previsão
  future <- make_future_dataframe(m, periods = 24, freq = "month")
  forecast <- predict(m, future)
  
  png("outputs/previsao_prophet.png", width = 800, height = 600)
  plot(m, forecast) + ggtitle("Previsão Prophet - IPCA")
  dev.off()
  
  png("outputs/componentes_prophet.png", width = 800, height = 600)
  prophet_plot_components(m, forecast)
  dev.off()
  
  saveRDS(m, "outputs/modelo_prophet.rds")
  message("Resultados do Prophet salvos em 'outputs'.")
  
} else {
  stop("Dados limpos não encontrados.")
}
