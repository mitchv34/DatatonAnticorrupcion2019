rm(list = ls())
gc()

library(dplyr)
library(magrittr)
library(networkD3)
library(pracma)

periodo1 <- c(1, 2017, 9, 2017) # mes inicial, año inicial, mes final, año final
periodo2 <- c(10, 2017, 12, 2018)

contr <- read.csv("contratacionesShort.csv") 
contr %<>% dplyr::filter(., contr$roles != "b") 
contr %<>% transmute(., roles = as.character(roles),
                                        id = as.character(id), 
                                        year  = as.integer(year), 
                                        size = as.integer(awds), 
                                        month, ocid)
contr$size[is.na(contr$size)] <- 0
contr$group <- ifelse(contr$roles == "p", 1, 2)
contr2 <- contr
contr <- select(contr, -ocid)

### HARD CODE


contrFiltrada1 <- filter(contr, year<= periodo1[2] & year<=periodo1[4])
contrFiltrada1 <- filter(contr, (year == periodo1[2] & month >= periodo1[1]) |
                           (year==periodo1[4] & month <= periodo1[3]) |
                        (year>periodo1[2] & year<periodo1[4])) %>% 
  select(., id, size, group)

contrFiltrada2 <- filter(contr, year<= periodo2[2] & year<=periodo2[4])
contrFiltrada2 <- filter(contr, (year == periodo2[2] & month >= periodo2[1]) |
                           (year==periodo2[4] & month <= periodo2[3]) |
                           (year>periodo2[2] & year<periodo2[4])) %>% 
  select(., id, size, group)
                          
contrFiltrada1 <- aggregate(. ~ id + group, contrFiltrada1, sum)
contrFiltrada2 <- aggregate(. ~ id + group, contrFiltrada2, sum)

contrFiltrada1['indiceNodes'] <- 1:nrow(contrFiltrada1) - 1
contrFiltrada2['indiceNodes'] <- 1:nrow(contrFiltrada2) - 1


### links

finalLink1 <- data.frame()
finalLink2 <- data.frame()

for(j in 1:2){
  
  if(j == 1){
    contrPeriodo <- filter(contr2, year<= periodo1[2] & year<=periodo1[4])
    contrPeriodo <- filter(contr2, (year == periodo1[2] & month >= periodo1[1]) |
                               (year==periodo1[4] & month <= periodo1[3]) |
                               (year>periodo1[2] & year<periodo1[4])) %>% 
      select(., id, size, group, ocid)
  }
  
  if(j == 2){
    
    contrPeriodo <- filter(contr2, year<= periodo2[2] & year<=periodo2[4])
    contrPeriodo <- filter(contr2, (year == periodo2[2] & month >= periodo2[1]) |
                               (year==periodo2[4] & month <= periodo2[3]) |
                               (year>periodo2[2] & year<periodo2[4])) %>% 
      select(., id, size, group, ocid)
    
  }
  
  for(i in unique(contrPeriodo$ocid)){
    
    contr_i <- dplyr::filter(contrPeriodo, contrPeriodo$ocid == i)
    orig <- dplyr::filter(contr_i, contr_i$group == 1)
    targets <- dplyr::filter(contr_i, contr_i$group != 1)
    
    for(licitante in 1:nrow(targets)){
      
      link_i <- data.frame(orig$id[1], targets$id[licitante],  
                           #targets$size[licitante])
                           1)
      names(link_i) <- c("source", "target", "value")
      if(j == 1){finalLink1 <- rbind(finalLink1, link_i)}
      if(j == 2){finalLink2 <- rbind(finalLink2, link_i)}
      
    }
    
  }
  
  
}


ID1s <- transmute(contrFiltrada1, source = id, sourceID = indiceNodes)
final1 <-  merge(finalLink1, ID1s, 
                 by.x = "source", by.y = "source", all.x = T, no.dups = F)
ID1t <- transmute(contrFiltrada1, target = id, targetID = indiceNodes)
final1 <-  merge(final1, ID1t, 
                 by.x = "target", by.y = "target", all.x = T, no.dups = F)

ID2s <- transmute(contrFiltrada2, source = id, sourceID = indiceNodes)
final2 <-  merge(finalLink2, ID2s, 
                 by.x = "source", by.y = "source", all.x = T, no.dups = F)
ID2t <- transmute(contrFiltrada2, target = id, targetID = indiceNodes)
final2 <-  merge(final2, ID2t, 
                 by.x = "target", by.y = "target", all.x = T, no.dups = F)
contrFiltrada1$sizeReduced <- ifelse(contrFiltrada1$size == 0, 0, nthroot(contrFiltrada1$size,5))
contrFiltrada2$sizeReduced <- ifelse(contrFiltrada2$size == 0, 0, nthroot(contrFiltrada2$size,5))

# final1$target <- as.character(final1$target)
# final1$source <- as.character(final1$source)
# final1$value <- as.character(final1$value)
# contrFiltrada1$sizeReduced <- as.character(contrFiltrada1$sizeReduced)
# contrFiltrada1$group <- as.character(contrFiltrada1$group)
contrFiltrada1$distance <- 120*contrFiltrada1$sizeReduced
contrFiltrada1$label <- paste0(substr(contrFiltrada1$id, 1, 3), ": $",
                               as.character(contrFiltrada1$size))
contrFiltrada2$label <- paste0(substr(contrFiltrada2$id, 1, 3), ": $",
                               as.character(contrFiltrada2$size))

forceNetwork(Links = final1, Nodes = contrFiltrada1,
            Source = "sourceID", Target = "targetID",
            Value = "value", NodeID = "label", 
            Nodesize = "sizeReduced",
            Group = "group", opacityNoHover = 2,
            opacity = 1, zoom = T, bounded = T,
            fontSize = 15,linkDistance =120)
              
              
forceNetwork(Links = final2, Nodes = contrFiltrada2,
             Source = "sourceID", Target = "targetID",
             Value = "value", NodeID = "label", 
             Nodesize = "sizeReduced",
             Group = "group", opacityNoHover = 2,
             opacity = 1, zoom = T, bounded = T,
             fontSize = 15,linkDistance =120)



# red1 <- simpleNetwork(final1, final1[2], final1[1])
