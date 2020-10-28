use Shoping_Mall_Management

go
    exec Sp_floor '1st Floor'
    exec Sp_floor '2nd Floor'
    exec Sp_floor '3rd Floor'
    exec Sp_floor '4th Floor'
    exec Sp_floor '5th Floor'
go
------Execute sp_stall------------
exec Sp_stall 101, 'Smart Cosmetics',  1200,1
 exec Sp_stall 102, 'Prince Supper',    1000,1
 exec Sp_stall 103, 'Baby Shope',       2400,1
 exec Sp_stall 101, 'Toy House',        1500,1

 exec Sp_stall 201,'Beautiful Boutique',      1200,2
 exec Sp_stall 202,'Eves Ladies Wear Linda ', 1000,2
 exec Sp_stall 203,'Still In Style Boutique', 1200,2
 exec Sp_stall 204,'Anna Bella',              1000,2

 exec Sp_stall 301,'Moores Clothing for Men', 1400,3
 exec Sp_stall 302,'Plus Point',              1600,3
 exec Sp_stall 303,'Easy Buy',                1600,3
 exec Sp_stall 304,'Tuxedo Royale',           1200,3

 exec Sp_stall 401,'BATA',        2000,4
 exec Sp_stall 402,'APEX',        2400,4
 exec Sp_stall 403,'Jenys',       1600,4
 exec Sp_stall 404,'Bay Bay',     1400,4

 exec Sp_stall 501,'SAMSUMG MOBILE',     1400,5
 exec Sp_stall 501,'SYMPHONEY MOBILE',   1600,5
 exec Sp_stall 501,'WALTON',             1800,5
 exec Sp_stall 501,'NOKIA',              1200,5
 ---------
 go
  exec Sp_Rentdetails 'Stall Per 1sqftr',         10
   exec Sp_Rentdetails 'Electricity per 1sqrft',   1
   exec Sp_Rentdetails 'Security',                 500
   exec Sp_Rentdetails 'Sevice charge',            500

 go
 exec Sp_RentRechord  1,'01-02-2019';
 go
exec sp_Employee 'Md Mehadi Hasan',1, '01-01-2019'
exec sp_Employee 'Md Raihan',      2, '01-01-2019'
exec sp_Employee 'Md Hasan Ali',   3, '01-01-2019'
exec sp_Employee 'Md Sumon khan',  4, '01-01-2019'
exec sp_Employee 'Md Sujon',       4, '01-01-2019'
exec sp_Employee 'Md Zubaer khan', 5, '01-01-2019'
exec sp_Employee 'aslam ',    1, '01-01-2019'
go
go
  exec sp_Salary 'Manager',           20000, .05,.2
  exec sp_Salary 'Accounter',         15000, .05,.2
  exec sp_Salary 'Computer Operator', 15000, .05,.2
  exec sp_Salary 'Security',          10000, .05,.2
  exec sp_Salary 'Sweeper',           8000,  .05,.2
go
exec sp_Stallmanager 'MD Khairul islam',  1
exec sp_Stallmanager 'MD Alamin hossain', 2
exec sp_Stallmanager 'MD Sazzad islam',   3
exec sp_Stallmanager 'MD Abul kalam  ',   4
exec sp_Stallmanager 'Shabbir Ahammed',   5
exec sp_Stallmanager 'MD Faysal ',        6
exec sp_Stallmanager 'MD Kamal ',         7
exec sp_Stallmanager 'MD Jakir',          8
exec sp_Stallmanager 'MD Alom',           9
exec sp_Stallmanager 'MD Rakibul islam', 10
exec sp_Stallmanager 'MD Khairul Alom',  11
exec sp_Stallmanager 'MD Habib Uddin',   12
exec sp_Stallmanager 'Tapon Mojumder',   13
exec sp_Stallmanager 'MD Hasan Ali',     14
exec sp_Stallmanager 'MD Raju Ahammed',  15
exec sp_Stallmanager 'MD Turag Hasan',   16
exec sp_Stallmanager 'MD Polas',         17
exec sp_Stallmanager 'Tonmoy Nandi',     18
exec sp_Stallmanager 'Biplop Kumar',     19
exec sp_Stallmanager 'MD Tarikul islam', 20

go

select *from Accounts
go
select * from Employee
go
select *from Expenditure
go
select *from Floor
go
select *from Rent_Details
go
select *from Rental_Rechord
go
select *from Salary
go
select *from Stall
go
select *from Stall_Manager
go

select *from fn_stallManager(5)
go
select *from vw_stall
go
