library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
source("analysis.R")



# efine a `server` function
server <- function(input, output) {
  
 
  # Q1 starts here
  # ******************************************************************************************
  # filter the data based on user input
  output$one_scatter <- renderPlotly({
    # load data
    data_one <- get_data_one()
    
    # setup the initial plot when no input received
    if(is.null(input$gender_one)) {
      scatter_plot <-ggplot(data = data_one) +
          geom_point(aes(x = poverty_rate, y = 0, color = state))+
          ylim(0, 40) + xlim(5, 31) +
          theme(legend.position="none") +
          xlab("Poverty Percentage") +
          ylab("Smoking Percentage of Selected Gender") 
    } else {
      # filter the observations based on user input
      data_one <- data_one %>% 
        gather(key = smoking_gender, value = smoking_percentage, c(2,3)) %>% 
        filter(smoking_gender == input$gender_one)
      
      # formate hover info
      plot_ly(data = data_one,
              x = ~poverty_rate,
              y = ~smoking_percentage,
              color = ~state,
              hoverinfo = 'text',
              text = ~state)
      
      # generate thte plot
      scatter_plot <- ggplot(data = data_one) +
          geom_point(aes(x = poverty_rate, y = smoking_percentage, color = state)) +
          geom_smooth(aes(x = poverty_rate, y = smoking_percentage), method = "lm", size = 0.5) +
          ylim(0, 40) + xlim(5, 31) +
          theme(legend.position="none") +
          xlab("Poverty Percentage") +
          ylab("Smoking Percentage of Selected Gender")
      ggplotly(scatter_plot, tooltip = "state")
    }
  })
  
  # output for map plot
  
  output$map <- renderPlotly({
    
    # load data
    data_one <- get_data_one() 
    
    # filter the data based on user input
    data_one <- data_one %>% 
      gather(key = smoking_gender, value = smoking_percentage, c(2,3)) %>% 
      filter(smoking_gender == input$dropdown_gender)
    
    # Add the missing states and set their values to NA
    state <- c("AK", "MT", "NV", "OR", "WA")
    smoking_percentage <- c(-1,-1,-1,-1,-1)
    smoking_gender <- c(-1,-1,-1,-1,-1)
    poverty_rate <- c(-1,-1,-1,-1,-1)
    data_missing <- data.frame(state, poverty_rate, smoking_gender, smoking_percentage)
    
    # add a hover row for missing data
    namevector <- c("hover")
    data_missing[ , namevector] <- NA
    data_missing[, "hover"] <- paste0("State: NA", '<br>',
                                      "Poverty Rate: NA")
    
    # add a hover row for existing data
    data_temp <- data_one %>% mutate(hover = paste0("State: ", state, "<br>",
                                                    "Poverty_Rate: ", poverty_rate, "%"))
    
    # combine missing and existing data
    data_one <- rbind(data_temp, data_missing)
    
    
    # give state boundaries a white border
    l <- list(color = toRGB("white"), width = 2)
    # specify some map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showlakes = TRUE,
      lakecolor = toRGB('white')
    )
    
    # generate the choropleth map
    map <- plot_geo(data_one, locationmode = 'USA-states') %>%
      add_trace(
        z = ~smoking_percentage, text = ~hover, locations = ~state,
        color = ~smoking_percentage, colors = 'Purples', 
        zauto = FALSE, zmax = 35
      ) %>%
      colorbar(title = "Smoking Percentage") %>%
      layout(
        title = paste(names(input$dropdown_gender), "Youth Smoking Percentage from 1999 to 2017"),
        geo = g,
        autosize = T
      )
    map    # return the map plot
  })
  

  
  # Q2 starts here
  # ******************************************************************************************
   # A plotOutput showing the 'plot' output (based on the user specification)
    # Assign a reactive `renderPlot()` function to the outputted 'plot' value
    output$my_plot <- renderPlot({
      selected_values <- input$year_two
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
      
      plot_data <- joined %>% filter(Year == selected_values)
      
      #use the joined data set to make a scattered plot of poverty with under age
      # smoking as smooth to show causation 
      p <- ggplot(data = plot_data)+
        geom_point(mapping = aes(x = ages_0_to_17_in_poverty_rate, y = avg_rate_smoking))+
        geom_smooth(mapping = aes(x = ages_0_to_17_in_poverty_rate, y = avg_rate_smoking))

      p #return the plot
    })#end of render plot    
  
  
  # Q3 starts here
  # ******************************************************************************************
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
          Gender == input$gender_three
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
        geom_col(mapping = aes(x = percentage_bins, y = Data_Value, fill = Education)) + labs(
          title = paste(
            "Smoking Cessation Vs. Poverty Rates for", input$gender_three,
            "in the year of", input$years,
            input$selected_year, "in the United States"),
          x = "Poverty Rate", y = "Cessation") +
        scale_fill_brewer(palette = "Accent")
    }) 
    
    # output a data table
    output$table <- renderTable({
      
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
          Gender == input$gender_three
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
  
