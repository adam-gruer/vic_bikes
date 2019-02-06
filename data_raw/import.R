

library(tidyverse)
sites <- readxl::read_xlsx("C:/Users/gruera/Downloads/VicRoads_Bike_Site_Number_Listing.xlsx")
View(sites)

sites %>% 
  janitor::clean_names() %>% 
  select(1:6) %>% 
  filter(!is.na(lat)) %>% 
  sf::st_as_sf(crs = 4326,coords = c("long","lat")) %>% 
  mapview::mapview()
  
  


bike_volume_speed_url <- "https://vicroadsopendatastorehouse.vicroads.vic.gov.au/opendata/Traffic_Measurement/Bicycle_Volume_and_Speed/Bicycle_Volume_speed_2015.zip"

