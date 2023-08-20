-- soroush jahanian
-- 983112034

-- UDF
-- 1)
-- returns travellers with id more than 4 else returns travellers with id more than 2
CREATE FUNCTION ID_4_2() 
RETURNS TABLE (firstname character VARying, lastname character VARying, traveller_id integer) 
AS 
$$
BEGIN
		RETURN QUERY SELECT T.firstname, T.lastname, T.traveller_id FROM "traveller" T WHERE T.traveller_id > 4;
		IF NOT FOUND THEN	
		RETURN QUERY SELECT T.firstname, T.lastname, T.traveller_id FROM "traveller" T WHERE T.traveller_id > 2;
		END IF;		
END;
$$ LANGUAGE plpgsql;

SELECT ID_4_2();

-- 2)
-- editing bus
CREATE OR REPLACE FUNCTION update_bus(
	_capacity		INTEGER
) RETURNS void AS 
$$
	
BEGIN
	UPDATE "bus" 
	SET capacity = _capacity
	WHERE capacity = 100;
END;
$$ LANGUAGE plpgsql;

SELECT update_bus(100);
SELECT * FROM "bus";

-- 3)
CREATE OR REPLACE FUNCTION priceluxury(price integer) RETURNS VARCHAR(10) AS $$
 DECLARE
  BEGIN 
     IF price <= 5 THEN
            return 'VIP';
	 ELSIF price <= 10 THEN	 
            return 'VVIP';
	 ELSEIF price <= 15 THEN
            return 'CIP';
	 ELSE 
            return 'unsupported';
	 END IF;	
END;
$$ LANGUAGE plpgsql;

SELECT priceluxury(2);
SELECT priceluxury(7);
SELECT priceluxury(12);
SELECT priceluxury(19);

-- SP
-- 1)
-- increase salary 
CREATE OR REPLACE PROCEDURE increase_salary(
	current_salary numeric(10, 2))
LANGUAGE plpgsql    
AS 
$$
BEGIN
     UPDATE employee SET salary = salary + current_salary;
    COMMIT;
END;
$$;
call increase_salary(40.30);
select salary from employee;

-- 2)
CREATE OR REPLACE PROCEDURE originError(origin varchar(20), destination varchar(20))
LANGUAGE plpgsql    
AS 
$$
BEGIN
	IF origin = destination
 	   THEN RAISE EXCEPTION 'You can not have same origin and destination';
	end if;
    COMMIT;
END;
$$;

call originError('city1', 'city1');
call originError('city1', 'city2');
select * from travel;

-- Trigger
-- 1)
-- trigger that updates id of buses
CREATE OR REPLACE FUNCTION updateId() RETURNS TRIGGER AS $$
DECLARE record Record;
	BEGIN
		UPDATE "bus" SET bus_id = bus_id+1
		WHERE company_name = OLD.company_name;
		RETURN NULL;
	END;	
$$ LANGUAGE plpgsql;

CREATE TRIGGER updateIdTrigger 
AFTER INSERT OR UPDATE ON "bus"       
 FOR EACH ROW EXECUTE 
PROCEDURE updateId();  

-- 2)
-- trigger do not allow inserting buses with type equal "type2"
CREATE OR REPLACE FUNCTION restrictBusModel() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.bus_type = 'type2' THEN 
		RAISE EXCEPTION 'unlimited moldel';
	RETURN NULL;
    END IF; 
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER restrictBusModelTrigger
BEFORE INSERT OR UPDATE ON "bus"
FOR EACH ROW
EXECUTE PROCEDURE restrictBusModel(); 

-- 3)
CREATE OR REPLACE FUNCTION deleteTravell()
RETURNS trigger AS $$ 
BEGIN 
	IF OLD.travel_date='2020-08-08'
 	   THEN RAISE EXCEPTION 'You are not allowed to delete the Reserved travels in date = 2020-08-08.';
	end if;
    RETURN NULL;	
END;
$$ LANGUAGE plpgsql; 

CREATE TRIGGER deleteTravellTrigger 
BEFORE DELETE ON "travel" 
FOR EACH ROW 
EXECUTE PROCEDURE deleteTravell(); 

delete  from "travel" where travel_date='2020-08-08'
delete  from "travel" where travel_date='2020-09-09'

-- 4)
CREATE OR REPLACE FUNCTION uppperName() RETURNS TRIGGER AS $$
BEGIN
	NEW.terminal_name = UPPER(NEW.terminal_name);
	NEW.city = UPPER(NEW.city);
	NEW.t_location = UPPER(NEW.t_location);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  uppperNameTrigger
	BEFORE INSERT ON "terminal"
FOR EACH ROW
EXECUTE PROCEDURE uppperName();

INSERT INTO "terminal" VALUES('teminal6', 'city6', 'location6');
select * from "terminal" 

-- 5)
CREATE OR REPLACE FUNCTION upgradepay() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.payment_id > 3 THEN 
	NEW.payment_id = NEW.payment_id + 5;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER upgradepayTrigger
	BEFORE INSERT ON "payment"
FOR EACH ROW
EXECUTE PROCEDURE upgradepay();

INSERT INTO "payment" VALUES('12', 'cash', 'bank4', '2021-11-10', '02:03:04');
SELECT * FROM "payment"

-- Cursor
-- 1)
-- show message contain name of companies with id less than 3
Create OR Replace Function get_id_3() RETURNS void AS $$
	declare company RECORD;
	declare name character VARying;
	declare CompCursor Cursor For (select C.company_id, C.company_name from "company" C 
									where company_id < 3);
Begin
	OPEN CompCursor;
	Loop
		Fetch CompCursor into company;
			If not found then exit;
			end if;
		Raise NOTICE 'Name:%', company.company_name;
	End Loop;
End
$$
Language plpgsql;

select * from  get_id_3();

-- 2)
Create OR Replace Function show_traveller() RETURNS void AS $$
	declare traveller RECORD;
	DECLARE firstname varchar(20);
	DECLARE lastname varchar(20);
	declare trCursor Cursor For (SELECT T.firstname, T.lastname, T.national_code 
							FROM "traveller" T where T.firstname = 'firstname1');
Begin
	OPEN trCursor;
	Loop
		Fetch trCursor into firstname , lastname;
			If not found then exit;
			end if;
		Raise NOTICE 'firstanme:% lastname:%', traveller.firstname, traveller.lastname;
	End Loop;
End
$$
Language plpgsql;

SELECT * FROM "traveller"

-- Transaction
-- 1)
BEGIN TRANSACTION;
	UPDATE "bus" SET capacity = capacity + 10 WHERE company_name = 'company1';
	UPDATE "bus" SET capacity = capacity - 5 WHERE company_name = 'company2';
	UPDATE "bus" SET capacity = capacity - 10 WHERE company_name = 'company3';
	UPDATE "bus" SET capacity = capacity + 5 WHERE company_name = 'company4';
COMMIT;

-- 2)
SELECT * FROM travel;
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	INSERT INTO travel VALUES('origin5', 'destination5', '2021-09-08', '05:11:11');
COMMIT;
SELECT * FROM travel;

-- View
-- 1)
CREATE VIEW averageCap AS 
	 SELECT b.plaque, b.bus_id, AVG(b.capacity) FROM bus b 
	GROUP BY b.bus_id
	
--2
CREATE VIEW remainDate AS
	SELECT t.travel_id, EXTRACT(YEAR FROM age(now()::date, t.travel_date::date)) as date FROM travel t;

DROP VIEW averageCap;
DROP VIEW remainDate;

SELECT * FROM averageCap;
SELECT * FROM remainDate;