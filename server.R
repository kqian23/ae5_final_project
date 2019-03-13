library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("jsonlite")
source("analysis.R")


# define a `server` function
server <- function(input, output) {

  # Q1 starts here


  # Q2 starts here


  # Q3 starts here
  
  # rename poverty column

  
 
  
  output$cessation <- renderPlot({
    poverty <- get_youth_poverty_data()
    colnames(poverty)[colnames(poverty) == "state"] <- "states"
    colnames(poverty)[colnames(poverty) == "state_abbreviation"] <- "State"
   
     # filter out poverty data set
    poverty_data_plot <- poverty %>%
      filter(year == input$years)
   
    # filter out tobaco data set
    cessation <- get_youth_tobacco_data() %>%
      select(-Geo_Location, -Response) %>%
      filter(
        Topic_Description == "Cessation (Youth)", Year == input$years,
        Gender == input$gender
      )

    joined_cessation_poverty_data <- left_join(cessation, poverty,
      by = c("State")
    ) %>%
      select(
        Year, State, Gender, Education, Data_Value,
        ages_0_to_17_in_poverty_rate
      )

    joined_cessation_poverty_data <- mutate(joined_cessation_poverty_data,
      poverty_rate = as.numeric(ages_0_to_17_in_poverty_rate)
    ) 

    poverty_perc_bin_labels <-
      c(
        "0% to 5%", "5% to 10%", "10% to 15%", "15% to 20%", "20% to 25%",
        "25% to 30%", "30% to 35%"
      )
    percentage_bins <-
      cut(
        joined_cessation_poverty_data$poverty_rate,
        c(0, 5, 10, 15, 20, 25, 30, 35), poverty_perc_bin_labels
      )

    ggplot(data = joined_cessation_poverty_data) +
      geom_col(mapping = aes(
        x = percentage_bins, y = Data_Value,
        fill = Education
      )) + labs(
        title = paste(
          "Smoking Cessation Vs. Poverty Rates for", input$gender,
          "in the year of", input$years,
          input$selected_year, "in the United States"
        ),
        x = "Poverty Rate", y = "Cessation"
      ) +
      scale_fill_brewer(palette = "Accent")
  }) 
  
  # output a data table
  output$table <- renderTable({
    
    # poverty_data_table <- poverty %>%
    #   filter(year == input$years)
    # 
    # # filter out tobaco data set
    # cessation_table <- get_youth_tobacco_data() %>%
    #   select(-Geo_Location, -Response) %>%
    #   filter(
    #     Topic_Description == "Cessation (Youth)", Year == input$years,
    #     Gender == input$gender
    #   )
    # 
    # joined_cessation_poverty_data_table <- left_join(cessation, poverty, 
    #                                            by = c("State")) %>%
    #   select(
    #     Year, State, Gender, Education, Data_Value,
    #     ages_0_to_17_in_poverty_rate
    #   )
    # # %>% 
    # #   arrange(-ages_0_to_17_in_poverty_rate) %>% 
    # #   head(n = 10)
    
    poverty <- get_youth_poverty_data()
    colnames(poverty)[colnames(poverty) == "state"] <- "states"
    colnames(poverty)[colnames(poverty) == "state_abbreviation"] <- "State"
    
    poverty_data_table <- poverty %>%
      filter(year == input$years) 
    
    # filter out tobaco data set
    cessation_table <- get_youth_tobacco_data() %>%
      select(-Geo_Location, -Response) %>%
      filter(
        Topic_Description == "Cessation (Youth)", Year == input$years,
        Gender == input$gender
      ) 

    
    joined_cessation_poverty_data_table <- left_join(cessation_table, poverty_data_table, 
                                                     by = c("State")) %>% 
      select(
        Year, State, Gender, Education, Data_Value,
        ages_0_to_17_in_poverty_rate
      ) %>% 
      na.omit() %>%  
      head(n = 10)
    

      
  })



  # Q4 starts here
  output$education <- renderPlot({
    youth_tobacco_data_set <- get_youth_tobacco_data()
    youth_tobacco_data_set <- youth_tobacco_data_set %>%
      filter(Year == input$year) %>% # replace w/input year
      filter(Topic_Description == "Cigarette Use (Youth)") %>%
      filter(Gender == "Overall") %>%
      filter(Response == input$feature) %>%
      select(State, Education, Data_Value)

    youth_tobacco_data_set <- spread(youth_tobacco_data_set,
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
    percentage_bins <- cut(joined_data_set$poverty_rate, c(0, 5, 10, 15, 20, 35), percentage_bin_labels)

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
      -percentage_bins
    )
    summarized_set$education <- factor(summarized_set$education, levels = c("Middle_School", "High_School", "Difference"))
    ggplot(data = summarized_set) +
      geom_col(mapping = aes(x = percentage_bins, y = percentage, fill = education), position = "dodge")
  })
}

