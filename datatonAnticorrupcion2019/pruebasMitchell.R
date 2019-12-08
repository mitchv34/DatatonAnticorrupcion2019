# 
library(networkD3)
library(tidyverse)
niveles <- function(x) levels(as.factor(x))

# URLs
url <- c("www/datosMitchell", "www/datosJuan")

list.files(url[1])


links <- c("gen_edgelist_INIFED-208.csv", 
  "gen_edgelist_CULTURA-113.csv", 
  "gen_edgelist_SEMAR-272.csv", 
  "gen_edgelist_febrero-2017.csv", 
  "gen_edgelist_marzo-2017.csv"
  )

nodos <- c("gen_node_atts_INIFED-208.csv", 
           "gen_node_atts_CULTURA-113.csv", 
           "gen_node_atts_SEMAR-272.csv", 
           "gen_node_atts_febrero-2017.csv", 
           "gen_node_atts_marzo-2017.csv")

# Red con los datos de juan 
linksMitch <- read_csv(paste0(url[1], "/",links[5])) %>% as.data.frame() %>% select(-X1)

nodosMitch <- read_csv(paste0(url[1], "/", nodos[5])) %>% as.data.frame()




nodosMitch <- nodosMitch %>% 
  filter(niveles(nodosMitch$nodes) %in% niveles(c(niveles(linksMitch$source), niveles(linksMitch$target)))) %>% 
  select(-X1)

nodosMitch <- nodosMitch %>% 
  mutate(num = 0:(dim(nodosMitch)[1]-1)) %>% 
  mutate(nodeSize = ifelse(asociado, 1000, 20))

idNodos <- nodosMitch[,c(1,5)]

linksMitch <- merge(linksMitch, idNodos, by.x = "source", by.y = "nodes", all.x = T) %>% 
  merge(idNodos, by.x = "target", by.y = "nodes", all.x = T)


forceNetwork(Links = linksMitch,
             Nodes = nodosMitch,
             colourScale = JS("d3.scaleOrdinal(d3.schemeCategory10);"), 
             Source = "num.x",
             Target = "num.y",
             NodeID = "nodes",
             Group = "asociado",
             Nodesize = "nodeSize",
             opacity = 0.9, 
             legend = T,
             zoom = TRUE)

