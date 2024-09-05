## R Shiny demonstration projects.

### Waitz explores Library building occupancy data.  

View at  <https://gjanee.shinyapps.io/waitz>.


### Run App using Docker

all the necessary files are on the  `jb-docker` docker branch

1. Build the docker image using the `renv` information (takes 5-10min). Run this command from the top level of the repository
   ```bash
   docker image build -t shinywaitz/shiny-waitz .
   ```
1. Run the image
   ```bash
   docker run --rm  -p 3838:3838 shiny-waitz
   ```
1. Open your web browser and got to: http://0.0.0.0:3838/