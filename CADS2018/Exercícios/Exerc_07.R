# Exercícios aula 07
lista.de.pacotes = c("tidyverse","lubridate","janitor",
                     "readxl","stringr","repmis","janitor",
                     "survey","srvyr") # escreva a lista de pacotes
novos.pacotes <- lista.de.pacotes[!(lista.de.pacotes %in%
                                      installed.packages()[,"Package"])]
if(length(novos.pacotes) > 0) {install.packages(novos.pacotes)}
lapply(lista.de.pacotes, require, character.only=T)
rm(lista.de.pacotes,novos.pacotes)
gc()



##


data(api)

out <- apistrat %>%
  mutate(hs_grad_pct = cut(hsg, c(0, 20, 100), include.lowest = TRUE,
                           labels = c("<20%", "20+%"))) %>%
  group_by(stype, hs_grad_pct) %>%
  summarize(api_diff = mean(api00 - api99, na.rm=T),
            n = n())

ggplot(data = out, aes(x = stype, y = api_diff, group = hs_grad_pct, fill = hs_grad_pct)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(y = 0, label = n), position = position_dodge(width = 0.9), vjust = -1)


# simple random sample
srs_design_srvyr <- apisrs %>% 
  as_survey_design(ids = 1, fpc = fpc)


strat_design_srvyr <- apistrat %>%
  as_survey_design(1, 
                   strata = stype, 
                   fpc = fpc, 
                   weight = pw,
                   variables = c(stype, starts_with("api")))


# amostra baleatória simples 
srs_design_srvyr2 <- apisrs %>% 
  as_survey(ids = 1, fpc = fpc)

# Manipulação
strat_design_srvyr <- strat_design_srvyr %>%
  mutate(api_diff = api00 - api99) %>%
  rename(api_students = api.stu)

# População
out <- strat_design_srvyr %>%
  summarise(api_diff = survey_mean(api_diff, 
                                   vartype = "ci"))

# Por grupo
out2 <- strat_design_srvyr %>%
  group_by(stype) %>%
  summarize(api_increase = survey_mean(api_diff, 
                                       vartype = "ci"))



# Por grupo e dentro da variável agrupada
out3 <- strat_design_srvyr %>%
  group_by(stype) %>%
  summarise(api_increase = survey_total(api_diff >= 0,
                                        vartype="cv"),
            api_decrease = survey_total(api_diff < 0,
                                        vartype="ci"))

## De volta ao exemplo
strat_design <- apistrat %>%
  as_survey(strata = stype, 
            fpc = fpc, 
            weight  = pw)

out4 <- strat_design %>%
  mutate(hs_grad_pct = cut(hsg, c(0, 20, 100), 
                           include.lowest = TRUE,
                           labels = c("<20%", "20+%"))) %>%
  group_by(stype, hs_grad_pct) %>%
  summarize(api_diff = survey_mean(api00 - api99, 
                                   vartype = "ci"),
            n = survey_total(vartype = "ci"))

ggplot(data = out4, aes(x = stype, 
                       y = api_diff, 
                       group = hs_grad_pct, 
                       fill = hs_grad_pct,
                       ymax = api_diff_upp, 
                       ymin = api_diff_low)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(position = position_dodge(width = 0.9), width = 0.1) +
  geom_text(aes(y = 0, label = n), position = position_dodge(width = 0.9), vjust = -1)



# Scoped
# Calcular survey mean para todas as variáveis que começam com "api"
strat_design %>%
  summarize_at(vars(starts_with("api")), survey_mean)
srvyr::survey_mean()