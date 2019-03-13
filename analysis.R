library("httr")
library("jsonlite")
library("dplyr")
library("tidyr")


View(get_youth_tobacco_data())
View(get_youth_poverty_data())

# Returns a data frame of the Youth Tobacco Survey with data on smoking for children
# across the nation
get_youth_tobacco_data <- function () {
  tobacco_data_raw <- read.csv("data/Youth_Tobacco_Survey__YTS__Data.csv", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")
  tobacco_data <- tobacco_data_raw %>% 
    select(YEAR, LocationAbbr, Gender, Education, Data_Value, Response, TopicDesc, GeoLocation) 
  
  # Give proper column names
  colnames(tobacco_data) <- c("Year", "State", "Gender", "Education", "Data_Value", "Response", 
                             "Topic_Description", "Geo_Location")
  
  # Take out states that are not in the Youth Poverty Data Set
  tobacco_data <- tobacco_data %>% 
    filter(is.na(Data_Value) == FALSE) %>% 
    filter( State != "GU" &
             State != "PR" &
             State != "VI" &
             State != "US") 
  # Return Tobacco Data Set
  tobacco_data
}

# Returns a data frame of the SAIPE with the data on youth (age 0-17) poverty across the 
# nation
get_youth_poverty_data <- function() {
  poverty_uri <- "https://api.census.gov/data/timeseries/poverty/saipe?get=NAME,SAEPOV0_17_PT,SAEPOVRT0_17_PT,SAEMHI_PT,STABREV&for=state:*&YEAR=1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017"
  poverty_header <- GET(poverty_uri)
  poverty_content <- content(poverty_header, type = "text", encoding = "UTF-8")
  poverty_data <- fromJSON(poverty_content)
  
  # Turn data into a data frame to work with and give it column names
  poverty_data <- as.data.frame(poverty_data, stringsAsFactors = FALSE)
  colnames(poverty_data) <- c("state", "ages_0_to_17_in_poverty_count", "ages_0_to_17_in_poverty_rate", "median_household_income_estimate", "state_abbreviation", "year","")
  
  # Take out the first row of the original set's names
  poverty_data <- poverty_data[-1,]
  poverty_data <- select(poverty_data, state, ages_0_to_17_in_poverty_count, ages_0_to_17_in_poverty_rate, median_household_income_estimate, year, state_abbreviation)
  
  # Take out states from the frame that are not in the Youth Tobacco data frame
  poverty_data <- poverty_data %>% 
    group_by(state,state_abbreviation) %>% 
    filter(state_abbreviation != "AL" &
             state_abbreviation !=  "MT" &
             state_abbreviation != "NV" &
             state_abbreviation != "OR" &
             state_abbreviation != "WA") 
   
  poverty_data
}

# Return a dataframe containing summary of Youth Poverty data
get_poverty_summary <- function() {
  poverty_summary <- get_youth_poverty_data() %>% 
    summarize(ages_0_to_17_in_poverty_count = mean(as.numeric(ages_0_to_17_in_poverty_count), na.rm = TRUE),
              ages_0_to_17_in_poverty_rate = mean(as.numeric(ages_0_to_17_in_poverty_rate), na.rm = TRUE),
              median_household_income_estimate = mean(as.numeric(median_household_income_estimate), na.rm = TRUE))
  poverty_summary_ranked <- poverty_summary
  poverty_summary_ranked$rank <- rank(-poverty_summary_ranked$ages_0_to_17_in_poverty_rate)
  poverty_summary_ranked
}

# Return a data frame containing a general data frame of Youth Tobacco Data
get_tobacco_summary <- function() {
  tobacco_summary <- get_youth_tobacco_data() %>% 
    filter(Topic_Description == "Cigarette Use (Youth)" | Topic_Description == "Smokeless Tobacco Use (Youth)") %>% 
    filter(Gender == "Overall") %>% 
    group_by(State) %>% 
    summarize(
      max_rate_smoking = max(Data_Value), 
      min_rate_smoking = min(Data_Value),
      avg_rate_smoking = mean(Data_Value)
    )

  tobacco_summary_ranked <- tobacco_summary 
  tobacco_summary_ranked$rank <- rank(-tobacco_summary_ranked$avg_rate_smoking)
  tobacco_summary_ranked
}

# Return data frame of Youth Poverty and Youth Tobacco joined by the state
get_joined_data <- function() {
  data_joined <- left_join(get_tobacco_summary(), get_poverty_summary(), by = c("State" = "state_abbreviation"))
  data_joined <- select(data_joined, -6)
  colnames(data_joined)[c(5, 9)] <- c("smoking_rank", "poverty_rank")
  data_joined <- filter(data_joined, State != "AL")
  data_joined
}

# Return data frame of tabacco data frame grouped by state and gender, and then summarized
get_tobacco_by_gender <- function() {
  gender_tobacco <- get_youth_tobacco_data() %>% 
    filter(Topic_Description != "Cessation (Youth)") %>% 
    filter(Gender != "Overall") %>% 
    filter(Response != "Ever") %>% 
    select(State, Gender, Data_Value) %>% 
    group_by(Gender, State) %>% 
    summarize(
      max_rate_smoking = max(Data_Value), 
      min_rate_smoking = min(Data_Value),
      avg_rate_smoking = mean(Data_Value)
    )
  
  gender_tobacco_ranked <- gender_tobacco
  gender_tobacco_ranked$rank <- rank(-gender_tobacco_ranked$avg_rate_smoking)
  gender_tobacco_ranked
}

# Return a data frame of Youth Tobacco grouped by state and education level, and summarized
get_tobacco_by_education <- function() {
  education_tobacco <- get_youth_tobacco_data() %>% 
    filter(Topic_Description != "Cessation (Youth)") %>% 
   filter(Response != "Ever") %>% 
    select(State, Education, Data_Value) %>% 
    group_by(Education, State) %>% 
    summarize(
      max_rate_smoking = max(Data_Value), 
      min_rate_smoking = min(Data_Value),
      avg_rate_smoking = mean(Data_Value)
    )
  
  education_tobacco_ranked <- education_tobacco
  education_tobacco_ranked$rank <- rank(-education_tobacco_ranked$avg_rate_smoking)
  education_tobacco_ranked
}

# Return a data frame of Youth Tobacco grouped by state and education level, and summarized
get_tobacco_by_topic <- function() {
    topic_tobacco <- get_youth_tobacco_data() %>% 
    select(State, Topic_Description, Data_Value) %>% 
    group_by(Topic_Description, State) %>% 
    summarize(
      max_rate = max(Data_Value), 
      min_rate = min(Data_Value),
      avg_rate = mean(Data_Value)
    )
  tobacco_topic_ranked <- topic_tobacco
  tobacco_topic_ranked$rank <- rank(-tobacco_topic_ranked$avg_rate)
  tobacco_topic_ranked
}

