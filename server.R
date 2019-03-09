shinyServer(function(input, output, session) {
   
  print("Initialize Start")
  values <- reactiveValues()
  values$work_data <- data.frame(stringsAsFactors = F)
  
  # --------------------------
  # Create Data for table and plot
  observeEvent(input$btn_run, {
    
    tryCatch({
      values$work_data <- eval(parse(text = input$code))
    }, 
    error = function(e){
      print("aaa")
      message(e)           
    },
      silent = TRUE
    )
    
    insertUI(
      selector = "#btn_run",
      where = "afterEnd",
      ui = fluidRow(column(5, DTOutput("result_table")))
    )
    
  })
  
  # --------------------------
  # Output : Table
  output$result_table <- renderDT( 
    values$work_data, options = list(lengthChange = FALSE)
  ) 
})
