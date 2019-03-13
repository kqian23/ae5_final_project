library("shiny")
source("server.R")

home_page <- tabPanel(
  "Home",
  #  includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
  br(), br(), br(), br(),
  titlePanel(h1("Study on Youth Poverty and Youth Smoking",
    align = "center",
    style = "font-size: 70px"
  ))
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
        inputId = "gender",
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
    tabPanel(
      "Q2"
      # Q2 Code starts here
    ),
    question_three_page,
    question_four_page,
    team_page,
    sources_page
  )
)
