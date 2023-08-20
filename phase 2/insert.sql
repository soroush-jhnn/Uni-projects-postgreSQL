-- soroush jahanian
-- 983112034

-- delete
delete from terminal cascade;
delete from employee cascade;
delete from company cascade;
delete from travel cascade;
delete from traveller cascade;
delete from ticket cascade;
delete from payment cascade;
delete from bus cascade;
delete from rating cascade;

DELETE FROM employee
WHERE first_name = 'firstname3';

-- show
select * from employee;
select * from terminal;
select * from company;
select * from travel;
select * from traveller;
select * from ticket;
select * from payment;
select * from bus;
select * from rating;

-- insert
insert into terminal(terminal_name, city, t_location)
	values ('teminal1', 'city1', 'location1'),
		   ('teminal2', 'city2', 'location2'),
		   ('teminal3', 'city3', 'location3'),
		   ('teminal4', 'city4', 'location4'),
		   ('teminal5', 'city5', 'location5');

insert into payment(price, payment_type, bank, payment_date, payment_time)
	values ('12', 'cash', 'bank1', '2020-10-10', '02:03:04'),
		   ('15', 'card', 'bank2', '2020-11-11', '03:03:04'),
		   ('16', 'cash', 'bank3', '2020-09-09', '04:03:04'),
		   ('18', 'card', 'bank1', '2020-07-07', '05:03:04');
		   
insert into travel(origin, destination, travel_date, travel_time)
	values ('origin1', 'destination1', '2023-10-10', '02:03:04'),
		   ('origin2', 'destination2', '2023-11-11', '03:03:04'),
		   ('origin3', 'destination3', '2023-09-09', '04:03:04'),
		   ('origin4', 'destination4', '2023-08-08', '05:03:04');
		   
insert into traveller(firstname, lastname, national_code, email, phone_number)
	values ('firstname1', 'lastname1', '123456789', 'firstemail@gmail.com', '111111111'),
		   ('firstname2', 'lastname2', '123456790', 'secondemail@gmail.com', '222222222'),
		   ('firstname3', 'lastname3', '123456791', 'thirdemail@gmail.com', '333333333'),
		   ('firstname4', 'lastname4', '123456792', 'fourthemail@gmail.com', '444444444');			   
		   
insert into bus(plaque, capacity, bus_type, color, company_name )
	values ('12gh123', '110', 'type1', 'blue', 'company1'),
		   ('56jk124', '110', 'type2', 'yellow', 'company2'),
		   ('98rf345', '110', 'type3', 'green', 'company3'),
		   ('00kl189', '110', 'type4', 'blue', 'company4');	
		   
insert into ticket(seat_number, travel_date, travel_time)
	values ('135', '2020-10-10', '02:03:04'),
		   ('101', '2020-11-11', '03:03:04'),
		   ('66', '2020-09-09', '04:03:04'),
		   ('77', '2020-08-08', '05:03:04');
		   
insert into employee(firstname, lastname, national_code, job_type, salary )
	values ('firstname1', 'lastname1', '123456789', 'type1', '1200.25'),
		   ('firstname2', 'lastname2', '123456790', 'type2', '1300.25'),
		   ('firstname3', 'lastname3', '123456791', 'type3', '1400.25'),
		   ('firstname4', 'lastname4', '123456791', 'type4', '1500.25');
		   
insert into company(company_name, bus_counter)
	values ('company1', '123'),
		   ('company2', '125'),
		   ('company3', '1400'),
		   ('company4', '331');		
		 
		   
-- update
UPDATE employee SET job_type = 'type1'
WHERE job_type = 'type2';

UPDATE traveller SET national_code = '123456794'
WHERE national_code = '123456790';

UPDATE payment SET bank = 'bank5'
WHERE bank = 'bank1'
AND payment_type = 'cash';

-- index
-- To create a unique B-tree index on the column company_id in the table terminal
CREATE UNIQUE INDEX c_id ON terminal (company_id);	

-- To create an index with non-default fill factor
CREATE UNIQUE INDEX c2_id ON terminal (company_id) WITH (fillfactor = 70);

-- To create a B-Tree index with deduplication disabled
CREATE INDEX c3_id ON terminal (company_id) WITH (deduplicate_items = off);

