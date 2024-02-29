USE sakila;

-- 1. select the first name, last name, and email address of all the customers who have rented a movie.

SELECT
    first_name,
    last_name,
    email
FROM
    customer
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            rental
    );
    
-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    AVG(p.amount) AS average_payment
FROM
    customer c
JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, customer_name;
    
-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
       -- Write the query using multiple join statements
       -- Write the query using sub queries with multiple WHERE clause and IN condition


SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category cat ON fc.category_id = cat.category_id
WHERE
    cat.name = 'Action';
    
-- Write the query using sub queries with multiple WHERE clause and IN condition

SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    email
FROM
    customer
WHERE
    customer_id IN (
SELECT
	r.customer_id
FROM
	rental r
WHERE
    r.inventory_id IN (
SELECT
	i.inventory_id
FROM
	inventory i
WHERE
	i.film_id IN (
SELECT
	f.film_id
FROM
	film f
WHERE
    f.film_id IN (
SELECT
	film_id
FROM
	film_category fc
WHERE
	fc.category_id IN (
SELECT
    category_id
FROM
    category
WHERE
	name = 'Action'
                                    )
                            )
                    )
            )
    );
    
    
    -- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
    
    SELECT
    customer_id,
    amount,
    CASE
        WHEN amount BETWEEN 0 AND 2 THEN 'Low'
        WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
        WHEN amount > 4 THEN 'High'
        ELSE 'Unknown'
    END AS transaction_label
FROM
    payment;
    


    