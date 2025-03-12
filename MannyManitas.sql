
create table ITEM (
ItemID int identity primary key,
Category varchar(50) not null,
NameItem varchar(50) not null,
Price smallmoney not null)


create table INVENTORY (
BinID int identity primary key,
ItemID int not null,
Stock int not null,
DateRecounting datetime not null,
PeriodRecounting tinyint not null,
foreign key (ItemID) references ITEM(ItemID))


create table SUPPLIER (
CompanyID int identity primary key,
CompanyName varchar(50) not null,
Address varchar(100) not null,
ContactName varchar(50) not null,
Country varchar(50) not null,
City varchar(50) not null,
PostalCode char(4) not null,
PhoneNo char(9) not null,
check (PostalCode like '[0-9][0-9][0-9][0-9]'),
check (PhoneNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))


create table SALESMAN (
SalesmanID int identity primary key,
FirstName varchar(50) not null,
LasName varchar(50) not null,
CompanyID int not null,
foreign key (CompanyID) references SUPPLIER(CompanyID))


create table SUPLY (
SalesmanID int not null,
ItemID int not null,
Discount tinyint not null,
PriceCost money not null,
foreign key (ItemID) references ITEM(ItemID),
foreign key (SalesmanID) references SALESMAN(SalesmanID))


create table CUSTOMER (
CustomerID int identity primary key,
Address varchar(100) not null,
FirstName varchar(50) not null,
LasName varchar(50) not null,
Email varchar(100) unique not null,
check (Email like '_%@_%._%'))


create table ORDER (
OrderID int identity primary key,
OrderDate datetime not null,
Status varchar not null,
ShippingID int not null)