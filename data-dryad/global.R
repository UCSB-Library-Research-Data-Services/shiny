library(shiny)
library(rdryad) #DEPRECATED
library(tidyverse)

# Filename locally
cached_file <- "data/river_data_test.csv"

# Only download the data if it is not yet cached locally
if (!file.exists(cached_file)) {
  # get a dataset
  file_names <- dryad_download(dois="10.5061/dryad.f74fs")
  river_data <- read_csv(file_names$`10.5061/dryad.f74fs`[[1]])
  write_csv(river_data, cached_file)
}
  
  


