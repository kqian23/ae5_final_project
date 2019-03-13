library("shiny")
library("plotly")

question_three_page <- tabPanel(
  "Poverty and Smoking Cessation",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "years",
        label = "Select a year between 1992 and 2017",
        choices = list(
          "1999", "2000", "2001", "2002", "2003",
          "2004", "2005", "2006", "2007", "2008",
          "2009", "2010", "2011", "2012", "2013",
          "2014", "2015", "2016", "2017"
        )
      ),
      radioButtons(
        inputId = "gender_three",
        label = "Select a gender of interest to compare against",
        choices = list(
          "Male",
          "Female",
          "Overall"
        )
      )
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Table", tableOutput("table")),
        tabPanel(
          "plot", plotOutput(outputId = "cessation")
        ),
        
        tabPanel(
          "Analysis",
          h4("For the states that has the highest cessation percentage in a given
             year, what is its poverty level?"),
          h5("Does the percentage of the attempt to quit smoking relate to poverty?"),
          h5("We would like to know if income plays a role for children to make 
             the decision of whether to quit smoking"),
          p("In anaanalizing ")
          )
        
        )
      )
)
    )