-- BIVARIATE ANALYSIS
-- PRICE
COPY (
  SELECT inches, weight_laptop, price_laptop, ram_gb, ssd_capacity, hdd_capacity, clock_speed
  FROM laptop_data_cleaned
) TO '/path/to/laptop_numeric.csv' WITH CSV HEADER;

-- Example: Correlation between price and ram
SELECT 
    (SUM((ram - avg_ram) * (price - avg_price)) /
     (SQRT(SUM(POWER (ram - avg_ram, 2))) * 
     SQRT(SUM(POWER(price - avg_price, 2))))) AS corr_price_ram
FROM (
    SELECT 
        ram,
        price,
        (SELECT AVG(ram) FROM laptop_cleaning) AS avg_ram,
        (SELECT AVG(price) FROM laptop_cleaning) AS avg_price
    FROM laptop_cleaning
) AS subquery;

CREATE TABLE corr_summary AS
SELECT 
  'ram' AS variable, corr(ram, price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT 'ssd_capacity', corr(ssd_capacity, price)
FROM laptop_cleaning
UNION ALL
SELECT 'clock_speed', corr(clock_speed, price)
FROM laptop_cleaning
UNION ALL
SELECT 'hdd_capacity', corr(hdd_capacity, price)
FROM laptop_cleaning
UNION ALL
SELECT 'weight', corr(weight, price)
FROM laptop_cleaning;

SELECT *
FROM corr_summary;

SELECT corr(ram, price) AS corr_ram_price,
       corr(ssd_capacity, price) AS corr_ssd_price,
       corr(clock_speed, price) AS corr_clock_price
FROM laptop_cleaning;

inches                     0.054461
ram                        0.681182
price                      1.000000
px_width                   0.553897
px_height                  0.550083
display_ips_panel          0.257585
display_is_touch_screen    0.186600
clock_speed                0.422046
ssd_capacity               0.676851
hdd_capacity              -0.096546
ssd_count                  0.513941
hdd_count                 -0.168153
flash_storage             -0.200529
Name: price, dtype: float64; 

INSERT INTO corr_summary (variable, correlation)
SELECT
    'px_width' AS variable, corr(px_width, price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT 
    'px_height' AS variable, corr(Px_height, price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT 'ssd_count' AS variable, corr(ssd_count, price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT 'hdd_count' AS variable, corr(hdd_count, price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT 'flash_storage' AS variable, corr(flash_storage, price) AS correlation
FROM laptop_cleaning;

ALTER TABLE corr_summary
ADD COLUMN inches INT; 

ALTER TABLE corr_summary
ALTER COLUMN inches TYPE NUMERIC USING inches::NUMERIC;

ALTER TABLE corr_summary
DROP COLUMN inches; 

INSERT INTO corr_summary (variable, correlation)
SELECT 'inches', corr(inches, price)
FROM laptop_cleaning;

INSERT INTO corr_summary (variable, correlation)
SELECT 'price', corr (price, price)
FROM laptop_cleaning; 

-- change boolean to int 
UPDATE laptop_cleaning
SET 
    ips_panel = display_ips_panel :: INT,
    touch_screen = display_ips_touch_screen::INT;

ALTER TABLE laptop_cleaning
ADD COLUMN ips_panel INT,
ADD COLUMN touch_screen INT;

UPDATE laptop_cleaning
SET ips_panel = 
    CASE 
        WHEN display_ips_panel, TRUE THEN 1 ELSE 0 END,
    touch_screen = 
    CASE 
        WHEN display_ips_touch_screen, TRUE THEN 1 ELSE 0 END;

UPDATE laptop_cleaning
SET inches = 15.6
WHERE company = 'Dell'
  AND unnamed in (476)
  AND inches IS NULL;

