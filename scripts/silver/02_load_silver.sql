-- =============================================================
-- Load datawarehouse_silver.slv_crm_cust_info
-- =============================================================
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
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		ELSE 'n/a'
	END AS cst_marital_status,
    
    -- 3. Normalize gender values to readable format
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
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

-- =============================================================
-- Load datawarehouse_silver.slv_crm_prd_info
-- =============================================================
TRUNCATE TABLE datawarehouse_silver.slv_crm_prd_info;
INSERT INTO datawarehouse_silver.slv_crm_prd_info (
	prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
	prd_id,
    
    -- 1. Extract category ID
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    
    -- 2. Extract product key
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
    
    prd_nm,
    IFNULL(prd_cost, 0) AS prd_cost,
    
    -- 3. Map product line codes to descriptive values
    CASE UPPER(TRIM(prd_line))
		 WHEN 'M' THEN 'Mountain'
		 WHEN 'R' THEN 'Road'
		 WHEN 'S' THEN 'Other Sales'
		 WHEN 'T' THEN 'Touring'
         ELSE 'n/a'
	END AS prd_line,
    
    prd_start_dt,
    
    -- 4. Calculate end date as one day before the next start date
    DATE_SUB(
		LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt), 
		INTERVAL 1 DAY
	) AS prd_end_dt
FROM datawarehouse_bronze.bz_crm_prd_info;

-- =============================================================
-- Load datawarehouse_silver.slv_crm_sales_details
-- =============================================================
TRUNCATE TABLE datawarehouse_silver.slv_crm_sales_details;
INSERT INTO datawarehouse_silver.slv_crm_sales_details (
	sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
    
    -- 1. Convert invalid '0' date values into NULL
    CASE 
		WHEN sls_order_dt = 0 THEN NULL
		ELSE sls_order_dt
    END AS sls_order_dt,
    
    CASE 
		WHEN sls_ship_dt = 0 THEN NULL
		ELSE sls_ship_dt
    END AS sls_ship_dt,
    
    CASE 
		WHEN sls_due_dt = 0 THEN NULL
		ELSE sls_due_dt
    END AS sls_due_dt,
    
    -- 2. Recalculate sales if original value is missing or incorrect
    CASE 
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
			THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales,
    
    sls_quantity,
    
    -- 3. Recalculate price if original value is missing or incorrect
    CASE 
        WHEN sls_price IS NULL OR sls_price <= 0 THEN 
            CASE 
                WHEN sls_quantity IS NULL OR sls_quantity = 0 THEN 0
                ELSE ROUND(sls_sales / sls_quantity, 0)
            END
        ELSE sls_price
    END AS sls_price
FROM datawarehouse_bronze.bz_crm_sales_details;
















