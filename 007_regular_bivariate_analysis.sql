-- BIVARIATE WEIGHT
CREATE TABLE corr_weight AS
SELECT 'inches' as variable, corr (inches,weight) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'ram', corr (ram, weight)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (px_width, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (px_width, weight)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ppi_whole', corr (ppi_whole, weight)
    FROM laptop_cleaning;

SELECT *
FROM corr_weight;

--WEIGHT VS HDD CAPACITY
SELECT
    hdd_capacity,
    ROUND (AVG (weight),2) AS avg_weight,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY hdd_capacity) AS median_hdd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE hdd_capacity <> 0
GROUP BY hdd_capacity
ORDER BY hdd_capacity;

-- Weight vs Ram
SELECT
    ram,
    ROUND (AVG (weight),2) AS avg_weight,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE ram IS NOT NULL
GROUP BY ram
ORDER BY ram;
--in general the weight is increasing as the ram is increasing  
-- #this is because the higher ram is present in the gaming laptops where the weight is higher.

SELECT
    ram,
    typename,
    ROUND (AVG (weight),2) AS avg_weight,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE ram IS NOT NULL 
    AND typename in ('Ultrabook')
GROUP BY ram, typename
ORDER BY ram;


-- company vs quality rank

SELECT 
    l.company,
    s.quality_rank
FROM laptop_cleaning AS l
LEFT JOIN screen_data AS s
    ON l.resolution = s.resolution;

SELECT resolution, COUNT(*) 
FROM screen_data
GROUP BY resolution
HAVING COUNT(*) > 1;

WITH base AS (
    SELECT 
        l.company,
        s.quality_rank
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)

SELECT
    quality_rank,

    -- Acer
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Acer' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Acer'), 0)
    , 2) AS acer_pct,

    -- Apple
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Apple' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Apple'), 0)
    , 2) AS apple_pct,

    -- Asus
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Asus' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Asus'), 0)
    , 2) AS asus_pct,

    -- Chuwi
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Chuwi' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Chuwi'), 0)
    , 2) AS chuwi_pct,

    -- Dell
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Dell' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Dell'), 0)
    , 2) AS dell_pct,

    -- Fujitsu
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Fujitsu' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Fujitsu'), 0)
    , 2) AS fujitsu_pct,

    -- Google
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Google' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Google'), 0)
    , 2) AS google_pct,

    -- HP
    ROUND(
        100.0 * SUM(CASE WHEN company = 'HP' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'HP'), 0)
    , 2) AS hp_pct,

    -- Huawei
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Huawei' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Huawei'), 0)
    , 2) AS huawei_pct,

    -- LG
    ROUND(
        100.0 * SUM(CASE WHEN company = 'LG' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'LG'), 0)
    , 2) AS lg_pct,

    -- Lenovo
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Lenovo' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Lenovo'), 0)
    , 2) AS lenovo_pct,

    -- Mediacom
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Mediacom' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Mediacom'), 0)
    , 2) AS mediacom_pct,

    -- Microsoft
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Microsoft' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Microsoft'), 0)
    , 2) AS microsoft_pct,

    -- MSI
    ROUND(
        100.0 * SUM(CASE WHEN company = 'MSI' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'MSI'), 0)
    , 2) AS msi_pct,

    -- Razer
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Razer' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Razer'), 0)
    , 2) AS razer_pct,

    -- Samsung
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Samsung' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Samsung'), 0)
    , 2) AS samsung_pct,

    -- Toshiba
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Toshiba' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Toshiba'), 0)
    , 2) AS toshiba_pct,

    -- Vero
    ROUND(
        100.0 * SUM(CASE WHEN company = 'Vero' THEN 1 END)
        / NULLIF((SELECT COUNT(*) FROM base WHERE company = 'Vero'), 0)
    , 2) AS vero_pct

FROM base
GROUP BY quality_rank
ORDER BY quality_rank;


SELECT company,
    COUNT (*) as company_count
FROM laptop_cleaning
GROUP BY company;



# of all the laptops of acer in dataset - 47% have the low screen quality. -- so acer laptops tends to be cheaper.
# of all the laptops of apple in dataset - 57% have high screen quality, and 19% very high and 19% lower mid.
# most of the laptops around 65% have a mid quality screen.  -- 1920X 1080 or 1920 X 1200.
# 22% of the total laptops have HD Ready screen quality. -- 1366 x 768.
# lenevo,hp,dell - makes laptops with all kinds of screen.
# apple doesnt make - mid quality screened laptops.


SELECT
    s.quality_rank,
    SUM(CASE WHEN l.company = 'Acer' THEN 1 ELSE 0 END) AS acer,
    SUM(CASE WHEN l.company = 'Apple' THEN 1 ELSE 0 END) AS apple,
    SUM(CASE WHEN l.company = 'Dell' THEN 1 ELSE 0 END) AS dell,
    SUM(CASE WHEN l.company = 'HP' THEN 1 ELSE 0 END) AS hp,
    SUM(CASE WHEN l.company = 'Lenovo' THEN 1 ELSE 0 END) AS lenovo
