## Data Cleaning Project - Uncleaned Laptop Price Dataset
**Understanding the Structure and Content of an Unprocessed Laptop Price Dataset**
This is SQL based data analysis project focusing on data cleaning, exploratory data analysis, and insights into laptop pricing factors.

### Data Overview
The Uncleaned Laptop Price dataset is a collection of laptop product listings scraped from an online e-commerce website. The dataset includes information about various laptop models, such as their brand, screen size, processor, memory, storage capacity, operating system, and price. However, the dataset is uncleaned, a lot of missing values, some inconsistent formatting, and other errors that need to be addressed before the data can be used for analysis or modeling. The dataset contains over 1,300 laptop listings, making it a reasonably sized dataset for analysis and modeling. The raw dataset contains missing values, inconsistent naming conventions, and mixed units that require preprocessing before analysis. The target variable in the dataset is the price, which is a continuous variable and needed to examine the impact of features on the cost (price). 

### GOAL 
The goal of this project is to identify the factors that contribute the price of laptop. By performing a data analysis using SQL, this project aims to clean the data, which is important to the data to be tidy to provide valuable insights to analyze.

### Project Structure
#### sql
- 01_schema
- 02_data_cleaning
- 03_eda

#### data
- raw
- cleaned

#### outputs
- correlation.csv
- heatmap.csv


### Key Insights
- Laptop price shows strong correlation with RAM and storage capacity
- Screen size has a moderate impact on pricing
- Gaming laptops tend to be priced significantly higher than notebooks and ultrabooks

### Visualization
- [Laptop Market Dashboard (Tableau)](https://public.tableau.com/...)
- Correlation heatmap generated from SQL output

### Reproducibility Notes
- Raw data was re-imported from the original source for reproducibility.
- All analysis steps are documented in SQL scripts.
- Output files can be reproduced by running the SQL queries sequentially.

### Tools
- PostgreSQL
- VS Code (SQLTools)
- Tableau
- GitHub



