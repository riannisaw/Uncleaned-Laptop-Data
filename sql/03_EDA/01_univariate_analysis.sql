-- UNIVARIATE ANALYSIS
SELECT company, 
    COUNT (*) AS products
FROM laptop_cleaning
GROUP BY company
ORDER BY products DESC;

SELECT company, 
    COUNT (*) AS company_count, 
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY company
ORDER BY company_count DESC;

SELECT typename, 
    COUNT (*) AS products
FROM laptop_cleaning
GROUP BY typename
ORDER BY products DESC;


SELECT typename, 
    COUNT (*) AS type_count, 
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY typename
ORDER BY type_count DESC;

-- Most laptops fall into the Notebook category, indicating that portability and general-purpose usage dominate the market.

SELECT inches, 
    COUNT (*) AS inches_count
FROM laptop_cleaning
GROUP BY inches
ORDER BY inches_count DESC;

SELECT 
    ROUND(AVG(inches), 2) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median_inches
FROM laptop_cleaning;

-- If mean > median → right-skewed
-- If mean < median → left-skewed

-- data is skewed (left-skewed), the distribution is not symetrical
-- make a scattered box in tableau
-- data value that is 18 and more are not possible

UPDATE laptop_cleaning
SET inches = NULL 
WHERE inches >= 18;

SELECT inches
FROM laptop_cleaning;

SELECT inches, 
    COUNT (*) AS inches_count
FROM laptop_cleaning
WHERE inches IS NOT NULL
GROUP BY inches
ORDER BY inches;

SELECT 
    AVG(inches) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median_inches
FROM laptop_cleaning
WHERE inches IS NOT NULL; 

-- count inches that is null
SELECT inches, 
    count (*) AS inches_is_null
FROM laptop_cleaning
WHERE inches IS NULL
GROUP BY inches; 

-- out (10)

-- ram value
SELECT ram, 
    COUNT (*) AS ram_count
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram_count DESC;

SELECT ram, 
    COUNT (*) AS ram_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram_count DESC;

-- 64 gb is possible - for the specialised laptops.
SELECT *
FROM laptop_cleaning
WHERE ram in (64);

-- ram 32GB for spesialized
SELECT *
FROM laptop_cleaning
WHERE ram = '32';

-- operation system 
SELECT opsys, 
    COUNT (*) AS opsys_count
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys_count DESC;

