DROP TYPE IF EXISTS kennyp.user_role CASCADE;
CREATE TYPE kennyp.user_role AS ENUM ('Admin', 'Customer', 'Employee');

DROP TYPE IF EXISTS kennyp.acc_type CASCADE;
CREATE TYPE kennyp.acc_type AS ENUM ('Checking', 'Savings');

DROP TABLE IF EXISTS kennyp.users CASCADE;
CREATE TABLE kennyp.users (
	
	id SERIAL PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	pwd VARCHAR(50) NOT NULL,
	user_role kennyp.user_role NOT NULL	
);

DROP TABLE IF EXISTS kennyp.accounts CASCADE; 
CREATE TABLE kennyp.accounts (

	id SERIAL PRIMARY KEY,
	balance NUMERIC(50, 2) DEFAULT 0,
--	acc_owner INTEGER NOT NULL REFERENCES kennyp.users(id),
	acc_type kennyp.acc_type NOT NULL,
	active BOOLEAN DEFAULT FALSE -- this determines whether the account has been opened
	
);

DROP TABLE IF EXISTS kennyp.users_accounts_jt CASCADE;
CREATE TABLE kennyp.users_accounts_jt (
	
	id SERIAL PRIMARY KEY,
	acc_owner INTEGER NOT NULL REFERENCES kennyp.users(id) ON DELETE CASCADE,
	account INTEGER NOT NULL REFERENCES kennyp.accounts(id) ON DELETE CASCADE

);

--implement PL/pgsql functional programming LANGUAGE FOR postgres rdbms
--CREATE a FUNCTION so that EVERY time a NEW account IS entered INTO the accounts table

INSERT INTO kennyp.users (username, pwd, user_role)
	VALUES ('Larry', 'pass', 'Employee'),
		   ('Marry', '1234', 'Customer'),
		   ('Barry', 'pass', 'Customer');

SELECT * FROM users;

INSERT INTO kennyp.accounts (balance, acc_owner)
	VALUES (100, 1),
		   (200, 2),
		   (2000, 2),
		   (300, 3);

SELECT * FROM accounts;

INSERT INTO users_accounts_jt (account, acc_owner)
	VALUES (1, 1),
		   (2, 2),
		   (3, 2),
		   (4, 3);

SELECT * FROM users_accounts_jt;

/*
 * The goal is so that Evrytime a new Acocunt is added to account
 * table, the users_accounts_jt is automatically populated with 
 * the acc_owner ID and the account id
 */

/**
 * PL/pgsql Procedural Language for PostgreSQL 
 * 
 * Allows you to create 
 * 		- custom types
 * 		- stored functions (return a result)
 * 		- stored procedures (think of it as a void function) since Postgres 11
 * 		- triggers
 */

/**
 * 
 *  create [or replace] function [name] (params)
 *  returns [type]
 *  as '
 * 		begin
 * 			[logic]
 * 		end
 *  '
 *  language plpgsql;
 * 
 */

-- create a function that inserts the acc_owner id & acc id into the joins table
-- every time a new record is inserted into Accounts table
CREATE OR REPLACE FUNCTION kennyp.auto_insert_into_jt()
RETURNS TRIGGER 
AS '
	BEGIN
		INSERT INTO kennyp.users_accounts_jt (acc_owner, account)	
			VALUES (NEW.acc_owner, NEW.id);
			
			RETURN NEW;
	END
'
LANGUAGE plpgsql;

-- this is a trigger function - the above function is depeNdent on it
CREATE TRIGGER trig 
	AFTER INSERT ON kennyp.accounts
	FOR EACH ROW
	EXECUTE PROCEDURE kennyp.auto_insert_into_jt();

SELECT * FROM kennyp.users;
SELECT * FROM kennyp.accounts;
SELECT * FROM kennyp.users_accounts_jt;

INSERT INTO kennyp.accounts (balance, acc_owner, active)
	VALUES (500000, 4, TRUE);
	
-- user id, username, password, role, account id, account balance, isActive
SELECT users.id, users.username, users.pwd, users.user_role, accounts.id AS account_id, accounts.balance, accounts.active
	FROM  users
	LEFT JOIN users_accounts_jt ON users.id = users_accounts_jt.acc_owner
	LEFT JOIN accounts ON accounts.id = users_accounts_jt.account;