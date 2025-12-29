-- Built a full correlation matrix using advanced SQL by unpivoting numerical features with lateral joins and reconstructing a pivot-style correlation table for exploratory analysis and heatmap visualization

WITH corr_long AS (
    SELECT
        v1.var AS variable,
        v2.var AS corr_with,
        corr(v1.val, v2.val) AS correlation
    FROM laptop_cleaning l
    CROSS JOIN LATERAL (
        VALUES
        ('clock_speed', clock_speed),
        ('flash_storage', flash_storage),
        ('hdd_capacity', hdd_capacity),
        ('hdd_count', hdd_count),
        ('inches', inches),
        ('ips_panel', display_ips_panel::int),
        ('ppi_whole', ppi_whole),
        ('price', price),
        ('px_height', px_height),
        ('px_width', px_width),
        ('ram', ram),
        ('ssd_capacity', ssd_capacity),
        ('ssd_count', ssd_count),
        ('touch_screen', display_ips_touch_screen::int),
        ('weight', weight)
    ) v1(var, val)
    CROSS JOIN LATERAL (
        VALUES
        ('clock_speed', clock_speed),
        ('flash_storage', flash_storage),
        ('hdd_capacity', hdd_capacity),
        ('hdd_count', hdd_count),
        ('inches', inches),
        ('ips_panel', display_ips_panel::int),
        ('ppi_whole', ppi_whole),
        ('price', price),
        ('px_height', px_height),
        ('px_width', px_width),
        ('ram', ram),
        ('ssd_capacity', ssd_capacity),
        ('ssd_count', ssd_count),
        ('touch_screen', display_ips_touch_screen::int),
        ('weight', weight)
    ) v2(var, val)
    GROUP BY v1.var, v2.var
)
SELECT
    variable,

    MAX(CASE WHEN corr_with = 'clock_speed' THEN correlation END) AS corr_clock_speed,
    MAX(CASE WHEN corr_with = 'flash_storage' THEN correlation END) AS corr_flash_storage,
    MAX(CASE WHEN corr_with = 'hdd_capacity' THEN correlation END) AS corr_hdd_capacity,
    MAX(CASE WHEN corr_with = 'hdd_count' THEN correlation END) AS corr_hdd_count,
    MAX(CASE WHEN corr_with = 'inches' THEN correlation END) AS corr_inches,
    MAX(CASE WHEN corr_with = 'ips_panel' THEN correlation END) AS corr_ips_panel,
    MAX(CASE WHEN corr_with = 'ppi_whole' THEN correlation END) AS corr_ppi_whole,
    MAX(CASE WHEN corr_with = 'price' THEN correlation END) AS corr_price,
    MAX(CASE WHEN corr_with = 'px_height' THEN correlation END) AS corr_px_height,
    MAX(CASE WHEN corr_with = 'px_width' THEN correlation END) AS corr_px_width,
    MAX(CASE WHEN corr_with = 'ram' THEN correlation END) AS corr_ram,
    MAX(CASE WHEN corr_with = 'ssd_capacity' THEN correlation END) AS corr_ssd_capacity,
    MAX(CASE WHEN corr_with = 'ssd_count' THEN correlation END) AS corr_ssd_count,
    MAX(CASE WHEN corr_with = 'touch_screen' THEN correlation END) AS corr_touch_screen,
    MAX(CASE WHEN corr_with = 'weight' THEN correlation END) AS corr_weight

FROM corr_long
GROUP BY variable
ORDER BY variable;

-- price vs inches
-- numerical vs numerical
-- corr = 

CREATE TABLE corr_prices AS
SELECT 'inches' as variable, corr (inches, price) AS correlation
FROM laptop_cleaning; 

SELECT *
FROM corr_prices;

SELECT 
    price,
    inches,
    COUNT (*) AS laptop_count
FROM laptop_cleaning
WHERE inches IS NOT NULL
GROUP BY price, inches
ORDER BY inches;

SELECT
    inches,
    COUNT(*) AS laptop_count,
    STRING_AGG(price::text, ', ' ORDER BY price) AS price_list
FROM laptop_cleaning
GROUP BY inches
ORDER BY inches;

SELECT
    inches,     -- x-axis
    price       -- y-axis
FROM laptop_cleaning
WHERE inches IS NOT NULL
  AND price IS NOT NULL
ORDER BY inches, price;

