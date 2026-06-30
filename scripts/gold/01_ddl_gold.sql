-- =============================================================
-- Create Dimension: datawarehouse_gold.dim_customers
-- =============================================================
CREATE OR REPLACE VIEW datawarehouse_gold.dim_customers AS
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

-- =============================================================
-- Create Dimension: datawarehouse_gold.dim_products
-- =============================================================
CREATE OR REPLACE VIEW datawarehouse_gold.dim_products AS
SELECT
	-- 1. Generate a Surrogate Key sorted by the internal unique Product ID
	ROW_NUMBER() OVER (ORDER BY pi.prd_start_dt, pi.prd_key) AS product_key,
    
	pi.prd_id AS product_id,
    pi.prd_key AS product_number,
	pi.prd_nm AS product_name,
	pi.cat_id AS category_id,
    pc.cat AS category,
	pc.subcat AS subcategory,
    pc.maintenance AS maintenance,
	pi.prd_cost AS cost,
	pi.prd_line AS product_line,
	pi.prd_start_dt AS start_date
FROM datawarehouse_silver.slv_crm_prd_info pi
LEFT JOIN datawarehouse_silver.slv_erp_px_cat_g1v2 pc
ON pi.cat_id = pc.id
-- 2. Filter out historical data to keep only the currently active products
WHERE pi.prd_end_dt IS NULL;

-- =============================================================
-- Create Dimension: datawarehouse_gold.fact_sales
-- =============================================================
CREATE OR REPLACE VIEW datawarehouse_gold.fact_sales AS
SELECT 
	sd.sls_ord_num AS order_number,
    pr.product_key,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM datawarehouse_silver.slv_crm_sales_details sd

-- 1. JOIN the Gold product view using the unique product number
LEFT JOIN datawarehouse_gold.dim_products pr
ON sd.sls_prd_key = pr.product_number

-- 2. JOIN the Gold customer view using the unique customer ID
LEFT JOIN datawarehouse_gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id;
