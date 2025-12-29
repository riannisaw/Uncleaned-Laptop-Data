-- Check what columns you have
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'laptop_cleaning';

-- Count missing values per column
SELECT
  COUNT(*) AS total_rows,
  COUNT(unnamed) AS unnamed_not_null,
  COUNT(company) AS company_not_null,
  COUNT(typename) AS typename_not_null,
  COUNT(inches) AS inches_not_null,
  COUNT(screen_resolution) AS screen_not_null,
  COUNT(cpu) AS cpu_not_null,
  COUNT(ram) AS ram_not_null,
  COUNT(memory) AS memory_not_null,
  COUNT(gpu) AS gpu_not_null,
  COUNT(opsys)AS price_not_null,
  COUNT(weight) AS weight_not_null,
  COUNT(price) AS price_not_null
FROM laptop_cleaning;

SELECT *
FROM laptop_cleaning_backup
WHERE memory IS NULL; 

-- count missing value
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(unnamed)AS null_unnamed,
    COUNT(*) - COUNT(company) AS null_company,
    COUNT(*) - COUNT(typename) AS null_typename,
    COUNT(*) - COUNT(inches) AS null_inches,
    COUNT(*) - COUNT(screen_resolution) AS nullscreensize,
    COUNT(*) - COUNT(cpu) AS null_cpu,
    COUNT(*) - COUNT(ram) AS null_ram,
    COUNT(*) - COUNT(memory) AS null_storage,
    COUNT(*) - COUNT(gpu) AS null_gpu,
    COUNT(*) - COUNT(opsys)AS null_opsys,
    COUNT(*) - COUNT(weight) AS null_weight,
    COUNT(*) - COUNT(price) AS null_price
FROM laptop_cleaning;

-- show unique company name
SELECT company,
    COUNT (*) AS company_count
FROM laptop_cleaning-- or laptop_data_cleaned if you didn’t deduplicate yet
WHERE company IS NOT NULL
GROUP BY company
ORDER BY company_count DESC; 

-- show unique data of type_name
SELECT typename,
    COUNT (*) AS typename_count
FROM laptop_cleaning
WHERE typename IS NOT NULL
GROUP BY typename
ORDER BY typename_count DESC;

-- get the list of inches
SELECT inches,
    COUNT (*) as inches_count
FROM laptop_cleaning
WHERE inches IS NOT NULL
GROUP BY inches
ORDER BY inches_count DESC;

-- get the list of screen resolution
SELECT screen_resolution,
    COUNT (*) as screen_count
FROM laptop_cleaning
WHERE screen_resolution IS NOT NULL
GROUP BY screen_resolution
ORDER BY screen_count DESC;

-- get the list of cpu
SELECT cpu,
    COUNT (*) AS cpu_count
FROM laptop_cleaning  
WHERE cpu IS not null
GROUP BY cpu
ORDER BY cpu_count DESC;

-- get the list of ram
SELECT ram,
    COUNT (*) AS ram_count
FROM laptop_cleaning 
WHERE ram IS NOT NULL
GROUP BY ram
ORDER BY ram_count DESC;
 

-- RAM 1 GB Windows 10 Can't run on it
-- RAM 2 GB Windows 10 can possibly run
-- RAM 4GB, 8GB, 24GB, 32GB, 64GB

-- 1GB laptops (very low-end)
SELECT *
FROM laptop_cleaning
WHERE ram = '1GB';

DELETE FROM laptop_cleaning WHERE
ram = '1GB';

-- 2GB laptops (low-end but possible)
SELECT *
FROM laptop_cleaning
WHERE ram = '2GB';

-- 4GB, 8GB, 16gb mid-end 
SELECT *
FROM laptop_cleaning
WHERE ram IN ('4GB','8GB','16GB');

-- 24GB, 32GB, 64GB (high-end)
SELECT *
FROM laptop_cleaning
WHERE ram IN ('24GB', '32GB', '64GB');

--memory has ?
SELECT *
FROM laptop_cleaning
WHERE memory In ('?'); 

-- memory has flash storage , hdd and ssd -- three cols can be created.
-- id 903,824,609,319 -- their flash storage means ssd along with all the apple devices.
-- id 447 has both flash storage and hdd

-- get the list of memory
SELECT DISTINCT memory,
    COUNT (*) AS memory_count
FROM laptop_cleaning
WHERE memory IS NOT NULL
GROUP BY memory
ORDER BY memory_count DESC; 

SELECT *
FROM laptop_cleaning
WHERE LOWER(memory) LIKE '%flash%';

SELECT company,
    COUNT (*) AS flash_laptops
FROM laptop_cleaning
WHERE LOWER(memory) LIKE '%flash%'
    AND company <> 'Apple'
GROUP BY company
ORDER BY flash_laptops DESC; 

SELECT *
FROM laptop_cleaning
WHERE LOWER(memory) LIKE '%flash%'
    AND company <> 'Apple';


-- get the list of gpu
SELECT DISTINCT gpu,
    COUNT (*) AS gpu_count
FROM laptop_cleaning  
WHERE gpu IS NOT NULL
GROUP BY gpu
ORDER BY gpu_count DESC;

-- get the list of opsys
SELECT DISTINCT Opsys,
    COUNT (*) AS opsys_count
FROM laptop_cleaning
WHERE opsys IS NOT NULL
GROUP BY opsys
ORDER BY opsys_count DESC;

-- Android get the least out of any opsys, it shows consistency in this data
-- show the details of android
SELECT *
FROM laptop_data_cleaned
WHERE LOWER(operation_system) LIKE '%android%';

SELECT weight,
    COUNT (*) AS weight_count
FROM laptop_cleaning
WHERE weight IS NULL
GROUP BY weight;

--copy before delete all NULL
CREATE TABLE laptop_cleaned_copy As
SELECT * FROM laptop_cleaning;

-- delete NULL
DELETE FROM laptop_cleaning
WHERE unnamed IS NULL 
    OR company IS NULL
   OR typename IS NULL
   OR inches IS NULL
   OR screen_resolution IS NULL
   OR cpu IS NULL
   OR ram IS NULL
   OR memory IS NULL
   OR gpu IS NULL
   OR opsys IS NULL
   OR weight IS NULL
   OR price IS NULL;

SELECT * FROM laptop_cleaning;