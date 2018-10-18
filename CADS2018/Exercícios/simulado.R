## Simulado

## Parte 1 ----

# Carregue o tidyverse e o lubridate

# 1. Carregue o arquivo `decisoes.rds` em um objeto chamado `decisoes`.


# 2. Separe a coluna `classe_assunto` em duas colunas, uma contendo a `classe` 
# e outra contendo o `assunto`


# 3. Elabore um data.frame em que as linhas sejam o assunto, as colunas sejam os anos e os valores 
# sejam as quantidades de decisões 
# Dica 1: crie uma variável `ano` e exclua os casos em que não há informação sobre data da decisão
# Dica 2: agrupar por assunto e ano e fazer o spread



## Parte 2 ----

# 1. Caregue os pacotes "tidyverse", "survey" e "srvyr"


# 2. Leia o conjunto de dados 'api' do pacote survey usando o comando data(api)


# 3. Elimine os objetos 'apiclus1', 'apiclus2', 'apipop' e 'apistrat'
# mantendo apenas o objeto apisrs


# 4. crie o objeto 'pesos' selecionando as colunas 'stypr' e 'pw' do objeto 'apisrs'


# 5. crie o objeto 'escolas_notas' selecionando as colunas 
# 'cds', 'stype', 'api99' e 'api00' do objeto apisrs


# 6. Remova as duplicatas (linhas em duplicidade) do arquivo `pesos` que você criou no passo 4


# 7. Quantas linhas tem o novo objeto `pesos`, sem as duplicidades


# 8. Traga a variável `pw` para `escola_notas`, criando um novo objeto `amostra` 
# resultado da união (join) do objeto `pesos` ao objeto `escolas_notas` 
# dica use left_join, com `escola_notas` na esquerda.


# 9. Crie o objeto tbl_svy `amostra_expandida` expandindo a amostra aleatória simples (`amostra`)
# usando apenas a variável (coluna) "pw", contendo o peso amostral. 


# 10. Faça um gráfico de barras comparando a variação média 
# das notas de 1999 (`api99`) e 2000 (`api00`) por tipo de escola (`stype`) 
# utilize as estimativas intervalares para construir barras com o intervalo de confiança


