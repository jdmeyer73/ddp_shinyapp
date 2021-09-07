
library(shiny)

# Define server logic 
shinyServer(function(input, output) {
    
    # Require necessary packages
    require(datarium)
    require(olsrr)
    require(GGally)

    # Create dataset for linear regression
    predictors <- reactive({
        data <- marketing
        response <- as.data.frame(data$sales)
        names(response) <- "sales"
        predictors <- input$variable
        xvars <- as.data.frame(data[,predictors])
        names(xvars) <- predictors
        fulldata <- cbind(response,xvars)
        fulldata
    })
    
    # Create correlation plot if checkbox selected
    output$corr <- renderPlot({
        if ("correlation"%in%input$plots) {
            ggpairs(data=predictors())    
        }
    })
    
    # Create model results
    output$model <- renderPrint({
        cat("Linear regression model: sales ~",paste(input$variable, collapse=" + "))
        fit <- lm(sales~.,data=predictors())
        summary(fit)
    })
    
    # Create outlier/leverage plot if checkbox selected
    output$lev <- renderPlot({
        if ("outlev"%in%input$plots) {
            fit <- lm(sales~.,data=predictors())
            plot <- ols_plot_resid_lev(fit)
            plot
        }
    })
    
})
