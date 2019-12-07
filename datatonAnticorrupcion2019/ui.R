library(shiny)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(title = "Datatón Anticorrupción", id = "intro",
             
             tabPanel("Introducción", 
                      tags$head(
                        # Include mi custom CSS
                        includeCSS("styles.css")
                      ),  
                      
                      HTML('<section class="hero">
                                <div class="hero-inner">
                                    <h1>Sociedades y Corrupción</h1>
                                    <h2>Datatón Anticorrupción 2019</h2>
                                </div>
                      </section>'), 

  br(),   br(),  br(),  br(),  br(),  br(),  br(),  br(),  br(),  br(),                   
                      
  fluidPage(
      fluidRow(
          column(2, offset = 1, HTML('<img src="logos/dataton.png" alt="Sponsors" style = "/* Flexbox stuff */
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 6vw;
                  ">')), 
          
          column(2, HTML('<img src="logos/pdn.png" alt="Sponsors" style = "/* Flexbox stuff */
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 6vw;
                  ">')), 
          
          column(2, HTML('
          <a href="https://www.usaid.gov">
          <img src="logos/usaid.png" alt="Sponsors" style = "/* Flexbox stuff */
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 6vw;
                  ">
            </a>')), 
          
          column(2, offset = 1, HTML('<img src="logos/sesna.png" alt="Sponsors" style = "/* Flexbox stuff */
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 6vw;
                  ">')), 
          
          column(1, HTML('
        <a href="https://twitter.com/DBuesos">
          <img src="logos/dbuesos.png" alt="Sponsors" style = "/* Flexbox stuff */
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 6vw;
                  ">
          </a>           
                         '))
          
      )
    )
), 
    
    tabPanel("Juan", 
        HTML("<h2 class = 'texto'>Sobre esta sección.</h2>"),
        p("En esta sección tratamos de visualizar las relaciones entre múltiples empresas a la hora de competir por contratos en las licitaciones públicas."),
        p("Resulta que, a la hora de los procesos de licitación, los participantes van a los concursos compartiendo datos en común como pueden ser: Numeros telefónicos, correos, dominios, direcciones, etc., provocando comportamientos sospechosos que bien pueden servir como alertas para posibles actos de corrupción y colusión entre agentes."), 
  
          
HTML("<h2 class = 'texto'>Creación de la base</h2>
<ul>
<li class = 'lista'>Creamos una base de datos que tenga identificado a cada punto de contacto.</li>
<li class = 'lista'>Los puntos de contacto se obtienen a partir de los contratistas que tienen información o su dirección.</li>
</ul>"), 

# AQUI VA A IR UNA TABLA DE CONTACTOS #                
HTML("<ul><li class = 'lista'>De la base de datos de contrataciones seleccionamos los datos de contacto de los que han ganado licitaciones. Estos tiene datos como <i>nombre de la persona de contacto</i>, <i>email</i>, <i>teléfono</i>, <i>número de fax</i>, <i>dirección</i> y <i>id del proveedor</i></ul></li>"
  ),

HTML("<ul><li class = 'lista'>De todos los contratos encontramos <b>563,693</b> puntos de contacto. Muchos de estos se repiten porque un contratista que ganó varias veces aparecerá como un contacto por cada contrato ganado.</li>
<li class = 'lista'>Calculamos todas las combinaciones únicas de telefono y <i>tenderer_id</i>.</li>
<li class = 'lista'>Luego verificamos si existen casos en los que varios tenderer_id comparten el:</li>
<ul>
    <li class = 'lista'>Teléfono: 700 casos en los que eso ocurre.</li>
    <li class = 'lista'>Email: 839 casos.</li>
    <li class = 'lista'>Nombre: 706 casos</li>
    <li class = 'lista'>Número de fax: 135 casos</li>
    <li class = 'lista'>Dirección de la calle: 172 casos</li>
</ul>    
<li class = 'lista'>Todos estos son signos de sospecha.</li>
<li class = 'lista'>En muchos casos hay cuentas de funcionarios públicos. Habría que verificar cuál es su papel.</li>
<li class = 'lista'>La pregunta relevante es <b>¿Hay casos en los que contratistas que tienen contactos en común hayan participado en un mismo proceso de licitación?</b></li></ul><br>
     <p><b>El resultado que encontramos es que existen 571 casos de contratistas posiblemente relacionados en una misma licitación.</b></p>"), 

HTML("<h2 class = 'texto'>Conclusiones del análisis</h2>"), 

HTML("<p><b>¿En cuántos de estos casos los contratistas representaban el 50% de los proponentes o más?</b></p>"),
HTML("<p><b>R: </b>Los contratistas representaban el 50% de los proponentes o más en 212 licitaciones</p>"), 
br(),

HTML("<p><b>¿En cuántos de estos casos los asociados fueron los únicos proponentes?</b></p>"), 
HTML("<p><b>R: </b> En 41 licitaciones</p>"),
br(),

HTML("<p>De estos casos <b>¿en cuántas licitaciones los que estaban relacionados ganaron un concurso?</b></p>"), 
HTML("<p><b>R: </b> En 370 licitaciones ganó al menos uno de los contratistas asociados</p>"),
br(),

HTML("<p><b>¿Cuántos contratistas asociados recibieron un contrato?</b></p>"), HTML("<p><b>R: </b> 552  contratistas asociados ganaron una licitación</p>" ), 
br(),

HTML("<p><b style= 'color:red;'>¿En qué dependencias, unidades compradoras y servidores públicos ocurre más esto?</b></p>"),
br()






), # Fin Juan 
    
    tabPanel("Mitchell"), 
    
    tabPanel("Georgina")
    
  )
)