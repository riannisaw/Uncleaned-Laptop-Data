## Data Cleaning Project - Uncleaned Laptop Price Dataset
**Understanding the Structure and Content of an Unprocessed Laptop Price Dataset**
This is SQL based data analysis project focusing on data cleaning, exploratory data analysis, and insights into laptop pricing factors.

### Data Overview
The Uncleaned Laptop Price dataset is a collection of laptop product listings scraped from an online e-commerce website. The dataset includes information about various laptop models, such as their brand, screen size, processor, memory, storage capacity, operating system, and price. However, the dataset is uncleaned, a lot of missing values, some inconsistent formatting, and other errors that need to be addressed before the data can be used for analysis or modeling. The dataset contains over 1,300 laptop listings, making it a reasonably sized dataset for analysis and modeling. The raw dataset contains missing values, inconsistent naming conventions, and mixed units that require preprocessing before analysis. The target variable in the dataset is the price, which is a continuous variable and needed to examine the impact of features on the cost (price). 

### GOAL 
The goal of this project is to identify the factors that contribute the price of laptop. By performing a data analysis using SQL, this project aims to clean the data, which is important to the data to be tidy to provide valuable insights to analyze.

### Project Structure
#### [SQL](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/01_schema/create_table.sql)

[**Schema**](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/sql/01_schema)
- [Create Table](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/01_schema/create_table.sql)

[**Data Cleaning**](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/sql/02_data%20cleaning)
- [assessing_data.sql](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/02_data%20cleaning/assesing_data.sql)
- [cleaning_data.sql](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/02_data%20cleaning/cleaning_data.sql)

[**EDA**](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/sql/03_EDA)

- [`01_univariate_analysis.sql`](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/03_EDA/01_univariate_analysis.sql)
- [`02_bivariate_analysis.sql`](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/03_EDA/02_bivariate%20analysis.sql)
- [`03_regular_bivariate.sql`](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/03_EDA/03_regular_bivariate_analysis.sql)
- [`04_multivariate_analysis.sql`](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/sql/03_EDA/04_Multivariate_Analysis)
</details>


#### [Data](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/data)
- [raw](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/data/laptop%20Data%20(raw).csv)
- [cleaned](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/data/laptop_cleaning%20(cleaned).csv)

