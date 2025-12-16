CREATE TABLE laptop_cleaning
    (unnamed TEXT,
    Company TEXT, 
    TypeName TEXT,
    Inches TEXT,
    Screen_Resolution TEXT,
    CPU TEXT,
    RAM TEXT,
    MEMORY TEXT,
    GPU TEXT,
    Opsys TEXT,
    weight TEXT,
    price TEXT
);


\copy laptop_cleaning FROM 'C:\Users\ACER\Downloads\archive (18)\laptopData.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENDODING 'UTF8');

SELECT * FROM laptop_cleaning; 

C:\Users\ACER\Downloads\archive (18)\laptopData.csv


SELECT *
FROM laptop_cleaning
ORDER BY unnamed;

ALTER TABLE laptop_cleaning
ALTER COLUMN price TYPE DECIMAL(10,2);
