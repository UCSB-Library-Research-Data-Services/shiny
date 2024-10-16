library(shiny)
library(rdryad) #DEPRECATED, and no replacement yet https://github.com/ropensci/rdryad/issues/41!!
library(tidyverse)

# Filename locally
my_cached_file <- "data-dryad/data/river_data_test.csv"
my_doi = "10.5061/dryad.f74fs"
my_repo = "Dryad"



data_cache_checker <- function(cached_file, doi, repo="Dryad"){
  # Only download the data if it is not yet cached locally
  if (file.exists(cached_file)) {
    data <- read.csv(cached_file) 
  } else {
    # get a dataset https://datadryad.org/stash/dataset/doi:10.5061/dryad.jh9w0vtcg
    file_names <- dryad_download(dois=doi)
    repo_data <- read_csv(file_names$doi[[1]])
    # Write the data
    write_csv(repo_data, cached_file)
    # Read the data
    data <- read.csv(cached_file)
  }
}
  
  

data_cache_checker(my_cached_file, my_doi, my_repo)
