-- now dealing with the structural issues.
-- screenresolution column

ALTER TABLE laptop_cleaning
ADD COLUMN px_width TEXT,
ADD COLUMN px_height TEXT;


-- split it up
UPDATE laptop_cleaning
SET 
-- Extract part before the 'x', then take the last word (width)
    px_width = SPLIT_PART(SPLIT_PART (Screen_Resolution, 'x', 1),
     ' ', 
    ARRAY_LENGTH(STRING_TO_ARRAY(SPLIT_PART(Screen_Resolution, 'x', 1), ' '), 1) -- No matter how many words are before the ‘x’, give me the last one
    ),
-- extra part after 'x' (height)
    px_height = SPLIT_PART (screen_resolution, 'x',2);

SELECT Screen_Resolution, px_width, px_height
FROM laptop_cleaning
LIMIT 10;

--convert to number
ALTER TABLE laptop_cleaning
ALTER COLUMN px_width TYPE INT USING px_width::INT,
ALTER COLUMN px_height TYPE INT USING px_height::INT;

-- IPS RESOLUTION
ALTER TABLE laptop_cleaning
ADD COLUMN display_ips_panel BOOLEAN,
ADD COLUMN display_ips_touch_screen BOOLEAN;

SELECT screen_resolution, display_ips_panel, display_ips_touch_screen
FROM laptop_cleaning
ORDER BY unnamed;

UPDATE laptop_cleaning
SET 
    display_ips_panel = CASE
    WHEN LOWER(screen_resolution) LIKE '%ips panel%' THEN TRUE ELSE FALSE
    END, 
    display_ips_touch_screen = CASE
    WHEN LOWER(screen_resolution) LIKE '%touchscreen%' THEN TRUE ELSE FALSE
    END;

UPDATE laptop_cleaning
SET
  -- set IPS flag if the screen description explicitly mentions "ips" or "ips panel"
  display_ips_panel = CASE
    WHEN screen_resolution ~* '\bips\b' OR screen_resolution ~* 'ips panel' THEN TRUE
    ELSE FALSE
  END,

  -- set touchscreen flag if description mentions "touchscreen" or "touch screen" (allow hyphen/space)
  display_ips_touch_screen = CASE
    WHEN screen_resolution ~* 'touch[\s-]*screen' THEN TRUE
    ELSE FALSE
  END; 

SELECT typename, screen_resolution, display_ips_panel, display_ips_touch_screen
FROM laptop_cleaning
WHERE LOWER(typename) LIKE '%2 in 1 convertible%'
ORDER BY unnamed;



-- FIX invalid 2-in-1 convertible row 
UPDATE laptop_cleaning
SET display_ips_touch_screen = TRUE
WHERE LOWER(typename) = '2 in 1 convertible'
  AND (display_ips_touch_screen IS FALSE OR display_ips_touch_screen IS NULL);


--CPU COLUMN
ALTER TABLE laptop_cleaning
ADD COLUMN clock_speed NUMERIC,
ADD COLUMN cpu_brand TEXT; 


UPDATE laptop_cleaning
SET clock_speed = 
    CAST(REGEXP_REPLACE(cpu, '.* ([0-9.]+)GHz', '\1') AS NUMERIC); 

UPDATE laptop_cleaning
SET cpu_brand = SPLIT_PART(cpu, ' ', 1),
    gpu_brand = SPLIT_PART (gpu, ' ', 1);

ALTER TABLE laptop_cleaning
ADD COLUMN gpu_brand TEXT;

SELECT cpu, cpu_brand, clock_speed, gpu_brand
FROM laptop_cleaning; 

-- now lets get all the indexes where the flash storage means the ssd.
-- 903,824,609,319  - consider them
-- dont consider flash + hdd index

ALTER TABLE laptop_cleaning
ADD COLUMN SSD_capacity TEXT, 
ADD COLUMN HDD_capacity TEXT;

UPDATE laptop_cleaning
SET 
  SSD_capacity = SPLIT_PART(memory, '+', 1),
  HDD_capacity = SPLIT_PART(memory, '+', 2);

--Identify swapped rows (where SSD info is in the wrong place)
SELECT memory, SSD_capacity
FROM laptop_cleaning
WHERE LOWER(SSD_capacity) LIKE '%hdd%'
   OR LOWER(SSD_capacity) LIKE '%hybrid%'
ORDER BY unnamed;

--swap the value for those rows
UPDATE laptop_cleaning
SET 
    ssd_capacity = hdd_capacity,
    hdd_capacity = SPLIT_PART(memory, '+', 1)
WHERE LOWER(ssd_capacity) LIKE '%hdd%'
   OR LOWER(ssd_capacity) LIKE '%hybrid%';

-- clean the data
UPDATE laptop_cleaning
SET
    ssd_capacity = TRIM(ssd_capacity),
    hdd_capacity = TRIM(hdd_capacity);


