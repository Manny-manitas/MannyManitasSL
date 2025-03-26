
-- Insertar datos en ITEM
INSERT INTO ITEM (Category, NameItem, Price) VALUES
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

-- Insertar datos en INVENTORY
INSERT INTO INVENTORY (ItemID, Stock, DateRecounting, PeriodRecounting) VALUES
(1, 100, GETDATE(), 7),
(2, 150, GETDATE(), 10),
(3, 50, GETDATE(), 15),
(4, 80, GETDATE(), 5),
(5, 200, GETDATE(), 7),
(6, 75, GETDATE(), 10),
(7, 120, GETDATE(), 14),
(8, 40, GETDATE(), 20),
(9, 90, GETDATE(), 7),
(10, 300, GETDATE(), 5),
(11, 50, GETDATE(), 15),
(12, 110, GETDATE(), 12),
(13, 200, GETDATE(), 10),
(14, 30, GETDATE(), 25),
(15, 60, GETDATE(), 30);

-- Insertar datos en SUPPLIER
INSERT INTO SUPPLIER (CompanyName, Address, ContactName, Country, City, PostalCode, PhoneNo) VALUES
('FerreProveed', 'Calle Mayor 12', 'Juan López', 'España', 'Madrid', '28001', '910123456'),
('Suministros Herrami', 'Av. Central 45', 'Ana Pérez', 'España', 'Valencia', '46002', '963456789'),
('Construcciones López', 'Calle Reforma 32', 'Luis Gómez', 'España', 'Sevilla', '41005', '955123678'),
('ElectroSuministros', 'Calle del Voltio 88', 'Sara Ruiz', 'España', 'Barcelona', '08020', '934567890'),
('Maderas del Sur', 'Avenida del Bosque 15', 'Roberto Álvarez', 'España', 'Granada', '18010', '958765432');


-- Insertar datos en SALESMAN
INSERT INTO SALESMAN (FirstName, LasName, CompanyID) VALUES
('Carlos', 'Martínez', 1),
('Elena', 'Fernández', 2),
('Laura', 'Hernández', 3),
('David', 'Jiménez', 2),
('Fernando', 'Ortiz', 1),
('Clara', 'Ramírez', 3);

-- Insertar datos en SUPPLY
INSERT INTO SUPPLY (SalesmanID, ItemID, Discount, PriceCost) VALUES
(1, 1, 10, 10.00),
(1, 2, 5, 5.00),
(2, 3, 15, 8.50),
(2, 4, 8, 14.00),
(1, 5, 12, 3.00),
(3, 6, 8, 16.50),
(3, 7, 5, 6.80),
(4, 8, 12, 5.80),
(5, 9, 10, 20.00),
(6, 10, 15, 1.80),
(4, 11, 7, 4.00),
(5, 12, 10, 2.90),
(6, 13, 5, 25.50),
(3, 14, 6, 27.99),
(4, 15, 8, 20.50);

-- Insertar datos en CUSTOMER
INSERT INTO CUSTOMER (Address, FirstName, LasName, Email) VALUES
('Calle A 10', 'María', 'García', 'maria.garcia@email.com'),
('Av. B 22', 'Pedro', 'Sánchez', 'pedro.sanchez@email.com'),
('Calle F 18', 'Andrea', 'Martínez', 'andrea.martinez@email.com'),
('Av. Z 37', 'Francisco', 'González', 'francisco.gonzalez@email.com'),
('Calle H 25', 'Carmen', 'Ortega', 'carmen.ortega@email.com'),
('Paseo X 50', 'Javier', 'Méndez', 'javier.mendez@email.com');

-- Insertar datos en ORDERS
INSERT INTO ORDERS (OrderDate, Status, ShippingID, CustomerID) VALUES
(GETDATE(), 'Pendiente', 1, 1),
(GETDATE(), 'Enviado', 2, 2),
(GETDATE(), 'Pendiente', 3, 3),
(GETDATE(), 'Enviado', 4, 4),
(GETDATE(), 'Entregado', 5, 5),
(GETDATE(), 'Pendiente', 6, 6);

-- Insertar datos en ORDER_DETAILS
INSERT INTO ORDER_DETAILS (OrderID, ItemID, Quantity, Price, ArrivalDate) VALUES
(1, 1, 2, 12.50, DATEADD(DAY, 3, GETDATE())),
(1, 3, 1, 9.99, DATEADD(DAY, 3, GETDATE())),
(2, 2, 5, 5.75, DATEADD(DAY, 5, GETDATE())),
(3, 6, 1, 18.90, DATEADD(DAY, 4, GETDATE())),
(3, 8, 2, 7.25, DATEADD(DAY, 4, GETDATE())),
(4, 10, 3, 6.40, DATEADD(DAY, 6, GETDATE())),
(4, 12, 1, 22.99, DATEADD(DAY, 6, GETDATE())),
(5, 14, 4, 2.10, DATEADD(DAY, 2, GETDATE())),
(5, 15, 2, 4.50, DATEADD(DAY, 2, GETDATE())),
(6, 7, 5, 3.25, DATEADD(DAY, 7, GETDATE())),
(6, 9, 2, 29.99, DATEADD(DAY, 7, GETDATE()));

-- Insertar datos en SHIPPING_METHOD
INSERT INTO SHIPPING_METHOD (OrderID, Type, Year, Cost) VALUES
(1, 'Estándar', '2025', 5.00),
(2, 'Express', '2025', 8.50),
(3, 'Express', '2025', 10.00),
(4, 'Económico', '2025', 5.00),
(5, 'Rápido', '2025', 7.50),
(6, 'Estándar', '2025', 6.00);
