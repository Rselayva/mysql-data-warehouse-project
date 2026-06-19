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

-- Expectation: No Result
SELECT cst_key
FROM datawarehouse_silver.slv_crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM datawarehouse_silver.slv_crm_cust_info;
