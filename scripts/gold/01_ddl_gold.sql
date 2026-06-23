CREATE OR REPLACE VIEW datawarehouse_gold.dim_customer AS
SELECT
	-- 1. Generate a unique Surrogate Key for the Gold Dimension Table
	ROW_NUMBER() OVER (ORDER BY ci.cst_id, ci.cst_key) AS customer_key,
    
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS firstname,
	ci.cst_lastname AS lastname,
    la.cntry AS country,
	ci.cst_marital_status AS marital_status,
    
    -- 2. Resolve conflicting gender info: CRM takes precedence as the Master Source
    CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender info
        ELSE IFNULL(ca.gen, 'n/a')
	END AS gender,
    
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM datawarehouse_silver.slv_crm_cust_info ci
LEFT JOIN datawarehouse_silver.slv_erp_cust_az12 ca
	ON ci.cst_key = ca.cid
LEFT JOIN datawarehouse_silver.slv_erp_loc_a101 la
	ON ci.cst_key = la.cid;