SELECT
    inches,
    COUNT(*)            AS num_products,
    MIN(price)          AS min_price,
    ROUND(AVG(price),2) AS avg_price,
    MAX(price)          AS max_price
FROM laptop_cleaning
WHERE inches IS NOT NULL
  AND price IS NOT NULL
GROUP BY inches
ORDER BY inches;

-- inches vs weight 
-- numerical vs numerical
-- corr = 0.82 high correlation

SELECT 
    weight,
    inches,
    COUNT (*) AS laptop_count
FROM laptop_cleaning
WHERE inches IS NOT NULL
GROUP BY weight, inches
ORDER BY inches;

SELECT
    inches,
    COUNT(*) AS laptop_count,
    STRING_AGG(weight::text, ', ' ORDER BY weight) AS weights_list
FROM laptop_cleaning
GROUP BY inches
ORDER BY inches;

-- Inches Vs Ram

SELECT
    ram,
    AVG (ROUND (inches,2)) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median_inches,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram;

SELECT
    ram,
    MIN(inches) AS min_inches,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inches) AS q1_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inches) AS median_inches,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY inches) AS q3_inches,
    MAX(inches) AS max_inches
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram;

-- corr is very low and no consistent relation.
-- the variability is more for each ram type

-- Inches vs hdd capacity

SELECT
    hdd_capacity,
    AVG (ROUND (inches,2)) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY hdd_capacity) AS median_hdd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE hdd_capacity IS NOT NULL
GROUP BY hdd_capacity
ORDER BY hdd_capacity;


-- inches vs ssd_capacity
SELECT
    ssd_capacity,
    AVG (ROUND (inches,2)) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ssd_capacity) AS median_ssd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE hdd_capacity IS NOT NULL
GROUP BY ssd_capacity
ORDER BY ssd_capacity;


-- inches vs clockspeed
SELECT
    clock_speed,
    ROUND (AVG(inches),2) AS avg_inches,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY clock_speed) AS median_clock_speed,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE clock_speed IS NOT NULL
    AND inches IS NOT NULL
GROUP BY clock_speed
ORDER BY clock_speed;


-- BIVARIATE RAM 
CREATE TABLE corr_ram AS
SELECT 'inches' as variable, corr (inches,ram) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, ram)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (px_width, ram)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (px_width, ram)
    FROM laptop_cleaning;


SELECT *
FROM corr_ram;


-- ram vs ssd_capacity 

SELECT
    ssd_capacity,
    ROUND (AVG (ram),2) AS avg_ram,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ssd_capacity) AS median_ssd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE hdd_capacity IS NOT NULL
GROUP BY ssd_capacity
ORDER BY ssd_capacity;

SELECT 
    ram,
    ssd_capacity,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE ssd_capacity <> 0
GROUP BY ram, ssd_capacity
ORDER BY ram, ssd_capacity;
-- this correlation is mostly because of the 256gb ssd and 8gb ram combination.

-- RAM vx width 
SELECT
    px_width,
    ROUND (AVG (ram),2) AS avg_ram,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY px_width) AS median_width,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
WHERE hdd_capacity IS NOT NULL
GROUP BY px_width
ORDER BY px_width;
-- this higher correaltion is because of the 8gb ram combination and the 1920 px_width combination - which is common for most of the devices
-- the same can be said about the ram vs px_height.
-- because of this there is also correlation present between the ram and ppi.


-- RAM vs CLOCK SPEED
SELECT 
    ram,
    MIN(clock_speed) AS min_clock,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY clock_speed) AS q1_clock,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY clock_speed) AS median_clock,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY clock_speed) AS q3_clock,
    MAX(clock_speed) AS max_clock,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY ram
ORDER BY ram;

SELECT 
    cpu_brand,
    ram,
    MIN(clock_speed) AS min_clock,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY clock_speed) AS q1_clock,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY clock_speed) AS median_clock,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY clock_speed) AS q3_clock,
    MAX(clock_speed) AS max_clock,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY cpu_brand, ram
ORDER BY cpu_brand, ram;
-- the median clock_speed increases as the ram increases. across all the cpu brands. 

-- here also price varies a lot at the same clock_speed this shows that price depends on other characteristics as well.
SELECT 
    ram,
    clock_speed,
    ROUND(AVG(price), 2) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    COUNT(*) AS laptop_count
FROM laptop_cleaning
GROUP BY ram, clock_speed
ORDER BY ram, clock_speed;

