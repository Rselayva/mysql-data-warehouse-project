/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'datawarehouse_silver' database. 
    
    It executes validation queries targeting:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Any returned rows indicate data quality issues that require investigation and resolution.
===============================================================================
*/

-- =============================================================
-- Checking datawarehouse_silver.slv_crm_cust_info
-- =============================================================
-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT
	cst_id,
	COUNT(*)
FROM datawarehouse_silver.slv_crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT
	cst_key
FROM datawarehouse_silver.slv_crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT 
	cst_gndr
FROM datawarehouse_silver.slv_crm_cust_info;

-- =============================================================
-- Checking datawarehouse_silver.slv_crm_prd_info
-- =============================================================
-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT
	prd_id,
	COUNT(*)
FROM datawarehouse_silver.slv_crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted Spaces
-- Expectation: No Result
SELECT 
	prd_nm
FROM datawarehouse_silver.slv_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLS or Negative Numbers
-- Expectation: No Result
SELECT 
	prd_cost
FROM datawarehouse_silver.slv_crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
	prd_line
FROM datawarehouse_silver.slv_crm_prd_info;

-- Check for Invalid Date Orders (End Date Earlier than Start Date)
-- Expectation: No Result
SELECT
	*
FROM datawarehouse_silver.slv_crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- =============================================================
-- Checking datawarehouse_silver.slv_crm_prd_info
-- =============================================================
-- Check for Invalid Date
-- Expectation: No Result
SELECT
	sls_due_dt
FROM datawarehouse_silver.slv_crm_sales_details
WHERE sls_due_dt <= 0
   OR sls_due_dt > '20500101'
   OR sls_due_dt < '19000101';

-- Check for Invalid Date Orders (Shipping Date or Due Date Earlier than Order Date)
-- Expectation: No Invalid Date 
SELECT
	*
FROM datawarehouse_silver.slv_crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Between Sales, Quantity, and Price
-- Expectation: No Result
SELECT DISTINCT
	sls_sales,
    sls_quantity,
    sls_price
FROM datawarehouse_silver.slv_crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- =============================================================
-- Checking datawarehouse_silver.slv_erp_cust_az12
-- =============================================================
-- Identify Out-of-Range Birth Dates
-- Removed Future Dates Only
SELECT
	bdate
FROM datawarehouse_silver.slv_erp_cust_az12
WHERE bdate <= 0
OR    bdate > CURDATE()
OR    bdate < '1926-01-01';

-- Data Standardization & Consistency
SELECT DISTINCT 
	gen
FROM datawarehouse_silver.slv_erp_cust_az12;

-- =============================================================
-- Checking datawarehouse_silver.slv_erp_loc_a101
-- =============================================================
-- Data Standardization & Consistency
SELECT DISTINCT
	cntry
FROM datawarehouse_silver.slv_erp_loc_a101
ORDER BY cntry;

-- =============================================================
-- Checking datawarehouse_silver.slv_erp_px_cat_g1v2
-- =============================================================
-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT 
    * 
FROM datawarehouse_silver.slv_erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT 
    maintenance 
FROM datawarehouse_silver.slv_erp_px_cat_g1v2;




