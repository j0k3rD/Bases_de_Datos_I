# Tarea creación de tablas.
use tablatarea;

create table agenda(
		agenda_id integer(8),
        nombre varchar(20),
        apellido varchar(20),
        domicilio varchar(15),
        teléfono varchar(50)
);

create table tienda(
		tienda_id integer(8),
        nombre varchar(20),
        dueño varchar(20),
        dirección varchar(15),
        teléfono varchar(12)
);

Insert into agenda (agenda_id, apellido, nombre, domicilio, teléfono)
	Values (1, "Perez", "Rigoberto", "San Martin 432", "+54 (2604)353123");
Insert into agenda
	Values (2, "Moralez", "Josefo", "Mitre 240", "+54 (2604)435213");
Insert into agenda
	Values (3, "Vera", "Juancho", "Srg Cabral 239", "+54 (2604)251345");
Insert into agenda
	Values (4, "Sanchez", "Manuela", "Massa 654", "+54 (2604)123123");
Insert into agenda
	Values (5, "Venitez", "Pepe", "Indep 240", "+54 (2604)234653");

Insert into tienda (tienda_id, nombre, dueño, dirección, teléfono)
	Values (1, "Rubor", "Rigoberto", "San Martin 432", "+54 (2604)353123");
Insert into tienda
	Values (2, "El más barato", "Josefo", "Mitre 240", "+54 (2604)435213");
Insert into tienda
	Values (3, "Portal", "Juancho", "Srg Cabral 239", "+54 (2604)251345");
Insert into tienda
	Values (4, "Saeptentrional", "Manuela", "Massa 654", "+54 (2604)123123");
Insert into tienda
	Values (5, "Supremo", "Pepe", "Indep 240", "+54 (2604)234653");

select * from tienda;
select * from agenda;

# Dejo para ayuda de futuro.    
ALTER TABLE tienda
modify column teléfono varchar(50);

Alter table tienda
drop column teléfono;

ALTER TABLE tienda
ADD teléfono varchar(50);

# Tarea del select.
# Usar tabla customer(store_id), store(managerStaff_id), adress(city_id / adress), city(city)
use sakila;

Select C.customer_id "ID-Vendedor",
	C.first_name "Nombre Vendedor",
    C.last_name "Apellido Vendedor",
    #(select S.manager_staff_id from store S where S.store_id = C.store_id) "ID-Manager", No lo pide el ejercicio
    (Select St.first_name from staff St Where St.staff_id = ( Select S.manager_staff_id from store S where S.store_id = C.store_id) ) "Nombre_Gerente",
    (Select Ci.city from city Ci Where Ci.city_id = (Select A.city_id from address A where A.address_id = (Select A.address_id from address A where C.address_id = A.address_id))) "Ciudad",
    (select A.address from address A where A.address_id = C.address_id) "Domicilio"
    #(select A.address2 from address A where A.address_id = C.address_id) "Domicilio Secundario", No tiene nada
    #(select S.manager_staff_id from store S where S.store_id = C.store_id) "Nombre Ciudad"
From customer C;

select * from address;


