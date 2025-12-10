# 02_clean.R
library(dplyr)
library(janitor)
library(lubridate)
library(stringr)

raw <- read_csv("data/potholes_raw.csv") %>% clean_names()

clean <- raw %>%
  filter(str_detect(type_of_service_request, "Pothole")) %>%
  filter(!is.na(creation_date)) %>%
  mutate(
    creation_date = ymd(creation_date),
    year = year(creation_date)
  ) %>%
  #filter(year == 2018) %>%  
  select(type_of_service_request, creation_date, year, community_area, status)

write_csv(clean, "data/potholes.csv")

print(paste("clean successful  total", nrow(clean), "lines of Pothole data"))
