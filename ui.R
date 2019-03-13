library("shiny")
library("plotly")
source("server.R")

# ******************************************************************************************
# Pages

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

question_one_page <- tabPanel("Poverty & Gender of Smokers",
                              h3("How does poverty rate affect male youth tobacco usage versus female youth tobacco usage?"),
                              br(),
                              p("Why does this question matter?"),
                              p("This question helps us understand how poverty rates affect the decision to smoke in males versus females. Through this, we can see what gender has a higher tendency to smoke in low poverty environments, and anti-smoking campaigns can focus in on that demographic to reduce harm."),
                              br(),
                              # Two tbas for two plots
                              tabsetPanel(
                                # First plot: scatter plot of avg poverty rate and avg smoking rate
                                tabPanel("Explore Correlation",
                                         # implant check box on the right side bar
                                         sidebarLayout(position = "right",
                                                       sidebarPanel(
                                                         checkboxGroupInput("gender_one",
                                                                            label = "Select Gender",
                                                                            choices = c("Male" = "avg_male_smoking", "Female" = "avg_female_smoking"),
                                                                            selected = "Male"
                                                         )
                                                       ),
                                                       # main panel for analysis and data presentation
                                                       mainPanel(
                                                         plotlyOutput(outputId = "one_scatter"),
                                                         br(),
                                                         p("The following scatter plot shows the correlation of averaged poverty percentage and the averaged youth smoking percentage of the selected gender from 1999 to 2017. Each colorful dot represents a state and together we could see a general relationship from the linear regression fit of the scatter points(the blue line), with the shaded area as range of standard error. The data used for presentation is filtered for only FREQUENTLY youth smokers, which is the major group of concern in the aspect of health and growth."),
                                                         p("For male youth, the slope of the regression line is approximately 0.55, which shows a moderate positive correlation. This means that the increase of poverty rate in a state has a moderate correlation with the increase of male youth smokers in that state. "),
                                                         p("On the female side, the regression line has a slope of around 0.125, which shows a very weak positive correlation between female youth smoking and poverty rate."),
                                                         p("Overall, the slope of regression line for both gender is near 0.37, which means a weak positive correlation. So from the data, it seems greater the poverty in a state, higher the chance that youth in such state will become a frequent smoker. Moreover, in the few states that have the highest overall smoking percentage (Kentucky, West Virginia, Alabama and Tennessee), we could see that they all have poverty percentage over 20%, which is more than half of the averaged poverty percentage for all states. In the aspect of gender, it seems like male youth are more likely to be affected by the increase of poverty.")
                                                       )
                                         )
                                ),
                                # second panel: choropleth map of avg smoking level
                                tabPanel("View Data On Map",
                                         # implant dropdown box on the right side bar
                                         sidebarLayout(position = "right",
                                                       sidebarPanel(
                                                         selectInput("dropdown_gender",
                                                                     label = "Select Gender",
                                                                     choices = c("Male" = "avg_male_smoking", "Female" = "avg_female_smoking"))
                                                       ),
                                                       # main panel for map presentation and analysis
                                                       mainPanel(
                                                         p("This choropleth map shows the averaged smoking percentage of the selected race in the United States. The different color of each state indicate the level of smoking percentage, which deeper the color is, greater the smoking percentage of the selected gender in that state. You could compare the difference of smoking distribution between male youth and female youth by selecting the dropdown menu. Furthermore, the poverty information of a particular state will be shown when mouse is hovered on that area. *States where data is not available is shown white and will display a value of -1 when you hover on it. "),
                                                         br(),
                                                         plotlyOutput(outputId = "map"),
                                                         br(),
                                                         p("We can tell from the graph that, states in the mid-west area (such as Kentucky, Tennessee, West Virginia and Alabama) tend to have the greatest percentage of youth smoking for both genders, where the color is the deepest, and the poverty rates in this area are also relatively hight (20~30%). "),
                                                         p("Kentucky seems to have the highest youth smoking rate for both gender (33.9% for man and 21.2% for woman). "),
                                                         p("Overall, male youth has a much higher smoking percentage than woman based on the color."),
                                                         p("This map is useful for state government to realize and regulate the problem of youth smoking, especially for the states have high percentage of smoking rate. During the regulating, the data suggests to focus more on underage smoking by male youth, due to the severity of the problem. Middle and high schools in all states could also use this data for preventing the increase of youth smoking based on the current local poverty level.")
                                                       )
                                         )
                                )
                              )
                      )

question_two_page <- tabPanel("Poverty & Underage Smoking",
                              sidebarLayout(
                                sidebarPanel(
                                  # A `titlePanel` with the title "Poverty and Youth Tobacco Usage by Year"
                                  titlePanel("Poverty and Youth Tobacco Usage by Year"),
                                  
                                  # A `selectInput()` labeled "Select a state". This dropdown should let
                                  # the user pick one of the states in the joined data set.
                                  selectInput(inputId = "year_two", label = "Select a Year", 
                                              choices = list(
                                                "1999", "2000", "2001", "2002", "2003",
                                                "2004", "2005", "2006", "2007", "2008",
                                                "2009", "2010", "2011", "2012", "2013",
                                                "2014", "2015", "2016", "2017"
                                              ), selected = "2000")
                                  
                                ),
                                mainPanel(
                                  plotOutput(outputId = "my_plot"),
                                      h2("Is there causation between youth poverty 
                                         and under age smoking?"),
                                      h3("By joining the youth tobacco dataset and 
                                      the youth poverty dataset we created a new 
                                      dataset observing the state, year, 
                                      0-17-year-old poverty rate, and underage 
                                      smoking. The visualization allows the user 
                                      to choose a year and see if there is 
                                      causation with the youth poverty rate and 
                                      underage smoking of that year. According 
                                      to the data there is no causation between 
                                      youth poverty rate and underage smoking, 
                                      but there is moderate correlation.")
                                )
                              ))


question_three_page <- tabPanel(
  "Poverty and Smoking Cessation",
  titlePanel("For the states that has the highest cessation percentage in a given
             year, what is its poverty level?"),
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
        inputId = "gender_three",
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
          h5("Does the percentage of the attempt to quit smoking relate to poverty?"),
          h6("We would like to know if income plays a role for children to make 
             the decision of whether to quit smoking"),
          p("In anaanalizing ")
        )
      
      )
    )
  )
)



question_four_page <- tabPanel("Poverty and Education of Smokers",
                               titlePanel(
                                 "Does poverty rate correlate to a difference in high school tobacco usage and middle school usage?"
                               ),
                               br(), br(),
                               sidebarLayout(
                                 sidebarPanel(

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
                                     inputId = "gender_four",
                                     label = "Select a gender",
                                     choices = list ("Male","Female","Overall")
                                   )
                                 ), 
                                 mainPanel(
                                   
                                   plotOutput(
                                     outputId = "education"
                                   )
                                 )
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
                                 middle school is increasing as poverty rates increase. In fact in the 25%-30% bin, the average percent difference is 19.9, while in the 10% to 15%, the average 
                                 percent difference is 16.03% That is a difference of 3.87%. This helps us understand that there might be a correlation between poverty rates
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

# ******************************************************************************************
# Main ui
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