FROM laptop_cleaning l
LEFT JOIN screen_data s
    ON l.resolution = s.resolution
GROUP BY s.quality_rank
ORDER BY s.quality_rank;

-- COMPANY VS IPS PANEL
SELECT
    company,
    SUM(CASE WHEN ips_panel = 1 THEN 1 ELSE 0 END) AS ips_count,
    SUM(CASE WHEN ips_panel = 0 THEN 1 ELSE 0 END) AS non_ips_count
FROM laptop_cleaning
GROUP BY company
ORDER BY company;

SELECT
    company,
    ROUND(100.0 * SUM(CASE WHEN ips_panel = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS ips_pct,
    ROUND(100.0 * SUM(CASE WHEN ips_panel = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS non_ips_pct
FROM laptop_cleaning
GROUP BY company
ORDER BY company;

SELECT *
FROM laptop_cleaning
LIMIT 10;

-- company vs price 
SELECT 
    company,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY company
ORDER BY company;

-- checking lenovo price over 150000
SELECT unnamed, price, display_ips_panel
FROM laptop_cleaning
WHERE company = 'Lenovo' AND price >150000;

SELECT unnamed, price, display_ips_panel
FROM laptop_cleaning
WHERE company = 'HP' AND price >130000;


SELECT unnamed, price, display_ips_panel
FROM laptop_cleaning
WHERE  unnamed in (558, 592,720, 985,1048);


SELECT *
FROM laptop_cleaning
WHERE  unnamed in (306, 724,830, 884,1070, 1103)
ORDER BY unnamed;
--# at index - 830 and 1070 - ips panel is not present.  -- indicates price not only depends on the display_ips_panel.
-- at 884 - 4k ultra hd screen

-- Company vs weight
SELECT 
    company,
    MIN(weight) AS min_weight,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY weight) AS q1_weight,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY weight) AS median_weight,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) AS q3_weight,
    MAX(weight) AS max_weight
FROM laptop_cleaning
GROUP BY company
ORDER BY company;

-- typename & company
SELECT
    company,
    typename,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, typename
ORDER BY company, typename;

SELECT
    company,
    typename,
    ROUND(
        100.0 * COUNT(*) 
        / SUM(COUNT(*)) OVER (PARTITION BY company)
    , 2) AS pct
FROM laptop_cleaning
GROUP BY company, typename
ORDER BY company, typename;

-- opsys vs company
SELECT
    company,
    opsys,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, opsys
ORDER BY company, opsys;

-- company vs cpu brand
SELECT
    company,
    cpu_brand,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, cpu_brand
ORDER BY company, cpu_brand;

-- company vs gpu brand compared with the price
SELECT
    company,
    gpu_brand,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, gpu_brand
ORDER BY company, gpu_brand;

SELECT
    gpu_brand,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY gpu_brand
ORDER BY gpu_brand;

SELECT
    company,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY company;

SELECT
    company,
    gpu_brand,
    COUNT(*) AS count_gpu
FROM laptop_cleaning
WHERE 
    (company = 'Lenovo' AND price > 150000) OR
    (company = 'Dell'   AND price > 135000) OR
    (company = 'HP'     AND price > 135000) OR
    (company = 'Asus'   AND price > 150000) OR
    (company = 'Acer'   AND price > 70000)
GROUP BY company, gpu_brand
ORDER BY company, count_gpu DESC;

-- company,cpu_brand,price,clock_speed
SELECT
    company,
    cpu_brand,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, cpu_brand
ORDER BY company, cpu_brand;
-- Lenovo and Acer uses Intel more
-- Apple only use Intel

-- box plot 
SELECT
    cpu_brand,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY cpu_brand;

-- box plot company vs price 
SELECT
    company,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY company;

-- clock speed vs price 
SELECT
    clock_speed,
    price,
    gpu_brand,
    cpu_brand,
    company
FROM laptop_cleaning
ORDER BY clock_speed;

SELECT corr(clock_speed, price)
FROM laptop_cleaning;
-- 0.42462219071322366

-- avg price per clockspeed
SELECT
    clock_speed,
    AVG(price) AS avg_price
FROM laptop_cleaning
GROUP BY clock_speed
ORDER BY clock_speed;

--Final Filter (Dell, Lenovo, HP with Intel CPU)
SELECT
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
WHERE company IN ('Dell', 'Lenovo', 'HP')
  AND cpu_brand = 'Intel'
GROUP BY gpu_brand
ORDER BY median_price DESC;

-- COMPANY VS RAM 
SELECT
    company,
    ram,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company,ram
ORDER BY ram;

SELECT
    ram,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram;

-- 4, 8 and 16 gb is the famous among all


-- COMPANY VS CLOCK SPEED
SELECT
    company,
    clock_speed,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY company, clock_speed;

-- company vs ssd capacity
SELECT
    company,
    ssd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, ssd_capacity
ORDER BY ssd_capacity;

-- company vs hdd capacity
SELECT
    company,
    hdd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, hdd_capacity
ORDER BY hdd_capacity;


-- company vs hdd_count/ssd count 

SELECT
    company,
    ssd_count,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, ssd_count
ORDER BY ssd_count;

SELECT
    company,
    hdd_count,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, hdd_count
ORDER BY hdd_count;


--company vs ppi whole 
SELECT
    company,
    ppi_whole,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY company, ppi_whole
ORDER BY ppi_whole;

-- company vs resolution
SELECT resolution, company, COUNT(*) AS count
FROM laptop_cleaning
GROUP BY resolution, company
ORDER BY resolution, company;

SELECT 
    resolution,
    AVG(price) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    MIN(price),
    MAX(price)
FROM laptop_cleaning
GROUP BY resolution;


SELECT 
    s.quality_rank,
    AVG(l.price) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.price) AS median_price,
    MIN(l.price) AS min_price,
    MAX(l.price) AS max_price
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY s.quality_rank
ORDER BY s.quality_rank;

