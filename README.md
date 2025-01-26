# Analyzing Forest Fire Data
## Dency Claris Thomas 

This repository contains a reproducible pipeline for analyzing forest fire data and visualizing insights using a Shiny web application. The pipeline is dockerized for easy replication and includes GitHub Actions for continuous integration.

## Dataset
The dataset used in this project is sourced from Kaggle: [Forest Fires Dataset](https://www.kaggle.com/datasets/elikplim/forest-fires-data-set).

## Steps to Reproduce

### 1. Clone the Repository
Clone this repository to your local machine:
```bash
git clone https://github.com/dency-claris/Analyzing-Forest-Fire.git
cd Analyzing-Forest-Fire
```

### 2. Build the Docker image
Ensure you have Docker installed and running on your system. Then, build and run the app using the following commands:
```bash
docker build -t forest_fire_shiny_app .
```
### 3. Run the Docker container
```bash
docker run -d -p 3838:3838 --name forest_fire_shiny_app forest_fire_shiny_app
```
Access the Shiny app in your browser at: [http://localhost:3838](http://localhost:3838).

## GitHub Actions Workflow
This repository includes a GitHub Actions workflow to automatically build, test, and validate the Dockerized Shiny app upon each push or pull request to the `main` branch. The workflow performs the following steps:
1. Checks out the repository code.
2. Sets up Docker.
3. Builds the Docker image for the app.
4. Runs the container for testing.
5. Tests the app using a simple `curl` request to ensure it's running.
6. Stops and cleans up the container after testing.

The workflow file is located at `.github/workflows/mail.yml`.

## About the Shiny App
The Shiny app provides visualizations for analyzing forest fire data. It includes:

### User Interface
**Dropdown Menu**: Select a visualization type:
   - Fires by Month
   - Fires by Day
   - Boxplot of Variables
   - Scatter: Wind vs Area
   - Heatmap of Fires
   - Radar Chart


### Visualizations
- **Fires by Month/Day**: Displays the frequency of fires by month or day.
- **Boxplot of Variables**: Shows the distribution of variables like temperature and wind.
- **Scatter Plot (Wind vs Area)**: Visualizes the relationship between wind and burned area.
- **Heatmap**: Displays the intensity of fires across locations.
- **Radar Chart**: Compares multiple variables across fire incidents.

### Interacting with the App
Select a visualization type from the dropdown and view the corresponding plot in the main panel.
