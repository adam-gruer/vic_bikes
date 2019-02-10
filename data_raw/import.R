

library(tidyverse)
library(fs)

sites <- readxl::read_xlsx("data_raw/VicRoads_Bike_Site_Number_Listing.xlsx")
View(sites)

sites <- 
  sites %>% 
  janitor::clean_names() %>% 
  select(1:6) %>% 
  filter(!is.na(lat)) %>% 
  sf::st_as_sf(crs = 4326,coords = c("long","lat")) 

mapview::mapview(sites)

#unzip each folder to a separate directory
library(fs)

zip_files <- dir_ls("./data_raw", glob = "*IND.zip") 

walk(zip_files, function(zip_file){
    new_dir <- 
          zip_file %>% 
          path_file() %>% 
          path_ext_remove() %>% 
          path("data_raw", .) %>% 
          unzip(zip_file, exdir = .)

})

dirs <- fs::dir_ls("data_raw", glob = "*IND", type = "directory")

bike_data <- fs::dir_map(dirs, read_csv) %>% 
   map_dfr(rbind)

ggplot(bike_data, aes(x = SPEED)) +
geom_histogram(  )

summary(bike_data)



#bike_volume_speed_url <- "https://vicroadsopendatastorehouse.vicroads.vic.gov.au/opendata/Traffic_Measurement/Bicycle_Volume_and_Speed/Bicycle_Volume_speed_2015.zip"