--Identify swapped rows (where HDD info is in the wrong place)
SELECT unnamed, memory, ssd_capacity, HDD_capacity
FROM laptop_cleaning
WHERE LOWER(HDD_capacity) LIKE '%ssd%'
ORDER BY unnamed;

ALTER TABLE laptop_cleaning
ADD COLUMN ssd_count INT DEFAULT 0,
ADD COLUMN hdd_count INT DEFAULT 0;

ALTER TABLE laptop_cleaning
ALTER COLUMN unnamed TYPE INT USING unnamed::INT;

UPDATE laptop_cleaning
SET 
    ssd_count = 2,
    hdd_capacity = NULL
WHERE unnamed IN (28, 266, 347, 901); 

-- Count occurrences of “HDD” in the memory column
SELECT 
    memory AS memory,
    COUNT(*) AS count
FROM laptop_cleaning
WHERE LOWER(memory) LIKE '%hdd%'
GROUP BY memory
ORDER BY count DESC;

-- there is '1TB HDD + 1TB HDD' so we did the recheck on ssd cpacity
SELECT unnamed, memory, ssd_capacity, hdd_capacity
FROM laptop_cleaning
WHERE unnamed IN (703)

UPDATE laptop_cleaning
SET 
    hdd_count = 2,
    ssd_capacity = NULL
WHERE unnamed IN (703);

--Count how many SSDs or HDDs per laptop
UPDATE laptop_cleaning
SET ssd_count = CASE 
            WHEN LOWER(ssd_capacity) LIKE '%ssd%' THEN 1
            ELSE 0
        END,
    hdd_count = 
        CASE 
            WHEN LOWER(hdd_capacity) LIKE '%hdd%' THEN 1
            WHEN LOWER(hdd_capacity) LIKE '%hybrid%' THEN 1
            ELSE 0
        END;

UPDATE laptop_cleaning
SET 
    ssd_count = 2
WHERE unnamed IN (28, 266, 347, 901); 

SELECT unnamed, ssd_capacity, ssd_count, hdd_capacity, hdd_count
FROM laptop_cleaning
WHERE unnamed IN (28, 266, 347, 703, 901); 

-- now flash storage problem
-- now find the index where the flash storage are actually the ssd only - i.e when company = apple and the index are these 903,824,609,319
ALTER TABLE laptop_cleaning
ADD COLUMN IF NOT EXISTS flash_storage TEXT,
ADD COLUMN IF NOT EXISTS ssd_count INT DEFAULT 0,
ADD COLUMN IF NOT EXISTS hdd_count INT DEFAULT 0;

-- find row when the apple company mentioned
SELECT unnamed, memory, company
FROM laptop_cleaning
WHERE LOWER (company) LIKE '%apple%'
    AND LOWER(memory) LIKE '%flash%'
ORDER BY unnamed; 

SELECT *
FROM laptop_cleaning
WHERE unnamed IN (903, 824, 609, 319); -- this is flash storage = ssd for the non apple product

-- Keep 903,824,609,319 as SSD (even though non-Apple)
UPDATE laptop_cleaning
SET ssd_count = 1
WHERE unnamed IN (903, 824, 609, 319);

-- Move all other Flash Storage rows (non-Apple, except those 4) into flash_storage
UPDATE laptop_cleaning
SET 
    flash_storage = ssd_capacity,
    ssd_capacity = NULL,
    ssd_count = 0
WHERE LOWER(memory) LIKE '%flash%'
  AND LOWER(company) <> 'apple'
  AND unnamed NOT IN (903, 824, 609, 319);

--  Fix the special hybrid case (ID = 447)
UPDATE laptop_cleaning
SET hdd_count = 1
WHERE unnamed = 447;

-- clean extra spaces 
UPDATE laptop_cleaning
SET 
    ssd_capacity = TRIM(ssd_capacity),
    flash_storage = TRIM(flash_storage);

SELECT *
FROM laptop_cleaning
WHERE unnamed IN (28, 266, 347, 901, 703);

-- replace with number only
UPDATE laptop_cleaning
SET ssd_capacity = REGEXP_REPLACE
    (ssd_capacity, '([0-9]+(?:\\.[0-9]+)?)(GB|TB).*', '\1\2', 'gi'); 

UPDATE laptop_cleaning
SET ssd_capacity = REGEXP_REPLACE(ssd_capacity, '(GB|TB)', '', 'gi'); 

SELECT *
FROM laptop_cleaning
WHERE company LIKE '%?%'
   OR typename LIKE '%?%'
   OR inches LIKE '%?%'
   OR screen_resolution LIKE '%?%'
   OR cpu LIKE '%?%'
   OR ram LIKE '%?%'
   OR MEMORY LIKE '%?%'
   OR gpu LIKE '%?%'
   OR opsys LIKE '%?%'
   OR weight LIKE '%?%'
   OR price LIKE '%?%';

