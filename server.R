library(shiny)
# Need 'ggplot2' package to get a better aesthetic effect.
library(ggplot2)

# The 'sample.R' source code is used to generate data to be plotted, based on the input skewness, 
# tailedness and modality. For more information, see the source code in 'sample.R' code.
source("sample.R")

shinyServer(function(input, output) {
  # We generate 10000 data points from the distribution which reflects the specification of skewness,
  # tailedness and modality. 
  n = 10000
  
  # 'scale' is a parameter that controls the skewness and tailedness.
  scale = 1000
  
  # The `reactive` function is a trick to accelerate the app, which enables us only generate the data
  # once to plot two plots. The generated sample was stored in the `data` object to be called later.
  data <- reactive({
    # For `Unimodal` choice, we fix the mode at 0.
    if (input$modality == "Unimodal") {mu = 0}
    
    # For `Bimodal` choice, we fix the two modes at -2 and 2.
    if (input$modality == "Bimodal") {mu = c(-2, 2)}
    
    # Details will be explained in `sample.R` file.
    sample1 <- multimodal(n, mu, skewness = scale * input$skewness, tailedness = scale * input$kurtosis)
    data.frame(x = sample1)})
  
  
  output$histogram <- renderPlot({
    # Plot the histogram.
    ggplot(data(), aes(x = x)) + 
      geom_histogram(aes(y = ..density..), binwidth = .5, colour = "black", fill = "white") + 
      xlim(-6, 6) +
      ylab("Dichte") +
      # Overlay the density curve.
      geom_density(alpha = .5, fill = "lightblue") + ggtitle("Histogramm der Daten") + 
      theme(plot.title = element_text(lineheight = .8, face = "bold"))+
      theme_minimal()
  })
  
  
  
  output$qqplot <- renderPlot({
    # Plot the QQ plot.
    ggplot(data(), aes(sample = x)) + stat_qq() + ggtitle("QQ-Plot der Daten") +
      theme(plot.title = element_text(lineheight=.8, face = "bold")) +
      ylab("Daten")+
      xlab("Theoretische Verteilung")+
      theme_minimal()
  })
  
  
  
})