-- INCHES
CREATE TABLE corr_inches AS
SELECT 'ram' as variable, corr (ram,inches) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, inches)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (px_width, inches)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (px_width, inches)
    FROM laptop_cleaning
UNION ALL
SELECT 'ppi_whole', corr(ppi_whole, inches)
FROM laptop_cleaning;


DROP TABLE corr_inches;


SELECT *
FROM corr_inches;

ALTER TABLE corr_summary
RENAME TO corr_price;

-- px_width
CREATE TABLE corr_width AS
SELECT 'ram' as variable, corr (ram,px_width) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, px_width)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (px_width, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (px_width, px_width)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr (ppi_whole, px_width)
    FROM laptop_cleaning;

-- px height 
CREATE TABLE corr_height AS
SELECT 'ram' as variable, corr (ram,px_height) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, px_height)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, px_height)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr (ppi_whole, px_height)
    FROM laptop_cleaning;

--clock speed
CREATE TABLE corr_clock_speed AS
SELECT 'ram' as variable, corr (ram, clock_speed) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, clock_speed)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, clock_speed)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr (ppi_whole, clock_speed)
FROM laptop_cleaning;

-- SSD CAPACITY
CREATE TABLE corr_ssd_capacity AS
SELECT 'ram' as variable, corr (ram,ssd_capacity) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, ssd_capacity)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, ssd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, ssd_capacity)
    FROM laptop_cleaning;


-- hdd capacity 
CREATE TABLE corr_hdd_capacity AS
SELECT 'ram' as variable, corr (ram,hdd_capacity) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, hdd_capacity)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width,hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, hdd_capacity)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, hdd_capacity)
    FROM laptop_cleaning;

-- SSD Count
CREATE TABLE corr_ssd_count AS
SELECT 'ram' as variable, corr (ram,ssd_count) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, ssd_count)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, ssd_count)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, ssd_count)
    FROM laptop_cleaning;

-- HDD Count
CREATE TABLE corr_hdd_count AS
SELECT 'ram' as variable, corr (ram,hdd_count) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, hdd_count)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, hdd_count)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, hdd_count)
    FROM laptop_cleaning;

-- flash storage
CREATE TABLE corr_flash_storage AS
SELECT 'ram' as variable, corr (ram,flash_storage) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, flash_storage)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, flash_storage)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, flash_storage)
    FROM laptop_cleaning;

-- ips panel
CREATE TABLE corr_ips_panel AS
SELECT 'ram' as variable, corr (ram,ips_panel) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, ips_panel)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, ips_panel)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, ips_panel)
    FROM laptop_cleaning;

-- touch screen
CREATE TABLE corr_touch_screen AS
SELECT 'ram' as variable, corr (ram,touch_screen) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, touch_screen)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, touch_screen)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, touch_screen)
    FROM laptop_cleaning;

