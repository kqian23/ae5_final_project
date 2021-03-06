library("shiny")
library("plotly")

question_two_page <- tabPanel("Poverty & Underage Smoking",
                              # A `titlePanel` with the title "Poverty and Youth Tobacco Usage by Year"
                              titlePanel(
                                "Is there correlation with youth suffering from poverty and underage smoking?"
                                ),
                              br(), br(),
                              sidebarLayout(
                                sidebarPanel(
                                   # A `selectInput()` labeled "Select a state". This dropdown should let
                                  # the user pick one of the states in the joined data set.
                                  selectInput(inputId = "year_two", label = "Select a Year", 
                                              choices = list(
                                                "1999", "2000", "2001", "2002", "2003",
                                                "2004", "2005", "2006", "2007", "2008",
                                                "2009", "2010", "2011", "2012", "2013",
                                                "2014", "2015", "2016", "2017"
                                              ), selected = "2000"))
                                  
                                ,
                                mainPanel(
                                  plotOutput(outputId = "my_plot")
                                )),
                                  br(),br(),
                                  h2("The answer to this question will help us understand why people begin to start smoking at a young age."), 
                                  br(),
                                  p("It is well known that smoking will cause significant health issues over a long period of time. 
                                    According to cancer.gov, smoking causes more premature, preventable death in the U.S. and each year 480,000 
                                    deaths occur due to smoking, including smokeless tobacco. There is no safe tobacco. Deaths due to smoking are 
                                    three times higher than non-smokers. Also, nicotine is considered to be similarly as addictive to drugs 
                                    categorized as Schedule I by the DEA (dea.gov).")
                                  ,
                                  h2("What does the data tell us?"),
                                  br(),
                                  p("The data does not show a strong correlation, but it does show a relation between youth poverty rates and 
                                    underage smoking. For example, in 2008 there is a strong trend between underage smoking and youth 
                                    poverty rate while in 2000 the trend isn't as evident. A state with a poverty rate of around 29 percent has an underage
                                    smoking rate of 22 percent. Likewise, a state with around 10 percent poverty rate has an average smoking rate percentage of just a little above 10 percent in the year 2000.
                                    Never the less, recognizing young people undergoing the difficulties of poverty are vulnerable to begin smoking at a young age.")
                              )                              
                          
