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
  mutate(week = as.integer(week_no - 40)) %>% 
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
         retail_disc, coupon_disc, coupon_match_disc, week, transaction_timestamp)

# save final data set
usethis::use_data(transactions, overwrite = TRUE)

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
  mutate_at(vars(ends_with("_id")), as.character) %>%
  mutate(
    marital_status = recode(marital_status, `A` = 'Married', `B` = "Unmarried", `U` = "Unknown"), 
    home_ownership = ifelse(home_ownership == "Probable Owner", "Probable Homeowner", home_ownership), 
    household_size = factor(household_size, levels = c("1", "2", "3", "4", "5+"), ordered = TRUE)
    ) %>%  
  mutate(household_comp = ifelse((household_comp == "Single Male" | 
                                    household_comp == "Single Female") & 
                                   household_size == '1', "1 Adult No Kids", 
                                 household_comp)) %>%
  mutate(household_comp = ifelse((household_comp == "Single Male" | 
                                    household_comp == "Single Female") & 
                                   as.integer(household_size) > 1, 
                                 "1 Adult Kids", 
                                 household_comp)) %>%
  mutate(kids_count = ifelse(household_comp == "1 Adult No Kids" | 
                               household_comp == "2 Adults No Kids", 
                             '0', kids_count)) %>%
  mutate(household_comp = ifelse(household_comp == "Unknown" & kids_count ==
                                   "Unknown" & household_size == '1', 
                                 "1 Adult No Kids", household_comp)) %>%
  mutate(household_comp = ifelse(household_comp == "Unknown" & household_size ==
                                   '3' & kids_count == '1', "2 Adults Kids",
                                 household_comp)) %>%
  mutate(household_comp = ifelse(household_comp == "Unknown" & household_size ==
                                   '5+' & kids_count == '3+', "2 Adults Kids",
                                 household_comp)) %>%
  mutate(household_comp = ifelse(household_comp == "Unknown" & household_size ==
                                   '2' & kids_count == '1', "1 Adult Kids",
                                 household_comp)) %>%
  mutate(household_comp = ifelse(household_size == '1', "1 Adult No Kids",
                                 household_comp)) %>%
  mutate(household_comp = ifelse(household_comp == "Unknown" & marital_status ==
                                   "Married" & household_size == "2",
                                 "2 Adults No Kids", household_comp)) %>%
  mutate(kids_count = ifelse(kids_count == "Unknown" & household_comp ==
                               "1 Adult Kids" & household_size == '2', '1',
                             kids_count)) %>%
  mutate(kids_count = ifelse(kids_count == "Unknown" & marital_status ==
                               "Married" & household_size == "2", '0', 
                             kids_count)) %>%
  mutate(kids_count = ifelse(household_size == '2' & household_comp == 
                               '1 Adult Kids', '1', kids_count)) %>%
  mutate(kids_count = ifelse(household_comp == "2 Adults No Kids", '0', 
                             kids_count)) %>%
  mutate(kids_count = ifelse(household_size == '1', '0', kids_count)) %>%
  mutate(marital_status = ifelse(marital_status == "Unknown" & 
                                   (household_comp == "1 Adult Kids" | 
                                      household_comp == "1 Adult No Kids"), 
                                 "Unmarried", marital_status)) %>%
  mutate(household_comp = factor(household_comp, 
                                 levels = c("1 Adult Kids", "1 Adult No Kids",
                                            "2 Adults Kids", "2 Adults No Kids",
                                            "Unknown"), 
                                 ordered = TRUE)) %>%
  mutate(
    kids_count = factor(kids_count, levels = c("0", "1", "2", "3+", "Unknown"), ordered = TRUE), 
    age = factor(age, levels = c("19-24", "25-34", "35-44", "45-54", "55-64", "65+"), ordered = TRUE), 
    home_ownership = factor(home_ownership, 
                            levels = c("Renter", "Probable Renter", 
                                       "Homeowner", "Probable Homeowner", "Unknown"), 
                            ordered = TRUE), 
    household_size = factor(household_size, levels = c("1", "2", "3", "4", "5+"), ordered = TRUE), 
    marital_status = factor(marital_status, levels = c("Married", "Unmarried", "Unknown"), ordered = TRUE), 
    income = factor(income, 
                    levels = c("Under 15K", "15-24K", "25-34K", "35-49K", 
                               "50-74K", "75-99K", "100-124K", "125-149K", 
                               "150-174K", "175-199K", "200-249K", "250K+"), 
                    ordered = TRUE)
    ) %>%
  na_if("Unknown") %>%
  arrange(household_id) %>%
  select(household_id, age, income, home_ownership, marital_status, 
         household_size, household_comp, kids_count)

# save final data set
usethis::use_data(demographics, overwrite = TRUE)

