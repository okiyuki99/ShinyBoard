shinyServer(function(input, output, session) {
   
  print("Initialize Start")
  cnt_table <- 0
  work_data <- list()
  id_notification <- ""
  #id_notification <<- showNotification("File Format Error", duration = 5, closeButton = T, type = "error")
  
  # --------------------------
  # UI : Editor
  output$ui_editor <- renderUI({
    if(input$select_lang == "R"){
      shinyAce::aceEditor("code", mode="r", theme = "monokai", value="df <- data.frame(num=1:4, let=LETTERS[2:5],rand=rnorm(4)) 
                         df")
    }else if(input$select_lang == "SQL(Presto)"){
      shinyAce::aceEditor("code", mode="sql", theme = "xcode", value="select * from test limit 100")
    }
  })
  
  # --------------------------
  # Create Data for table and plot
  observeEvent(input$btn_run, {
    
    df <- tryCatch({
      eval(parse(text = input$code))
    },
    error = function(e){
      id_notification <<- showNotification("Error : Run Code", duration = 5, closeButton = T, type = "error")
      return(NULL)
    },silent = TRUE)
    
    if(is.null(df)){
      return(-1)
    }
    
    cnt_table <<- cnt_table + 1
    work_data[[cnt_table]] <<- df
    
    insertUI(
      selector = "#btn_run",
      where = "afterEnd",
      ui = shinydashboard::box(id = paste0("box",cnt_table), title = NULL, status = "primary", width = 12, 
        div(style="display:inline-block",tags$h3(paste0("Table",cnt_table))),
        div(style="display:inline-block",tags$button(id = paste0("remove",cnt_table), type="button", class="btn action-button btn-default btn-sm", HTML('<i class="fa fa-trash"></i> Trash'))),
        #DTOutput(paste0("result_table",cnt_table))
        tabsetPanel(
          tabPanel("table", DTOutput(paste0("result_table",cnt_table))),
          tabPanel("code", verbatimTextOutput(paste0("result_code",cnt_table)))
        )
      )
      
    )
    
    output[[paste0('result_table',cnt_table)]] <- renderDT(
      work_data[[cnt_table]], rownames = F, extensions = c('Buttons','KeyTable'),
      options = list(dom = 'Bfrtip', buttons = I('colvis'), keys = TRUE, columnDefs = list(list(className = 'dt-right', targets = "_all")),
                     initComplete = JS("function(settings, json) {","$(this.api().table().header()).css({'background-color': '#666', 'color': '#fff'});","}"))
    )
    
    output[[paste0('result_code',cnt_table)]] <- renderText(
      input$code
    )
    
    
    
    obs_event_remove <- lapply(1:cnt_table, function(i){
      observeEvent(input[[paste0("remove",i)]], {
        removeUI(
          selector = paste0("div:has(> #box",i,")")
        )
      })
    })
  })
  
  # --------------------------
  # Output : Table
  #output$result_table <- renderDT( 
  #  values$work_data, options = list(lengthChange = FALSE)
  #) 
})
