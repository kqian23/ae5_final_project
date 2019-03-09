library("shiny")
source("server.R")


ui <- navbarPage("I'm NavBar",
  tabPanel("Home"
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
  tabPanel("About"
           # About Code starts here
           ),
  tabPanel("Sources"
           # Source Code starts here
           )
)



shinyApp(ui = ui, server = server)