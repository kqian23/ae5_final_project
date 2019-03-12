library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
source("analysis.R")

# efine a `server` function
server <- function(input, output) {
  
  # Q1 starts here
  
  
  # Q2 starts here
  
  
  # Q3 starts here
  
  
  # Q4 starts here
  output$education <- renderPlot({
    
    # Get youth tobacco data set
    youth_tobacco_data_set <- get_youth_tobacco_data() 
    
    #input = list()
    #input$year = "2000"
    #input$type = "Cigarette Use (Youth)"
    #input$gender = "Overall"
    #input$feature = "Ever"
    # update youth tobacco data set based on input values for year, type of smoking, gender, and frequency
    youth_tobacco_data_set <- youth_tobacco_data_set %>% 
      filter(Year == input$year) %>%  # Filter for chosen year
      filter(Topic_Description == input$type) %>% # Filter for type of smoking
      filter(Gender == input$gender) %>% # Filter for gender
      filter(Response == input$frequency) %>%  # Filter for frequency of smoking
      select(State, Education, Data_Value) # select State, Education, and Data Value (which is percentage of students in a state who fall under a category)
    
    # Tidy up data using tidyr in order to combine with youth_poverty_data_set
    youth_tobacco_data_set <- spread(youth_tobacco_data_set, 
      key = "Education",
      value = "Data_Value"
    )
    
    # Get youth poverty data set
    youth_poverty_data_set <- get_youth_poverty_data()
    
    # update youth poverty data set based on input values for year
    youth_poverty_data_set <- youth_poverty_data_set %>% 
      filter(year == input$year) %>%  # Filter for chosen year
      ungroup() %>% # the get_youth_poverty_data() function groups data, but we want it ungrouped for this application
      select(State = state_abbreviation, ages_0_to_17_in_poverty_rate) # select State and Poverty Rate for children age 0-17

    # Join data sets by their state so that each row contains a state, a smoking percentage for HS'ers, a smoking percentage for MS'ers, and a poverty rate in that state
    joined_data_set <- left_join(youth_poverty_data_set, youth_tobacco_data_set, by = c("State"))
  
    # Turn poverty rate information into numeric data so that we can split it up into groups
    joined_data_set <- mutate(joined_data_set, poverty_rate = as.numeric(ages_0_to_17_in_poverty_rate))
    percentage_bin_labels <- c("0% to 5%", "5% to 10%", "10% to 15%", "15% to 20%", "20% to 25%", "25% to 30%", "30% to 35%")  # Labels for grouping on next line
    percentage_bins <- cut(joined_data_set$poverty_rate, c(0,5,10,15,20,25,30,35), percentage_bin_labels) # Group by poverty rate and assign labels for a given bin
    joined_data_set <- mutate(joined_data_set, percentage_bins) # place labels into the joined data set
    joined_data_set <- select(joined_data_set, `High School`, `Middle School`, percentage_bins) 
  
    joined_data_set <- group_by(joined_data_set, percentage_bins)
    joined_data_set <- na.omit(joined_data_set) # remove all rows that don't have both a high school and middle school value for consistency
    
    # Average mean high school and middle school smoking rate by percentage bin
    summarized_set <- summarize(joined_data_set,
                                High_School = mean(`High School`, na.rm = TRUE),
                                Middle_School = mean(`Middle School`, na.rm = TRUE)
                                )
    summarized_set <- mutate(summarized_set, Difference = High_School - Middle_School)
    
    # Tidy up data using tidyr to make it appropriate for plotting
    summarized_set <- gather(summarized_set, 
                             key = education, value = percentage,
                             -percentage_bins) # ignore percentage bins column
    
    # The below line of code makes it so that bars appear in the following order: Middle School, High School, and Difference
    summarized_set$education <- factor(summarized_set$education, levels = c("Middle_School","High_School","Difference")) 
    
    # Make the plot
    ggplot(data = summarized_set) +
      geom_col(mapping = aes(x = percentage_bins, y = percentage, fill = education), position = "dodge") + 
      labs (
        x = "Poverty Rates",
        y = paste0("Avg % ", input$gender, " students who smoke in ", input$year),
        title = paste0("Avg % ", input$gender, " students who smoke in ", input$year, " relative to poverty rate"),
        fill = "Education Level"
      )
    
    
    
  })
  
}