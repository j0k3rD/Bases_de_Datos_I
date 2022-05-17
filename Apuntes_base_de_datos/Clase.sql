# Tarea que se pideo en alguna clase anterior.
use sakila;

Select  P.payment_id,
	    P.customer_id,
		C.first_name,
		C.last_name,
		P.staff_id,
		(select concat(S.first_name, " - ", S.last_name) from staff S where S.staff_id = P.staff_id) "Vendedor",
		P.rental_id,
		(select R.rental_date from rental R where R.rental_id = P.rental_id) "Fecha Alquiler",
		(select R.return_date from rental R where R.rental_id = P.rental_id) "Fecha Devolución",
		(select datediff( (select R.return_date from rental R where R.rental_id = P.rental_id), (select R.rental_date from rental R where R.rental_id = P.rental_id))) "Demora",
        (select F.rental_duration from film F where F.film_id  = (select I.film_id from inventory I where I.inventory_id = (select R.inventory_id from rental R where R.rental_id = P.rental_id))) "Prestamo Permitido",
		(select F.title from film F where F.film_id  = (select I.film_id from inventory I where I.inventory_id = (select R.inventory_id from rental R where R.rental_id = P.rental_id))) "Película",
        (select datediff( (select R.return_date from rental R where R.rental_id = P.rental_id), (select R.rental_date from rental R where R.rental_id = P.rental_id))) * 0.25 "Recargo",
        P.amount,
		P.payment_date,
		P.last_update
From payment P,
     customer C
Where P.customer_id = C.customer_id
and (select datediff( (select R.return_date from rental R where R.rental_id = P.rental_id), (select R.rental_date from rental R where R.rental_id = P.rental_id))) > (select F.rental_duration from film F where F.film_id  = (select I.film_id from inventory I where I.inventory_id = (select R.inventory_id from rental R where R.rental_id = P.rental_id)));

Create View TableFilm1tablefilm1 as
Select F.film_id,
	#(select concat(A.first_name, " ", A.last_name) from actor A where A.actor_id = (select FA.actor_id from film_actor FA where FA.film_id = F.film_id)) "Actor",
    # No funciona cuando tienes solo (from film F) porque cada pelicula tiene como 10 actores, entonces devuelve mas de una fila y da error. Para este caso hay que hacer
    # un Join, agregado el (from film F, film_actor FA / where F.film_id = FA.film_id) entonces unis esas dos tablas mostrando todo lo repetido, y ahi si te dejaria hacer un
    # select encadenado que los traiga repetido, pero va a tener espacio para agregarlo, ya que ahora se repiten
    # Saber cuantos actores tiene una fila =>
    # select actor_id, film_id from film_actor
    # order by film_id;
    #
    Fa.actor_id,
    (select concat(A.first_name, " ", A.last_name) from actor A where A.actor_id = Fa.actor_id) "Actor",
    F.title,
    F.description,
    F.release_year,
    F.language_id,
    F.original_language_id,
    F.rental_duration,
    F.rental_rate,
    F.length,
    F.replacement_cost,
    F.rating,
    F.special_features,
    F.last_update
From film F, film_actor FA
Where F.film_id = FA.film_id
and f.film_id = 1;

use sakila;

select * from tablefilm1;

select * from store;

use tablatarea;

# Clase 9
# Lista de Join: inner/right/left join
select C.first_name, C.last_name, P.staff_id, P.rental_id 
from payment P left join customer C
on P.customer_id = C.customer_id;

select f.film_id,
	   f.title,
       concat(a.first_name, " ", a.last_name)"Actor"
from film f inner join 
  film_actor fa
  on f.film_id = fa.film_id inner join
  actor a
  on fa.actor_id = a.actor_id;
		
use sakila;

select customer_id,
		concat(first_name, " ", last_name) "Nombre Y Apellido",
        get_customer_balance(customer_id, date("2006-12-31")) "Deuda"
from customer;

# get_customer_balance()

## Clase 10 (Funciones y Parametros).
select  *,
	    #inventory_held_by_customer(inventory_id) // Esto me daba valores nulos, por eso le meti un IFNULL, aunque deberia estar dentro del a función.
        IFNULL(inventory_held_by_customer(inventory_id), 0) "Inventario del Cliente"
from rental;

Call rewards_report(7, 20.00, @count);
select @count;
## En este caso no me devuelve nada, probe con diferentes numeros y no funciona, no se si hay algo incorrecto en los numeros.

SELECT count(*) from PERSONAL