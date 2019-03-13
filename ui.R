library("shiny")
source("server.R")

home_page <- tabPanel(
  "Home",
  #  includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), 
  br(), br(), br(), br(),
  titlePanel(h1("Study on Youth Poverty and Youth Smoking", align = "center", 
                style = "font-size: 70px"))
)

team_page <- tabPanel(
  "Team",
  # includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), 
  br(), br(), br(), br(),
  titlePanel(h1("Our Team", align = "left", style = "font-size: 70px")),
  br(), br(),
  includeCSS("www/profile.css"),
  includeHTML("www/profile.html")
)

sources_page <- tabPanel(
  "Sources",
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), 
  br(), br(), br(), br(), br(), br(),
  includeHTML("www/sources.html")
)




question_one_page <- tabPanel("Poverty & Gender of Smokers")

question_two_page <- tabPanel("Poverty & Underage Smoking",
                              sidebarLayout(
                                sidebarPanel(
                                  # A `titlePanel` with the title "Poverty and Youth Tobacco by State"
                                  titlePanel("Poverty and Youth Tobacco by State"),
                                  
                                  # A `selectInput()` labeled "Select a state". This dropdown will let
                                  # the user pick a year in the joined data set.
                                  selectInput(inputId = "Year", label = "Select a Year", 
                                              choices = select_values, selected = "1999")
                                  ),
                                mainPanel(
                                  plotOutput(outputId = "my_plot"),
                                  h2("Is there causation between youth poverty 
                                     and underage smoking?"),
                                  h3("By joining the youth tobacco dataset and 
                                     the youth poverty dataset we created a new 
                                     dataset observing the state, year, 
                                     0-17-year-old poverty rate, and underage 
                                     smoking. The visualization allows the user 
                                     to choose a year and see if there is causation 
                                     with the youth poverty rate and underage smoking of that year. 
                                     According to the data there is no causation between youth 
                                     poverty rate and underage smoking, but there is moderate correlation.")
                                )
                              ))



question_three_page <- tabPanel(
  "Poverty and Smoking Cessation",
  titlePanel("asf"),
  sidebarLayout()
)


question_four_page <- tabPanel(
  "Question 4",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "year",
        label = "Select a year between 1992 and 2016",
        choices = list(
          "1999", "2000", "2001", "2002", "2003",
          "2004", "2005", "2006", "2007", "2008",
          "2009", "2010", "2011", "2012", "2013",
          "2014", "2015", "2016", "2017"
        )
      ),
      radioButtons(
        inputId = "feature",
        label = "Select a feature of interest to compare against",
        choices = list(
          "Frequent",
          "Ever",
          "Current"
        )
      )
    ),
    mainPanel(
      plotOutput(
        outputId = "education"
      )
    )
  )
)


ui <- fluidPage(
  includeCSS("www/bootstrap.css"),
  includeCSS("www/header.css"),
  navbarPage(
    "",
    home_page,
    question_one_page,
    question_two_page,
    question_three_page,
    question_four_page,
    team_page,
    sources_page
  )
)
