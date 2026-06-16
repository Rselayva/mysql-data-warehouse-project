DROP TABLE IF EXISTS datawarehouse_bronze.bz_crm_cust_info;
CREATE TABLE datawarehouse_bronze.bz_crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE
);

DROP TABLE IF EXISTS datawarehouse_bronze.bz_crm_prd_info;
CREATE TABLE datawarehouse_bronze.bz_crm_prd_info (
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
);

DROP TABLE IF EXISTS datawarehouse_bronze.bz_crm_sales_details;
CREATE TABLE datawarehouse_bronze.bz_crm_sales_details (
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

DROP TABLE IF EXISTS datawarehouse_bronze.bz_erp_CUST_AZ12;
CREATE TABLE datawarehouse_bronze.bz_erp_CUST_AZ12 (
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50)
);

DROP TABLE IF EXISTS datawarehouse_bronze.bz_erp_LOC_A101;
CREATE TABLE datawarehouse_bronze.bz_erp_LOC_A101 (
	cid VARCHAR(50),
	cntry VARCHAR(50)
);

DROP TABLE IF EXISTS datawarehouse_bronze.bz_erp_PX_CAT_G1V2;
CREATE TABLE datawarehouse_bronze.bz_erp_PX_CAT_G1V2 (
	id VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50)
);