SELECT opsys, 
    COUNT (*) AS opsys_count,
    ROUND (100.0 * COUNT (*)/ SUM(COUNT (*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys_count DESC;

-- count opsys that is null
SELECT opsys, 
    count (*) AS opsys_is_null
FROM laptop_cleaning
WHERE opsys IS NULL
GROUP BY opsys; 

-- out (No data)

-- weight 
SELECT weight, 
    COUNT (*) AS weight_count
FROM laptop_cleaning
GROUP BY weight
ORDER BY weight;

SELECT 
    AVG(weight) AS avg_weight,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight
FROM laptop_cleaning
WHERE weight IS NOT NULL; 

-- mean > median = right skewed

-- weight > 5 is an outlier
UPDATE laptop_cleaning
SET weight = NULL
WHERE weight > 5;

-- weight < 0.5 is not possible
UPDATE laptop_cleaning
SET weight = NULL
WHERE weight < 0.5;


SELECT weight, 
    COUNT (*) AS weight_count
FROM laptop_cleaning
GROUP BY weight
ORDER BY weight;

SELECT 
    AVG(weight) AS avg_weight,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight
FROM laptop_cleaning
WHERE weight IS NOT NULL; 

-- data is balance
-- these 2 in one convertible - are very old models and can be used as laptops and tablets.
-- need to do scatter box

SELECT
    COUNT(weight) AS count_non_null,
    COUNT(DISTINCT weight) AS unique_values,
    MODE() WITHIN GROUP (ORDER BY weight) AS most_frequent_value,
    MAX(freq_count) AS frequency_of_top
FROM (
    SELECT
        weight,
        COUNT(*) AS freq_count
    FROM laptop_cleaning
    WHERE weight IS NOT NULL
    GROUP BY weight
) AS freq_table;

SELECT weight, 
    count (*) AS weight_is_null
FROM laptop_cleaning
WHERE weight IS NULL
GROUP BY weight; 


-- PRICE
SELECT price, 
    COUNT (*) AS price_count
FROM laptop_cleaning
GROUP BY price
ORDER BY price DESC;

-- the dataset is 0ld and the specs are top notch - for 2017. so justified price.
SELECT *
FROM laptop_cleaning
WHERE price > 200000;

-- Px_height
SELECT px_height, 
    COUNT (*) AS px_height_count
FROM laptop_cleaning
GROUP BY px_height
ORDER BY px_height DESC;

SELECT px_height, 
    count (*) AS px_height_is_null
FROM laptop_cleaning
WHERE px_height IS NULL
GROUP BY px_height; 

-- px_width
SELECT px_width, 
    COUNT (*) AS px_width_count
FROM laptop_cleaning
GROUP BY px_width
ORDER BY px_width DESC;

SELECT px_width, 
    count (*) AS px_width_is_null
FROM laptop_cleaning
WHERE px_width IS NULL
GROUP BY px_width; 


-- display ips count
SELECT display_ips_panel, 
    COUNT (*) AS display_ips_panel_count
FROM laptop_cleaning
GROUP BY display_ips_panel
ORDER BY display_ips_panel DESC;

SELECT display_ips_panel, 
    count (*) AS display_ips_panel_is_null
FROM laptop_cleaning
WHERE display_ips_panel IS NULL
GROUP BY display_ips_panel; 

SELECT display_ips_panel, 
    COUNT (*) AS display_ips_panel_count,
    ROUND (100.0 * COUNT (*)/ SUM(COUNT (*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY display_ips_panel
ORDER BY display_ips_panel_count DESC;

-- Touch Screen
SELECT display_ips_touch_screen, 
    COUNT (*) AS display_ips_touch_screen_count
FROM laptop_cleaning
GROUP BY display_ips_touch_screen
ORDER BY display_ips_touch_screen DESC;

SELECT display_ips_touch_screen, 
    count (*) AS display_ips_touch_is_null
FROM laptop_cleaning
WHERE display_ips_touch_screen IS NULL
GROUP BY display_ips_touch_screen; 

SELECT display_ips_touch_screen, 
    COUNT (*) AS display_ips_touch_count,
    ROUND (100.0 * COUNT (*)/ SUM(COUNT (*)) OVER (), 2) AS percentage
FROM laptop_cleaning
GROUP BY display_ips_touch_screen
ORDER BY display_ips_touch_count DESC;

-- HDD capacity
SELECT hdd_capacity, 
    COUNT (*) AS hdd_count
FROM laptop_cleaning
WHERE hdd_capacity <> 0
GROUP BY hdd_capacity
ORDER BY hdd_count DESC;

-- this 500 and 508 means 512gb - total and out of which 500 and 508 gb are usable.
UPDATE laptop_cleaning
SET hdd_capacity = 512
WHERE hdd_capacity IN (500, 508); 

SELECT hdd_capacity, 
COUNT (*) AS hdd_null
FROM laptop_cleaning
WHERE hdd_capacity IS NULL
GROUP BY hdd_capacity; 

-- hdd count 
SELECT hdd_count, 
    COUNT (*) AS count
FROM laptop_cleaning
GROUP BY hdd_count
ORDER BY count DESC;

-- SSD Capacity 
SELECT ssd_capacity, 
    COUNT (*) AS ssd_count
FROM laptop_cleaning
GROUP BY ssd_capacity
ORDER BY ssd_count DESC;

SELECT ssd_capacity, 
COUNT (*) AS ssd_null
FROM laptop_cleaning
WHERE ssd_capacity IS NULL
GROUP BY ssd_capacity; 

--ssd count
SELECT ssd_count, 
    COUNT (*) AS count
FROM laptop_cleaning
GROUP BY ssd_count
ORDER BY count DESC;

-- CPU BRAND 
SELECT cpu_brand, 
    COUNT (*) AS brand_count
FROM laptop_cleaning
GROUP BY cpu_brand
ORDER BY brand_count DESC;

-- Clock speed
SELECT clock_speed, 
    COUNT (*) AS clock_speed_count
FROM laptop_cleaning
GROUP BY clock_speed
ORDER BY clock_speed_count DESC;

--gpu brand 
SELECT gpu_brand, 
    COUNT (*) AS gpu_count
FROM laptop_cleaning
GROUP BY gpu_brand
ORDER BY gpu_count DESC;

-- flash storage
SELECT flash_storage, 
    COUNT (*) AS flash_count
FROM laptop_cleaning
GROUP BY flash_storage
ORDER BY flash_count DESC;

-- COUNT NULL 
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE ssd_capacity IS NULL) AS ssd_null_count,
    COUNT(*) FILTER (WHERE hdd_capacity IS NULL) AS hdd_null_count, 
    COUNT (*) FILTER (WHERE gpu_brand IS NULL) AS gpu_brand_null, 
    COUNT (*) FILTER (WHERE cpu_brand IS NULL) AS cpu_null,
    COUNT (*) FILTER (WHERE clock_speed IS NULL) AS clock_speed_null,
    COUNT (*) FILTER (WHERE flash_storage IS NULL) AS flash_null,
    COUNT (*) FILTER (WHERE ssd_count is null) as ssd_count,
    COUNT (*) FILTER (WHERE hdd_count is null) as hdd_count
FROM laptop_cleaning;

SELECT COUNT(weight) AS count,
       COUNT(DISTINCT weight) AS unique_values,
       ROUND(AVG(weight), 2) AS avg_weight,
       MIN(weight) AS min_weight,
       MAX(weight) AS max_weight
FROM laptop_cleaning;
