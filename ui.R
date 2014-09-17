library(shiny)


# Define UI for unemployement data application
shinyUI(fluidPage(
        
        #  Application title
        titlePanel("US Unemployment Data by State for Years 2000 to 2013"),
        
        # Slider widget for year
        
        sidebarLayout(
                sidebarPanel(
                        
                        #Instructions on how to use slider
                        h3("Choose Year Range"),
                        helpText("Click on the slider and", 
                                 "select the range of years",
                                 "you would like to view."),
                        
                        
                        # Slider widget
                        #Select a year range from 2000 to 2013
                        sliderInput("range", "Year Range:",
                                    min = 2000, max = 2013, step=1,
                                    format="####", value = c(2000,2013)),
                        
                        #Instructions on how to use the selectize box
                        h3("Choose the states"),
                        helpText("Click in the box below and select", 
                                 "all the states you would like to view."
                                 ),
                        
                        #Select the states
                        #Can select multiple states
                        selectizeInput( 'e0', 'States', 
                                        choices=state.name, multiple=TRUE)
                        
                        
                        
                ),
                
                
                mainPanel(
                        #General Instructions for using the app
                        h4("Instructions"),
                        helpText("This app uses unemployment data from the Bureau of", 
                                 "Labor Statistics for the years 2000-2013 and",
                                 "allows you to plot the data on a line plot. You can",
                                 "select the date range to view and what states' data you'd",
                                 "like to visualize in the plot. Data for the unemployment for",
                                 "the United States is plotted by default."),
                        #place the plot
                        plotOutput("unemployplot")
                )
        )
))
