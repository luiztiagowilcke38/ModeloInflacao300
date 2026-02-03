# Arquivo Principal: Modelo de Previsão de Inflação (2026-2040)
# Autor: Luiz Tiago Wilcke
# Data: 2026

# Configuração Inicial
options(warn = -1)
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Função para instalar e carregar pacotes
instalar_carregar <- function(pacote) {
  if (!require(pacote, character.only = TRUE)) {
    install.packages(pacote, dependencies = TRUE)
    library(pacote, character.only = TRUE)
  }
}

# Lista de pacotes necessários
pacotes <- c(
  "tidyverse", "forecast", "tseries", "readxl", "writexl", 
  "rbcb", "urca", "lmtest", "strucchange", "prophet", "vars", 
  "rugarch", "tsDyn", "ggplot2", "gridExtra",
  "imputeTS", "psych", "mFilter", "FinTS", "wavelets"
)

# Carregar pacotes
sapply(pacotes, instalar_carregar)

# Diretórios
dir_R <- "R"
dir_data <- "data"
dir_outputs <- "outputs"

# Função para executar módulos
executar_modulo <- function(nome_arquivo) {
  caminho_arquivo <- file.path(dir_R, nome_arquivo)
  if (file.exists(caminho_arquivo)) {
    message(paste("Executando:", nome_arquivo))
    source(caminho_arquivo)
    message(paste("Concluído:", nome_arquivo))
  } else {
    warning(paste("Arquivo não encontrado:", nome_arquivo))
  }
}

# --- Execução Sequencial dos Módulos ---

# 1. Preparação de Dados
executar_modulo("mod01_coleta_dados_bc.R")
executar_modulo("mod02_limpeza_dados.R")
executar_modulo("mod03_transformacao_log.R")
executar_modulo("mod04_diferenciacao.R")
executar_modulo("mod05_analise_descritiva.R")

# 2. Análise Exploratória e Decomposição
executar_modulo("mod06_plotagem_serie.R")
executar_modulo("mod07_autocorrelaçao.R")
executar_modulo("mod08_teste_normalidade.R")
executar_modulo("mod09_teste_adf.R")
executar_modulo("mod10_teste_kpss.R")

# 3. Estacionariedade e Filtros
executar_modulo("mod11_teste_pp.R")
executar_modulo("mod12_teste_za.R")
executar_modulo("mod13_decomposicao_stl.R")
executar_modulo("mod14_filtro_hodrick_prescott.R")
executar_modulo("mod15_analise_fourier.R")
executar_modulo("mod16_transformada_wavelet.R")

# 4. Modelagem ARIMA/SARIMA
executar_modulo("mod17_selecao_arima.R")
executar_modulo("mod18_ajuste_sarima.R")
executar_modulo("mod19_analise_residuos_arima.R")
executar_modulo("mod20_previsao_arima.R")

# 5. Volatilidade (GARCH)
executar_modulo("mod21_teste_arch.R")
executar_modulo("mod22_ajuste_garch_padrao.R")
executar_modulo("mod23_ajuste_egarch.R")
executar_modulo("mod24_ajuste_tgarch.R")
executar_modulo("mod25_simulacao_volatilidade.R")

# 6. Modelagem Multivariada (VAR/VECM)
executar_modulo("mod26_teste_causalidade_granger.R")
executar_modulo("mod27_teste_cointegracao_johansen.R")
executar_modulo("mod28_ajuste_var.R")
executar_modulo("mod29_ajuste_vecm.R")
executar_modulo("mod30_impulso_resposta.R")

# 7. Métodos Avançados e Machine Learning
executar_modulo("mod31_modelo_prophet.R")
executar_modulo("mod32_suavizacao_exponencial.R")
executar_modulo("mod33_modelo_tbats.R")
executar_modulo("mod34_regressao_dinamica.R")
executar_modulo("mod35_janela_deslizante.R")

# 8. Previsão e Simulação (2026-2040)
executar_modulo("mod36_geracao_cenarios_otimista.R")
executar_modulo("mod37_geracao_cenarios_pessimista.R")
executar_modulo("mod38_projecao_longo_prazo.R")
executar_modulo("mod39_intervalos_confianca.R")
executar_modulo("mod40_combinacao_previsoes.R")

# 9. Relatórios Finais
executar_modulo("mod41_tabela_metricas.R")
executar_modulo("mod42_relatorio_final.R")

message("Execução do modelo finalizada com sucesso.")
