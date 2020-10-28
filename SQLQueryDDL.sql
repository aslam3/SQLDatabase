use master;
go
if DB_ID('Shoping_Mall_Management') is not null
    drop database Shoping_Mall_Management;
go

create database Shoping_Mall_Management;
go
use Shoping_Mall_Management
go
--------------create table----------
create table Floor
(
  ID int identity primary key,
  F_Level varchar(30)
)

create table Stall
(
  ID int identity primary key,
  StallNo int ,
  StallName varchar(50),
  StallVolume int ,
  S_Floor int references Floor(ID),

)
Create table Stall_Manager
(
  ID int identity primary key,
  ManagerName varchar(30),
  M_Stall int references Stall(ID)
)
create table Rent_Details
(
  ID int identity primary key,
  RentalSector varchar(50),
  Rent money
)
go
Create table Rental_Rechord
(
  ID int identity primary key,
  Stall_Id int references Stall(ID),
  Stall_Rent money ,
  Electricity_bill money,
  Rent_Date datetime
)


go
create table Accounts
(
  ID int identity primary key,
  Stall_Id int references Stall(ID),
  Total_Rent money,
  Total_Recive money,
  Total_Due money
)
go
Create table Salary
(
  ID int identity primary key,
  Designation varchar (50),
  Salary money,
  Medical money,
  HouseRent money
)



go
create Table Employee
(
  ID int identity primary key,
  Name varchar(50),
  DesigID int references Salary(ID),
  TotalSalary money,
    
  Join_Date datetime 
)
go
Create table Expenditure
(
  ID int identity primary key,
  Expend_Sector varchar(50),
  Total_Amount money
)
go
-------------create trigger------------
create trigger tr_exp
on Employee
for insert,update,delete
As
Begin
	declare @t int,@head varchar(25)
	select @t= sum(TotalSalary) from Employee
	select @head= Expend_Sector from Expenditure
	 if @head='Totalsalary'
		begin
			
			update Expenditure set Total_Amount=@t where Expend_Sector='Totalsalary'
		end
	else
		
		insert into Expenditure values ('Totalsalary',@t)
	 
End
go

-------------create Stor procedure for insert-------------

create proc Sp_floor
@flevel varchar(30)
as
begin
insert into Floor values(@flevel)
end
go

Create proc Sp_stall
@sno int , @name varchar(50), @vlm int , @sf int
 as
  begin 
  insert into Stall values (@sno, @name,@vlm,@sf)
 end
 go 



 create proc Sp_Rentdetails
  @rs varchar(50), @rent money
  as
   begin
    insert into Rent_Details values (@rs,@rent)
   end
  go

  create proc Sp_RentRechord
 @sid int , @rdate datetime
 as
  begin
   declare @volum int,@rent money, @total money,@etotal money,@erent money
   
  select @volum=StallVolume from Stall
  select @rent= Rent from Rent_Details where ID=1
  select @erent=Rent from Rent_Details where ID=2
  select @total=(@volum*@rent)
  select @erent=(@volum*@erent)
  
  insert into Rental_Rechord  values (@sid,@total,@erent,@rdate)
 end
 go






 ---------------With Join-------------
 create proc sp_Employee
@name varchar(30), @desig int, @joindate datetime
as
begin
declare @total money, @salary money, @medical money, @house money

select  @total= salary+(salary*medical)+(salary*houserent)  from Salary
join Employee on Employee.DesigID=Salary.ID
insert into Employee values (@name, @desig,@total, @joindate)
end
go


Create proc sp_Salary 
@desig varchar(30), @salary money, @med money, @hrent money
as
begin 
insert into Salary values (@desig, @salary, @med, @hrent)
end
go


create proc sp_Stallmanager
@mname varchar(30), @mstall int 
as
begin
insert into Stall_Manager values (@mname,@mstall)
end
go


-----------------
create proc sp_Accounts
@sid int , @recive money
as
begin
declare @total money, @srent money ,@ebill money , @security money,@service money

select @ebill= Electricity_bill from Rental_Rechord
select @security=Rent from Rent_Details where ID=3
select @service= Rent from Rent_Details where ID=4
select @srent= Stall_Rent from Rental_Rechord
select @total= (@ebill+@srent+@security+@service)

insert into Accounts values (@sid, @total,@recive)
end


go

----------------
create proc sp_Expenditure 
@exsect varchar(50), @total money
as
begin 

insert into Expenditure values (@exsect, @total)
end
go


---------------create after inserted trigger--------------
create trigger tr_account
on Accounts
After  insert 

as
begin
declare @trent money, @trecive money, @tdue money ,@aid int
select @aid = ID from inserted
select @trent = Total_Rent from inserted
select @trecive = Total_Recive from inserted
select @tdue = Total_Due from inserted


 update Accounts set Total_Due= (Total_Rent - @trecive) where ID=@aid
 end
 go



 ----------create table valued function ------------
 create function fn_stallManager(@id int)
 returns table
 as
 return
     select ManagerName,M_Stall  from Stall_Manager where ID=@id
go

---------------Create view-----------
create view vw_stall
as
select *from Stall where StallVolume>1000
go

---------Create trigger for calculate Employee total salary from Joining with salary table-------
Create trigger tr_EmployeeSalary
on Employee
After insert
As
Begin
 declare @dId int, @sId int,@tSalary money,@emId int
 select @emId= ID from Employee
 Select @dId= DesigID from Employee
 Select @sId= ID from Salary
select  @tSalary= salary+(salary*medical)+(salary*houserent)  from Salary
join Employee on Employee.DesigID=Salary.ID

 Update Employee set TotalSalary=@tSalary where ID=@emId
 end
 go
