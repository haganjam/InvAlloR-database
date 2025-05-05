#' @title preservation correction factors
#' @description create a data.frame with the preservation correction factor data
#' @author James G. Hagan (james_hagan(at)outlook.com)
#' 

# load relevant libraries
library(readr)

# load the reference list
pre_dat <- readr::read_csv(here::here("raw-data/dry_biomass_correction_data.csv"),
                           col_types = cols(
                             correction_factor_id = col_double(),
                             first_author = col_character(),
                             year = col_double(),
                             journal = col_character(),
                             title = col_character(),
                             location_description = col_character(),
                             preservation = col_character(),
                             percentage = col_double(),
                             order = col_character(),
                             taxon = col_character(),
                             rank = col_character(),
                             correction_percentage = col_double(),
                             doi_url = col_character(),
                             notes = col_character()
                           ))

# check the database
head(pre_dat)
str(pre_dat)

# replace the NA characters with true NAs
pre_dat[pre_dat == "NA"] <- NA

# export the database as a .rds file
saveRDS(pre_dat, here::here("database/preservation_correction_database.rds"))
