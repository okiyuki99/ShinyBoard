shinyUI(fluidPage(
  tags$head(
    tags$style(
      HTML(".shiny-notification {position:fixed; width:400px;; top: calc(5%);; left: calc(10%);;}")
    )
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