UPDATE laptop_cleaning
SET 
    ssd_capacity = NULLIF(REPLACE(ssd_capacity, '?', ''), ''),
    weight = NULLIF(REPLACE(weight, '?', ''), ''),
    memory = NULLIF(REPLACE(memory, '?', ''), ''),
    inches = NULLIF(REPLACE (inches, '?', ''), '');

-- convert to numeric type
ALTER TABLE laptop_cleaning
ALTER COLUMN ssd_capacity TYPE NUMERIC
     USING NULLIF(ssd_capacity, '')::NUMERIC;

-- detect which row are TB and multiply by 1024
UPDATE laptop_cleaning
SET ssd_capacity = ssd_capacity * 1024
WHERE LOWER(memory) LIKE '%tb ssd%';

SELECT ssd_capacity, 
    COUNT (*) AS count_ssd
FROM laptop_cleaning
WHERE ssd_capacity IS NOT NULL
GROUP BY ssd_capacity
ORDER BY count_ssd DESC;  

-- HDD memory
-- cleaning HDD 
UPDATE laptop_cleaning
SET hdd_capacity = REGEXP_REPLACE(hdd_capacity, '(HDD|Hybrid|GB|TB)', '', 'gi')
WHERE hdd_capacity IS NOT NULL;

ALTER TABLE laptop_cleaning
ALTER COLUMN hdd_capacity TYPE NUMERIC USING NULLIF 
    (TRIM(hdd_capacity), '')::NUMERIC;

-- Normalize TB to GB 
SELECT memory, hdd_capacity
FROM laptop_data_cleaned; 

UPDATE laptop_cleaning
SET hdd_capacity = hdd_capacity * 1024
WHERE hdd_capacity IN (1, 1.0, 2); 

SELECT hdd_capacity, 
    COUNT (*) AS count_hdd
FROM laptop_cleaning
WHERE hdd_capacity IS NOT NULL
GROUP BY hdd_capacity
ORDER BY hdd_capacity DESC;

-- automatic count
UPDATE laptop_cleaning
SET 
    ssd_count = CASE WHEN ssd_capacity IS NOT NULL THEN 1 ELSE 0 END,
    hdd_count = CASE WHEN hdd_capacity IS NOT NULL THEN 1 ELSE 0 END
WHERE unnamed NOT IN (28, 266, 347, 901, 703);

SELECT ssd_count, COUNT(*) AS num_laptops
FROM laptop_cleaning
GROUP BY ssd_count
ORDER BY ssd_count;

SELECT hdd_count, COUNT(*) AS num_laptops
FROM laptop_cleaning
GROUP BY hdd_count
ORDER BY hdd_count;

-- flash storage value content
SELECT flash_storage, 
    COUNT (*) AS count_flash
FROM laptop_cleaning
WHERE flash_storage is not null
GROUP BY flash_storage; 

UPDATE laptop_cleaning
SET flash_storage = TRIM(REGEXP_REPLACE(flash_storage, '([0-9]+).*', '\1', 'gi'))
WHERE flash_storage IS NOT NULL;

ALTER TABLE laptop_cleaning
ALTER COLUMN flash_storage TYPE NUMERIC USING NULLIF(flash_storage, '')::NUMERIC;

-- 180GB and 240GB are possible for business laptop
-- Possible data outlier
SELECT 
    unnamed, 
    company,
    typename,
    ssd_capacity,
    hdd_capacity,
    flash_storage,
    price,
    opsys
FROM laptop_cleaning
WHERE ssd_capacity IN (8, 16, 32, 64);

-- at index 950 the data for ssd_capacity is wrong. price is high

SELECT unnamed, ssd_capacity, price
FROM laptop_cleaning
WHERE ssd_capacity IN (2, 4, 8, 16, 32, 64);
-- compare to the low memory laptop, 950's price is around 10 times than the other

UPDATE laptop_cleaning
SET ssd_capacity = NULL
WHERE unnamed IN (950); 

-- the ssd of this low capacity are possible and common in very low budget devices as these products are also low in price the data is valid.
-- these indexes where ssd_capacity is 32 and opsys = windows - they wont even run - so removing them.

SELECT unnamed, company, ssd_capacity, opsys, price
FROM laptop_cleaning
WHERE LOWER(opsys) LIKE '%windows%'
  AND ssd_capacity <= 32;

DELETE FROM laptop_cleaning
WHERE LOWER(opsys) LIKE '%windows%'
  AND ssd_capacity <= 32;

SELECT COUNT(*) 
FROM laptop_cleaning
WHERE LOWER(opsys) LIKE '%windows%'
  AND ssd_capacity <= 32;


-- DATA VALIDITY ISSUE
UPDATE laptop_cleaning
SET ram = TRIM(TRAILING 'GB' FROM ram);

