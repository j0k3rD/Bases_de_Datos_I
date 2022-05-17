# Final de Base de Datos I
# Nombre: Marcos Miglierina

create database ferreteria;

use ferreteria;

#--------------- Creación de Tablas -----------------------
# Producto
CREATE TABLE `ferreteria`.`producto` (
  `CodigoProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Descripción` VARCHAR(250) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`CodigoProducto`));

# Deposito
CREATE TABLE `ferreteria`.`deposito` (
  `IDDeposito` INT NOT NULL AUTO_INCREMENT,
  `CodigoProducto` INT NOT NULL,
  `Cantidad` DECIMAL(10,3) NOT NULL,
  `Fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`IDDeposito`),
  INDEX `CodigoProducto_idx` (`CodigoProducto` ASC) VISIBLE,
  CONSTRAINT `CodigoProducto`
    FOREIGN KEY (`CodigoProducto`)
    REFERENCES `ferreteria`.`producto` (`CodigoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Venta
CREATE TABLE `ferreteria`.`venta` (
  `IDVenta` INT NOT NULL AUTO_INCREMENT,
  `IDDeposito` INT NOT NULL,
  `Cantidad` DECIMAL(10,3) NOT NULL,
  `PrecioVenta` DECIMAL(10,2) NOT NULL,
  `Fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`IDVenta`),
  INDEX `IDDepositoFK_idx` (`IDDeposito` ASC) VISIBLE,
  CONSTRAINT `IDDepositoFK`
    FOREIGN KEY (`IDDeposito`)
    REFERENCES `ferreteria`.`deposito` (`IDDeposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
#--------------- Creación de Tablas -----------------------

#--------------- Ingreso de Datos -----------------------
# Producto
INSERT INTO `ferreteria`.`producto` (`Nombre`, `Descripción`, `Precio`) VALUES ('Destornillador Phillips', 'Destornillador Phillips 3,2 X 152mm Truper 14058 Acero S-2', '185.50');
INSERT INTO `ferreteria`.`producto` (`Nombre`, `Descripción`, `Precio`) VALUES ('Pinza Universal', 'Pinza Universal 7 180 Mm Mango Soft Touch', '619.00');
INSERT INTO `ferreteria`.`producto` (`Nombre`, `Descripción`, `Precio`) VALUES ('Clavo Punta Paris', 'Clavo Punta Paris 6 Pulgadas por kilogramo', '500.00');

# Deposito
INSERT INTO `ferreteria`.`deposito` (`CodigoProducto`, `Cantidad`, `Fecha`) VALUES ('1', '200', current_timestamp());
INSERT INTO `ferreteria`.`deposito` (`CodigoProducto`, `Cantidad`, `Fecha`) VALUES ('2', '50', current_timestamp());
# En el caso de los clavos y objetos similares, la cantidad determina la cantidad de Kg que tiene de ese producto. Lo deje asi, ya que al agregar un nuevo valor de kg, la cantidad
# quedaría nula en el caso de clavos y objetos similares y el kg en caso de herramientas quedaría nula tambien, lo ideal sería no usar nulos en tabla para evitar problemas futuros.
INSERT INTO `ferreteria`.`deposito` (`CodigoProducto`, `Cantidad`, `Fecha`) VALUES ('3', '20', current_timestamp());

# Venta 1:
INSERT INTO `ferreteria`.`venta` (`IDDeposito`, `Cantidad`, `PrecioVenta`, `Fecha`) VALUES ('1', '2', CalcularPrecio(( select codigoProducto from deposito where iddeposito = 1 ), '2'), current_timestamp());

# Venta 2:
INSERT INTO `ferreteria`.`venta` (`IDDeposito`, `Cantidad`, `PrecioVenta`, `Fecha`) VALUES ('2', '1', CalcularPrecio(( select codigoProducto from deposito where iddeposito = 2 ), '1'), current_timestamp());

# Venta 3:
# En el caso de la cantidad de clavos, en cantidad le agrego el 0,5 ya que se lleva 500 gramos de clavos, en caso de 1kg, sería 1.
INSERT INTO `ferreteria`.`venta` (`IDDeposito`, `Cantidad`, `PrecioVenta`, `Fecha`) VALUES ('3', '0.5', CalcularPrecio(( select codigoProducto from deposito where iddeposito = 3 ), '0.5'), current_timestamp());
#--------------- Ingreso de Datos -----------------------

#--------------- Consultas -----------------------
# Consulta Stock disponible de articulos por fecha.
Select IDDeposito "ID del Deposito",
	   ( Select P.Nombre from producto P where P.CodigoProducto = D.CodigoProducto ) "Producto",
       ( Select P.Descripción from producto P where P.CodigoProducto = D.CodigoProducto ) "Descripción",
       Cantidad,
       Fecha
From deposito D
Where date(fecha) = date("2021-07-02");

# Consulta de pedidos diarios
Select IDVenta "ID de Venta",
	   ( Select P.Nombre from producto P where P.CodigoProducto = ( Select D.CodigoProducto from deposito D where D.IDDeposito = V.IDDeposito ) ) "Producto",
       Cantidad,
       PrecioVenta "Precio de Venta",
       Fecha
From venta V
Where date(fecha) = date("2021-07-02");

# Vistas de todas las tablas para visualizar su contenido
Create View VistaDeposito as
Select IDDeposito "ID del Deposito",
	   ( Select P.Nombre from producto P where P.CodigoProducto = D.CodigoProducto ) "Producto",
       ( Select P.Descripción from producto P where P.CodigoProducto = D.CodigoProducto ) "Descripción",
       Cantidad,
       Fecha
From deposito D;

Create View VistaVenta as
Select IDVenta "ID de Venta",
	   ( Select P.Nombre from producto P where P.CodigoProducto = ( Select D.CodigoProducto from deposito D where D.IDDeposito = V.IDDeposito ) ) "Producto",
       Cantidad,
       PrecioVenta "Precio de Venta",
       Fecha
From venta V;

Create View VistaProducto as
Select *
From producto;
#--------------- Consultas -----------------------