# Librerias
library(networkD3)
library(tidyverse)
niveles <- function(x) levels(as.factor(x))


# URLs
url <- c("www/datosMitchell", "www/datosJuan")

list.files(url[1])
list.files(url[2]) # Juan

# Red con los datos de juan 
linksJuan <- read_csv(paste0(url[2], "/asociados_links.csv")) %>% as.data.frame()
nodosJuan <- read_csv(paste0(url[2], "/asociados_nodos.csv")) %>% 
  as.data.frame() 
 
(nodosJuan$id == "CIJ731003QK3-012M7K001") %>% table()

head(nodosJuan)

# Contratos
contratos <- nodosJuan %>% 
  filter(tipo == "contrato") %>% 
  pull(id) # 571 obs

# Analisis
(linksJuan$origen_id %in% contratos) %>% table()
(linksJuan$destino_id %in% contratos) %>% table() # 11374 matches. 

# RedContratoLinks
redContratolinks <- linksJuan %>% 
  filter(red == 1) 

entidades <- c(redContratolinks$origen_id %>% niveles(), redContratolinks$destino_id %>% niveles() ) %>% unique()

# redContratolinks
# redContratoNodes 

redContratoNodes  <- nodosJuan %>% 
  filter(num %in% c(redContratolinks$origen_num, redContratolinks$destino_num))
  
library(tidyr)






# Red
forceNetwork(Links = redContratolinks, 
             Nodes = redContratoNodes,
             Source = "origen_num", 
             Target = "destino_num",
             NodeID = "num",
             Group = "tipo", 
             opacity = 0.8)


# linksJuan %>% head()
nodosJuan %>% head()


# simpleNetwork(redContrato, zoom = TRUE)
# class(linksJuan$origen_id)
# class(linksJuan$destino_id)
# 

# # Load data
# data(MisLinks)
# data(MisNodes)
# 
# MisLinks <- MisLinks %>% 
#   head()
# 
# MisLinks %>% head()
# MisNodes %>% head()
# 
# table(MisLinks$source)
# table(MisLinks$target)
# 
# MisNodes$name %>% levels()

# # Plot
# forceNetwork(Links = MisLinks, Nodes = MisNodes,
#              Source = "source", Target = "target",
#              Value = "value", NodeID = "name",
#              Group = "group", opacity = 0.8)
# 
# class(MisLinks)

