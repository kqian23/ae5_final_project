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
  )), 
  h2("Introduction", align = "center"),
  h4("Underage smoking and poverty… Do they relate two each other? Intuitively we can’t tell. It’s possible that teenagers in poor areas have less option of 
     recreation and tobacco becomes the dominant one; It’s also reasonable that teenagers in poor areas are less likely to afford tobacco and hence they are 
     more popular in richer areas. Having curiosity for those questions, we decide to do a data analysis on two distinct data frames containing youth smoking
     and poverty information, and hopefully could draw some useful insights and the end."),
  br(),
  h2("Background Information:", align = "center"),  
  h4("Our group has chosen two data sets, one with data regarding the rate of youth tobacco usage. The other has data about poverty rates. We will compare the data by state to make our observation and see if there is a correlation between poverty rates and youth smoking in 2017.
    The youth tobacco data set contains the percentage of smoking by states for different youth groups. There are features like gender, education level, smoking type and smoking frequency, which allows us to explore and ask a variety of questions about youth tobacco usage.
    The concept of poverty is simple - it is the number of people who fall below their state poverty line in terms of income. Ages 0-17 classify as youth, so we are studying youth poverty rates and counts by state.
    This domain is worthy analyzing because it will help us understand the correlation between low-income students and their likelihood to develop smoking habits. We feel that by understanding this correlation, we can better understand if bad habits such as smoking are largely affected by socioeconomic status or not.
    This information might be crucial to anti-smoking marketing campaigns, so they know what type of ads to run in what places.")
)

team_page <- tabPanel(
  "Team",
  includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
  br(), br(), br(), br(),
  titlePanel(h1("Our Team", align = "center", style = "font-size: 70px")),
  br(), br(),
  includeCSS("www/profile.css"),
  includeHTML("www/profile.html")
)

sources_page <- tabPanel(
  "Sources",
  includeCSS("www/header.css"),
  includeHTML("www/header.html"),
  br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
  br(), br(), br(), br(), 
  titlePanel(h1("Our Sources", align = "center", style = "font-size: 70px")), 
  br(), br(),
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