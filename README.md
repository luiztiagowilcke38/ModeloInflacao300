# Modelo de Previsão de Inflação (2026-2040)

**Autor:** Luiz Tiago Wilcke  
**Linguagem:** R  


## Descrição
Este projeto implementa um modelo estatístico avançado de séries temporais para prever a inflação brasileira (IPCA) no período de 2026 a 2040. O sistema é composto por **42 módulos** independentes que cobrem desde a coleta de dados até a simulação de cenários de longo prazo.

## Estrutura do Projeto
- `R/`: Contém os 42 scripts (módulos) do modelo.
- `data/`: Armazena os dados brutos e processados (CSV).
- `outputs/`: Contém os resultados, gráficos e relatórios gerados.
- `main.R`: Script principal para execução sequencial do modelo.

## Funcionalidades
1. **Coleta Automática**: Dados oficiais do Banco Central (SGS).
2. **Estatística Avançada**: Testes de Raiz Unitária (ADF, KPSS, PP, ZA), Cointegração e Causalidade.
3. **Modelagem**:
   - ARIMA/SARIMA (Sazonalidade)
   - GARCH/EGARCH/TGARCH (Volatilidade condicional)
   - VAR/VECM (Multivariado)
   - Machine Learning: Prophet, Redes Neurais (via bibliotecas híbridas se aplicável)
4. **Previsão Longo Prazo**: Bootstrap e Simulação de Monte Carlo até 2040.

## Como Executar
1. Abra o projeto no RStudio ou terminal.
2. Certifique-se de que os pacotes listados em `main.R` estão instalados.
3. Execute o script principal:
   ```R
   source("main.R")
   ```

## Resultados
Os principais resultados estarão na pasta `outputs/`:
- `previsao_ensemble_2026_2040.csv`: Previsão combinada dos modelos.
- `fan_chart_inflacao.png`: Gráfico de projeção com intervalos de confiança.
- `RELATORIO_FINAL_INFLACAO.txt`: Resumo da execução.

## Módulos
O sistema é dividido em 9 categorias:
1. Preparação de Dados (Mods 1-5)
2. Análise Exploratória (Mods 6-10)
3. Estacionariedade (Mods 11-15)
4. Modelagem Univariada (Mods 16-20)
5. Volatilidade (Mods 21-25)
6. Multivariada (Mods 26-30)
7. Avançados/ML (Mods 31-35)
8. Simulação (Mods 36-40)
9. Relatórios (Mods 41-42)

---
*Projeto desenvolvido por Luiz Tiago Wilcke.*
