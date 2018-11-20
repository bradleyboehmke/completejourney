# This is the script used to clean the completejourney data

library(tidyverse)
library(lubridate)

# transactions -----------------------------------------------------------------

transactions <- read_csv("../../Data sets/Complete_Journey_UV_Version/transaction_data.csv") %>% 
  # select a one year slice of the data
  filter(day >= 285, day < 650) %>% 
  # convert it to a real date variable
  mutate(day = as.Date('2017-01-01') + (day - 285)) %>% 
  # re-index the week
  mutate(week_number = week_no - 40) %>% 
  # remove one straggling transaction on Christmas Day we will assume they were closed
  filter(day != '2017-12-25') %>%
  # create the transaction timestamp, add a random seconds component
  mutate(
    trans_time = as.integer(trans_time),
    hour = substr(sprintf('%04d', trans_time), 1, 2), 
    min = substr(sprintf('%04d', trans_time), 3, 4), 
    sec = sprintf('%02d', as.integer(as.numeric(str_sub(as.character(basket_id), start = -2)) * 60/100))
    ) %>%
  # handle weird daylight savings time cases
  mutate(hour = ifelse((day == as.Date('2017-03-12') & hour == '02'), '03', hour)) %>%
  unite(time, hour, min, sec, sep = ":", remove = FALSE) %>%
  mutate(transaction_timestamp = as.POSIXct(paste(day, time), 
                                            format="%Y-%m-%d %H:%M:%S", 
                                            tz="America/New_York")) %>%
  # what should we do about retail discounts that are positive? 
  # here we convert them to zero
  mutate(retail_disc = ifelse(retail_disc > 0, 0, retail_disc)) %>%
  # make the discount variables positive
  mutate(
    retail_disc = abs(retail_disc),
    coupon_disc = abs(coupon_disc),
    coupon_match_disc = abs(coupon_match_disc)
    ) %>%
  # rename household_key to household_id
  rename(household_id = household_key) %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  # sort by transaction datetime
  arrange(transaction_timestamp) %>%
  # reorder the variables
  select(household_id, store_id, basket_id, product_id, quantity, sales_value,
         retail_disc, coupon_disc, coupon_match_disc, week_number, 
         transaction_timestamp)

# save final data set
devtools::use_data(transactions)

# demographics -----------------------------------------------------------------

demographics <- read_csv("../../Data sets/Complete_Journey_UV_Version/hh_demographic.csv") %>% 
  rename(
    household_id = household_key,
    age = age_desc,
    income = income_desc,
    home_ownership = homeowner_desc,
    household_size = household_size_desc,
    marital_status = marital_status_code,
    household_comp = hh_comp_desc,
    kids_count = kid_category_desc
    ) %>% 
  mutate(
    age = factor(age, levels = c("19-24", "25-34", "35-44", "45-54", "55-64", "65+"), ordered = TRUE),
    marital_status = recode(marital_status, `A` = "Married", `B` = "Single", `U` = "Unknown"),
    marital_status = factor(marital_status, levels = c("Married", "Single", "Unknown"), ordered = TRUE),
    income = factor(income, levels = c("Under 15K", "15-24K", "25-34K", "35-49K", 
                                       "50-74K", "75-99K", "100-124K", "125-149K", 
                                       "150-174K", "175-199K", "200-249K", 
                                       "250K+"), ordered = TRUE),
    home_ownership = ifelse(home_ownership == "Probable Owner", "Probable Homeowner", home_ownership),
    home_ownership = factor(home_ownership, levels = c("Renter", "Probable Renter", 
                                                       "Homeowner", "Probable Homeowner", 
                                                       "Unknown"), ordered = TRUE),
    household_comp = factor(household_comp, levels = c("Single Female", "Single Male", 
                                                       "2 Adults No Kids", "1 Adult Kids",
                                                       "2 Adults Kids", "Unknown"), ordered = TRUE),
    household_size = factor(household_size, levels = c("1", "2", "3", "4", "5+"), ordered = TRUE),  
    kids_count = factor(kids_count, levels = c("1", "2", "3+", "None/Unknown"), ordered = TRUE)
    ) %>%   
  arrange(as.numeric(household_id)) %>%
  mutate_at(vars(ends_with("_id")), as.character) %>%
  select(
    household_id, age, income, marital_status, home_ownership, household_size,
    household_comp, kids_count
    )

devtools::use_data(demographics)

