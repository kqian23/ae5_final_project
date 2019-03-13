library("shiny")
library("plotly")

# create tab for question three response
question_three_page <- tabPanel(
  "Poverty and Smoking Cessation",
  titlePanel("For the states that has the highest cessation percentage in a 
            given year, what is its poverty level?"),
  # created the side bar pannel for wedgits 
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
    # creates the main panel for the Table, Plot and Analysis
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Table", tableOutput("table")),
        tabPanel(
          "Plot", plotOutput(outputId = "cessation")
        ),
        tabPanel(
          "Analysis",
          h5("Does the percentage of the attempt to quit smoking relate to 
             poverty?"),
          h6("We would like to know if income plays a role for children to make 
             the decision of whether to quit smoking"),
          h3("Why does this question matter?"),
          p("Our group had a hypothesis of people with lower income would 
             smoke more than people with higher income. Finding this 
            relationship may help to explain issues either directly or 
            indirectly related with smocking and income. Issues such as 
            health problems, education, and poverty."),
          h3("What variables are considered?"),
          p("We are focusing on youth in middle school and high school. The 
           poverty data is taken in the range of age 0 - 17. We have also taken 
           gender as another variable to determine the relationship."),
          h3("Conclusion from data"),
          p("Based of the data that we got we have concluded that cessation and
            poverty have direct relationship.Looking at the states with the 
            highest cessation values, their poverty rate is significantly lower 
            than those with lower cessation percentage on any given year 
            [1999 - 2017]."),
          h3("Further work to be done"),
          p("For further work in analyzing the relationship between cessation 
           and poverty our team would suggest going on broader scale at world 
           level and analyzing the data for each country. As well as refining 
           the the data to county level will help to see the relationship 
           stronger.")
        )
      )
    )
  )
)
