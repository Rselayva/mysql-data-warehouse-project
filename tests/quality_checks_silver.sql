-- =============================================================
-- Checking slv_crm_cust_info
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
-- Checking slv_crm_prd_info
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

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Result
SELECT
	*
FROM datawarehouse_silver.slv_crm_prd_info
WHERE prd_end_dt < prd_start_dt;














