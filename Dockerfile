## Get the docker baseline created
FROM dencyclaris/forest_fire_rap:version2


## Try to use renv lock file for dependencies
COPY renv.lock /srv/shiny-app/renv.lock
WORKDIR /srv/shiny-app


# Copy all project files into the container
COPY . /srv/shiny-app/
## Use renvlock for the packages
RUN R -e "if (file.exists('renv.lock')) { install.packages('renv', repos='https://cloud.r-project.org/'); renv::restore() }"


# Build the targets pipeline
RUN R -e "library(targets); tar_config_set(store = '/srv/shiny-app/_targets'); targets::tar_make();"

# Expose the Shiny app port
EXPOSE 3838

# Set the command to run the Shiny app
CMD ["R", "-e", "library(targets); shiny::runApp('/srv/shiny-app', host = '0.0.0.0', port = 3838)"]