-- SCREEN RELATED ANALYSIS
SELECT screen_resolution,
        COUNT (*) AS count_screen
FROM laptop_cleaning
GROUP BY screen_resolution
ORDER BY count_screen;

CREATE TABLE screen_data (
    resolution VARCHAR(20),
    name VARCHAR(100),
    aspect_ratio VARCHAR(10),
    quality_rank VARCHAR(20)
);

INSERT INTO screen_data (resolution, name, aspect_ratio, quality_rank) VALUES
('3840 x 2160', '4K UHD (Ultra High Definition)', '16:9', 'Very High'),
('2256 x 1504', 'Custom (close to 3:2 aspect ratio)', '3:2', 'Very High'),
('2880 x 1800', 'Retina Display (Common in MacBook Pros)', '16:10', 'Very High'),
('2736 x 1824', 'Custom (close to 3:2 aspect ratio)', '3:2', 'High'),
('2560 x 1600', 'WQXGA (Wide Quad Extended Graphics Array)', '16:10', 'High'),
('2560 x 1440', 'WQHD (Wide Quad HD)', '16:9', 'High'),
('2400 x 1600', 'WQXGA (Wide Quad Extended Graphics Array)', '3:2', 'High'),
('2304 x 1440', 'WQHD (Wide Quad HD)', '16:9', 'High'),
('3200 x 1800', 'QHD+ (Quad HD Plus)', '16:9', 'High'),
('2160 x 1440', 'QHD+ (Quad HD Plus)', '3:2', 'High'),
('1920 x 1200', 'WUXGA', '16:10', 'Mid'),
('1920 x 1080', 'Full HD (1080p)', '16:9', 'Mid'),
('1600 x 900', 'HD+', '16:9', 'Lower-Mid'),
('1440 x 900', 'WXGA+', '16:10', 'Lower-Mid'),
('1366 x 768', 'HD Ready', '16:9', 'Lower');

SELECT *
FROM laptop_cleaning AS l
LEFT JOIN screen_data AS s
    ON l.screenresolution = s.resolution;

SELECT*
FROM screen_data;



-- joining resolution 
ALTER TABLE laptop_cleaning
ADD COLUMN resolution VARCHAR(20);

UPDATE laptop_cleaning
SET resolution =
    CONCAT(px_width, ' x ', px_height);

-- salah 
SELECT 
    screen_data.name as resolution_type,
    ROUND (AVG(price),2) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price,
    COUNT(*) AS laptop_count
FROM laptop_cleaning, screen_data
GROUP BY resolution_type
ORDER BY median_price DESC;
-- buat bahan evaluasi dan belajar aja nanti

SELECT *
FROM laptop_cleaning
LEFT JOIN screen_data 
    ON laptop_cleaning.resolution = screen_data.resolution;


SELECT 
    lc.resolution,
    sd.name AS resolution_type,
    sd.quality_rank,
    ROUND(AVG(lc.price), 2) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lc.price) AS median_price,
    COUNT(*) AS laptop_count
FROM laptop_cleaning lc
LEFT JOIN screen_data sd
    ON lc.resolution = sd.resolution
GROUP BY lc.resolution, sd.name, sd.quality_rank
ORDER BY median_price DESC;

-- form the graph we can clearly see that the resolution_type/screen type- dictates the price.
-- for the higer quality - 4K ultra HD median price is genrally higher
-- for full hd screen with the resolution of 1920 X 1080 px the price range varies - present at both higher and lower costs.
-- mac books made by apple have retina display and the price is higer and the quality/resolution is higher.

SELECT
    company, 
    typename,
    COUNT (*) laptop_count
FROM laptop_cleaning
WHERE inches IS NULL
GROUP BY company, typename;

