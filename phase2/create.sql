-- soroush jahanian
-- 983112034

-- create
create table terminal
 (terminal_name varchar (20) not null,
 city varchar (20) not null,
 t_location varchar (50),
 terminal_id  serial primary key,
 company_id serial);
 

create table payment
(price numeric(10,2),
 payment_type varchar(15),
 bank varchar(15),
 payment_date date,
 payment_time time,
 traveller_id serial,
 payment_id serial primary key
 -- foreign key (travelller_id) references traveller (traveller_id) on delete cascade
 );
 
 create table travel
 (origin varchar(20),
 destination varchar(20),
 travel_date date,
 travel_time time,
 travel_id serial primary key
 );
 
  create table traveller
 (firstname varchar (20),
 lastname varchar (15),
 national_code numeric (20) not null,
 email varchar(25),
 phone_number numeric(15),
 travel_id serial,
 traveller_id serial primary key,
 foreign key (travel_id) references travel (travel_id) on delete cascade
 );
 
  create table bus
(plaque varchar (15),
 capacity numeric(5),
 bus_type varchar(15),
 color varchar(10),
 company_name varchar(15),
 -- rating numeric (1),
 bus_id serial primary key
--  foreign key (rating) references rating(rate) on delete cascade,
 );
 
 create table ticket
(seat_number numeric(3),
 travel_date date,
 travel_time time,
 travel_id serial,
 bus_id serial,
 ticket_id serial primary key,
 payment_id serial,
 foreign key (travel_id) references travel (travel_id) on delete cascade,
 foreign key (bus_id) references bus (bus_id) on delete cascade,
 foreign key (payment_id) references payment (payment_id) on delete cascade
 );

create table employee
 (firstname varchar (20),
 lastname varchar (15),
 national_code numeric (20) not null,
 job_type varchar (20) not null, 
 salary numeric (10,2),
 -- rating numeric (1),
 employee_id serial primary key,
 terminal_id serial,
--  foreign key (rating) references rating (rate) on delete cascade,
 foreign key (terminal_id) references terminal (terminal_id) on delete cascade);
 
-- create table rating
--  (rate numeric (1),
--  rating_id serial primary key);


create table company
 (company_name varchar (15),
 bus_counter numeric(7),
 travel_id serial,
 bus_id serial,
 ticket_id serial,
 terminal_id serial,
 company_id serial primary key,
 -- rating numeric (1),
 foreign key (terminal_id) references terminal (terminal_id) on delete cascade,
 foreign key (bus_id) references bus (bus_id) on delete cascade,
 foreign key (travel_id) references travel (travel_id) on delete cascade,
 foreign key (ticket_id) references ticket (ticket_id) on delete cascade
 -- foreign key (rating) references rating (rate) on delete cascade,
 );



-- drop 
drop table if exists terminal cascade;
drop table if exists employee cascade;
drop table if exists company cascade;
drop table if exists travel cascade;
drop table if exists traveller cascade;
drop table if exists ticket cascade;
drop table if exists payment cascade;
drop table if exists bus cascade;
drop table if exists rating cascade;
