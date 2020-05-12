library(shiny)
library(ggplot2)
library(babynames)

ui <- fluidPage(

  titlePanel('Relative Name Popularity, 1880-2017'),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput('nameSelection', label = 'First Name(s)', choices = NULL,
        multiple = TRUE, options = list(maxItems = 5, maxOptions = 500)
      ),
      selectizeInput('sexSelection', label = 'Sex', choices = c('Female' = 'F','Male' = 'M'),
        multiple = FALSE
      ),
      verbatimTextOutput('value'),
      'This tool is designed to allow you to explore the relative popularity of names over time.',
      'Enter up to five first names of interest and the resulting graph will display what percentage',
      'of infants of that sex were registered under those names with the social security',
      'administration by year.',
      tags$br(),
      tags$br(),
      tags$b('Data Source:'),'The',
      tags$a(href = 'https://cran.r-project.org/web/packages/babynames/index.html', 'babynames package'),
      'created by Wickham Hadley. For raw data files and more interactive tools, visit the',
      tags$a(href='https://www.ssa.gov/oact/babynames/limits.html', 'Social Security Administration.')
      
    ),
    mainPanel(
      plotOutput('namesPlot')  
    )
    
  )
)
      

server <- function(input, output, session){
  
  selectedData <- reactive({
    babynames[babynames$name %in% input$nameSelection 
              & babynames$sex == input$sexSelection,]
  })
  
  
  updateSelectizeInput(session,'nameSelection',
                       choices = sort(unique(babynames$name)),
                       server = TRUE)
  
  output$namesPlot <- renderPlot({
    
    ggplot(data=selectedData(), aes(x=year, y=prop*100, group=name, color = name)) +
      geom_line(size = 1.2) + labs(color = 'Name', y = '% of Babies Born', x = 'Year') +
      theme(text = element_text(size=16))
    

  })

}

shinyApp(ui = ui, server =server)