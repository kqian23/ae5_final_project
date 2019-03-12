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
                                                                  "Does poverty rate correlate to a difference in high school tobacco usage and middle school usage?"
                                                       ), br(), br(),
                                                       plotOutput(
                                                                 outputId = "education"
                                                       ),
                                                       h2("Why does this question matter?"),
                                                       p("This question helps us understand when students pick up smoking in different poverty levels. If the difference in high school 
                                                          tobacco usage versus middle school decreases as poverty rates rise, it means that more students pick up smoking in middle school as 
                                                          poverty rates go up. If the differences increases as poverty rates rise, it means that more students pick up smoking in high school as 
                                                          poverty rates go up. Anti-smoking campaigns can use this information to target middle schoolers/high schoolers based on what the research shows."),
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
                                                       img(src = "Cigarette.png", height = "500px", width = "800px"),
                                                       br(), br(),
                                                       p("When looking at this chart, it is evident that the blue bar, signifying the difference in cigarette smoking rates between high school and
                                                         middle school is increasing as poverty rates increase. In fact in the 25%-30% bin, the average percent difference is BLANK, while in the 10% to 15%, the average 
                                                         percent difference is BLANK. That is a difference of BLANK. This helps us understand that there might be a correlation between poverty rates
                                                         and when students pick up smoking. As poverty rate increases, it seems that more and more students end up picking up smoking in high school rather than
                                                         middle school. This might indicate that anti-cigarette marketing campaigns should focus on highschoolers in high poverty areas."),
                                                       h3("Smokeless Tobacco Data"),
                                                       img(src = "SmokelessTobacco.png", height = "500px", width = "800px"),
                                                       br(), br(),
                                                       p("When looking at this chart, there is not a clear correlation to be made between tobacco rates and when smoking is picked up. 
                                                          While the difference between the 10% to 15% and the 25% - 30% bins is nearly the same as the cigarette use chart, there is 
                                                         not a clear upwards trend for the differences columns as poverty rates increase. As a result, there is a low chance for correlation between poverty rates 
                                                         and when students pick up smokeless tobacco.
                                                         
                                                         One potential reason why difference in smokeless tobacco might not have a significant trend is because smokeless tobacco is friendlier to younger populations than
                                                         cigarettes. As a result, middle schoolers and high schoolers at any poverty rate can pick them up. Furthermore, smokeless tobacco is easier to hide than cigarettes,
                                                         making them more friendly to all ages from all poverty rates.")
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

