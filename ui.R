shinyUI(fluidPage(
  
  fluidRow(
    column(10, offset = 1, titlePanel("ShinyBoard"), radioButtons("select_lang", label = NULL, choices = c("R","SQL"), selected = "R", inline = T))
  ),  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(10, offset = 1, shinyAce::aceEditor("code", mode="r", theme = "xcode", value="df <- data.frame(num=1:4, let=LETTERS[2:5],rand=rnorm(4)) 
                         df")),
    column(10, offset = 1, actionButton("btn_run", "Run"))
    #column(10, offset = 1, DTOutput("result_table"))
    #column(12, verbatimTextOutput("result_table"))
  )
))
