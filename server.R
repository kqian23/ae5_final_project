library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
source("analysis.R")



# efine a `server` function
server <- function(input, output) {
  
  # Q1 starts here
  
  
  # Q2 starts here
 

    
    

    
    # A plotOutput showing the 'plot' output (based on the user specification)

    # Assign a reactive `renderPlot()` function to the outputted 'plot' value
    output$my_plot <- renderPlot({
      selected_values <- input$Year
      #source in youth tobacco data
      youth_smoking <- get_youth_tobacco_data()
      
      #source in youth poverty data
      youth_poverty <- get_youth_poverty_data() 
      
      #filter youth smoking to exclude cessation
      filtered_smoking <- youth_smoking %>% 
        filter(Topic_Description == "Cigarette Use (Youth)" | Topic_Description == "Smokeless Tobacco Use (Youth)") %>%
        #select the columns to join with youth poverty
        select(Year, State, Data_Value)
      
      #select which columns to join with youth smoking
      filtered_poverty <- youth_poverty %>% 
        select(year, state, ages_0_to_17_in_poverty_rate, state_abbreviation)
      
      #join the datasets
      joined <- left_join(filtered_smoking, filtered_poverty, 
                          by = c("State" = "state_abbreviation")) %>% 
        select(state, ages_0_to_17_in_poverty_rate, Data_Value, Year) %>%
        #group by state and year
        group_by(state, Year) %>% 
        summarise(avg_rate_smoking = mean(Data_Value, na.rm = TRUE),
                  ages_0_to_17_in_poverty_rate = 
                    mean(as.numeric(ages_0_to_17_in_poverty_rate), na.rm = TRUE)) %>% 
        filter(!is.na(state))
      
      plot_data <- joined %>% filter(Year == input$Year)
      
      
      #use the joined data set to make a scattered plot of poverty with under age
      # smoking as smooth to show causation 
      p <- ggplot(data = plot_data)+
        geom_point(mapping = aes(x = ages_0_to_17_in_poverty_rate, y = avg_rate_smoking))+
        geom_smooth(mapping = aes(x = ages_0_to_17_in_poverty_rate, y = avg_rate_smoking))
      
      
      
      
      p #return the plot
    })#end of render plot    
  
  
  # Q3 starts here
  
  
  # Q4 starts here
  output$education <- renderPlot({
    youth_tobacco_data_set <- get_youth_tobacco_data() 
    youth_tobacco_data_set <- youth_tobacco_data_set %>% 
      filter(Year == input$year) %>% #replace w/input year
      filter(Topic_Description == "Cigarette Use (Youth)") %>% 
      filter(Gender == "Overall") %>% 
      filter(Response == input$feature) %>% 
      select(State, Education, Data_Value)
    
    youth_tobacco_data_set <- spread( youth_tobacco_data_set,
      key = "Education",
      value = "Data_Value"
    )
    
    youth_poverty_data_set <- get_youth_poverty_data()
    youth_poverty_data_set <- youth_poverty_data_set %>% 
      filter(year == input$year) %>% 
      ungroup() %>% 
      select(State = state_abbreviation, ages_0_to_17_in_poverty_rate)

    
    joined_data_set <- left_join(youth_poverty_data_set, youth_tobacco_data_set, by = c("State"))

    joined_data_set <- mutate(joined_data_set, poverty_rate = as.numeric(ages_0_to_17_in_poverty_rate))
    percentage_bin_labels <- c("0% to 5%", "5% to 10%", "10% to 15%", "15% to 20%", "20% to 25%")
    percentage_bins <- cut(joined_data_set$poverty_rate, c(0,5,10,15,20,35), percentage_bin_labels)
    
    joined_data_set <- mutate(joined_data_set, percentage_bins)
    joined_data_set <- select(joined_data_set, State, poverty_rate, `High School`, `Middle School`, percentage_bins)
    joined_data_set <- group_by(joined_data_set, percentage_bins)
    joined_data_set <- na.omit(joined_data_set)
    
    summarized_set <- summarize(joined_data_set,
                                High_School = mean(`High School`, na.rm = TRUE),
                                Middle_School = mean(`Middle School`, na.rm = TRUE)
                                )
    summarized_set <- mutate(summarized_set, Difference = High_School - Middle_School)
    
    summarized_set <- gather(summarized_set, 
                             key = education, value = percentage,
                             -percentage_bins)
    summarized_set$education <- factor(summarized_set$education, levels = c("Middle_School","High_School","Difference"))
    ggplot(data = summarized_set) +
      geom_col(mapping = aes(x = percentage_bins, y = percentage, fill = education), position = "dodge")
    
    
    
  })
}
  
