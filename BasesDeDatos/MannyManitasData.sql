-- Insertar datos en la tabla ITEM
INSERT INTO ITEM (Category, NameItem, Price) 
VALUES
('Herramientas', 'Martillo', 12.50),
('Herramientas', 'Destornillador', 5.75),
('Materiales', 'Cemento', 9.99),
('Materiales', 'Pintura Blanca', 15.30),
('Ferretería', 'Tornillos 50mm', 3.40),
('Herramientas', 'Llave Inglesa', 18.90),
('Herramientas', 'Alicate', 7.25),
('Materiales', 'Yeso', 6.40),
('Materiales', 'Madera MDF', 22.99),
('Ferretería', 'Clavos 30mm', 2.10),
('Ferretería', 'Bisagras Acero', 4.50),
('Electrónica', 'Cinta Aislante', 3.25),
('Electrónica', 'Multímetro Digital', 29.99),
('Jardinería', 'Tijeras de Podar', 15.75),
('Jardinería', 'Manguera 10m', 25.00);

-- Insertar datos en la tabla SUPPLIER
INSERT INTO SUPPLIER (CompanyName, Address, ContactName, Country, City, PostalCode, PhoneNo)
VALUES
('FerreProveed', 'Calle Mayor 12', 'Juan López', 'España', 'Madrid', '28001', '910123456'),
('Suministros Herrami', 'Av. Central 45', 'Ana Pérez', 'España', 'Valencia', '46002', '963456789'),
('Construcciones López', 'Calle Reforma 32', 'Luis Gómez', 'España', 'Sevilla', '41005', '955123678'),
('ElectroSuministros', 'Calle del Voltio 88', 'Sara Ruiz', 'España', 'Barcelona', '08020', '934567890'),
('Maderas del Sur', 'Avenida del Bosque 15', 'Roberto Álvarez', 'España', 'Granada', '18010', '958765432');

-- Insertar datos en la tabla SALESMAN (debe haber un CompanyID existente en SUPPLIER)
INSERT INTO SALESMAN (FirstName, LastName, CompanyID) 
VALUES
('Carlos', 'Martínez', 1),
('Elena', 'Fernández', 2),
('Laura', 'Hernández', 3),
('David', 'Jiménez', 2),
('Fernando', 'Ortiz', 1),
('Clara', 'Ramírez', 3);

-- Insertar datos en la tabla CUSTOMER
INSERT INTO CUSTOMER (Address, FirstName, LastName, Email) 
VALUES
('Calle Falsa 123', 'Pedro', 'González', 'pedro.gonzalez@email.com'),
('Avenida Real 456', 'Ana', 'López', 'ana.lopez@email.com'),
('Calle Libertad 789', 'Luis', 'Martínez', 'luis.martinez@email.com'),
('Paseo Central 10', 'Marta', 'Hernández', 'marta.hernandez@email.com'),
('Calle Sol 21', 'Juan', 'Pérez', 'juan.perez@email.com');

-- Insertar datos en la tabla ORDERS (asegurarse que CustomerID exista en la tabla CUSTOMER)
INSERT INTO ORDERS (OrderDate, Status, CustomerID)
VALUES
('2025-05-01', 'Pending', 1),
('2025-05-02', 'Shipped', 2),
('2025-05-03', 'Delivered', 3),
('2025-05-04', 'Cancelled', 4),
('2025-05-05', 'Shipped', 5);

-- Insertar datos en la tabla ORDER_DETAILS (asegurarse que OrderID y ItemID existan)
INSERT INTO ORDER_DETAILS (OrderID, ItemID, Quantity, Price, ArrivalDate) 
VALUES
(1, 1, 5, 12.50, '2025-05-06'),
(1, 2, 3, 5.75, '2025-05-06'),
(2, 3, 2, 9.99, '2025-05-07'),
(3, 4, 10, 15.30, '2025-05-08'),
(4, 5, 15, 3.40, '2025-05-09'),
(5, 6, 7, 18.90, '2025-05-10');

-- Insertar datos en la tabla SHIPPING_METHOD (asegurarse que OrderID exista en la tabla ORDERS)
INSERT INTO SHIPPING_METHOD (OrderID, Type, Year, Cost)
VALUES
(1, 'Standard', '2025', 5.00),
(2, 'Express', '2025', 10.00),
(3, 'Standard', '2025', 5.50),
(4, 'Express', '2025', 12.00),
(5, 'Standard', '2025', 6.00);

-- Insertar datos en la tabla SUPPLY (asegurarse que SalesmanID y ItemID existan)
INSERT INTO SUPPLY (SalesmanID, ItemID, Discount, PriceCost)
VALUES
(1, 1, 10, 11.00),
(2, 2, 15, 5.00),
(3, 3, 20, 9.00),
(4, 4, 5, 14.00),
(5, 5, 30, 3.00),
(6, 6, 25, 17.00);
