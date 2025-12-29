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


\copy laptop_cleaning FROM 'C:\Users\ACER\Downloads\Uncleaned Laptop Data\laptopData.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENDODING 'UTF8');

SELECT * FROM laptop_cleaning; 

