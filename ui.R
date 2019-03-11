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

ui <- fluidPage(
  includeCSS("www/bootstrap.css"),
  includeCSS("www/header.css"),
  navbarPage("",
             
    home_page,
     tabPanel("Q1"
              # Q1 Code starts here
     ),
     tabPanel("Q2"
              # Q2 Code starts here
     ),
     tabPanel("Q3"
              # Q3 Code starts here
     ),
     tabPanel("Q4"
              # Q4 Code starts here
     ),
    team_page,
    sources_page
  )
)

