library(shiny)
unemploy<-read.csv("blsunemployment.csv")

# Define server logic for slider and select box widgets
shinyServer(function(input, output) {
        # Reactive expression to compose a subset of unemployment data
        # for date range and state 
        dataforplot<-reactive({
                
                # Collect input data
                dateinput1<-input$range[1]
                dateinput2<-input$range[2]
                states<-c("UNITED STATES")
                states<-union(states, toupper(input$e0))
                
                #View(dateinput1)
                #View(dateinput2)
                #View(states)
                #View(unemploy)
                
                #subset by year range and state choice
                unemploydata<-unemploy[unemploy$year >= dateinput1 & 
                                               unemploy$year <= dateinput2 &
                                               unemploy$state %in% states,
                                       c("state","unemployment","year")]
                        
        }) 
        
        # Show the plot of unemployment rate by state for date range selected
        output$unemployplot <- renderPlot({
                dateinput1<-input$range[1]
                dateinput2<-input$range[2]
                states<-c("UNITED STATES")
                states<-union(states, toupper(input$e0))
                unemploydata<-dataforplot()
                #View(unemploydata)
                
                #Plot labels
                yLabel<-"Unemployment"
                xLabel<-"Year"
                mainLabel<-"Unemployment Rate in the US"
                maxrate<-max(unemploydata$unemployment)
                footnote<-"Source: Bureau of Labor Statistics"
                
                #Generate Plot
                plotnum<-1
                plotColors=palette()
                par(mar=c(5.1, 4.1, 4.1, 10.2), xpd=TRUE)
                for(state in states){
                        if(plotnum==1){
                                plot(unemploydata$year[unemploydata$state==state],
                                     unemploydata$unemployment[unemploydata$state==state],
                                     xlab=xLabel, ylab=yLabel, main=mainLabel, sub=footnote,
                                     xlim=c(dateinput1, dateinput2), ylim=c(0, maxrate),
                                     type="b", pch=plotnum, col=plotColors[plotnum])
                        }
                        else {
                                lines(unemploydata$year[unemploydata$state==state],
                                      unemploydata$unemployment[unemploydata$state==state],
                                      type="b",
                                      pch=plotnum, col=plotColors[plotnum])
                        }
                        plotnum<-plotnum +1
                }
                #create a legend
                legend ("topright", inset=c(-0.2,0), states, cex=0.8, fill=plotColors);
                par(mar=c(5, 4, 4, 2)+0.1)
        })
})