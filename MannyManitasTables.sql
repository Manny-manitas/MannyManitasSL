--create database MannyManitas
--use MannyManitas

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
PostalCode char(5) not null,
PhoneNo char(9) not null,
check (PostalCode like '[0-9][0-9][0-9][0-9][0-9]'),
check (PhoneNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))


create table SALESMAN (
SalesmanID int identity primary key,
FirstName varchar(50) not null,
LastName varchar(50) not null,
CompanyID int not null,
foreign key (CompanyID) references SUPPLIER(CompanyID))


create table SUPPLY (
SalesmanID int not null,
ItemID int not null,
Discount tinyint not null,
PriceCost money not null,
primary key(SalesmanID, ItemID),
foreign key (ItemID) references ITEM(ItemID),
foreign key (SalesmanID) references SALESMAN(SalesmanID))


create table CUSTOMER (
CustomerID int identity primary key,
Address varchar(100) not null,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Email varchar(100) unique not null,
check (Email like '_%@_%._%'))


create table ORDERS (
OrderID int identity primary key,
OrderDate datetime not null,
Status varchar(9) not null,
CustomerID int not null,
check (Status in ('Pending','Shipped','Delivered','Cancelled')),
foreign key (CustomerID) references CUSTOMER(CustomerID))


create table ORDER_DETAILS (
OrderID int,
ItemID int,
Quantity int not null,
Price smallmoney not null,
ArrivalDate date not null,
primary key(OrderID,ItemID),
foreign key (ItemID) references ITEM(ItemID),
foreign key (OrderID) references ORDERS(OrderID))


create table SHIPPING_METHOD (
OrderID int,
Type varchar(50) not null,
Year char(4) not null,
Cost smallmoney not null,
primary key(OrderID,Type),
foreign key (OrderID) references ORDERS(OrderID),
check (Year like '20[0-2][0-9]'))



