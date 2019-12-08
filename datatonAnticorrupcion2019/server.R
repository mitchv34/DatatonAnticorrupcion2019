library(shiny)

shinyServer(function(input, output, session) {

  output$imgJuan <- renderImage({
    list(src = paste0("www/datosJuan/graficas_asociados/redes/red_",
                      input$selJuan,
                      ".0.png"),
         contentType = 'image/png',
         width = 1000
    )}, deleteFile = FALSE)
  

output$imgMitchell <- renderImage({
  list(src = paste0("www/datosMitchell/datos mitch/red_",
                    input$selMitch,
                    ".png"),
       contentType = 'image/png',
       width = 1000
  )}, deleteFile = FALSE)


output$imgGina <- renderImage({
  list(src = paste0("www/datosGina/red_gina_",
                    input$selGina,
                    ".png"),
       contentType = 'image/png',
       width = 1000
  )}, deleteFile = FALSE)


})


