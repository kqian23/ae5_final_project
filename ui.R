library("shiny")
source("server.R")


ui <- fluidPage(
  #includeCSS("www/bootstrap.css"),
  includeCSS("www/profile.css"),
  includeCSS("www/header.css"),
  navbarPage("I'm NavBar",
     tabPanel("Home",
        includeHTML("www/header.html")
     ),
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
     tabPanel("About",
        includeHTML("www/profile.html")
     ),
     tabPanel("Sources"
              # Source Code starts here
     )
  )
)

