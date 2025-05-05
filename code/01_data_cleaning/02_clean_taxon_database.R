# Clean taxon database

# load relevant libraries
library(bdc)
library(stringdist)
library(readr)

# load the equation data
t_dat <- readr::read_csv(here::here("raw-data/taxon_database.csv"),
                         col_types = cols(
                           database = col_character(),
                           id = col_double(),
                           group1 = col_character(),
                           group2 = col_character(),
                           db_taxon = col_character(),
                           db_taxon_gt_order = col_character(),
                           db_higher_rank_source = col_logical(),
                           db_taxon_higher_rank = col_logical(),
                           db_taxon_higher = col_logical()
                         ))
head(t_dat)

# check the variable structure
str(t_dat)

# clean the names for typos etc.
clean_names <- bdc::bdc_clean_names(sci_names = t_dat$db_taxon, save_outputs = FALSE)

# check if any names were changed
if (!any(clean_names$scientificName != clean_names$names_clean)) {
  message("No names were changed")
}

# replace the names in tax.dat with these cleaned names
t_dat$db_taxon <- clean_names$names_clean

# fix the special names
spec_names <- c(
  "Rotifera",
  "Tardigrada",
  "Nematoda",
  "Platyhelminthes",
  "Turbellaria",
  "Annelida",
  "Oligochaeta"
)

# replace incorrectly spelled special names
for (i in 1:length(spec_names)) {
  x <-
    sapply(t_dat$db_taxon, function(y) {
      ain(x = spec_names[i], table = y, method = "lv", maxDist = 2)
    })

  t_dat[x, "db_taxon"] <- spec_names[i]
}

# write this into a .rds file
saveRDS(t_dat, file = here::here("database/taxon_database.rds"))