-- FILLING MISSING INCHES 
-- Most common inches in each category inches_map = {
    ('Asus', 'Notebook'): 11.6,
    ('Dell', '2 in 1 Convertible'): 13.3,
    ('Dell', 'Gaming'): 15.6,
    ('Lenovo', 'Notebook'): 11.6,
    ('Lenovo', 'Ultrabook'): 14.0,
    ('MSI', 'Gaming'): 17.3,
    ('Microsoft', 'Ultrabook'): 13.5--

CREATE TABLE inches_category(
    company_name TEXT,
    type_name TEXT,
    laptop_inches INT
);

ALTER TABLE inches_category
ALTER COLUMN laptop_inches TYPE NUMERIC;

INSERT INTO inches_category (company_name, type_name, laptop_inches) VALUES
('Asus', 'Notebook', '11.6'),
('Dell', '2 in 1 Convertible', '13.3'),
('Dell', 'Gaming', '15.6'),
('Lenovo', 'Notebook', '11.6'),
('Lenovo', 'Ultrabook', '17.3'),
('Microsoft', 'Ultrabook', '13.5');

SELECT *
FROM inches_category;

UPDATE laptop_cleaning
SET inches = CASE
    WHEN company='Asus' AND typename='Notebook' THEN 11.6
    WHEN company='Dell' AND typename='Gaming' THEN 15.6
    WHEN company='Dell' AND typename='2 in 1 Convertible' THEN 13.3
    WHEN company='Lenovo' AND typename='Notebook' THEN 11.6
    WHEN company='Microsoft' AND typename='Ultrabook' THEN 13.5
    WHEN company='Lenovo' AND typename='Ultrabook' THEN 17.3
    WHEN company='MSI' AND typename='Gaming' THEN 17.3
END
WHERE inches IS NULL;

SELECT
    company, 
    typename,
    COUNT (*) laptop_count
FROM laptop_cleaning
WHERE inches IS NULL
GROUP BY company, typename;

-- Create PPI whole
ALTER TABLE laptop_cleaning
ADD COLUMN ppi_whole NUMERIC;

UPDATE laptop_cleaning
SET ppi_whole = ROUND(
        SQRT((px_width * px_width) + (px_height * px_height)) / inches
    )
WHERE ppi_whole IS NULL;

SELECT *
FROm laptop_cleaning
WHERE ppi_whole is null;


--weight is null
SELECT
    company, 
    typename,
    COUNT (*) laptop_count
FROM laptop_cleaning
WHERE weight IS NULL
GROUP BY company, typename;


-- 
CREATE TABLE weights_map (
    company_name VARCHAR(50),
    type_name VARCHAR(50),
    inches NUMERIC(4,1),
    weight_value NUMERIC(4,2)
);

INSERT INTO weights_map (company_name, type_name, inches, weight_value) VALUES
('Acer', 'Notebook', 15.6, 2.1),
('Asus', '2 in 1 Convertible', 13.3, 1.1),
('Asus', 'Ultrabook', 14.0, 1.0),
('Dell', 'Notebook', 15.6, 2.2),
('Dell', 'Notebook', 17.3, 2.8),
('Dell', 'Ultrabook', 15.6, 1.88),
('Lenovo', 'Notebook', 15.6, 2.2),
('Lenovo', 'Notebook', 17.3, 2.8),
('Lenovo', 'Ultrabook', 14.0, 1.13),
('Toshiba', 'Notebook', 15.6, 2.0);

UPDATE laptop_cleaning AS l
SET weight = w.weight_value
FROM weights_map AS w
WHERE l.weight IS NULL
  AND l.company = w.company_name
  AND l.typename = w.type_name
  AND ROUND(l.inches, 1) = w.inches;

SELECT * 
FROM laptop_cleaning
WHERE weight IS NULL;

-- update weight (the other way)
UPDATE laptop_cleaning
SET weight = CASE
    WHEN company = 'Acer' AND typename='Notebook' AND inches = '15.6' THEN 2.1
    WHEN company = 'Asus' AND typename='Ultrabook' AND inches = '15.6' THEN 2.1
     WHEN company = 'Asus'    AND typename = 'Ultrabook'          AND inches = 14.0 THEN 1.0
    WHEN company = 'Dell'    AND typename = 'Notebook'           AND inches = 15.6 THEN 2.2
    WHEN company = 'Dell'    AND typename = 'Notebook'           AND inches = 17.3 THEN 2.8
    WHEN company = 'Dell'    AND typename = 'Ultrabook'          AND inches = 15.6 THEN 1.88
    WHEN company = 'Lenovo'  AND typename = 'Notebook'           AND inches = 15.6 THEN 2.2
    WHEN company = 'Lenovo'  AND typename = 'Notebook'           AND inches = 17.3 THEN 2.8
    WHEN company = 'Lenovo'  AND typename = 'Ultrabook'          AND inches = 14.0 THEN 1.13
    WHEN company = 'Toshiba' AND typename = 'Notebook'           AND inches = 15.6 THEN 2.0
    ELSE weight
END
WHERE weight IS NULL;

-- where ram is null
SELECT *
FROM laptop_cleaning
WHERE unnamed in (683);





