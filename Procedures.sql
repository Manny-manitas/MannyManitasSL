

create or alter procedure getitembyid
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



create or alter procedure getordersbycustomer
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



create or alter procedure getorderdetails
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



create or alter procedure gettotalpurchasevalue
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



create or alter procedure getoutofstockitems
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



create or alter procedure getsuppliersbycountry
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



EXEC getitembyid @itemid = 3
EXEC getordersbycustomer @customerid = 1
EXEC getorderdetails @orderid = 1;
EXEC gettotalpurchasevalue @customerid = 1;
EXEC getoutofstockitems;
EXEC getsuppliersbycountry @country = 'España';
