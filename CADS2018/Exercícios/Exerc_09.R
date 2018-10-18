# Exercícios aula 09
lista.de.pacotes = c("tidyverse","lubridate","janitor",
                     "readxl","stringr","repmis","janitor",
                     "survey","srvyr","scales") # escreva a lista de pacotes
novos.pacotes <- lista.de.pacotes[!(lista.de.pacotes %in%
                                      installed.packages()[,"Package"])]
if(length(novos.pacotes) > 0) {install.packages(novos.pacotes)}
lapply(lista.de.pacotes, require, character.only=T)
rm(lista.de.pacotes,novos.pacotes)
gc()


# Carregando dados
data(api)

# Olhando apisrs
View(apisrs)

# amostra aleatória simples 
srs_design_srvyr <- apisrs %>% 
  as_survey(fpc = fpc)

# Criando variáveis
srs_design_srvyr <- srs_design_srvyr %>%
  mutate(nivel=case_when(
    stype=="E"~"Fundamental",
    stype=="M"~"Fundamental",
    stype=="H"~"Médio"
  ))



# mais rápido
srs_design_srvyr <- apisrs %>% 
  as_survey(fpc = fpc) %>%
  mutate(nivel=case_when(
    stype=="E"~"Fundamental",
    stype=="M"~"Fundamental",
    stype=="H"~"Médio"
  ))


resolucao <- srs_design_srvyr %>%
  group_by(nivel) %>%
  summarize(proporcao = survey_mean(vartype = "cv"),
            n=survey_total(vartype = "ci"))
library(scales)

# ggplot
p <- srs_design_srvyr %>%
  data.frame() %>%
  ggplot(aes(x=api99/1000,
                 y=api00/1000,
                 color=nivel,
                 shape=paste(nivel,"-",stype),
             group=nivel)) +
  geom_point() +
  geom_smooth(method="loess",se=F) +
  scale_color_manual(values = c("#ff0000","aquamarine4")) +
  scale_x_continuous(limits = c(0,1),
                     labels = scales::percent)+
  scale_y_continuous(limits = c(0,1),
                     labels = scales::percent) +
  facet_wrap(~nivel) +
  theme_minimal() 
  
  
p  
  
# ggplot
# Votação mudança composição nota
# Não foram geradas maiorias, permanecemos como estamos, 50/50
  
  
  


## ggplot

srs_design_srvyr %>%
  data.frame() %>%

