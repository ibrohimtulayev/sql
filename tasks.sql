SELECT COUNT(*) AS Number_of_Films_Never_Rented
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT(film_id)
    FROM rental
);

SELECT f.film_id, f.title, SUM(p.amount) AS total_income
FROM film f
         LEFT JOIN inventory i ON f.film_id = i.film_id
         LEFT JOIN rental r ON i.inventory_id = r.inventory_id
         LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY total_income
LIMIT 3;

SELECT store_id, total_revenue AS max_revenue
FROM (
         SELECT store.store_id, SUM(payment.amount) AS total_revenue
         FROM rental
                  JOIN inventory ON rental.inventory_id = inventory.inventory_id
                  JOIN store ON inventory.store_id = store.store_id
                  JOIN payment ON rental.rental_id = payment.rental_id
         WHERE EXTRACT(YEAR FROM payment.payment_date) = 2017
         GROUP BY store.store_id
     ) store_revenues
ORDER BY total_revenue DESC
LIMIT 1;