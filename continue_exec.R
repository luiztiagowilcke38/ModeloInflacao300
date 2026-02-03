# Script para continuar a execução a partir do Módulo 35
# Carrega configurações e pacotes do main.R original se necessário, 
# mas vamos carregar o básico aqui para garantir.

options(warn = -1)
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Função para executar (copiada do main.R)
executar_modulo <- function(nome_arquivo) {
  caminho_arquivo <- file.path("R", nome_arquivo)
  if (file.exists(caminho_arquivo)) {
    message(paste("Executando:", nome_arquivo))
    source(caminho_arquivo)
    message(paste("Concluído:", nome_arquivo))
  } else {
    warning(paste("Arquivo não encontrado:", nome_arquivo))
  }
}

# Módulos Restantes
#executar_modulo("mod35_janela_deslizante.R")
#executar_modulo("mod36_geracao_cenarios_otimista.R")
#executar_modulo("mod37_geracao_cenarios_pessimista.R")
#executar_modulo("mod38_projecao_longo_prazo.R")
#executar_modulo("mod39_intervalos_confianca.R")
executar_modulo("mod40_combinacao_previsoes.R")
executar_modulo("mod41_tabela_metricas.R")
executar_modulo("mod42_relatorio_final.R")

message("Execução de continuação finalizada.")
