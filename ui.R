library("shiny")
source("server.R")

home_page <- tabPanel("Home",
            #  includeCSS("www/header.css"),
              includeHTML("www/header.html"),
              br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
              titlePanel(h1("Study on Youth Poverty and Youth Smoking", align = "center", style = "font-size: 70px"))
)

team_page <- tabPanel("Team",
             # includeCSS("www/header.css"),
              includeHTML("www/header.html"),
              br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
              titlePanel(h1("Our Team", align = "left", style = "font-size: 70px")),
              br(), br(),
              includeCSS("www/profile.css"),
              includeHTML("www/profile.html")
              
)

sources_page <- tabPanel("Sources",
                 includeHTML("www/header.html"),
                 br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(), br(),
                 includeHTML("www/sources.html")
)




question_one_page <- tabPanel("Poverty & Gender of Smokers")


question_two_page <- tabPanel("Poverty & Underage Smoking",
                              sidebarLayout(
                                sidebarPanel(
                                  # A `titlePanel` with the title "Poverty and Youth Tobacco by State"
                                  titlePanel("Poverty and Youth Tobacco by State"),
                                  
                                  # A `selectInput()` labeled "Select a state". This dropdown should let
                                  # the user pick one of the states in the joined data set.
                                  selectInput(inputId = "Year", label = "Select a Year", 
                                              choices = select_values, selected = "2000")
                                  
                                ),
                                mainPanel(
                                  plotOutput(outputId = "my_plot")
                                )
                              ))

 

question_four_page <- tabPanel("Question 4",
                           sidebarLayout(
                             sidebarPanel(
                               selectInput(
                                 inputId = "year",
                                 label = "Select a year between 1992 and 2016",
                                 choices = list("1999", "2000", "2001", "2002", "2003",
                                                "2004", "2005", "2006", "2007", "2008",
                                                "2009", "2010", "2011", "2012","2013",
                                                "2014","2015", "2016", "2017")
                               ),
                               radioButtons(
                                 inputId = "feature",
                                 label = "Select a feature of interest to compare against",
                                 choices = list (
                                   "Frequent",
                                   "Ever",
                                   "Current")
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
  navbarPage("",
    home_page,
     question_one_page,
     question_two_page,
     tabPanel("Q3"
              # Q3 Code starts here
     ),
    question_four_page,
    team_page,
    sources_page
  )
)

