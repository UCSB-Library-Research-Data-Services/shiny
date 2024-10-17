library(shiny)
library(rdryad) #DEPRECATED, and no replacement yet https://github.com/ropensci/rdryad/issues/41!!
library(tidyverse)

# Filename locally
my_cached_file <- "data/river_data_test.csv"
my_dryad_doi = "10.5061/dryad.f74fs"
zenodo_url_file = "https://zenodo.org/records/4992324/files/File%20A1.csv?download=1"
zenodo_filename = "data/File_A1.csv"
my_repo = "Dryad"



data_cache_checker <- function(cached_file, doi_url, repo="Dryad"){
  # Only download the data if it is not yet cached locally
  if (file.exists(cached_file)) {
    repo_data <- read.csv(cached_file) 
  } else {
    if (repo == "Dryad") {
      # get a dataset https://datadryad.org/stash/dataset/doi:10.5061/dryad.jh9w0vtcg
      file_names <- dryad_download(dois=doi_url)
      repo_data <- read_csv(file_names[[doi_url]][[1]])  #assuming we want the first file in this example
      # Write the data
      write_csv(repo_data, cached_file)
    }
    if (repo == "Zenodo") {
      # get a dataset from https://doi.org/10.5061/dryad.0645r
      repo_data <- read_csv(doi_url)
      # Write the data
      write_csv(repo_data, cached_file)
    }
  }
  return(repo_data)
}



river_data <- data_cache_checker(my_cached_file, my_dryad_doi, repo = "Dryad")

# data_cache_checker(zenodo_filename, zenodo_url_file, repo = "Zenodo")