SELECT 
    s.quality_rank,
    l.resolution,
    COUNT(*) AS count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY s.quality_rank, l.resolution
ORDER BY s.quality_rank, l.resolution;

-- company vs resolution type
SELECT 
    l.company,
    s.name as resolution_type,
    COUNT(*) AS count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY l.company, resolution_type
ORDER BY l.company, resolution_type;

-- company vs resolution type + gpu brand 
SELECT 
    s.name,
    l.gpu_brand,
    AVG(l.price) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.price) AS median_price
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY s.name, l.gpu_brand
ORDER BY s.name, median_price DESC;

-- company vs aspect ratio
SELECT 
    l.company,
    s.aspect_ratio,
    COUNT(*) AS count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY l.company, s.aspect_ratio
ORDER BY l.company;

SELECT 
    s.aspect_ratio,
    l.typename,
    AVG(l.price) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.price) AS median
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
GROUP BY s.aspect_ratio, l.typename
ORDER BY s.aspect_ratio, l.typename;

-- quality rank mid
SELECT s.quality_rank,
    s.name as resolution_type,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
GROUP BY resolution_type, s.quality_rank;

SELECT quality_rank
FROm screen_data;

SELECT
    l.gpu_brand,
    AVG (price) as avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.price) AS median,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
GROUP BY gpu_brand;

SELECT 
    clock_speed,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
GROUP BY clock_speed
ORDER BY laptop_count DESC;

SELECT *
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
    AND company = 'Lenovo'
ORDER BY unnamed;

-- quality rank vs ppi_whole
SELECT 
    ppi_whole,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
GROUP BY ppi_whole
ORDER BY laptop_count DESC;
-- ppi is not contributing a lot to the price - for laptops with the mid quality screen.

-- quality rank mid vs inches
SELECT 
    inches,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.quality_rank = 'Mid'
GROUP BY inches
ORDER BY laptop_count DESC;

-- resolution type 'HD ready' vs ssd capacity and price
SELECT
    l.ssd_capacity,
    AVG (price) as avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.price) AS median,
    COUNT (*) as laptop_count
FROM laptop_cleaning l
JOIN screen_data s 
    ON l.resolution = s.resolution
WHERE s.name = 'HD Ready'
GROUP BY ssd_capacity;

SELECT 
    typename,
    opsys,
    COUNT(*) AS count
FROM laptop_cleaning
GROUP BY typename, opsys
ORDER BY typename, opsys;

(
    -- main crosstab counts
    SELECT 
        typename,
        opsys,
        COUNT(*) AS count
    FROM laptop_cleaning
    GROUP BY typename, opsys
)

UNION ALL

(
    -- row totals (typename = typename, opsys = 'All')
    SELECT 
        typename,
        'All' AS opsys,
        COUNT(*)
    FROM laptop_cleaning
    GROUP BY typename
)

UNION ALL

(
    -- column totals (typename = 'All', opsys = opsys)
    SELECT
        'All' AS typename,
        opsys,
        COUNT(*)
    FROM laptop_cleaning
    GROUP BY opsys
)

UNION ALL

(
    -- grand total
    SELECT 
        'All' AS typename,
        'All' AS opsys,
        COUNT(*)
    FROM laptop_cleaning
)
ORDER BY typename, opsys;

-- typename vs weight
SELECT
    typename,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY weight) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY typename;

-- typename vs cpu brand 
SELECT
    typename,
    cpu_brand,
    count (*) as laptop_count
FROM laptop_cleaning
GROUP BY typename,cpu_brand;

-- typename vs gpubrand
SELECT 
    gpu_brand,
    typename,
    COUNT(*) AS count
FROM laptop_cleaning
GROUP BY gpu_brand, typename
ORDER BY gpu_brand, typename;

SELECT typename, gpu_brand, price
FROM laptop_cleaning;

SELECT
    typename,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY typename
ORDER BY median_price DESC;

