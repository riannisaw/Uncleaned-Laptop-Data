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
  creating table and input the dataset
- 02_data_cleaning
  Assesses data quality and applies cleaning steps such as type casting, missing value handling, and standardization.
- 03_eda
  Performs univariate, bivariate, and multivariate analysis entirely in SQL to explore laptop characteristics and pricing patterns.

### Project Structure
#### SQL

<details>
<summary><strong>01_schema</strong></summary>
- [`create_table.sql`](sql/01_schema/create_table.sql)
</details>

<details>
<summary><strong>02_data_cleaning</strong></summary>

- [`assessing_data.sql`](sql/02_data_cleaning/assessing_data.sql)
- [`cleaning_data.sql`](sql/02_data_cleaning/cleaning_data.sql)
</details>

<details>
<summary><strong>03_EDA</strong></summary>

- [`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)
- [`02_bivariate_analysis.sql`](sql/03_EDA/02_bivariate_analysis.sql)
- [`03_regular_bivariate.sql`](sql/03_EDA/03_regular_bivariate.sql)
- [`04_multivariate_analysis.sql`](sql/03_EDA/04_multivariate_analysis.sql)
</details>


#### Data
- raw
- cleaned

#### Outputs
- correlation.csv
- heatmap.csv

### Table of Contents
- [Data Overview](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/README.md#data-overview)
- [Project Structure](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/README.md#project-structure)
- Data Cleaning Approach
- Exploratory Data Analysis
- Key Analysis Highlights
- Tableau Visualization

### Data Cleaning Approach
Data cleaning was performed in SQL to transform raw scraped data into an
analysis-ready format. Key cleaning steps included:

- Identifying missing and invalid values
- Standardizing categorical fields (e.g., brand and OS)
- Converting numerical fields to proper data types
- Removing or correcting inconsistent entries

### Exploratory Data Analysis
Exploratory data analysis was conducted entirely in SQL to understand
distributions, relationships, and interactions among laptop features.

The analysis was structured as:
- Univariate analysis to examine individual feature distributions
- Bivariate analysis to explore relationships between features and price
- Multivariate analysis to study combined effects of multiple variables

### Key Insights
#### Type of Laptops
What is the most typical laptop the company have? 

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**

<img width="405" height="198" alt="image" src="https://github.com/user-attachments/assets/e0d997fe-527f-435d-bf07-2ff5beb5ec49" />

**Insights:** Most laptops fall into the Notebook category, indicating that portability and general-purpose usage dominate the market.

#### Company / Brand Distribution
Which laptop brands have the highest number of product listings in the dataset?
<img width="302" height="506" alt="image" src="https://github.com/user-attachments/assets/e2abfd21-bc96-42fb-a714-f15a88481c25" />


### Visualization
- [Laptop Market Dashboard (Tableau)](https://public.tableau.com/...)
- Correlation heatmap generated from SQL output

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### Reproducibility Notes
- Raw data was re-imported from the original source for reproducibility.
- All analysis steps are documented in SQL scripts.
- Output files can be reproduced by running the SQL queries sequentially.

### Tools
- PostgreSQL
- VS Code (SQLTools)
- Tableau
- GitHub



