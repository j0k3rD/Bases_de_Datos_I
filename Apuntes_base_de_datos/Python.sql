use python;

create table PERSONAL(
		personal_id integer(8),
        nombre varchar(20),
        apellido varchar(20),
        domicilio varchar(15),
        teléfono varchar(50)
);

Insert into PERSONAL
    Values (Null ,"Beta", "Test", "Test 2.0", "+54 (2604)251345");

Select * from PERSONAL;

DELETE FROM personal WHERE personal_id = Null;

drop table personal

