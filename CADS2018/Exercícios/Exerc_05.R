# Exercícios aula 05
lista.de.pacotes = c("tidyverse","lubridate","janitor","readxl","stringr","repmis") # escreva a lista de pacotes
novos.pacotes <- lista.de.pacotes[!(lista.de.pacotes %in%
                                      installed.packages()[,"Package"])]
if(length(novos.pacotes) > 0) {install.packages(novos.pacotes)}
lapply(lista.de.pacotes, require, character.only=T)
rm(lista.de.pacotes,novos.pacotes)
gc()



# Carregue o arquivo `decisoes.rds` em um objeto chamado `decisoes`. ----

decisoes <- read_rds("~/git/aulas_ENAP/CADS2018/Exercícios/dados/decisoes.rds/decisoes.rds")

# Qual quantidade mensal de decisões por juiz?

juiz_mes <- decisoes %>% 
  mutate(data_decisao_corrigida=dmy(data_decisao),
         mes = month(data_decisao_corrigida)) %>%
  filter(!is.na(mes)) %>%
  group_by(juiz,mes) %>%
  summarise(numero_de_processos=n()) %>%
  spread(mes,numero_de_processos,fill = 0)


# Separate
assuntos <- decisoes %>% 
  select(n_processo, classe_assunto) %>% 
  separate(classe_assunto, 
           c('classe', 'assunto'), 
           sep = ' / ', 
           extra = 'merge', 
           fill = 'right') %>% 
  count(assunto, sort = TRUE)

# Processos partes
processos <- read_rds("~/git/aulas_ENAP/CADS2018/Exercícios/dados/decisoes.rds/processos_nested.rds")

# DEsaninhando
d_partes <- processos %>% 
  select(n_processo, partes) %>% 
  unnest(partes)

# Crie um objeto contendo informações sobre os tamanhos das bancadas dos ----
# partidos (arquivo `bancadas.rds`), suas respectivas coligações 
# eleitorais para 2018 (arquivo `coligacoes.xlsx`) e o 
# grau de concordância com a agenda do Gov 
# Temer (arquivo `governismo_temer.xlsx`). 

# Bônus: use `group_by` e `summarise` para identificar qual candidato tem a ----
# coligação com menor média de concordância e qual candidato 
# tem a maior proporção total de assentos.