SELECT
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY gpu_brand
ORDER BY median_price DESC;

SELECT
    typename,
    MIN(price),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY weight) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) AS q3,
    MAX(price)
FROM laptop_cleaning
GROUP BY typename;

-- from the heatmap - we can see that gaming laptops uses the nvidia gpu and from the box plot of type vs price with gpu_brand
--  nvidia gpu - for gaming laptops are expensive.
-- the notebooks uses the intel chips mostly followed by amd and then nividia gpus.
-- and the intel gpus are cheper due to which the mean for entire - notebook type is lesser - bar plot.

-- for the ultrabooks - which also include macs - the intel gpus are used -  and the median price is higher for this category as compared to the other
-- significantly - due to which the median price of the intel gpu increases for the overall dataset.

-- workstations have nvidia gpus - so costlier.
-- for the 2 in 1 convertible lesser priced gpus are used mostly - but for some the nvidia gpu are use which makes the price higher.

-- these ultrabooks are mostly apple macbooks in the dataset - due to which in the 4 plot the median price of intel gpu_brand

-- typename ultrabook
SELECT 
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
WHERE typename = 'Ultrabook'
GROUP BY gpu_brand;

-- typename vs resolution
SELECT 
    typename,
    resolution,
    count (*) as laptop_count
FROM laptop_cleaning
GROUP BY typename, resolution;

-- typename vs resolution_type
WITH base AS (
    SELECT *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT 
    name as resolution_type,
    typename,
    count (*) as laptop_count
FROM base
GROUP BY resolution_type, typename;

-- typename vs price by aspect_ratio
WITH base AS (
    SELECT *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT 
    typename,
    aspect_ratio,
    AVG (price) as avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM base
GROUP BY typename, aspect_ratio;

--typename vs quality_rank
WITH base AS (
    SELECT *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT 
    typename,
    quality_rank,
    count (*) as laptop_count
FROM base
GROUP BY  typename, quality_rank;


-- typename vs ram 
SELECT 
    typename, 
    ram, 
    count (*) as laptop_count
FROM laptop_cleaning
GROUP BY typename, ram;

most popular among all the ram type - 256 gb - across all the formats.
# higher ram is present in gaming, ultabooks and some notebooks.  
#- these notebook are premium notebooks with the core i7 processor and 
# screen are either full hd, quad hd , 4k ultra hd. -- some have high ppi but most are lowers.
# these higher ram ultrabooks have higher ppi and fullhd/uhd.

# at higher ram the screen quality and resolution are better so the price increases with the ram.

# ram increases - price increases the screen_quality increases as higher the ppi the better the screen_quality across all the types.

SELECT 
    typename,
    ram,
    price,
    ppi_whole
FROM laptop_cleaning
WHERE ram BETWEEN 0 AND 64; 

SELECT 
    typename,
    ram,
    AVG(price) AS avg_price,
    AVG(ppi_whole) AS avg_ppi
FROM laptop_cleaning
GROUP BY typename, ram
ORDER BY typename, ram;

SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = 'Ultrabook'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;


SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = 'Notebook'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;


SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = 'Gaming'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;

SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = '2 in 1 Convertible'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;

SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = 'Workstation'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;

SELECT ram, price, ppi_whole
FROM laptop_cleaning
WHERE typename = 'Netbook'
    AND ram BETWEEN 0 AND 64
ORDER BY ram;

-- typename Ultrabook ram >8 GB

SELECT*
FROM laptop_cleaning
WHERE typename = 'Ulrabook'
    AND ram = '8'
ORDER BY ram;

SELECT*
FROM laptop_cleaning
WHERE typename = 'Notebook'
    AND ram = '8'
ORDER BY ram;

-- typename vs inches
SELECT
    typename,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
GROUP BY typename;

-- 
SELECT 
    typename,
    SUM(CASE WHEN display_ips_panel = TRUE THEN 1 ELSE 0 END) AS ips_true,
    SUM(CASE WHEN display_ips_panel = FALSE THEN 1 ELSE 0 END) AS ips_false,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY typename
ORDER BY typename;

--box scattered
SELECT
    typename,
    display_ips_panel,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY typename, display_ips_panel
ORDER BY typename, display_ips_panel;

-- typename and price
SELECT 
    Typename, 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY typename;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = 'Ultrabook'
GROUP BY display_ips_panel;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = 'Notebook'
GROUP BY display_ips_panel;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = 'Netbook'
GROUP BY display_ips_panel;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = 'Gaming'
GROUP BY display_ips_panel;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = 'Workstation'
GROUP BY display_ips_panel;

SELECT 
    display_ips_panel,
    MIN(inches),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches)
FROM laptop_cleaning
WHERE typename = '2 in 1 Convertible'
GROUP BY display_ips_panel;


-- typename vs price (mean, median)
SELECT 
    typename,
    avg (price) as mean_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY typename
ORDER BY typename;

-- typename vs clockspeed
SELECT 
    typename,
    MIN(clockspeed),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY clockspeed) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY clockspeed) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY clockspeed) AS q3,
    MAX(clockspeed)
