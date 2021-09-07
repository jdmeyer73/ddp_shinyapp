#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
library(shiny)

# Define UI for application
shinyUI(fluidPage(
    # CSS style
    tags$head(
        tags$style(HTML("hr {border-top: 5px solid #FF0000;}"))
    ),
    
    # Application title
    titlePanel("Advertising Media and Sales"),

    # Sidebar with a checkbox inputs (for predictors and plots)
    #   and for app information
    sidebarLayout(
        sidebarPanel(
            h3("Options"),
            h4("Select the advertising media to be included in the model:"),
            checkboxGroupInput(inputId="variable", label=NULL, 
                               choices=list("YouTube"="youtube", 
                                 "Facebook"="facebook", 
                                 "Newspaper"="newspaper")),
            h4("Select plots to show:"),
            checkboxGroupInput(inputId="plots", label=NULL,
                               choices=list("Correlation"="correlation",
                                            "Outlier and Leverage Diagnostic"="outlev")),
            hr(),
            h3("Application Information"),
            p("This Shiny application uses a marketing dataset with sales and
              advertising budgets for various media. The user selects which
              predictors to include (if any) in linear regression model and 
              if any plots are desired."),
            h4("How to use:"),
            p("1. Select the predictors to include in the model"),
            p("2. Select if a correlation plot of the selected predictors is desired"),
            p("3. Select if a outlier and leverage plot of the fitted model is desired"),
            p("4. View results"),
            p(),
            h4("Author: Jeffrey Meyer"),
            tags$a(href="https://github.com/jdmeyer73/ddp_shinyapp",
                  "Link to GitHub repository")
            
        ),

        
        mainPanel(
            h3("Results"),
            conditionalPanel(
                "input.plots.indexOf('correlation') > -1",
                h4("Correlation Matrix"),
                plotOutput("corr")),
            h4("Regression Results"),
            verbatimTextOutput("model"),
            conditionalPanel(
                "input.plots.indexOf('outlev') > -1",
                h4("Outlier and Leverage Diagnostic Plot"),
                plotOutput("lev"))
        )
    )
))
