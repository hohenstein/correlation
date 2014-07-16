library(shiny)

library(MASS) # for mvrnorm

# Define server logic for correlation computation
shinyServer(function(input, output) {
  
  # Reactive function to sample from the bivariate standard normal
  # distribution with given correlation coefficient
  sampleData <- reactive({
    # covariance matrix
    covMat <- matrix(c(1, input$rho, 
                       input$rho, 1), ncol = 2L, nrow = 2L)
    # sample data
    mvrnorm(n = input$n, mu = c(0, 0), 
            Sigma = covMat)
  })
  
  # Reactive function to fit a linear model
  linearModel <- reactive({
    dat <- sampleData()
    lm(dat[ , 2L] ~ dat[ , 1L])
  })
  
  # Generate a scatterplot of the two-dimensional dataset
  output$scatterPlot <- renderPlot({
    # random data
    dat <- sampleData()
    # set plot margins
    def <- par()$mar
    par(mar = def + .5)
    # plot
    plot(dat,
         main = "Randomly sampled observations",
         xlab = "X",
         ylab = "Y",
         pch = 20L,
         cex.lab = 1.5,
         cex.main = 1.5)
    # estimate fit and draw line
    fit <- linearModel()
    abline(fit, col = "red", lwd = 2)
    # estimate intercept and draw line
    x <- dat[ , 1L]
    y <- dat[ , 2L]
    fit2 <- lm(I(y - input$rho * x) ~ 1)
    abline(coef(fit2)[[1L]], input$rho, 
           col = "grey10", lwd = 2, lty = 2L)
    # calculate correlation coefficient
    corCoef <- cor(x, y)
    # add a legend
    labs <- list(bquote(Population ~ rho == .(input$rho)), 
                 bquote(Sample ~ italic(r) == .(round(corCoef, 2))))
    legend("topright", 
           legend = do.call(expression, labs), 
           col = c("grey10", "red"),
           lwd = c(2, 2),
           lty = c(2L, 1L),
           bg = "gray90")
  })
  
  # Generate a lineplot to visualize the influence of the number of samples
  # on the estimated correlation coefficient
  output$linePlot <- renderPlot({
    dat <- sampleData()
    seqSamples <- seq.int(2L, input$n)
    corCoef <- vapply(seqSamples, function(idx) {
      cor(dat[seq(1L, idx), ])[[2]]
    }, FUN.VALUE = double(1L))
    # set plot margins
    def <- par()$mar
    par(mar = def + .5)
    # plot
    plot(seqSamples, corCoef,
         type = "l", col = "red", lwd = 2,
         main = "Estimation of the correlation coefficient",
         xlab = "Number of sampled observations",
         ylab = expression("Estimated value of" ~ rho),
         ylim = c(-1, 1),
         cex.lab = 1.5,
         cex.main = 1.5)
    abline(input$rho, 0, col = "grey10", lwd = 2, lty = 2L)
    if (input$n == 2)
      points(2, corCoef, col = "red", pch = 20L)
    # add a legend
    labs <- list(bquote(Population ~ rho == .(input$rho)), 
                 bquote(Sample ~ italic(r) == .(round(tail(corCoef, 1L), 2))))
    legend("topright", 
           legend = do.call(expression, labs), 
           col = c("grey10", "red"),
           lwd = c(2, 2),
           lty = c(2L, 1L),
           bg = "gray90")
  })
  
  # Generate an HTM table view of the data
  output$table <- renderTable({
    dat <- sampleData()
    colnames(dat) <- c("X", "Y")
    dat
  })
})