FROM laptop_cleaning
GROUP BY typename;

-- typename
SELECT 
    typename,
    SUM(CASE WHEN ssd_capacity = '128' THEN 1 ELSE 0 END) AS ssd_128,
    SUM(CASE WHEN ssd_capacity = '256' THEN 1 ELSE 0 END) AS ssd_256,
    SUM(CASE WHEN ssd_capacity = '512' THEN 1 ELSE 0 END) AS ssd_512,
    SUM(CASE WHEN ssd_capacity = '1024'   THEN 1 ELSE 0 END) AS ssd_1tb,
    SUM(CASE WHEN ssd_capacity = '2048'   THEN 1 ELSE 0 END) AS ssd_2tb
FROM laptop_cleaning
GROUP BY typename
ORDER BY typename;

SELECT 
    typename,
    SUM(CASE WHEN hdd_capacity = '0' THEN 1 ELSE 0 END) AS hdd_0,
    SUM(CASE WHEN hdd_capacity = '32' THEN 1 ELSE 0 END) AS hdd_32,
    SUM(CASE WHEN hdd_capacity = '128' THEN 1 ELSE 0 END) AS hdd_128,
    SUM(CASE WHEN hdd_capacity = '512' THEN 1 ELSE 0 END) AS hdd_512,
    SUM(CASE WHEN hdd_capacity = '1024' THEN 1 ELSE 0 END) AS hdd_1024,
    SUM(CASE WHEN hdd_capacity = '2048'   THEN 1 ELSE 0 END) AS hdd_2tb
FROM laptop_cleaning
GROUP BY typename
ORDER BY typename;

SELECT hdd_capacity,
    count (*) as laptop
FROM laptop_cleaning
GROUP BY hdd_capacity;

-- typename vs ssd capacity (price)
SELECT 
    typename,
    ssd_capacity,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3_price,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY typename, ssd_capacity
ORDER BY typename, ssd_capacity;

SELECT 
    typename,
    hdd_capacity,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3_price,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY typename, hdd_capacity
ORDER BY typename, hdd_capacity;

SELECT 
    ssd_capacity,
    hdd_capacity,
    hdd_count,
    ssd_count,
    price,
    cpu_brand,
    clock_speed,
    gpu_brand,
    ram,
    company,
    resolution
FROM laptop_cleaning
WHERE typename = 'Ultrabook'
  AND hdd_capacity >= 512;

-- average price per ppi bucket
SELECT 
    typename,
    FLOOR(ppi_whole / 20) * 20 AS ppi_group,  -- group PPI into bins like 100–120, 120–140…
    AVG(price) AS avg_price
FROM laptop_cleaning
GROUP BY typename, FLOOR(ppi_whole / 20) * 20
ORDER BY typename, ppi_group;

--correlation between PPI and price
SELECT 
    typename,
    corr(ppi_whole, price) AS ppi_price_correlation
FROM laptop_cleaning
GROUP BY typename;

-- regresion slope per typename
SELECT
    typename,
    regr_slope(price, ppi_whole) AS slope,
    regr_intercept(price, ppi_whole) AS intercept,
    regr_r2(price, ppi_whole) AS r2
FROM laptop_cleaning
GROUP BY typename;
-- slope → how much price increases when PPI increases by 1
-- intercept → baseline price
-- r2 → strength of prediction

-- opsys
SELECT 
    opsys,
    cpu_brand,
    COUNT(*) AS total_laptops
FROM laptop_cleaning
GROUP BY opsys, cpu_brand
ORDER BY opsys, cpu_brand;

SELECT
    opsys,
    cpu_brand,
    AVG(price) AS mean_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY opsys, cpu_brand
ORDER BY opsys, cpu_brand;


-- opsys vs gpu brand 
SELECT 
    opsys,
    gpu_brand,
    COUNT(*) AS total_laptops
FROM laptop_cleaning
GROUP BY opsys, gpu_brand
ORDER BY opsys, gpu_brand;

SELECT
    opsys,
    gpu_brand,
    AVG(price) AS mean_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY opsys, gpu_brand
ORDER BY opsys, gpu_brand;

-- opsys vs screen detail
-- opsys vs resolution
SELECT
    resolution,
    COUNT(CASE WHEN opsys = 'Windows' THEN 1 END) AS windows_count,
    COUNT(CASE WHEN opsys = 'MacOS' THEN 1 END) AS macos_count,
    COUNT(CASE WHEN opsys = 'Linux' THEN 1 END) AS linux_count
FROM laptop_cleaning
GROUP BY resolution
ORDER BY resolution;

 # windows mostly uses the mid(69%) and lower quality screens(20%) so price are lower - but also has some higher quality screens.(4%) - which combined with higher specs leads to some high prices.
