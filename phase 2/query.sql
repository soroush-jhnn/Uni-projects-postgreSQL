-- soroush jahanian
-- 983112034

select bus_type from bus
where color='yellow';


-- EXCEPT : blue buses with more than 100 capacity
(select * from bus where color = 'blue')
except 
(select * from bus where capacity > 100);


-- INTERSECT : select buses between 50 and 150 capacity
(select * from bus where capacity > 50)
intersect 
(select * from bus where capacity < 150);


-- 	JOIN : select all permutations
select * from terminal, company;
select * from employee, terminal, bus;


-- NATURAL JOIN: tuples with all permutations where same columns have same values
select price from payment natural join traveller
where bank= 'bank2';

-- LEFT OUTHER JOIN
select * from travel as T1 left join traveller as T2 on T1.travel_id = T2.travel_id;

-- RIGH OUTHER JOIN
select * from ticket as T right join payment as P on T.payment_id = P.payment_id;

-- Full OUTHER JOIN
select * from bus as B full join ticket as T on B.bus_id = T.bus_id;

	
-- GROUP BY 
select price from payment natural join traveller group by traveller_id, price;

-- ORDER BY:
select * from travel order by travel_date asc;
select * from travel order by travel_time desc;


-- COUNT : counf of all travellers whose traveller_id=2
select count(travel_id) as T from travel natural join traveller where traveller_id = 2;


-- AVG : average capacity of busses
select avg(capacity) avg_caps from bus;


-- SUM : sum of capacity of all busses
select sum(capacity) as total_caps from bus;


-- MAX
select ('2022\2\1' - min(travel_date))/365 as max_d from ticket;
select * from ticket where travel_date = (select min(travel_date) as max_d from ticket);


-- ALL : the bus which it's capacity is bigger than all other busses(maximum)
select * from bus where capacity >= all (select capacity from bus);


-- ANY : 
select * from bus where capacity > any (select capacity from bus natural join company );


-- IN : selects books who are of horror genre
select * from bus where bus_id in (select bus_id from bus where color ='blue');


