library("shiny")
library("plotly")

question_one_page <- tabPanel("Poverty & Gender of Smokers",
                              titlePanel("How does poverty rate affect male youth tobacco usage versus female youth tobacco usage?"),
                              br(),
                              h2("Why does this question matter?"),
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
                                                         br(), br(),
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
                                                         plotlyOutput(outputId = "map"),
                                                         br(), br(),
                                                         p("This choropleth map shows the averaged smoking percentage of the selected race in the United States. The different color of each state indicate the level of smoking percentage, which deeper the color is, greater the smoking percentage of the selected gender in that state. You could compare the difference of smoking distribution between male youth and female youth by selecting the dropdown menu. Furthermore, the poverty information of a particular state will be shown when mouse is hovered on that area. *States where data is not available is shown white and will display a value of -1 when you hover on it. "),
                                                         p("We can tell from the graph that, states in the mid-west area (such as Kentucky, Tennessee, West Virginia and Alabama) tend to have the greatest percentage of youth smoking for both genders, where the color is the deepest, and the poverty rates in this area are also relatively hight (20~30%). "),
                                                         p("Kentucky seems to have the highest youth smoking rate for both gender (33.9% for man and 21.2% for woman). "),
                                                         p("Overall, male youth has a much higher smoking percentage than woman based on the color."),
                                                         p("This map is useful for state government to realize and regulate the problem of youth smoking, especially for the states have high percentage of smoking rate. During the regulating, the data suggests to focus more on underage smoking by male youth, due to the severity of the problem. Middle and high schools in all states could also use this data for preventing the increase of youth smoking based on the current local poverty level.")
                                                       )
                                         )
                                )
                              )
)