# mac uses 57% high quality screen along with 19% very high quality screens so the price of mac is higher - generally.
# Mac OS prefers 16:10, - productivity (more vertical space).
# Chrome OS and Mac OS offer 3:2 screens, good for reading/coding.
# Windows devices mostly stick to 16:9, which is standard for general-use and entertainment.
# Chrome OS devices target the budget sector, mainly HD Ready and Full HD, rarely going premium.

-- opsys vs inches 
SELECT
    opsys,
    MIN(inches) AS min_inches,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches) AS max_inches
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys;

SELECT
    opsys,
    typename,
    MIN(inches) AS min_inches,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY inches) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3,
    MAX(inches) AS max_inches
FROM laptop_cleaning
GROUP BY opsys, typename
ORDER BY opsys, typename;

-- Opsys vs ram
SELECT
    opsys,
    ram,
    count (*) as count
FROM laptop_cleaning
GROUP BY opsys, ram
ORDER BY opsys, ram;

-- opsys vs weight
SELECT
    opsys,
    typename,
    MIN(weight) AS min_weight,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY weight) AS q1_weight,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY weight) AS median_weight,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) AS q3_weight,
    MAX(weight) AS max_weight
FROM laptop_cleaning
GROUP BY opsys, typename
ORDER BY typename, opsys;

-- ultrabooks of all opsys generally lighter.
# notebooks of all opsys types are around 2 kgs. - while for chrome os the weight is slightly below 2kg.
# gaming laptops are heavier - and mostly comes with windows opsys.
# workstation - mostly linux and windows and heavier.
# convertible laptops and netbooks are lightest.

-- opsys vs ips panel
SELECT
    display_ips_panel,
    SUM(CASE WHEN opsys = 'Windows' THEN 1 END) AS windows_count,
    SUM(CASE WHEN opsys = 'MacOS' THEN 1 END) AS macos_count,
    SUM(CASE WHEN opsys = 'No Os' THEN 1 END) AS linux_NoOs,
    SUM(CASE WHEN opsys = 'Chrome Os' THEN 1 END) AS linux_chrome,
    SUM(CASE WHEN opsys = 'Android' THEN 1 END) AS linux_Android
    SUM(CASE WHEN opsys = 'Linux' THEN 1 END) AS linux_count
FROM laptop_cleaning
GROUP BY display_ips_panel
ORDER BY display_ips_panel;

SELECT
    opsys,
    display_ips_panel,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1_price,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY price) AS median_price,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3_price,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY opsys, display_ips_panel
ORDER BY display_ips_panel, opsys;

-- opsys vs touch screen
SELECT
    display_ips_touch_screen,
    SUM(CASE WHEN opsys = 'Windows' THEN 1 END) AS windows_count,
    SUM(CASE WHEN opsys = 'MacOS' THEN 1 END) AS macos_count,
    SUM(CASE WHEN opsys = 'No Os' THEN 1 END) AS linux_NoOs,
    SUM(CASE WHEN opsys = 'Chrome Os' THEN 1 END) AS linux_chrome,
    SUM(CASE WHEN opsys = 'Android' THEN 1 END) AS linux_Android,
    SUM(CASE WHEN opsys = 'Linux' THEN 1 END) AS linux_count
FROM laptop_cleaning
GROUP BY display_ips_touch_screen
ORDER BY display_ips_panel;

SELECT
    opsys,
    display_ips_touch_screen,
    MIN(price) AS min_price,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1_price,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY price) AS median_price,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3_price,
    MAX(price) AS max_price
FROM laptop_cleaning
GROUP BY opsys, display_ips_touch_screen
ORDER BY display_ips_touch_screen, opsys;

-- opsys
WITH base AS (
    SELECT *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    name as resolution_type,
    opsys,
    COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY name) AS percentage
FROM base
GROUP BY resolution_type, opsys

-- opsys vs quality rank and price
WITH base AS (
    SELECT *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    quality_rank,
    opsys,
    PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM base
GROUP BY quality_rank, opsys

-- opsys vs clockspeed
SELECT 
    opsys,
    MIN(clock_speed),
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY clock_speed) AS q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY clock_speed) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY clock_speed) AS q3,
    MAX(clock_speed)
FROM laptop_cleaning
GROUP BY opsys;

-- opsys
SELECT 
    opsys,
    SUM(CASE WHEN ssd_capacity = '128' THEN 1 ELSE 0 END) AS ssd_128,
    SUM(CASE WHEN ssd_capacity = '256' THEN 1 ELSE 0 END) AS ssd_256,
    SUM(CASE WHEN ssd_capacity = '512' THEN 1 ELSE 0 END) AS ssd_512,
    SUM(CASE WHEN ssd_capacity = '1024'   THEN 1 ELSE 0 END) AS ssd_1tb,
    SUM(CASE WHEN ssd_capacity = '2048'   THEN 1 ELSE 0 END) AS ssd_2tb
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys;

