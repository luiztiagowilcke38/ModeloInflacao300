# Módulo 01: Coleta de Dados do Banco Central
# Objetivo: Obter a série histórica do IPCA (433)
# Autor: Luiz Tiago Wilcke

library(rbcb)
library(tidyverse)

message("Iniciando Módulo 01: Coleta de Dados...")

# Tentar obter dados do SGS (Sistema Gerenciador de Séries Temporais)
# Código 433: IPCA - Variação mensal
tryCatch({
  dados_ipca <- rbcb::get_series(c(IPCA = 433), start_date = "2000-01-01")
  
  if (nrow(dados_ipca) > 0) {
    # Salvar dados brutos
    write_csv(dados_ipca, "data/dados_brutos_ipca.csv")
    message("Dados do IPCA coletados e salvos em 'data/dados_brutos_ipca.csv'.")
    
    # Exibir primeiras linhas
    print(head(dados_ipca))
  } else {
    stop("Nenhum dado retornado da API.")
  }
  
}, error = function(e) {
  message("Erro ao coletar dados do BCB: ", e$message)
  message("Tentando usar dados locais se existirem...")
})
