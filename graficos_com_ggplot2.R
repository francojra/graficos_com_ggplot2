
# Gráficos com ggplot2 ---------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jéanné Franco ---------------------------------------------------------------------------------------------------------
# Data: 04/04/2024 -------------------------------------------------------------------------------------------------------------------------

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(tidyverse) # Pacote para manipulação de dados e gráficos
library(ggthemes) # Pacote com temas para gráficos em ggplot2
library(visdat) # Pacote para visualizar dados com NAs
library(dados) # Pacote com conjunto de dados traduzidos para o português

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

dados <- dados::pinguins # Carregando dados de pinguins do pacote dados
view(dados) # Visualizando tabela de dados
glimpse(dados) # Visualizando classes de dados
vis_dat(dados) # Outra forma de visualizar classes
vis_miss(dados) # Visuzalizar dados faltantes

# Manipulação de dados ---------------------------------------------------------------------------------------------------------------------

## Calcular médias, erros e desvios padrão da massa corporal por espécie

dados1 <- dados |>
  select(massa_corporal, especie) |>
  mutate(massa_kg = massa_corporal/1000) |>
  drop_na() |>
  group_by(especie) |>
  summarise(media = mean(massa_kg),
            sd = sd(massa_kg),
            n = n(),
            se = sd/sqrt(n))

view(dados1)

# Gráfico ggplot2 --------------------------------------------------------------------------------------------------------------------------

## Gráfico de barras com desvio padrão e texto

ggplot(dados1, aes(especie, media)) +
  geom_col(color = "darkblue", fill = "lightblue",
           width = 0.7) +
  geom_errorbar(aes(ymin = media - sd, ymax = media + sd),
                size = 0.8, width = 0.2) +
  scale_x_discrete(breaks = c("Pinguim-de-adélia",
                   "Pinguim-de-barbicha", "Pinguim-gentoo"),
                   labels = c("Pinguim de Adélia",
                    "Pinguim de Barbicha", "Pinguim Gentoo")) +
  geom_text(aes(label = n), vjust = 4, size = 3.3) +
  labs(x = "Espécies", y = "Massa corporal (kg)") +
  theme_clean() +
  theme(axis.text = element_text(color = "black"))
  
## Gráfico de dispersão entre comprimento de nadadeira e massa corporal
## por espécie

ggplot(dados, aes(x = comprimento_nadadeira, y = massa_corporal,
                  color = especie)) +
  geom_point(size = 2.8) +
  scale_color_manual(values = c("#831903", "#646773", "#123424"),
    breaks = c("Pinguim-de-adélia",
                   "Pinguim-de-barbicha", "Pinguim-gentoo"),
    labels = c("Pinguim de Adélia",
                    "Pinguim de Barbicha", "Pinguim Gentoo"),
    name = "Espécie") +
  labs(x = "Comprimento da nadadeira (mm)", 
       y = "Massa corporal (kg)") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black"))
  
  
  
  
  
  




  