SELECT 
    opsys,
    SUM(CASE WHEN hdd_capacity = '0' THEN 1 ELSE 0 END) AS hdd_0,
    SUM(CASE WHEN hdd_capacity = '32' THEN 1 ELSE 0 END) AS hdd_32,
    SUM(CASE WHEN hdd_capacity = '128' THEN 1 ELSE 0 END) AS hdd_128,
    SUM(CASE WHEN hdd_capacity = '512' THEN 1 ELSE 0 END) AS hdd_512,
    SUM(CASE WHEN hdd_capacity = '1024' THEN 1 ELSE 0 END) AS hdd_1024,
    SUM(CASE WHEN hdd_capacity = '2048'   THEN 1 ELSE 0 END) AS hdd_2tb
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys;

SELECT 
    opsys,
    SUM(CASE WHEN flash_storage = '0' THEN 1 ELSE 0 END) AS hdd_0,
    SUM(CASE WHEN flash_storage= '16' THEN 1 ELSE 0 END) AS hdd_16,
    SUM(CASE WHEN flash_storage = '32' THEN 1 ELSE 0 END) AS hdd_32,
    SUM(CASE WHEN flash_storage = '64' THEN 1 ELSE 0 END) AS hdd_64
FROM laptop_cleaning
GROUP BY opsys
ORDER BY opsys;

-- lets find the reasons why - cpu - intel, gpu - nvidia - price is higher. 
-- so better ppi,ram and gaming/notebook/workstation - so higher prices.

-- Check median price by CPU & GPU brand
SELECT 
    cpu_brand,
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    AVG(price) AS avg_price,
    COUNT(*) AS total_models
FROM laptop_cleaning
GROUP BY cpu_brand, gpu_brand
ORDER BY median_price DESC;

SELECT 
    ppi_whole,
    COUNT(*) AS count_models
FROM laptop_cleaning
WHERE cpu_brand = 'Intel'
  AND gpu_brand = 'Nvidia'
GROUP BY ppi_whole
ORDER BY count_models DESC;

SELECT 
    ppi_whole,
    COUNT(*) AS count_models
FROM laptop_cleaning
WHERE cpu_brand <> 'Intel'
  AND gpu_brand <> 'Nvidia'
GROUP BY ppi_whole
ORDER BY count_models DESC;

-- significant amount of higher ppi devices are present and they tend to be expensive.

SELECT
    cpu_brand,
    gpu_brand,
    ROUND(AVG(ram), 1) AS avg_ram,
    ROUND(AVG(ssd_capacity), 1) AS avg_ssd
FROM laptop_cleaning
GROUP BY cpu_brand, gpu_brand
ORDER BY avg_ram DESC;
-- avg ram and ssd capacity is higher than the others

SELECT
    typename, 
    count (*) as laptop_count
FROM laptop_cleaning
WHERE cpu_brand = 'Intel'
  AND gpu_brand = 'Nvidia'
GROUP BY typename
ORDER BY laptop_count DESC;
-- mostly gaming , notebooks and workstation.

SELECT 
    typename,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    COUNT(*) AS total_models
FROM laptop_cleaning
GROUP BY typename
ORDER BY median_price DESC;

-- does intel ad nvidia remain expensive after conrol specs
SELECT
    cpu_brand,
    gpu_brand,
    AVG(price) AS avg_price,
    AVG(ram) AS avg_ram,
    AVG(ssd_capacity) AS avg_ssd,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ppi_whole) AS median_ppi
FROM laptop_cleaning
GROUP BY cpu_brand, gpu_brand
ORDER BY avg_price DESC;

