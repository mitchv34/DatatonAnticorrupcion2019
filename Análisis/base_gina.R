library(pacman)
p_load(tidyverse)

bd <- read.csv("01 datos/contratacionesDF 3.csv")

tenders_y_pe <- bd%>% 
  mutate(id=as.character(id), 
         roles=as.character(roles)) %>% 
  filter(roles!="b") %>% 
  group_by(year,id,roles) %>% 
  mutate(total=sum(awds),
         concursos=n()) %>% 
  distinct(id, .keep_all = TRUE)

tenders_y_pe %>% 
  filter(roles!="p") %>% 
  View()

buyers <- bd %>% 
  filter(roles=="b") %>% 
  mutate(comprador=id) %>% 
  select(comprador,ocid)

bd_2 <- full_join(tenders_y_pe,buyers)
View(bd_2)  

write.csv(bd_2,"01 datos/concursos.csv")
    
#intento 2----

tenderers <-bd%>% 
  filter(!roles%in%c("p","b")) %>% 
  mutate(id=as.character(id), 
         roles=as.character(roles)) %>% 
  group_by(year,id,roles) %>% 
  mutate(total=sum(awds),
         concursos=n()) %>% 
  distinct(id, .keep_all = TRUE) %>% 
  ungroup() 
    
tenderers <- tenderers %>% 
  group_by(year,id) %>% 
  mutate(total_concursos=sum(concursos)) %>% 
  select(-c(awds,month)) %>% 
  filter(total!=0) %>% 
  ungroup() %>% 
  spread(roles,concursos) %>% 
  mutate(perdidos=total_concursos-st) %>% 
  rename("ganadaos"="st") %>% 
  mutate(roles="tenderers")

buyers <- bd %>% 
  filter(roles=="b") %>% 
  mutate(comprador=id) %>% 
  select(comprador,ocid)
  
pe <- bd %>% 
  mutate(roles=as.character(roles)) %>% 
  filter(roles=="p") %>% 
  group_by(year,id,roles) %>% 
    mutate(total=sum(awds),
           total_concursos=n()) %>% 
  distinct(id, .keep_all = TRUE) %>% 
  ungroup() %>% 
  select(-c(awds,month))
  

tenderers_y_pe <- bind_rows(tenderers,pe)
bd_5 <- full_join(tenderers_y_pe,buyers)

bd_5 <- bd_5 %>% 
  select(-ocid)

View(bd_5)  

bd_5 %>% 
  mutate(alerta=ifelse(total_concursos==ganadaos,"alerta","competencia")) %>% 
  group_by(alerta,year,comprador) %>%
  summarise(total=n()) %>% 
  View()
IMSS <- bd_5 %>% 
  filter(comprador=="IMSS-192") %>% 
  group_by(year) %>% 
  arrange(desc(ganadaos)) %>% 
  mutate(ranking=row_number()) %>% 
  filter(ranking<=10) %>% 
  ungroup()
IMSS_17 <- IMSS %>% 
  filter(year==2017) %>% 
  select(id) %>% 
  pull()
IMSS_16<- IMSS %>% 
  filter(year==2016) %>% 
  select(id) %>% 
  pull()  
IMSS_18<- IMSS %>% 
  filter(year==2018) %>% 
  select(id) %>% 
  pull()  


#basura----
group_by(year,id) %>% 
  mutate(total_concursos=sum(concursos)) %>%
  spread(roles,concursos) %>% 
  
  rename("ganados"="st",
         "perdidos"="t") %>% 
  mutate(alerta_ganados=ifelse(ganados==total_concursos,"alerta","competencia")) %>% 
  mutate(perdidos=ifelse(is.na(perdidos),0,perdidos)) 
    
BFA080627KN0    
    
bd_3 <- bd_2 %>% 
  group_by(year,id) %>% 
  mutate(total_concursos=sum(concursos)) %>%
  filter(roles!="p") %>% 
  spread(roles,concursos) %>% 
  rename("ganados"="st",
         "perdidos"="t") %>% 
  mutate(alerta_ganados=ifelse(ganados==total_concursos,"alerta","competencia")) %>% 
  mutate(perdidos=ifelse(is.na(perdidos),0,perdidos))

View(bd_3)


bd_2 %>% 
  filter(year==2017, roles%in%c("st","t")) %>% 
  arrange(desc(concursos)) %>% 
  View()


bd_2 %>% 
  filter(roles=="p", year==2017) %>%
  group_by(id,comprador) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(concursos=sum(n)) %>% 
  View()  


