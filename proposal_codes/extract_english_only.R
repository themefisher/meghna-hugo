# Language detection script
library(tidyverse)
library(cld3)
library(dplyr)

reviews <- read_csv("./data/raw/reviews.csv")

review_language <- c()

for (i in 1:nrow(reviews)){
  language <- detect_language(as.character(reviews$comments[i]))
  review_language <- append(review_language, language)
}

all_reviews <- cbind(reviews, review_language)
final_reviews <- all_reviews %>% filter(all_reviews$review_language == "en")
final_reviews <- subset(final_reviews, select = c("listing_id","date", "comments"))
#final_reviews <- sub_reviews %>%
  #group_by(listing_id) %>%
  #summarise(comments = paste(comments, collapse = " | "))
  
write_csv(final_reviews,"./data/clean/reviews.csv")

####

listings_lang <- read_csv("./data/raw/listings.csv")
listings_lang <- listings_lang %>% rename(listing_id = id)
  
description_lang <- c()

for (i in 1:nrow(listings_lang)){
  language <- detect_language(as.character(listings_lang$description[i]))
  description_lang <- append(description_lang, language)
}

all_listings <- cbind(listings_lang, description_lang)
final_listings <- all_listings %>% filter(all_listings$description_lang == "en")
write_csv(final_listings, "./data/clean/listing_en.csv")


#####################################################################################

## Distance calculation script
library(tidyverse)
library(geodist)

listings <- read.csv("./data/raw/listings.csv")
mrt <- read.csv("./data/mrtsg.csv")

listings <- listings %>% select(id, longitude, latitude)
colnames(listings) <- c("listing_id", "lon","lat")
mrt <- mrt %>% select(STN_NAME, Longitude, Latitude, COLOR)
colnames(mrt) <- c("STN_NAME", "lon", "lat", "stn_line")

nearest_stn <- c()
stn_distance <- c()

for (i in 1:nrow(listings)) {
  mrt_distance <- c()
  for (j in 1:nrow(mrt)) {
    distance <- geodist(listings %>% slice(i), mrt %>% slice(j))
    mrt_distance <- append(mrt_distance , distance)
  }
  nearest_stn <- append(nearest_stn, as.character(mrt$STN_NAME[which(min(mrt_distance) == mrt_distance)][[1]]))
  stn_distance <- append(stn_distance, min(mrt_distance))
}

fullerton <- data.frame("lon" = 103.8531, "lat" = 1.2864)
dist_centre <- c()

for (i in 1:nrow(listings)){
  dist_centre <- append(dist_centre, geodist(listings %>% slice(i), fullerton))
}

listings_stn_distance <- cbind(listings, data.frame(nearest_stn, stn_distance, dist_centre))
listings_stn_distance <- listings_stn_distance %>%
  inner_join(mrt, by = c("nearest_stn" = "STN_NAME")) %>%
  select(listing_id, nearest_stn, stn_distance, dist_centre) %>%
  distinct(listing_id, .keep_all = TRUE)

write.csv(listings_stn_distance, "./data/clean/listings_stn_dist.csv")

######################
## joint three folders

lst <- list(final_listings, listings_stn_distance, final_reviews)
combined <- reduce(lst, full_join, by = "listing_id") %>% replace(., is.na(.), 0)

