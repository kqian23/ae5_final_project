library("shiny")
library("plotly")
source("question_one.R")
source("question_two.R")
source("question_three.R")
source("question_four.R")

# ******************************************************************************************
# Pages

home_page <- tabPanel(
  "Home",
  includeCSS("www/header.css"),
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
  includeCSS("www/header.css"),
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
  includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
  br(), br(), br(), br(), br(), br(),
  includeHTML("www/sources.html")
)



# ******************************************************************************************
# Main ui
ui <- fluidPage(
  includeCSS("www/bootstrap.css"),
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