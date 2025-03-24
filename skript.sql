PRAGMA table_info(actor);
PRAGMA table_info(film);
PRAGMA table_info(customer);
PRAGMA table_info(rental);
PRAGMA table_info(category);

-- SQL Portfolio Projekt: Analýza filmové databáze Sakila
-- Autor: [Bronislav Pečner]
-- Popis: Tento skript analyzuje data o hercích, filmech a zákaznících.

-- TOP 5 nejobsazovanějších herců
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 5;

-- Nejpopulárnější žánr (nejvíce filmů)
SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY film_count DESC
LIMIT 1;

-- Největší zákazníci podle počtu výpůjček
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC
LIMIT 5;

-- Filmy dostupné v určitém městě
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city = 'Los Angeles';

-- Vývoj počtu výpůjček podle měsíců
SELECT strftime('%Y-%m', rental_date) AS month, COUNT(rental_id) AS rentals
FROM rental
GROUP BY month
ORDER BY month;
