shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  
  fluidRow(
    column(10, offset = 1, titlePanel("ShinyBoard"), radioButtons("select_lang", label = NULL, choices = c("R","SQL(Presto)"), selected = "R", inline = T))
  ),  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(10, offset = 1, uiOutput("ui_editor")),
    column(10, offset = 1, actionButton("btn_run", "Run"))
    #column(10, offset = 1, DTOutput("result_table"))
    #column(12, verbatimTextOutput("result_table"))
  )
))
