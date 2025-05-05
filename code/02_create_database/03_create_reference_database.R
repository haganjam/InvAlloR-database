#' @title reference list
#' @description create a data.frame of the equation references
#' @details This script compiles the list of publications from which the
#'   equations in the equation database were compiled
#' @author James G. Hagan (james_hagan(at)outlook.com)
#' 

# load relevant libraries
library(readr)

# load the reference list
ref_dat <- readr::read_csv(here::here("raw-data/reference_database.csv"),
                           col_types = cols(
                             reference_id = col_double(),
                             first_author = col_character(),
                             year = col_double(),
                             journal = col_character(),
                             title = col_character(),
                             location_description = col_character(),
                             doi_url = col_character(),
                             notes = col_character()
                           ))

# check the database
head(ref_dat)
str(ref_dat)

# replace the NA characters with true NAs
ref_dat[ref_dat == "NA"] <- NA

# export the database as a .rds file
saveRDS(ref_dat, here::here("database/reference_database.rds"))
