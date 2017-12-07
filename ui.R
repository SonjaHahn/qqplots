library(shiny)

# Define UI for application that helps students interpret the pattern of (normal) QQ plots. 
# By using this app, we can show students the different patterns of QQ plots (and the histograms,
# for completeness) for different type of data distributions. For example, left skewed heavy tailed
# data, etc. 

# This app can be (and is encouraged to be) used in a reversed way, namely, show the QQ plot to the 
# students first, then tell them based on the pattern of the QQ plot, the data is right skewed, bimodal,
# heavy-tailed, etc.


shinyUI(fluidPage(
  # Application title
  titlePanel("QQ-Plots interpretieren (Normalverteilung)"),
  
  sidebarLayout(
    sidebarPanel(
      # The first slider can control the skewness of input data. "-1" indicates the most left-skewed 
      # case while "1" indicates the most right-skewed case.
      sliderInput("skewness", "Schiefe", min = -1, max = 1, value = 0, step = 0.1, ticks = FALSE),
      
      # The second slider can control the skewness of input data. "-1" indicates the most light tail
      # case while "1" indicates the most heavy tail case.
      sliderInput("kurtosis", "Kurtosis", min = -1, max = 1, value = 0, step = 0.1, ticks = FALSE),
      
      # This selectbox allows user to choose the number of modes of data, two options are provided:
      # "Unimodal" and "Bimodal".
      selectInput("modality", label = "Modalität", 
                  choices = c("Unimodal" = "Unimodal", "Bimodal" = "Bimodal"),
                  selected = "Unimodal"),
      br(),
      # checkboxInput("swap", label="Achsen im QQ-Plot tauschen (SPSS-Ansicht)"),
      #  br(),
      # The following helper information will be shown on the user interface to give necessary
      # information to help users understand sliders.
      helpText(p("Schieberegler", strong("Schiefe:"),  
                 "Linke Seite: Linksschief vs. rechte Seite: Rechtsschief."), 
               p("Schieberegler", strong("Kurtosis:"), 
                 "Linke Seite: flachgipflig (light tailed) vs. rechte Seite: steilgipflig (heavy tailed)."),
               p("Auswahl", strong("Modalität:"),
                 "Ein oder mehr Gipfel."),
               br(),
               # helpText(p("Code entnommen und abgeändert aus https://stats.stackexchange.com/questions/101274/how-to-interpret-a-qq-plot ")), 
               helpText(a("Ursprünglicher Code/weitere Hinweise",     href="https://stats.stackexchange.com/questions/101274/how-to-interpret-a-qq-plot")
               )
               
      )
    ),
    
    # The main panel outputs two plots. One plot is the histogram of data (with the nonparamteric density
    # curve overlaid), to get a better visualization, we restricted the range of x-axis to -6 to 6 so 
    # that part of the data will not be shown when heavy-tailed input is chosen. The other plot is the 
    # QQ plot of data, as convention, the x-axis is the theoretical quantiles for standard normal distri-
    # bution and the y-axis is the sample quantiles of data. 
    mainPanel(
      plotOutput("histogram"),
      plotOutput("qqplot")
    )
  )
)
)