ALTER TABLE laptop_cleaning
ALTER COLUMN ram TYPE INT USING NULLIF(ram, '')::INT;

-- Normalize operation system names
UPDATE laptop_cleaning
SET Opsys = CASE
    WHEN LOWER(opsys) LIKE '%windows%' THEN 'Windows'
    WHEN LOWER(opsys) LIKE '%mac%' THEN 'Mac Os'
    WHEN LOWER(Opsys) LIKE '%chrome%' THEN 'Chrome OS'
    WHEN LOWER(opsys) LIKE '%linux%' THEN 'Linux'
    WHEN LOWER(opsys) LIKE '%android%' THEN 'Android'
    WHEN LOWER(opsys) LIKE '%no os%' THEN 'No OS'
    ELSE opsys
END;

--Clean weight column
UPDATE laptop_cleaning
SET weight = TRIM(TRAILING 'kg' FROM weight);

ALTER TABLE laptop_cleaning
ALTER COLUMN weight TYPE NUMERIC USING NULLIF(weight, '')::NUMERIC;


-- drop unused columns
ALTER TABLE laptop_data_cleaned
DROP COLUMN IF EXISTS gpu_graphics,
DROP COLUMN IF EXISTS memory_storage;

SELECT 
  COUNT(*) - COUNT(company) AS null_company,
  COUNT(*) - COUNT(inches) AS null_inches,
  COUNT(*) - COUNT(cpu) AS null_cpu,
  COUNT(*) - COUNT(ram) AS null_ram,
  COUNT(*) - COUNT(opsys) AS null_opsys,
  COUNT(*) - COUNT(weight) AS null_weight
FROM laptop_cleaning; 


-- replace null storage value with 0
UPDATE laptop_cleaning
SET 
    ssd_capacity = COALESCE(ssd_capacity, 0),
    hdd_capacity = COALESCE(hdd_capacity, 0),
    flash_storage = COALESCE(flash_storage, 0);

SELECT *
FROM laptop_cleaning
WHERE weight IS NULL;

-- we know DELL WORKSTATION mising scrren resolution is 15.6"
UPDATE laptop_cleaning
SET inches = 15.6
WHERE company = 'Dell'
  AND unnamed in (476)
  AND inches IS NULL;

-- missing weight 
SELECT *
FROM laptop_cleaning
WHERE weight IS NULL;

--Fill missing weights with mean per type
UPDATE laptop_cleaning AS l
SET weight = sub.avg_weight
FROM (
    SELECT typename, AVG(weight) AS avg_weight
    FROM laptop_cleaning
    WHERE weight IS NOT NULL
    GROUP BY typename
) AS sub
WHERE l.typename = sub.typename
  AND l.weight IS NULL;

SELECT *
FROM laptop_cleaning
WHERE unnamed IN (208);

-- CPU 
ALTER TABLE laptop_cleaning
ADD COLUMN IF NOT EXISTS cpu_details TEXT;

UPDATE laptop_cleaning
SET cpu_details = TRIM(
    REGEXP_REPLACE(cpu, '^(Intel|AMD)\s+', '', 'gi')       -- remove brand
);

UPDATE laptop_cleaning
SET cpu_details = TRIM(
    REGEXP_REPLACE(cpu_details, '\s+[0-9.]+GHz$', '', 'gi')       -- remove last clock speed
);

SELECT cpu, cpu_details
FROM laptop_cleaning
LIMIT 10;

SELECT *
FROM laptop_cleaning
WHERE unnamed in (476); 


-- fix all the data type
ALTER TABLE laptop_cleaning
ALTER COLUMN inches TYPE NUMERIC USING inches::NUMERIC,
ALTER COLUMN ram TYPE INT USING ram::INT,
ALTER COLUMN weight TYPE NUMERIC USING weight::NUMERIC,
ALTER COLUMN price TYPE NUMERIC USING price::NUMERIC,
ALTER COLUMN px_width TYPE INT USING px_width::INT,
ALTER COLUMN px_height TYPE INT USING px_height::INT,
ALTER COLUMN clock_speed TYPE NUMERIC USING clock_speed::NUMERIC,
ALTER COLUMN ssd_capacity TYPE NUMERIC USING ssd_capacity::NUMERIC,
ALTER COLUMN hdd_capacity TYPE NUMERIC USING hdd_capacity::NUMERIC,
ALTER COLUMN flash_storage TYPE NUMERIC USING flash_storage::NUMERIC,
ALTER COLUMN ssd_count TYPE INT USING ssd_count::INT,
ALTER COLUMN hdd_count TYPE INT USING hdd_count::INT;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'laptop_cleaning'
ORDER BY column_name;

CREATE TABLE laptop_cleaning_backup AS
SELECT *
FROM laptop_cleaning; 

