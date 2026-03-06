-- CREATE ROLE postgres WITH
-- LOGIN
-- SUPERUSER
-- CREATEDB
-- CREATEROLE
-- INHERIT;

CREATE OR REPLACE FUNCTION get_customer_rental_summary(p_customer_id INT)
RETURNS TABLE (total_rental int,total_amount int)
LANGUAGE plpgsql
AS $$
	DECLARE
		data RECORD;
		total_rental int = 0;
		total_amount int = 0;
	begin
		FOR data in SELECT * from customer c 
					join rental r using(customer_id)
					join inventory i using(inventory_id)
					join film f using(film_id) where c.customer_id = p_customer_id
			LOOP
				RAISE NOTICE 'rental id : %, film title: %,rental date : %, return date : % ',
				data.rental_id ,data.title ,data.rental_date,data.return_date;
				total_rental = total_rental + 1;
			END LOOP;

		FOR data in SELECT * FROM customer c join payment using(customer_id) where c.customer_id = p_customer_id
		LOOP
			total_amount = total_amount + data.amount;
		END LOOP;
		RETURN QUERY SELECT total_rental, total_amount;
	end
$$

CREATE OR REPLACE FUNCTION get_customer_rental_summary_f(p_customer_id INT)
RETURNS TABLE (total_rental int,total_amount NUMERIC)
LANGUAGE plpgsql
AS $$
	DECLARE
		data RECORD;
		total_rental int = 0;
		total_amount NUMERIC = 0;
	begin
		FOR data in SELECT * from customer c 
					join rental r using(customer_id)
					join inventory i using(inventory_id)
					join film f using(film_id) where c.customer_id = p_customer_id
			LOOP
				RAISE NOTICE 'rental id : %, film title: %,rental date : %, return date : % ',
				data.rental_id ,data.title ,data.rental_date,data.return_date;
				total_rental = total_rental + 1;
			END LOOP;

		FOR data in SELECT * FROM customer c join payment using(customer_id) where c.customer_id = p_customer_id
		LOOP
			total_amount = total_amount + data.amount;
		END LOOP;
		RETURN QUERY SELECT total_rental, total_amount;
	end
$$

select * from get_customer_rental_summary_f(1)

CREATE OR REPLACE FUNCTION get_overdue_rentals(p_days INT)
RETURNS VOID
LANGUAGE plpgsql
AS $$
	DECLARE
		rec RECORD;
		rented_days INT;
		rental_cursor CURSOR FOR
			SELECT 
				r.rental_id,
				f.title,
				r.rental_date
        FROM rental r
        JOIN inventory i USING (inventory_id)
        JOIN film f USING (film_id)
        JOIN customer c USING (customer_id)
        WHERE r.return_date IS NULL;
	BEGIN
		OPEN rental_cursor;
		LOOP
	        FETCH rental_cursor INTO rec;
	        EXIT WHEN NOT FOUND;
	
	        rented_days := CURRENT_DATE - rec.rental_date::DATE;
	
	        IF rented_days > p_days THEN
	            RAISE NOTICE 
	            'Rental ID: %, Film: %, Rented Days: %',
	            rec.rental_id,
	            rec.title,
	            rented_days;
	        END IF;
		END LOOP;
		CLOSE rental_cursor;
	END;
$$;

select * from get_overdue_rentals(500);