-- PPI WHOLE 
CREATE TABLE corr_ppi_whole AS
SELECT 'ram' as variable, corr (ram,ppi_whole) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, ppi_whole)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (ips_panel, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (touch_screen, ppi_whole)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr(ppi_whole, ppi_whole)
    FROM laptop_cleaning;


DROP TABLE corr_price;

DROP TABLE corr_weight;

DROP TABLE corr_ram;

-- PRICE 
CREATE TABLE corr_price AS
SELECT 'ram' as variable, corr (ram,price) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, price)
FROM laptop_cleaning
UNION ALL 
SELECT 
    'price', corr (price, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_width', corr (px_width, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'px_height', corr (px_height, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'clock_speed', corr (clock_speed, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_capacity', corr (ssd_capacity, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_capacity', corr (hdd_capacity, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ssd_count', corr (ssd_count, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'hdd_count', corr (hdd_count, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'flash_storage', corr (flash_storage, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'ips_panel', corr (px_width, price)
    FROM laptop_cleaning
UNION ALL
SELECT
    'touch_screen', corr (px_width, price)
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr (ppi_whole, price)
    FROM laptop_cleaning;

-- weight
CREATE TABLE corr_weight AS
SELECT 'ram' as variable, corr (ram,weight) AS correlation
FROM laptop_cleaning
UNION ALL
SELECT
    'weight', corr (weight, weight)
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


-- ram
CREATE TABLE corr_ram AS
SELECT 'ram' as variable, corr (ram,ram) AS correlation
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
    FROM laptop_cleaning
UNION ALL
SELECT 
    'ppi_whole', corr (ppi_whole, ram)
    FROM laptop_cleaning;


-- insert inches
INSERT INTO corr_clock_speed (variable, correlation)
SELECT 'inches', corr (inches, clock_speed)
FROM laptop_cleaning; 

INSERT INTO corr_flash_storage(variable, correlation)
SELECT 'inches', corr (inches, flash_storage)
FROM laptop_cleaning; 

INSERT INTO corr_hdd_capacity(variable, correlation)
SELECT 'inches', corr (inches, hdd_capacity)
FROM laptop_cleaning; 

INSERT INTO corr_hdd_count(variable, correlation)
SELECT 'inches', corr (inches, hdd_count)
FROM laptop_cleaning; 

INSERT INTO corr_inches(variable, correlation)
SELECT 'inches', corr (inches, inches)
FROM laptop_cleaning; 

INSERT INTO corr_ips_panel(variable, correlation)
SELECT 'inches', corr (inches, ips_panel)
FROM laptop_cleaning; 

INSERT INTO corr_price (variable, correlation)
SELECT 'inches', corr (inches, price)
FROM laptop_cleaning; 

INSERT INTO corr_ram(variable, correlation)
SELECT 'inches', corr (inches, ram)
FROM laptop_cleaning; 

INSERT INTO corr_ssd_capacity (variable, correlation)
SELECT 'inches', corr (inches, ssd_capacity)
FROM laptop_cleaning; 

INSERT INTO corr_touch_screen(variable, correlation)
SELECT 'inches', corr (inches, touch_screen)
FROM laptop_cleaning; 

INSERT INTO corr_weight(variable, correlation)
SELECT 'inches', corr (inches, weight)
FROM laptop_cleaning; 

INSERT INTO corr_width (variable, correlation)
SELECT 'inches', corr (inches, px_width)
FROM laptop_cleaning; 

INSERT INTO corr_height (variable, correlation)
SELECT 'inches', corr (inches, Px_height)
FROM laptop_cleaning; 

INSERT INTO corr_ssd_count (variable, correlation)
SELECT 'inches', corr (inches, ssd_count)
FROM laptop_cleaning; 

INSERT INTO corr_ppi_whole (variable, correlation)
SELECT 'inches', corr (inches, ppi_whole)
FROM laptop_cleaning; 

SELECT *
FROM corr_clock_speed;

SELECT *
FROM corr_flash_storage;

SELECT*
FROM corr_hdd_capacity;

SELECT *
FROM corr_hdd_count;

SELECT * 
FROM corr_height;

SELECT *
FROM corr_inches;

SELECT *
FROM corr_ips_panel;

SELECT *
FROM corr_ppi_whole;

SELECT *
FROM corr_price;

SELECT *
FROM corr_ram;

SELECT * 
FROM corr_ssd_capacity;

SELECT *
FROM corr_ssd_count;

SELECT *
FROM corr_touch_screen;

SELECT *
FROM corr_weight;

SELECT *
FROM corr_width;

SELECT*
FROM corr_height;


SELECT 
    t1.variable,
    t1.correlation AS corr_clock_speed,
    t2.correlation AS corr_flash_storage,
    t3.correlation AS corr_hdd_capacity,
    t4.correlation AS corr_hdd_count,
    t5.correlation AS corr_inches,
    t6.correlation AS corr_ips_panel,
    t7.correlation AS corr_ppi_whole,
    t8.correlation AS corr_price,
    t9.correlation AS corr_height,
    t10.correlation AS corr_weight,
    t11.correlation AS corr_ram,
    t12.correlation AS corr_ssd_capacity,
    t13.correlation AS corr_ssd_count,
    t14.correlation AS corr_touch_screen,
    t15.correlation AS corr_weight
FROM corr_clock_speed t1
LEFT JOIN corr_flash_storage t2 ON t1.variable = t2.variable
LEFT JOIN corr_hdd_capacity t3 ON t1.variable = t3.variable
LEFT JOIN corr_hdd_count t4 ON t1.variable = t4.variable
LEFT JOIN corr_inches t5 ON t1.variable = t5.variable
LEFT JOIN corr_ips_panel t6 ON t1.variable = t6.variable
LEFT JOIN corr_ppi_whole t7 ON t1.variable = t7.variable
LEFT JOIN corr_price t8 ON t1.variable = t8.variable
LEFT JOIN corr_height t9 ON t1.variable = t9.variable
LEFT JOIN corr_width t10 ON t1.variable = t10.variable
LEFT JOIN corr_ram t11 ON t1.variable = t11.variable
LEFT JOIN corr_ssd_capacity t12 ON t1.variable = t12.variable
LEFT JOIN corr_ssd_count t13 ON t1.variable = t13.variable
LEFT JOIN corr_touch_screen t14 ON t1.variable = t14.variable
LEFT JOIN corr_weight t15 ON t1.variable = t15.variable;