# products ---------------------------------------------------------------------

products <- read_csv("../../Data sets/Complete_Journey_UV_Version/product.csv") %>%
  rename(
    manufacturer_id = manufacturer,
    package_size = curr_size_of_product,
    product_category = commodity_desc,
    product_type = sub_commodity_desc
    ) %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  mutate(
    brand = factor(brand, levels = c("National", "Private")),
  # standardize/collapse some departments
    department = gsub("MISC\\. TRANS\\.|MISC SALES TRAN", "MISCELLANEOUS", department),
    department = gsub("VIDEO RENTAL|VIDEO|PHOTO", "PHOTO & VIDEO", department),
    department = gsub("RX|PHARMACY SUPPLY", "DRUG GM", department),
    department = gsub("DAIRY DELI|DELI/SNACK BAR", "DELI", department),
    department = gsub("PORK|MEAT-WHSE", "MEAT", department),
    department = gsub("GRO BAKERY", "GROCERY", department),
    department = gsub("KIOSK-GAS", "FUEL", department),
    department = gsub("TRAVEL & LEISUR", "TRAVEL & LEISURE", department),
    department = gsub("COUP/STR & MFG", "COUPON", department),
    department = gsub("HBC", "DRUG GM", department),
  # fix as many product size descriptions as possible
    package_size = gsub("CANS", "CAN", package_size),
    package_size = gsub("COUNT", "CT", package_size),
    package_size = gsub("DOZEN", "DZ", package_size),
    package_size = gsub("FEET", "FT", package_size),
    package_size = gsub("FLOZ", "FL OZ", package_size),
    package_size = gsub("GALLON|GL", "GAL", package_size),
    package_size = gsub("GRAM", "G", package_size),
    package_size = gsub("INCH", "IN", package_size),
    package_size = gsub("LIT$|LITRE|LITERS|LITER|LTR", "L", package_size),
    package_size = gsub("OUNCE|OZ\\.", "OZ", package_size),
    package_size = gsub("PACK|PKT", "PK", package_size),
    package_size = gsub("PIECE", "PC", package_size),
    package_size = gsub("PINT", "PT", package_size),
    package_size = gsub("POUND|POUNDS|LBS|LB\\.", "LB", package_size),
    package_size = gsub("QUART", "QT", package_size),
    package_size = gsub("SQFT", "SQ FT", package_size),
    package_size = gsub("^(\\*|\\+|@|:|\\)|-)", "", package_size),
    package_size = gsub("([[:digit:]])([[:alpha:]])", "\\1 \\2", package_size),
    package_size = trimws(package_size)) %>%
  mutate(
    product_type = gsub("\\*ATTERIES", "BATTERIES", product_type),
    product_type = gsub("\\*ATH", "BATH", product_type),
    product_type = gsub("^\\*", "", product_type)
    ) %>%
  # remove these strange cases
  filter(product_category != "(CORP USE ONLY)", 
         product_category != "MISCELLANEOUS(CORP USE ONLY)",
         product_type != "CORPORATE DELETES (DO NOT USE") %>%
  # how can we deal with cases where product_category == "UNKNOWN", 
  # but product_type != "UNKNOWN", and values of NA? (ignore for now)
  na_if("UNKNOWN") %>%
  na_if("NO COMMODITY DESCRIPTION") %>%
  na_if("NO SUBCOMMODITY DESCRIPTION") %>% 
  na_if("NO-NONSENSE") %>%
  select(product_id, manufacturer_id, department, brand, product_category, product_type, package_size)

# save final data set
usethis::use_data(products, overwrite = TRUE)

# promotions -----------------------------------------------------------------

promotions <- read_csv("../../Data sets/Complete_Journey_UV_Version/causal_data.csv") %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  # re-index the week
  mutate(
    display = as.factor(display),
    mailer = as.factor(mailer),
    week = as.integer(week_no - 40)
    ) %>% 
  # only select data from 2017
  semi_join(., transactions, by = 'week') %>%
  # sort by week first, since that is helpful to understand
  arrange(week, product_id, store_id) %>%
  select(product_id, store_id, display_location = display, mailer_location = mailer, week) 

# save final data set
readr::write_rds(promotions, path = 'data/promotions.rds', compress = 'gz')

# save sample dataset
promotions %>%
  group_by(store_id) %>%
  sample_frac(.5) %>%
  usethis::use_data(overwrite = TRUE)

# campaign_descriptions --------------------------------------------------------

