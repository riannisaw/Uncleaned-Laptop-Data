-- At first, I will split the data into categorical and numerical.
-- Then, I want to check on the data distribution, wrong values, and outliers.
-- After that, I will check on the skewness, and finally, I will check on correlation and feature engineering.
-- We may use methods like Winsorization and power transformations for example if it was needed.
-- After all this, I will start making pipelines to do these preprocessing steps in them.

SELECT *
FROM laptop_cleaning_backup
WHERE ssd_capacity = 0 
    AND hdd_capacity = 0
    and flash_storage = 0;