#### [Outputs](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/outputs)
- [correlation.csv](https://github.com/riannisaw/Uncleaned-Laptop-Data/tree/main/outputs/heatmap%20correlation)
- [heatmap visualisation](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/outputs/Heatmap%20Visualization.md)

### Table of Contents
- [Data Overview](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/README.md#data-overview)
- [Project Structure](https://github.com/riannisaw/Uncleaned-Laptop-Data/blob/main/README.md#project-structure)
- [Data Cleaning Approach](https://github.com/riannisaw/Annisa-Wulandari-Data-Analyst-Portfolio/edit/main/README.md#portfolio-projects)
- [Exploratory Data Analysis](https://github.com/riannisaw/Annisa-Wulandari-Data-Analyst-Portfolio/edit/main/README.md#portfolio-projects)
- [Key Analysis Highlights](https://github.com/riannisaw/Annisa-Wulandari-Data-Analyst-Portfolio/edit/main/README.md#portfolio-projects)
- [Tableau Visualization](https://github.com/riannisaw/Annisa-Wulandari-Data-Analyst-Portfolio/edit/main/README.md#portfolio-projects)

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

### Key Analysis Highlight
#### Brand Distribution
Which laptop brands have the highest number of product listings in the dataset?

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**

<img width="421" height="504" alt="image" src="https://github.com/user-attachments/assets/b67b1b68-f512-4bc8-91fc-0d368ed584b3" />


**Insights:** 
The laptop market is highly concentrated among a few major brands.
Lenovo, Dell, and HP together account for more than 65% in the dataset, indicating strong dominance by established manufacturers. Acer and Asus then following in the top 5, which in total 20% in the listings. 
This suggests that pricing and feature trends in the dataset are largely driven by these top brands, while smaller brands each contribute less than 5% indicates limited market and niche segments.

#### Type of Laptops
What is the most typical laptop the company have? 

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**

<img width="405" height="198" alt="image" src="https://github.com/user-attachments/assets/e0d997fe-527f-435d-bf07-2ff5beb5ec49" />

**Insights:** Most laptops fall into the Notebook category, showing that portability and general-purpose usage dominate the market, also making notebooks the most representative category for further analysis.

#### Screen Size
What is the typical laptop screen size after removing invalid and extreme values?

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**

<img width="282" height="459" alt="image" src="https://github.com/user-attachments/assets/d7ac4000-48c1-43be-b46e-a1c7c053ec9f" />
<img width="292" height="87" alt="image" src="https://github.com/user-attachments/assets/a982e630-a0bd-4291-9c10-5644fd4f3a48" />

**insights:**
The average and median screen sizes are both around the mid-15-inch range, simply showing that most laptops follow a standard form factor.
The closeness of the mean and median suggests a relatively balanced distribution after cleaning.

#### RAM 
What are the most common RAM configurations among laptops in the dataset?

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**
<img width="428" height="310" alt="image" src="https://github.com/user-attachments/assets/954c7baf-0fbb-4cb0-83f0-5753314dddfb" />

**insights:**
Most laptops are equipped with mid-range RAM configurations, reflecting typical consumer usage.
Higher RAM options appear less frequently, suggesting they are targeted toward specialized or high-performance use cases.

#### Operating Systems 
Which operating systems are most commonly used across laptop listings?

**SQL Query:**  
[`01_univariate_analysis.sql`](sql/03_EDA/01_univariate_analysis.sql)

**Result:**
<img width="444" height="198" alt="image" src="https://github.com/user-attachments/assets/de809fc3-48a0-4f78-a458-c9c2e11abc2f" />

**insights:**
Windows clearly dominates the dataset accounting for over 86% of all listings, pointing out strong market standardization.
Alternative operating systems represent smaller segments, likely catering to niche or specialized users.


#### price vs screen size
How does laptop screen size relate to pricing and market distribution?

**Result:**

<img width="623" height="457" alt="image" src="https://github.com/user-attachments/assets/4088604b-aa93-4115-9a33-401e59e062fb" />

<img width="305" height="83" alt="image" src="https://github.com/user-attachments/assets/31862520-679f-4704-91a5-34d775b82a8a" />

**insights:** 

15.6-inch laptops dominate the market and represent the broadest price range.
This screen size accounts for the highest number of listings and spans from budget to premium price points, indicating it is the most versatile and widely adopted form factor across consumer segments.

Despite having fewer listings, larger screen sizes such as 17.3 inches exhibit some of the highest maximum prices, suggesting that large-screen laptops are commonly associated with high-performance configurations.


#### weight vs price
Does laptop weight influence pricing?

**sql query:**


**Result:**
<img width="338" height="611" alt="image" src="https://github.com/user-attachments/assets/219c59c6-5042-41a8-83e4-6516c432c676" /> 
<img width="336" height="607" alt="image" src="https://github.com/user-attachments/assets/8f186653-9737-4aaa-b9e5-31d348599067" />

**Insight:**

Laptop weight shows only a moderate relationship with price, indicating that portability alone does not strongly determine cost.
Lightweight laptops exist across both mid-range and premium price segments, suggesting that price is influenced more by internal specifications than physical weight


#### PPI vs Price 
How does display quality (resolution and pixel density) affect laptop pricing?

**results:**

<img width="302" height="554" alt="image" src="https://github.com/user-attachments/assets/09ded581-1679-40f9-97f4-0316ea246d94" />
<img width="299" height="607" alt="image" src="https://github.com/user-attachments/assets/f6cb372e-7f38-4705-868f-7c1505efbf6a" />

**insight:**
Higher pixel density is generally associated with higher laptop prices, but the relationship is not strictly linear.
Laptops with higher PPI values (typically above ~180 PPI) tend to have significantly higher median prices, reflecting premium display quality such as sharper text and higher-resolution panels.
However, notable price variability exists within similar PPI ranges, indicating that while display sharpness contributes to pricing, it is not the sole driver—other factors such as brand positioning, performance specifications, and target market also play a substantial role.

#### RAM VS Price 
How does RAM capacity influence laptop pricing?

**result:**

<img width="449" height="307" alt="image" src="https://github.com/user-attachments/assets/fba7029d-e789-4346-8494-97ef2bcfbf58" />


**insight:**
Higher RAM capacities are generally associated with higher laptop prices, although significant price variability exists within the same RAM tier.
This indicates that while RAM is a key pricing factor, overall price is also influenced by CPU performance, storage type, and display quality.

Laptop pricing increases substantially with higher RAM capacities, confirming RAM as a major price driver.
Devices with 8 GB RAM dominate the market, serving as the mainstream standard, while laptops with 16 GB or more RAM show significantly higher median prices and are positioned as premium or performance-oriented products.

#### How do laptop types differ in price and specs?
**Typename vs median_price**

<img width="619" height="223" alt="image" src="https://github.com/user-attachments/assets/621c81f5-00a6-4add-a028-6762e89cdfed" />


<img width="303" height="224" alt="image" src="https://github.com/user-attachments/assets/d1326c52-5e78-4507-835f-53a453e73b92" />

**Typename vs gpu brand**

<img width="759" height="168" alt="image" src="https://github.com/user-attachments/assets/e7ee5d2f-2c57-41cd-af40-263e746b6deb" />


<img width="750" height="166" alt="image" src="https://github.com/user-attachments/assets/2504b867-c939-40e2-b442-fd8dec18e5c5" />

**Typename vs ram**

<img width="716" height="309" alt="image" src="https://github.com/user-attachments/assets/f30cda4e-a1a1-40b5-82b0-9bf3c60b1d28" />

**Typename vs screen size**

<img width="787" height="521" alt="image" src="https://github.com/user-attachments/assets/90c444ca-945b-4132-8cef-ffe92422728d" />

**INSIGHTS:**

- Gaming and Workstation laptops show the highest median and upper-quartile prices, with wide price dispersion.
- Ultrabooks sit in a premium but narrower price band, reflecting consistent high-end specifications.
- Notebooks and 2-in-1 Convertibles occupy the lower to mid-price range, with fewer high-price outliers.
- The presence of discrete Nvidia GPUs is the primary driver behind the premium pricing of gaming and workstation laptops.
- RAM acts as a gateway spec: as RAM increases, laptops move into higher display quality and price tiers.
- Laptop pricing is strongly segmented by type: gaming and workstation laptops are expensive due to Nvidia GPUs and high-performance hardware, ultrabooks command a premium through design and display quality, while notebooks remain price-efficient by prioritizing integrated graphics and lower-tier screens.







### Visualization
- [Laptop Market Dashboard (Tableau)](https://github.com/riannisaw/Laptop-Market-Dashboard/blob/main/README.md)

  Overview Dashboard
  <img width="1499" height="899" alt="Dashboard 3" src="https://github.com/user-attachments/assets/ca951e12-7e92-4591-bff5-19fb7b225b6e" />

  
- Correlation heatmap generated from SQL output
  The Tableau workbook used to generate the correlation heatmap  
can be found here:

<img width="907" height="464" alt="image" src="https://github.com/user-attachments/assets/35cd02d1-cca0-475b-a996-958b811dece8" />


https://1drv.ms/u/c/3ada70049f92c48b/IQDntnLgxOa8TKN2EYdhHUDKAVC9w_XqLKoipBGcmEjwSQE?e=0npmwu 

**Description**  
This heatmap shows the Pearson correlation between laptop hardware features  
such as RAM, price, screen size, and storage.

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