-- cpu brand vs resolution 
WITH base as (
    SELECT 
        *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    cpu_brand,

    SUM(CASE WHEN name = 'HD Ready' THEN 1 ELSE 0 END) AS hd_ready,
    SUM(CASE WHEN name = 'HD+' THEN 1 ELSE 0 END) AS hd_plus,
    SUM(CASE WHEN name = 'Full HD (1080p)' THEN 1 ELSE 0 END) AS full_hd,
    SUM(CASE WHEN name = 'WUXGA (Widescreen Ultra Extended Graphics Array)' THEN 1 ELSE 0 END) AS wuxga,
    SUM(CASE WHEN name = 'WXGA+ (Wide Extended Graphics Array Plus)' THEN 1 ELSE 0 END) AS wxga_plus,
    SUM(CASE WHEN name = 'WQXGA (Wide Quad Extended Graphics Array)' THEN 1 ELSE 0 END) AS wqxga,
    SUM(CASE WHEN name = 'QHD+ (Quad HD Plus)' THEN 1 ELSE 0 END) AS qhd_plus,
    SUM(CASE WHEN name = 'WQHD (Wide Quad HD)' THEN 1 ELSE 0 END) AS wqhd,
    SUM(CASE WHEN name = 'Retina Display (Common in MacBook Pros)' THEN 1 ELSE 0 END) AS retina,
    SUM(CASE WHEN name = '4K UHD (Ultra High Definition)' THEN 1 ELSE 0 END) AS uhd_4k,
    SUM(CASE WHEN name = 'Custom (close to 3:2 aspect ratio)' THEN 1 ELSE 0 END) AS custom_32,

    COUNT(*) AS total
FROM base
GROUP BY cpu_brand
ORDER BY total DESC;

WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000

SELECT
    ppi_whole,
    COUNT(*) AS total
FROM base
WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000
GROUP BY ppi_whole
ORDER BY total DESC;

SELECT
    ram,
    COUNT(*) AS total
FROM laptop_data_cleaned
WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000
GROUP BY ram
ORDER BY total DESC;

SELECT
    inches,
    COUNT(*) AS total
FROM laptop_data_cleaned
WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000
GROUP BY inches
ORDER BY total DESC;

SELECT
    gpu_brand,
    COUNT(*) AS total
FROM laptop_data_cleaned
WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000
GROUP BY gpu_brand
ORDER BY total DESC;

SELECT
    ssd_capacity,
    COUNT(*) AS total
FROM laptop_data_cleaned
WHERE cpu_brand = 'Intel'
  AND resolution_type = 'Full HD (1080p)'
  AND price_laptop > 150000
GROUP BY ssd_capacity
ORDER BY total DESC;

-- High-priced Intel laptops with FHD screens tend to have large displays (17 inches)
-- Most use Nvidia GPUs, contributing to premium pricing
-- RAM skewed toward 16–32 GB
-- SSD largely 256–512 GB
-- PPI lower because large screens with 1080p = lower pixel density

-- cpu_brand vs aspect_ratio
SELECT *
FROM screen_data;

WITH base as (
    SELECT 
        *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    cpu_brand,
    SUM(CASE WHEN aspect_ratio = '16:9' THEN 1 ELSE 0 END) AS "16:9",
    SUM(CASE WHEN aspect_ratio = '16:10' THEN 1 ELSE 0 END) AS "16:10",
    SUM(CASE WHEN aspect_ratio = '3:2' THEN 1 ELSE 0 END) AS "3:2"
FROM base
GROUP BY cpu_brand;

-- cpu brand vs quality rank 
WITH base as (
    SELECT 
        *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    cpu_brand,
    SUM(CASE WHEN quality_rank = 'Very High' THEN 1 ELSE 0 END) AS very_high,
    SUM(CASE WHEN quality_rank = 'High' THEN 1 ELSE 0 END) AS high,
    SUM(CASE WHEN quality_rank = 'Lower' THEN 1 ELSE 0 END) AS lower,
    SUM(CASE WHEN quality_rank = 'Mid' THEN 1 ELSE 0 END) AS mid,
    SUM(CASE WHEN quality_rank = 'Lower-Mid' THEN 1 ELSE 0 END) AS lower_mid
FROM base
GROUP BY cpu_brand;

-- cpu brand vs inches
SELECT 
    inches,
    SUM (CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) as AMD,
    SUM (CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) as Intel,
    SUM (CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) as Samsung
FROM laptop_cleaning
GROUP BY inches

-- cpu brand vs ram
SELECT 
    cpu_brand,
    SUM (CASE WHEN ram = '2' THEN 1 ELSE 0 END) as "2",
    SUM (CASE WHEN ram = '4' THEN 1 ELSE 0 END) as "4",
    SUM (CASE WHEN ram = '6' THEN 1 ELSE 0 END) as "6",
    SUM (CASE WHEN ram = '8' THEN 1 ELSE 0 END) as "8",
    SUM (CASE WHEN ram = '16' THEN 1 ELSE 0 END) as "16",
    SUM (CASE WHEN ram = '24' THEN 1 ELSE 0 END) as "24",
    SUM (CASE WHEN ram = '32' THEN 1 ELSE 0 END) as "32",
    SUM (CASE WHEN ram = '64' THEN 1 ELSE 0 END) as "64"
FROM laptop_cleaning
GROUP BY cpu_brand;

--skip dari 345 sampai 354

--gpu brand vs ram
SELECT
    ram,
    gpu_brand,
    COUNT(*) AS total_count
FROM laptop_cleaning
GROUP BY ram, gpu_brand
ORDER BY ram, gpu_brand;

--gpu brand vs price
SELECT
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY gpu_brand
ORDER BY gpu_brand;

--gpu brand vs typename
SELECT
    gpu_brand,
    typename,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM laptop_cleaning
GROUP BY gpu_brand, typename
ORDER BY gpu_brand, typename;

--gpu brand vs quality rank
WITH base as (
    SELECT 
        *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    ram,
    quality_rank,
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM base
GROUP BY ram, quality_rank, gpu_brand
ORDER BY ram, quality_rank, gpu_brand;

WITH base as (
    SELECT 
        *
    FROM laptop_cleaning l
    LEFT JOIN screen_data s
        ON l.resolution = s.resolution
)
SELECT
    typename,
    quality_rank,
    clock_speed,
    gpu_brand,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM base
GROUP BY typename, quality_rank, clock_speed, gpu_brand
ORDER BY typename, quality_rank, clock_speed, gpu_brand;




















