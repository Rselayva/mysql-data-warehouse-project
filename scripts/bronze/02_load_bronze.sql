/*
===============================================================================
Load Data: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This script loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `LOAD DATA INFILE` command to load data from CSV Files to bronze tables.

Parameters:
    None. 
	This script does not accept any parameters or return any values.

Environment Configuration: 
	This script uses MySQL 'LOAD DATA INFILE' to import raw dataset files.
	Based on your local setup, please update the paths below to match your 
	MySQL 'secure_file_priv' directory.

- Windows Default: 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets'
===============================================================================
*/

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_crm_cust_info;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/cust_info.csv'
INTO TABLE datawarehouse_bronze.bz_crm_cust_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_id, @v_key, @v_firstname, @v_lastname, @v_marital_status, @v_gndr, @v_date )
SET 
    cst_id             = NULLIF(TRIM(@v_id), ''),
    cst_key            = NULLIF(TRIM(@v_key), ''),
    cst_firstname      = NULLIF(TRIM(@v_firstname), ''),
    cst_lastname       = NULLIF(TRIM(@v_lastname), ''),
    cst_marital_status = NULLIF(TRIM(@v_marital_status), ''),
    cst_gndr           = NULLIF(TRIM(@v_gndr), ''),
	cst_create_date    = NULLIF(TRIM(@v_date), '');

SET SESSION sql_mode = DEFAULT;

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_crm_prd_info;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/prd_info.csv'
INTO TABLE datawarehouse_bronze.bz_crm_prd_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_prd_id, @v_prd_key, @v_prd_nm, @v_prd_cost, @v_prd_line, @v_prd_start_dt, @v_prd_end_dt )
SET 
    prd_id       = NULLIF(TRIM(@v_prd_id), ''),
    prd_key      = NULLIF(TRIM(@v_prd_key), ''),
    prd_nm       = NULLIF(TRIM(@v_prd_nm), ''),
    prd_cost     = NULLIF(TRIM(@v_prd_cost), ''),
    prd_line     = NULLIF(TRIM(@v_prd_line), ''),
    prd_start_dt = NULLIF(TRIM(@v_prd_start_dt), ''),
    prd_end_dt   = NULLIF(TRIM(@v_prd_end_dt), '');

SET SESSION sql_mode = DEFAULT;

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_crm_sales_details;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/sales_details.csv'
INTO TABLE datawarehouse_bronze.bz_crm_sales_details
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_sls_ord_num, @v_sls_prd_key, @v_sls_cust_id, @v_sls_order_dt, @v_sls_ship_dt, @v_sls_due_dt, @v_sls_sales, @v_sls_quantity, @v_sls_price )
SET 
    sls_ord_num  = NULLIF(TRIM(@v_sls_ord_num), ''),
    sls_prd_key  = NULLIF(TRIM(@v_sls_prd_key), ''),
    sls_cust_id  = NULLIF(TRIM(@v_sls_cust_id), ''),
    sls_order_dt = NULLIF(TRIM(@v_sls_order_dt), ''),
    sls_ship_dt  = NULLIF(TRIM(@v_sls_ship_dt), ''),
    sls_due_dt   = NULLIF(TRIM(@v_sls_due_dt), ''),
    sls_sales    = NULLIF(TRIM(@v_sls_sales), ''),
    sls_quantity = NULLIF(TRIM(@v_sls_quantity), ''),
    sls_price    = NULLIF(TRIM(@v_sls_price), '');

SET SESSION sql_mode = DEFAULT;

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_erp_CUST_AZ12;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE datawarehouse_bronze.bz_erp_CUST_AZ12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_cid, @v_bdate, @v_gen )
SET 
    cid   = NULLIF(TRIM(@v_cid), ''),
    bdate = NULLIF(TRIM(@v_bdate), ''),
    gen   = NULLIF(TRIM(@v_gen), '');

SET SESSION sql_mode = DEFAULT;

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_erp_LOC_A101;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/LOC_A101.csv'
INTO TABLE datawarehouse_bronze.bz_erp_LOC_A101
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_cid, @v_cntry )
SET 
    cid   = NULLIF(TRIM(@v_cid), ''),
    cntry = NULLIF(TRIM(@v_cntry), '');

SET SESSION sql_mode = DEFAULT;

SET SESSION sql_mode = '';

TRUNCATE TABLE datawarehouse_bronze.bz_erp_PX_CAT_G1V2;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE datawarehouse_bronze.bz_erp_PX_CAT_G1V2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'          
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
( @v_id, @v_cat, @v_subcat, @v_maintenance )
SET 
    id          = NULLIF(TRIM(@v_id), ''),
    cat         = NULLIF(TRIM(@v_cat), ''),
    subcat      = NULLIF(TRIM(@v_subcat), ''),
    maintenance = NULLIF(TRIM(@v_maintenance), '');

SET SESSION sql_mode = DEFAULT;