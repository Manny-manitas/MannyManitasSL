
create or alter trigger trg_inventory_update
on inventory
after update
as
begin
    declare @newstock int;

    select @newstock = stock from inserted;

    if @newstock < 0
    begin
        print 'error: no puede haber un stock negativo.';
        rollback transaction;
    end
end;



create or alter trigger trg_order_shipping
on orders
after insert
as
begin
    declare @orderid int, @defaulttype varchar(50), @defaultcost smallmoney;

    select @orderid = orderid from inserted;

    set @defaulttype = 'standard';
    set @defaultcost = 10.00;

    insert into shipping_method (orderid, type, year, cost)
    values (@orderid, @defaulttype, year(getdate()), @defaultcost);

    print 'se ha creado el método de envío para el pedido: ' + cast(@orderid as varchar);
end;



create or alter trigger trg_item_price_update
on item
after update
as
begin
    declare @itemid int, @price smallmoney, @costprice money;

    select @itemid = itemid, @price = price from inserted;

    select @costprice = pricecost from supply where itemid = @itemid;

    if @price < @costprice
    begin
        print 'el precio de venta es inferior al costo, se actualizará el precio de venta.';

        update item
        set price = @costprice
        where itemid = @itemid;
    end
    else
    begin
        print 'el precio de venta es válido.';
    end
end;



create or alter trigger trg_order_status_update
on orders
after update
as
begin
    declare @orderid int, @newstatus varchar(9), @currentdate datetime;

    select @orderid = orderid, @newstatus = status from inserted;
    set @currentdate = getdate();

    insert into order_status_log (orderid, status, changedate)
    values (@orderid, @newstatus, @currentdate);

    print 'estado del pedido ' + cast(@orderid as varchar) + ' actualizado a: ' + @newstatus;
end;

create table order_status_log (
    logid int identity primary key,
    orderid int,
    status varchar(9),
    changedate datetime
);



create or alter trigger trg_prevent_item_deletion
on item
instead of delete
as
begin
    declare @itemid int;

    select @itemid = itemid from deleted;

    if exists (select 1 from order_details where itemid = @itemid)
    begin
        print 'no se puede eliminar el artículo con id ' + cast(@itemid as varchar) + ' porque está en un pedido.';
    end
    else
    begin
        delete from item where itemid = @itemid;
        print 'artículo eliminado con id: ' + cast(@itemid as varchar);
    end
end;



create or alter trigger trg_order_details_quantity_check
on order_details
after insert, update
as
begin
    declare @orderid int, @itemid int, @quantity int;

    select @orderid = orderid, @itemid = itemid, @quantity = quantity from inserted;

    if @quantity <= 0
    begin
        print 'error: la cantidad de artículos en el pedido no puede ser cero o negativa.';
        rollback transaction;
    end
    else
    begin
        print 'cantidad válida registrada para el pedido ' + cast(@orderid as varchar) + ', artículo ' + cast(@itemid as varchar);
    end
end;


