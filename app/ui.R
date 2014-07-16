library(shiny)

# Define UI for correlation in bivariate standard normal distribution
shinyUI(fluidPage(
  
  # Application title
  #titlePanel("Estimate the correlation of a bivariate normal distribution"),
  titlePanel("Estimating correlation"),
  
  # Sidepar with controls to select the correlation coefficient in the
  # distribution and the number of random samples
  sidebarLayout(
    sidebarPanel(
      # Enter the correlation coefficient
      sliderInput("rho",
                  "Population correlation coefficient",
                  value = 0,
                  min = -1.0,
                  max = 1.0,
                  step = 0.1),
      
      # The break allows extra spacing
      br(),
      
      # Enter the number of samples
      numericInput("n",
                   "Number of random samples",
                   value = 100L,
                   min = 2L,
                   max = 10000L,
                   step = 1L),
      
      # A new line
      br(),
      
      # A note for the input file above
      tags$small("(Minimum: 2)"),
    
      # A horizontal line
      hr(),
    
      # Additional notes 
      h5("About"),
      helpText("The Pearson correlation coefficient refers to the linear
        dependence between two variables. In this application, the slider 
        can be used to specify the correlation between the two variables of
        a bivariate normal distribution."),
      helpText("Random samples are drawn from this population. Use the input
        field to specify the number of samples."),
      helpText("In the first tab, you can see a scatter plot of the random 
        samples together with a solid red line indicating the optimal linear 
        fit and a dashed line indicating the correlation in the population.
        The correlation of the random data may differ from the correlation
        in the population. Usually, this difference decreases with the 
        number of samples (see second tab). A table of the random samples
        can be found in the third tab."),
      
      # A new line
      br(),
      
      # References
      HTML('<h6>For more information have a look at the 
           <a href = "http://github.com">documentation</a>.
          You can find the 
           <a href = "http://github.com">code on Github</a>.</h6>')
    ),
    
    # Show a tabset that includes a scatter plot, a line plot, and a table
    # view of the sampled data
    mainPanel(
      tabsetPanel(type = "tabs",
        # A panel for the scatter plot          
        tabPanel("Sample correlation", plotOutput("scatterPlot")), 
        # A panel for the line (influence of number of samples)
        tabPanel("The influence of the number of samples",
                 plotOutput("linePlot")),
        # A panel for the table
        tabPanel("Table of sampled data", tableOutput("table"))
      )
    )
  )
))


# library(shiny)
# 
# # Define UI for random distribution application 
# shinyUI(fluidPage(
#   
#   # Application title
#   titlePanel("Tabsets"),
#   
#   # Sidebar with controls to select the random distribution type
#   # and number of observations to generate. Note the use of the br()
#   # element to introduce extra vertical spacing
#   sidebarLayout(
#     sidebarPanel(
#       radioButtons("dist", "Distribution type:",
#                    c("Normal" = "norm",
#                      "Uniform" = "unif",
#                      "Log-normal" = "lnorm",
#                      "Exponential" = "exp")),
#       br(),
#       
#       sliderInput("n", 
#                   "Number of observations:", 
#                   value = 500,
#                   min = 1, 
#                   max = 1000)
#     ),
#     
#     # Show a tabset that includes a plot, summary, and table view
#     # of the generated distribution
#     mainPanel(
#       tabsetPanel(type = "tabs", 
#                   tabPanel("Plot", plotOutput("plot")), 
#                   tabPanel("Summary", verbatimTextOutput("summary")), 
#                   tabPanel("Table", tableOutput("table"))
#       )
#     )
#   )
# ))