-- Load datawarehouse_silver.slv_crm_cust_info
TRUNCATE TABLE datawarehouse_silver.slv_crm_cust_info;
INSERT INTO datawarehouse_silver.slv_crm_cust_info (
	cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
SELECT
	cst_id,
	cst_key,
    
    -- 1. Trim names to remove extra whitespaces
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
    
    -- 2. Normalize martial status values to readable format
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		 ELSE 'n/a'
	END AS cst_marital_status,
    
    -- 3. Normalize gender values to readable format
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		 ELSE 'n/a'
	END AS cst_gndr,
    
	cst_create_date
FROM (
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_test
	FROM datawarehouse_bronze.bz_crm_cust_info
    WHERE cst_id IS NOT NULL
) t 
WHERE flag_test = 1; -- Select the most recent record for each customer
