/*
=============================================================
Create Three Layers Database
=============================================================
Script Purpose: 
	This script initializes the Medallion Architecture by creating three distinct MySQL databases: 
    'DataWarehouse_Bronze', 'DataWarehouse_Silver', and 'DataWarehouse_Gold'. If these databases 
    already exist, they will be dropped and recreated to ensure a clean environment.

WARNING: 
	Running this script will drop the entire database if they exist. All data in these three databases
    will be permanently deleted. Proceed with caution and ensure you have proper backups before running 
    this script.
*/

DROP DATABASE IF EXISTS DataWarehouse_Bronze;

CREATE DATABASE DataWarehouse_Bronze;

DROP DATABASE IF EXISTS DataWarehouse_Silver;

CREATE DATABASE DataWarehouse_Silver;

DROP DATABASE IF EXISTS DataWarehouse_Gold;

CREATE DATABASE DataWarehouse_Gold;