campaign_descriptions <- read_csv("../../Data sets/Complete_Journey_UV_Version/campaign_desc.csv") %>%
  rename(
    campaign_id = campaign, 
    start_date = start_day, 
    end_date = end_day
    ) %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  mutate(
    description = gsub('(Type)(A|B|C)', '\\1 \\2', description),
    description = factor(description, levels = paste('Type', LETTERS[1:3]), ordered = TRUE),
    start_date = as.Date('2017-01-01') + (start_date - 285),
    end_date = as.Date('2017-01-01') + (end_date - 285)
    ) %>%
  filter(year(start_date) == 2017 | year(end_date) == 2017) %>%
  # sort by date since that helps understand the timing of each campaign
  arrange(start_date) %>% 
  select(campaign_id, campaign_type = description, start_date, end_date) %>%
  arrange(as.numeric(campaign_id))
  
# campaigns --------------------------------------------------------------------

campaigns <- read_csv("../../Data sets/Complete_Journey_UV_Version/campaign_table.csv") %>%
  rename(
    campaign_id = campaign,
    household_id = household_key
  ) %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  # remove any campaigns that did not occur in 2017 %>% 
  semi_join(., campaign_descriptions, by='campaign_id') %>%
  # arrange by campaign so we can see each together
  arrange(campaign_id, household_id) %>%
  select(campaign_id, household_id) 

# coupons ----------------------------------------------------------------------

coupons <- read_csv("../../Data sets/Complete_Journey_UV_Version/coupon.csv") %>%
  rename(campaign_id = campaign) %>%
  mutate(coupon_upc = as.character(coupon_upc)) %>%
  # convert the id variables to characters
  mutate_at(vars(ends_with("_id")), as.character) %>% 
  # remove any campaigns that did not occur in 2017 %>% 
  semi_join(., campaign_descriptions, by='campaign_id') %>%
  arrange(coupon_upc, product_id) %>%
  select(coupon_upc, product_id, campaign_id)

# coupon_redemptions -----------------------------------------------------------

coupon_redemptions <- read_csv("../../Data sets/Complete_Journey_UV_Version/coupon_redempt.csv") %>%
  rename(
    household_id = household_key,
    campaign_id = campaign
    ) %>%
  # convert the id variables to characters and update dates
  mutate_at(vars(ends_with("_id")), as.character) %>%
  mutate(
    coupon_upc = as.character(coupon_upc), 
    redemption_date = as.Date('2017-01-01') + (day - 285)
    ) %>%
  filter(year(redemption_date) == 2017) %>%
  # remove any campaigns that did not occur in 2017 %>% 
  semi_join(., campaign_descriptions, by='campaign_id') %>%
  arrange(redemption_date) %>%
  select(household_id, coupon_upc, campaign_id, redemption_date)


# Reformat campaign ID so they are 1-27 -----------------------------------

# create campaign ID matching vector
old_id <- sort(as.numeric(unique(campaign_descriptions$campaign_id)))
new_id <- seq_along(old_id)
names(new_id) <- old_id

# function that changes campaign ID
switch_id <- function(x) {
  for (i in seq_along(x)) {
    index <- which(x[i] == names(new_id))
    x[i] <- new_id[index]
  }
  x
}

coupon_redemptions$campaign_id <- switch_id(coupon_redemptions$campaign_id)
campaign_descriptions$campaign_id <- switch_id(campaign_descriptions$campaign_id)
campaigns$campaign_id <- switch_id(campaigns$campaign_id)
coupons$campaign_id <- switch_id(coupons$campaign_id)

devtools::use_data(coupon_redemptions, overwrite = TRUE) 
devtools::use_data(campaign_descriptions, overwrite = TRUE)  
devtools::use_data(campaigns, overwrite = TRUE)
devtools::use_data(coupons, overwrite = TRUE) 

readr::write_rds(coupon_redemptions, path = 'data/coupon_redemptions.rds', compress = 'gz')
readr::write_rds(campaign_descriptions, path = 'data/campaign_descriptions.rds', compress = 'gz')
readr::write_rds(campaigns, path = 'data/campaigns.rds', compress = 'gz')
readr::write_rds(coupons, path = 'data/coupons.rds', compress = 'gz')

# data check summaries ---------------------------------------------------------

daily_sales <- transactions %>% 
  mutate(date = as.Date(transaction_timestamp, tz="America/New_York")) %>%
  group_by(date) %>% 
  summarize(total_sales_value = sum(sales_value, na.rm = TRUE)) 

daily_sales %>% 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total_sales_value))

daily_sales %>% 
  mutate(dow = strftime(date, '%A')) %>% 
  mutate(dow = factor(dow, levels=c("Monday", "Tuesday", "Wednesday", 
                                    "Thursday", "Friday", 
                                    "Saturday", "Sunday"), ordered=TRUE)) %>%
  group_by(dow) %>% 
  summarize(avg_sales = mean(total_sales_value)) %>% 
  ggplot() + 
  geom_bar(aes(x=dow, y=avg_sales), stat = 'identity')
