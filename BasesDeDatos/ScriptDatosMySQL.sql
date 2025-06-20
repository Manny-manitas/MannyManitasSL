USE [MannyManitas]
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INVENTORY]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVENTORY](
	[BinID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Stock] [int] NOT NULL,
	[DateRecounting] [datetime] NOT NULL,
	[PeriodRecounting] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITEM]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[NameItem] [varchar](50) NOT NULL,
	[Price] [smallmoney] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_DETAILS](
	[OrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [smallmoney] NOT NULL,
	[ArrivalDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [varchar](9) NOT NULL,
	[CustomerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALESMAN]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALESMAN](
	[SalesmanID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[CompanyID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesmanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SHIPPING_METHOD]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHIPPING_METHOD](
	[OrderID] [int] NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Year] [char](4) NOT NULL,
	[Cost] [smallmoney] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUPPLIER]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUPPLIER](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[ContactName] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[PostalCode] [char](5) NOT NULL,
	[PhoneNo] [char](9) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUPPLY]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUPPLY](
	[SalesmanID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Discount] [tinyint] NOT NULL,
	[PriceCost] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesmanID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CUSTOMER] ON 

INSERT [dbo].[CUSTOMER] ([CustomerID], [Address], [FirstName], [LastName], [Email]) VALUES (1, N'Calle Falsa 123', N'Pedro', N'González', N'pedro.gonzalez@email.com')
INSERT [dbo].[CUSTOMER] ([CustomerID], [Address], [FirstName], [LastName], [Email]) VALUES (2, N'Avenida Real 456', N'Ana', N'López', N'ana.lopez@email.com')
INSERT [dbo].[CUSTOMER] ([CustomerID], [Address], [FirstName], [LastName], [Email]) VALUES (3, N'Calle Libertad 789', N'Luis', N'Martínez', N'luis.martinez@email.com')
INSERT [dbo].[CUSTOMER] ([CustomerID], [Address], [FirstName], [LastName], [Email]) VALUES (4, N'Paseo Central 10', N'Marta', N'Hernández', N'marta.hernandez@email.com')
INSERT [dbo].[CUSTOMER] ([CustomerID], [Address], [FirstName], [LastName], [Email]) VALUES (5, N'Calle Sol 21', N'Juan', N'Pérez', N'juan.perez@email.com')
SET IDENTITY_INSERT [dbo].[CUSTOMER] OFF
GO
SET IDENTITY_INSERT [dbo].[ITEM] ON 

INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (1, N'Herramientas', N'Martillo', 12.5000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (2, N'Herramientas', N'Destornillador', 5.7500)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (3, N'Materiales', N'Cemento', 9.9900)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (4, N'Materiales', N'Pintura Blanca', 15.3000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (5, N'Ferretería', N'Tornillos 50mm', 3.4000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (6, N'Herramientas', N'Llave Inglesa', 18.9000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (7, N'Herramientas', N'Alicate', 7.2500)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (8, N'Materiales', N'Yeso', 6.4000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (9, N'Materiales', N'Madera MDF', 22.9900)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (10, N'Ferretería', N'Clavos 30mm', 2.1000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (11, N'Ferretería', N'Bisagras Acero', 4.5000)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (12, N'Electrónica', N'Cinta Aislante', 3.2500)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (13, N'Electrónica', N'Multímetro Digital', 29.9900)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (14, N'Jardinería', N'Tijeras de Podar', 15.7500)
INSERT [dbo].[ITEM] ([ItemID], [Category], [NameItem], [Price]) VALUES (15, N'Jardinería', N'Manguera 10m', 25.0000)
SET IDENTITY_INSERT [dbo].[ITEM] OFF
GO
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (1, 1, 5, 12.5000, CAST(N'2025-05-06' AS Date))
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (1, 2, 3, 5.7500, CAST(N'2025-05-06' AS Date))
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (2, 3, 2, 9.9900, CAST(N'2025-05-07' AS Date))
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (3, 4, 10, 15.3000, CAST(N'2025-05-08' AS Date))
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (4, 5, 15, 3.4000, CAST(N'2025-05-09' AS Date))
INSERT [dbo].[ORDER_DETAILS] ([OrderID], [ItemID], [Quantity], [Price], [ArrivalDate]) VALUES (5, 6, 7, 18.9000, CAST(N'2025-05-10' AS Date))
GO
SET IDENTITY_INSERT [dbo].[ORDERS] ON 

INSERT [dbo].[ORDERS] ([OrderID], [OrderDate], [Status], [CustomerID]) VALUES (1, CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'Pending', 1)
INSERT [dbo].[ORDERS] ([OrderID], [OrderDate], [Status], [CustomerID]) VALUES (2, CAST(N'2025-02-05T00:00:00.000' AS DateTime), N'Shipped', 2)
INSERT [dbo].[ORDERS] ([OrderID], [OrderDate], [Status], [CustomerID]) VALUES (3, CAST(N'2025-03-05T00:00:00.000' AS DateTime), N'Delivered', 3)
INSERT [dbo].[ORDERS] ([OrderID], [OrderDate], [Status], [CustomerID]) VALUES (4, CAST(N'2025-04-05T00:00:00.000' AS DateTime), N'Cancelled', 4)
INSERT [dbo].[ORDERS] ([OrderID], [OrderDate], [Status], [CustomerID]) VALUES (5, CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'Shipped', 5)
SET IDENTITY_INSERT [dbo].[ORDERS] OFF
GO
SET IDENTITY_INSERT [dbo].[SALESMAN] ON 

INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (1, N'Carlos', N'Martínez', 1)
INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (2, N'Elena', N'Fernández', 2)
INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (3, N'Laura', N'Hernández', 3)
INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (4, N'David', N'Jiménez', 2)
INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (5, N'Fernando', N'Ortiz', 1)
INSERT [dbo].[SALESMAN] ([SalesmanID], [FirstName], [LastName], [CompanyID]) VALUES (6, N'Clara', N'Ramírez', 3)
SET IDENTITY_INSERT [dbo].[SALESMAN] OFF
GO
INSERT [dbo].[SHIPPING_METHOD] ([OrderID], [Type], [Year], [Cost]) VALUES (1, N'Standard', N'2025', 5.0000)
INSERT [dbo].[SHIPPING_METHOD] ([OrderID], [Type], [Year], [Cost]) VALUES (2, N'Express', N'2025', 10.0000)
INSERT [dbo].[SHIPPING_METHOD] ([OrderID], [Type], [Year], [Cost]) VALUES (3, N'Standard', N'2025', 5.5000)
INSERT [dbo].[SHIPPING_METHOD] ([OrderID], [Type], [Year], [Cost]) VALUES (4, N'Express', N'2025', 12.0000)
INSERT [dbo].[SHIPPING_METHOD] ([OrderID], [Type], [Year], [Cost]) VALUES (5, N'Standard', N'2025', 6.0000)
GO
SET IDENTITY_INSERT [dbo].[SUPPLIER] ON 

INSERT [dbo].[SUPPLIER] ([CompanyID], [CompanyName], [Address], [ContactName], [Country], [City], [PostalCode], [PhoneNo]) VALUES (1, N'FerreProveed', N'Calle Mayor 12', N'Juan López', N'España', N'Madrid', N'28001', N'910123456')
INSERT [dbo].[SUPPLIER] ([CompanyID], [CompanyName], [Address], [ContactName], [Country], [City], [PostalCode], [PhoneNo]) VALUES (2, N'Suministros Herrami', N'Av. Central 45', N'Ana Pérez', N'España', N'Valencia', N'46002', N'963456789')
INSERT [dbo].[SUPPLIER] ([CompanyID], [CompanyName], [Address], [ContactName], [Country], [City], [PostalCode], [PhoneNo]) VALUES (3, N'Construcciones López', N'Calle Reforma 32', N'Luis Gómez', N'España', N'Sevilla', N'41005', N'955123678')
INSERT [dbo].[SUPPLIER] ([CompanyID], [CompanyName], [Address], [ContactName], [Country], [City], [PostalCode], [PhoneNo]) VALUES (4, N'ElectroSuministros', N'Calle del Voltio 88', N'Sara Ruiz', N'España', N'Barcelona', N'08020', N'934567890')
INSERT [dbo].[SUPPLIER] ([CompanyID], [CompanyName], [Address], [ContactName], [Country], [City], [PostalCode], [PhoneNo]) VALUES (5, N'Maderas del Sur', N'Avenida del Bosque 15', N'Roberto Álvarez', N'España', N'Granada', N'18010', N'958765432')
SET IDENTITY_INSERT [dbo].[SUPPLIER] OFF
GO
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (1, 1, 10, 11.0000)
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (2, 2, 15, 5.0000)
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (3, 3, 20, 9.0000)
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (4, 4, 5, 14.0000)
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (5, 5, 30, 3.0000)
INSERT [dbo].[SUPPLY] ([SalesmanID], [ItemID], [Discount], [PriceCost]) VALUES (6, 6, 25, 17.0000)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CUSTOMER__A9D1053471E9BA5E]    Script Date: 09/05/2025 13:12:09 ******/
ALTER TABLE [dbo].[CUSTOMER] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [dbo].[ITEM] ([ItemID])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [dbo].[ITEM] ([ItemID])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[ORDERS] ([OrderID])
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CUSTOMER] ([CustomerID])
GO
ALTER TABLE [dbo].[SALESMAN]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[SUPPLIER] ([CompanyID])
GO
ALTER TABLE [dbo].[SHIPPING_METHOD]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[ORDERS] ([OrderID])
GO
ALTER TABLE [dbo].[SUPPLY]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [dbo].[ITEM] ([ItemID])
GO
ALTER TABLE [dbo].[SUPPLY]  WITH CHECK ADD FOREIGN KEY([SalesmanID])
REFERENCES [dbo].[SALESMAN] ([SalesmanID])
GO
ALTER TABLE [dbo].[CUSTOMER]  WITH CHECK ADD CHECK  (([Email] like '_%@_%._%'))
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD CHECK  (([Status]='Cancelled' OR [Status]='Delivered' OR [Status]='Shipped' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[SHIPPING_METHOD]  WITH CHECK ADD CHECK  (([Year] like '20[0-2][0-9]'))
GO
ALTER TABLE [dbo].[SUPPLIER]  WITH CHECK ADD CHECK  (([PhoneNo] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[SUPPLIER]  WITH CHECK ADD CHECK  (([PostalCode] like '[0-9][0-9][0-9][0-9][0-9]'))
GO
/****** Object:  StoredProcedure [dbo].[getitembyid]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[getitembyid]
    @itemid int
as
begin
    declare @name varchar(50), @category varchar(50), @price smallmoney;

    select @name = NameItem, @category = Category, @price = Price
    from ITEM
    where ItemID = @itemid;

    if @name is not null
    begin
        print '--------------------------------------';
        print 'Item Details for ItemID: ' + cast(@itemid as varchar(10));
        print '--------------------------------------';
        print 'Name: ' + @name;
        print 'Category: ' + @category;
        print 'Price: ' + cast(@price as varchar(20));
        print '--------------------------------------';
    end
    else
    begin
        print 'Item not found for ItemID: ' + cast(@itemid as varchar(10));
    end
end
GO
/****** Object:  StoredProcedure [dbo].[getorderdetails]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[getorderdetails]
    @orderid int
as
begin
    print '--------------------------------------';
    print 'Order Details for OrderID: ' + cast(@orderid as varchar(10));
    print '--------------------------------------';

    declare @itemid int, @quantity int, @price smallmoney, @arrivaldate date;

    declare details_cursor cursor for
    select ItemID, Quantity, Price, ArrivalDate
    from ORDER_DETAILS
    where OrderID = @orderid;

    open details_cursor;
    fetch next from details_cursor into @itemid, @quantity, @price, @arrivaldate;

    while @@fetch_status = 0
    begin
        print 'ItemID: ' + cast(@itemid as varchar(10));
        print 'Quantity: ' + cast(@quantity as varchar(10));
        print 'Price: ' + cast(@price as varchar(20));
        print 'Arrival Date: ' + cast(@arrivaldate as varchar(20));
        print '--------------------------------------';
        fetch next from details_cursor into @itemid, @quantity, @price, @arrivaldate;
    end

    close details_cursor;
    deallocate details_cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[getordersbycustomer]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[getordersbycustomer]
    @customerid int
as
begin
    print '--------------------------------------';
    print 'Orders for CustomerID: ' + cast(@customerid as varchar(10));
    print '--------------------------------------';

    declare @orderid int, @orderdate datetime, @status varchar(9);

    declare order_cursor cursor for
    select OrderID, OrderDate, Status
    from ORDERS
    where CustomerID = @customerid;

    open order_cursor;
    fetch next from order_cursor into @orderid, @orderdate, @status;

    while @@fetch_status = 0
    begin
        print 'OrderID: ' + cast(@orderid as varchar(10));
        print 'Order Date: ' + cast(@orderdate as varchar(20));
        print 'Status: ' + @status;
        print '--------------------------------------';
        fetch next from order_cursor into @orderid, @orderdate, @status;
    end

    close order_cursor;
    deallocate order_cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[getoutofstockitems]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[getoutofstockitems]
as
begin
    print '--------------------------------------';
    print 'Out of Stock Items';
    print '--------------------------------------';

    declare @itemid int, @name varchar(50), @category varchar(50);

    declare stock_cursor cursor for
    select i.ItemID, i.NameItem, i.Category
    from ITEM i
    left join INVENTORY inv on i.ItemID = inv.ItemID
    where inv.Stock = 0;

    open stock_cursor;
    fetch next from stock_cursor into @itemid, @name, @category;

    while @@fetch_status = 0
    begin
        print 'ItemID: ' + cast(@itemid as varchar(10));
        print 'Name: ' + @name;
        print 'Category: ' + @category;
        print '--------------------------------------';
        fetch next from stock_cursor into @itemid, @name, @category;
    end

    close stock_cursor;
    deallocate stock_cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[getsuppliersbycountry]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[getsuppliersbycountry]
    @country varchar(50)
as
begin
    print '--------------------------------------';
    print 'Suppliers from ' + @country;
    print '--------------------------------------';

    declare @companyid int, @companyname varchar(50), @address varchar(100);

    declare supplier_cursor cursor for
    select CompanyID, CompanyName, Address
    from SUPPLIER
    where Country = @country;

    open supplier_cursor;
    fetch next from supplier_cursor into @companyid, @companyname, @address;

    while @@fetch_status = 0
    begin
        print 'CompanyID: ' + cast(@companyid as varchar(10));
        print 'Company Name: ' + @companyname;
        print 'Address: ' + @address;
        print '--------------------------------------';
        fetch next from supplier_cursor into @companyid, @companyname, @address;
    end

    close supplier_cursor;
    deallocate supplier_cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[gettotalpurchasevalue]    Script Date: 09/05/2025 13:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[gettotalpurchasevalue]
    @customerid int
as
begin
    declare @totalvalue money;

    select @totalvalue = sum(od.Quantity * od.Price)
    from ORDER_DETAILS od
    inner join ORDERS o on od.OrderID = o.OrderID
    where o.CustomerID = @customerid;

    if @totalvalue is not null
    begin
        print '--------------------------------------';
        print 'Total Purchase Value for CustomerID: ' + cast(@customerid as varchar(10));
        print '--------------------------------------';
        print 'Total Value: ' + cast(@totalvalue as varchar(20));
        print '--------------------------------------';
    end
    else
    begin
        print 'No orders found for CustomerID: ' + cast(@customerid as varchar(10));
    end
end
GO
