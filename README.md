# Modelo de Previsão de Inflação (2026-2040)

**Autor:** Luiz Tiago Wilcke  
**Linguagem:** R  

## Descrição
Este projeto implementa um modelo estatístico avançado de séries temporais para prever a inflação brasileira (IPCA) no período de 2026 a 2040. O sistema é composto por **42 módulos** independentes que cobrem desde a coleta de dados até a simulação de cenários de longo prazo, utilizando técnicas clássicas e de aprendizado de máquina.

## Fundamentação Teórica e Equações

O modelo utiliza diversas abordagens matemáticas para capturar a dinâmica da inflação. Abaixo estão as principais definições matemáticas dos modelos implementados.

### 1. Modelo SARIMA (Seasonal AutoRegressive Integrated Moving Average)
O modelo SARIMA $(p,d,q) \times (P,D,Q)_s$ é definido por:

$$
\phi_p(B) \Phi_P(B^s) (1 - B)^d (1 - B^s)^D y_t = \theta_q(B) \Theta_Q(B^s) \epsilon_t
$$

Onde:
*   $y_t$ é a série temporal transformada (log, diferenças).
*   $B$ é o operador de defasagem (Backshift), tal que $B y_t = y_{t-1}$.
*   $\phi_p(B) = 1 - \phi_1 B - \dots - \phi_p B^p$ é a parte autorregressiva.
*   $\theta_q(B) = 1 + \theta_1 B + \dots + \theta_q B^q$ é a parte de médias móveis.
*   $\Phi_P(B^s)$ e $\Theta_Q(B^s)$ são os polinômios sazonais.
*   $s$ é o período sazonal (12 para dados mensais).
*   $\epsilon_t \sim N(0, \sigma^2)$ é o ruído branco.

### 2. Volatilidade Condicional: GARCH(1,1)
A heterocedasticidade da inflação é modelada por um processo GARCH (Generalized Autoregressive Conditional Heteroskedasticity):

$$
\sigma_t^2 = \omega + \alpha \epsilon_{t-1}^2 + \beta \sigma_{t-1}^2
$$

Onde:
*   $\sigma_t^2$ é a variância condicional no tempo $t$.
*   $\omega > 0$ é a constante.
*   $\alpha \geq 0$ é o termo ARCH (choques passados).
*   $\beta \geq 0$ é o termo GARCH (persistência da volatilidade).
*   Restrição de estabilidade: $\alpha + \beta < 1$.

### 3. Modelo Prophet
Para capturar tendências não lineares e efeitos de feriados, utilizamos o modelo aditivo decomponível:

$$
y(t) = g(t) + s(t) + h(t) + \epsilon_t
$$

Onde:
*   $g(t)$ é a função de crescimento (tendência), modelada logisticamente ou linearmente.
*   $s(t)$ representa a sazonalidade periódica (Fourier series):
    $$ s(t) = \sum_{n=1}^N \left( a_n \cos\left(\frac{2\pi n t}{P}\right) + b_n \sin\left(\frac{2\pi n t}{P}\right) \right) $$
*   $h(t)$ são os efeitos de feriados ou eventos irregulares.

### 4. Vetor de Correção de Erros (VECM)
Para modelar relações de longo prazo (cointegração) entre variáveis, utilizamos o VECM:

$$
\Delta y_t = \Pi y_{t-1} + \sum_{i=1}^{p-1} \Gamma_i \Delta y_{t-i} + \mu + \epsilon_t
$$

Onde $\Pi = \alpha \beta'$, sendo $\beta$ o vetor de cointegração e $\alpha$ a velocidade de ajuste ao equilíbrio.

## Estrutura do Projeto
- `R/`: Contém os 42 scripts (módulos) do modelo.
- `data/`: Armazena os dados brutos e processados (CSV).
- `outputs/`: Contém os resultados, gráficos e relatórios gerados.
- `main.R`: Script principal para execução sequencial do modelo.

## Como Executar
1. Certifique-se de que o R está instalado.
2. Instale as dependências executando o início do script `main.R`.
3. Rode o pipeline completo:
   ```bash
   Rscript main.R
   ```

## Resultados Esperados
Os gráficos gerados na pasta `outputs/` incluem:
*   **Fan Chart**: Projeção com intervalos de incerteza $(50\%, 80\%, 95\%)$.
*   **Decomposição STL**: Tendência, Sazonalidade e Ruído.
*   **Simulação de Volatilidade**: Caminhos possíveis para o desvio padrão da inflação.
*   **Análise Espectral**: Identificação de ciclos dominantes via Fourier e Wavelets.

---
*Projeto desenvolvido por Luiz Tiago Wilcke.*
