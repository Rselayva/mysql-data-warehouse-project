/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script initializes the schema for the Silver Layer (Data Transformation) 
    by creating 6 core source tables within the 'datawarehouse_silver' database.
    Existing tables will be dropped and recreated to ensure a clean state.

WARNING:
    Running this script will DROP existing tables and PERMANENTLY DELETE all 
    contained data. Ensure data is backed up or can be re-ingested from the 
	Bronze Layer.
===============================================================================
*/

DROP TABLE IF EXISTS datawarehouse_silver.bz_crm_cust_info;
CREATE TABLE datawarehouse_silver.bz_crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE,
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS datawarehouse_silver.bz_crm_prd_info;
CREATE TABLE datawarehouse_silver.bz_crm_prd_info (
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS datawarehouse_silver.bz_crm_sales_details;
CREATE TABLE datawarehouse_silver.bz_crm_sales_details (
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
    sls_quantity INT,
    sls_price INT,
	dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS datawarehouse_silver.bz_erp_CUST_AZ12;
CREATE TABLE datawarehouse_silver.bz_erp_CUST_AZ12 (
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50),
	dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS datawarehouse_silver.bz_erp_LOC_A101;
CREATE TABLE datawarehouse_silver.bz_erp_LOC_A101 (
	cid VARCHAR(50),
	cntry VARCHAR(50),
	dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS datawarehouse_silver.bz_erp_PX_CAT_G1V2;
CREATE TABLE datawarehouse_silver.bz_erp_PX_CAT_G1V2 (
	id VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50),
	dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);