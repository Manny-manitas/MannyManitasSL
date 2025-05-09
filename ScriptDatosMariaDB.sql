CREATE TABLE `CUSTOMER` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(100) NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `INVENTORY` (
  `BinID` INT NOT NULL AUTO_INCREMENT,
  `ItemID` INT NOT NULL,
  `Stock` INT NOT NULL,
  `DateRecounting` DATETIME NOT NULL,
  `PeriodRecounting` TINYINT NOT NULL,
  PRIMARY KEY (`BinID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ITEM` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(50) NOT NULL,
  `NameItem` VARCHAR(50) NOT NULL,
  `Price` DECIMAL(10, 4) NOT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDER_DETAILS` (
  `OrderID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `Price` DECIMAL(10, 4) NOT NULL,
  `ArrivalDate` DATE NOT NULL,
  PRIMARY KEY (`OrderID`, `ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDERS` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATETIME NOT NULL,
  `Status` VARCHAR(9) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `SALESMAN` (
  `SalesmanID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `CompanyID` INT NOT NULL,
  PRIMARY KEY (`SalesmanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `SHIPPING_METHOD` (
  `OrderID` INT NOT NULL,
  `Type` VARCHAR(50) NOT NULL,
  `Year` CHAR(4) NOT NULL,
  `Cost` DECIMAL(10, 4) NOT NULL,
  PRIMARY KEY (`OrderID`, `Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `SUPPLIER` (
  `CompanyID` INT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  `ContactName` VARCHAR(50) NOT NULL,
  `Country` VARCHAR(50) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `PostalCode` CHAR(5) NOT NULL,
  `PhoneNo` CHAR(9) NOT NULL,
  PRIMARY KEY (`CompanyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `SUPPLY` (
  `SalesmanID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Discount` TINYINT NOT NULL,
  `PriceCost` DECIMAL(10, 4) NOT NULL,
  PRIMARY KEY (`SalesmanID`, `ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert Data
INSERT INTO `CUSTOMER` (`CustomerID`, `Address`, `FirstName`, `LastName`, `Email`) VALUES
(1, 'Calle Falsa 123', 'Pedro', 'González', 'pedro.gonzalez@email.com'),
(2, 'Avenida Real 456', 'Ana', 'López', 'ana.lopez@email.com'),
(3, 'Calle Libertad 789', 'Luis', 'Martínez', 'luis.martinez@email.com'),
(4, 'Paseo Central 10', 'Marta', 'Hernández', 'marta.hernandez@email.com'),
(5, 'Calle Sol 21', 'Juan', 'Pérez', 'juan.perez@email.com');

INSERT INTO `ITEM` (`ItemID`, `Category`, `NameItem`, `Price`) VALUES
(1, 'Herramientas', 'Martillo', 12.5000),
(2, 'Herramientas', 'Destornillador', 5.7500),
(3, 'Materiales', 'Cemento', 9.9900),
(4, 'Materiales', 'Pintura Blanca', 15.3000),
(5, 'Ferretería', 'Tornillos 50mm', 3.4000),
(6, 'Herramientas', 'Llave Inglesa', 18.9000),
(7, 'Herramientas', 'Alicate', 7.2500),
(8, 'Materiales', 'Yeso', 6.4000),
(9, 'Materiales', 'Madera MDF', 22.9900),
(10, 'Ferretería', 'Clavos 30mm', 2.1000),
(11, 'Ferretería', 'Bisagras Acero', 4.5000),
(12, 'Electrónica', 'Cinta Aislante', 3.2500),
(13, 'Electrónica', 'Multímetro Digital', 29.9900),
(14, 'Jardinería', 'Tijeras de Podar', 15.7500),
(15, 'Jardinería', 'Manguera 10m', 25.0000);

INSERT INTO `ORDER_DETAILS` (`OrderID`, `ItemID`, `Quantity`, `Price`, `ArrivalDate`) VALUES
(1, 1, 5, 12.5000, '2025-05-06'),
(1, 2, 3, 5.7500, '2025-05-06'),
(2, 3, 2, 9.9900, '2025-05-07'),
(3, 4, 10, 15.3000, '2025-05-08'),
(4, 5, 15, 3.4000, '2025-05-09'),
(5, 6, 7, 18.9000, '2025-05-10');

INSERT INTO `ORDERS` (`OrderID`, `OrderDate`, `Status`, `CustomerID`) VALUES
(1, '2025-01-05', 'Pending', 1),
(2, '2025-02-05', 'Shipped', 2),
(3, '2025-03-05', 'Delivered', 3),
(4, '2025-04-05', 'Cancelled', 4),
(5, '2025-05-05', 'Shipped', 5);

INSERT INTO `SALESMAN` (`SalesmanID`, `FirstName`, `LastName`, `CompanyID`) VALUES
(1, 'Carlos', 'Martínez', 1),
(2, 'Elena', 'Fernández', 2),
(3, 'Laura', 'Hernández', 3),
(4, 'David', 'Jiménez', 2),
(5, 'Fernando', 'Ortiz', 1),
(6, 'Clara', 'Ramírez', 3);

INSERT INTO `SHIPPING_METHOD` (`OrderID`, `Type`, `Year`, `Cost`) VALUES
(1, 'Standard', '2025', 5.0000),
(2, 'Express', '2025', 10.0000),
(3, 'Standard', '2025', 5.5000),
(4, 'Express', '2025', 12.0000),
(5, 'Standard', '2025', 6.0000);

INSERT INTO `SUPPLIER` (`CompanyID`, `CompanyName`, `Address`, `ContactName`, `Country`, `City`, `PostalCode`, `PhoneNo`) VALUES
(1, 'FerreProveed', 'Calle Mayor 12', 'Juan López', 'España', 'Madrid', '28001', '910123456'),
(2, 'Suministros Herrami', 'Av. Central 45', 'Ana Pérez', 'España', 'Valencia', '46002', '963456789'),
(3, 'Construcciones López', 'Calle de la Industria 10', 'Carlos López', 'España', 'Sevilla', '41010', '954321987');
