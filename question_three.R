library("shiny")
library("plotly")

# create tab for question three response
question_three_page <- tabPanel(
  "Poverty and Smoking Cessation",
  titlePanel("For the states that has the highest cessation percentage in a 
             given year, what is its poverty level?"),
  # created the side bar pannel for wedgits 
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
    # creates the main panel for the Table, Plot and Analysis
    mainPanel(
      tabsetPanel(
        type = "tabs",
        # create Table tab
        tabPanel("Table", tableOutput("table")),
        # create Plot tab
        tabPanel(
          "Plot", plotOutput(outputId = "cessation")
        ),
        # create Analysis tab
        tabPanel(
          "Analysis",
          h1("Does the percentage of the attempt to quit smoking relate to 
             poverty?"),
          h6("We would like to know if income plays a role for children to make 
             the decision of whether to quit smoking"),
          h3("Why does this question matter?"),
          p("Our group had a hypothesis of people with lower income would smoke 
            more than people with higher income. Finding this relationship may 
            help to explain issues either directly or indirectly related with 
            smocking and income and how income level affect students behavior 
            towards smoking. In thinking about cessation and income status, 
            students are most likely to not have a stable income to support 
            their smocking needs. Beyond the income needs finding the
            relationship between cessation of smocking and poverty may help 
            explain other issues related with smocking and income. Issues like 
            health instability, economic hardship, educational attainment and 
            so on. This data also can be used to help address students 
            struggling with smoking and lower income."),
          h3("What variables are considered?"),
          p("The main variables those came in play were income status, 
            cessation percentage, year, gender, age and educational status. 
            We took this variables one by one to study the relationship by 
            looking at trends and the maximum and minimum values. Our focus 
            groups are students between the age of 0 - 17 who are either in 
            middle school or high school. In considering gender, we have taken 
            consideration of male and female students individually and overall 
            which is both combined. The other variable was the year. We looked 
            at how each year has affected all the other variables and 
            hypothesized that the advancement of technology and increase in 
            awareness has and effect on the relationship."),
          h3("Conclusion from data"),
          p("Based of the data that we got we have concluded that cessation 
            and poverty have direct relationship. Looking at the states with 
            the highest cessation values, their poverty rate is significantly 
            lower than those with lower cessation percentage on any given year 
            [1999 - 2017]. Often times male students tend to smoke more than 
            female. The year variable shows a drastic change from 1999 to 2017. 
            The states with maximum cessation percentage has kept on decreasing 
            their poverty levels with in this time frame and the states with 
            the minimum of cessation percentage has an increased level of 
            poverty. Educational levels, middle school and high school also 
            have shown a significant changes. Middle schools has increased 
            their cessation percentage and that has related to decreased 
            poverty levels while high school students has shown decreased in 
            cessation percentage and increased in poverty levels. "),
          h3("Further work to be done"),
          p("For further work in analyzing the relationship between cessation 
            and poverty our team would suggests three ways."),br(),
            p("1.  Going on broader scale at world level and analyzing the data 
              for each country."), br(),
            p("2. Refining the the data to county level will help to see the 
              relationship stronger."),br(),
            p("3. Including older age groups such as college students and 
              people in the work force.")
        )
      )
    )
  )
)
