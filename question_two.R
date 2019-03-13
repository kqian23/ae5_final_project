library("shiny")
library("plotly")

question_two_page <- tabPanel("Poverty & Underage Smoking",
                              sidebarLayout(
                                sidebarPanel(
                                  # A `titlePanel` with the title "Poverty and Youth Tobacco Usage by Year"
                                  titlePanel("Poverty and Youth Tobacco Usage by Year"),
                                  
                                  # A `selectInput()` labeled "Select a state". This dropdown should let
                                  # the user pick one of the states in the joined data set.
                                  selectInput(inputId = "year_two", label = "Select a Year", 
                                              choices = list(
                                                "1999", "2000", "2001", "2002", "2003",
                                                "2004", "2005", "2006", "2007", "2008",
                                                "2009", "2010", "2011", "2012", "2013",
                                                "2014", "2015", "2016", "2017"
                                              ), selected = "2000")
                                  
                                ),
                                mainPanel(
                                  plotOutput(outputId = "my_plot"),
                                  h2("Is there causation between youth poverty 
                                     and under age smoking?"),
                                  h3("By joining the youth tobacco dataset and 
                                     the youth poverty dataset we created a new 
                                     dataset observing the state, year, 
                                     0-17-year-old poverty rate, and underage 
                                     smoking. The visualization allows the user 
                                     to choose a year and see if there is 
                                     causation with the youth poverty rate and 
                                     underage smoking of that year. According 
                                     to the data there is no causation between 
                                     youth poverty rate and underage smoking, 
                                     but there is moderate correlation.")
                                  )
                                  ))
