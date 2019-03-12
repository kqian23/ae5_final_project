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

question_four_page <- tabPanel("Question 4",
                               sidebarLayout(
                                             sidebarPanel(
                                                           br(),br(),
                                                           titlePanel("Question Four"),
                                                           br(), br(),br(),br(),br(),
                                                           selectInput(
                                                                       inputId = "year",
                                                                       label = "Select a year between 1992 and 2016",
                                                                       choices = list("1999", "2000", "2001", "2002", "2003","2004", "2005", "2006", "2007", "2008",
                                                                                      "2009", "2010", "2011", "2012","2013","2014","2015", "2016", "2017")
                                                           ), 
                                                           radioButtons(
                                                                       inputId = "frequency",
                                                                       label = "Select a frequency level",
                                                                       choices = list ("Frequent","Ever","Current")
                                                           ), 
                                                           radioButtons(
                                                                       inputId = "type",
                                                                       label = "Select a type of smoking",
                                                                       choices = list ("Cigarette Use (Youth)","Smokeless Tobacco Use (Youth)")
                                                           ),
                                                           radioButtons(
                                                                       inputId = "gender",
                                                                       label = "Select a gender",
                                                                       choices = list ("Male","Female","Overall")
                                                           )
                                             ), 
                                             mainPanel(
                                                       titlePanel(
                                                                  "How does poverty rate correlate with middle school tobacco usage versus high 
                                                                  school tobacco usage? In other words, does a difference in poverty rates 
                                                                  between two states cause a larger difference in middleschool tobacco usage or 
                                                                  in high school tobacco usage?"
                                                       ), 
                                                       plotOutput(
                                                                 outputId = "education"
                                                       ),
                                                       h2("Why does this question matter?"),
                                                       p("This question helps us understand at which age level do students pick up smoking in different poverty levels.
                                                         If students have a lower difference in tobacco usage in middle school versus high school in high poverty areas, 
                                                         anti-smoking campaigns can target middle schoolers to stop the usage before it begins. However, if there is a large
                                                         difference, then you know that most smoking in that poverty range is starting in high school, so the marketing efforts
                                                         should focus there."),
                                                       br(),
                                                       h2("What are the variables of interest?"),
                                                       p("With so many different variables in our interest, it is important to determine which variables we care about to answer
                                                         our question. We'll take a look at the 2017 data because it is the most recent. We will choose Overall gender because there
                                                         is no reason for us to split by gender. We'll take a look at the Ever frequency. We choose this frequency because as we said in
                                                         the above question, we are using this information to figure out when smoking is more likely to start in different poverty levels. 
                                                         As a result, we don't care about whether students are currently smoking or how often they smoke - just if they've smoked. Finally,
                                                         we'll take a look at both cigarette usage and smokeless tobacco to see if there is a difference in the two."),
                                                       h2("What does the data look like?"),
                                                       h3("Cigarette Use Data"),
                                                       h3("Smokeless Tobacco Data")
                                            )
                               )
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
    question_four_page,
    team_page,
    sources_page
  )
)

