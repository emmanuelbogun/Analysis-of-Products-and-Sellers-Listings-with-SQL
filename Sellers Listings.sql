--- Creating the tables ----
CREATE TABLE brands (
	id_brand integer PRIMARY KEY,
	brand text UNIQUE)
	
CREATE TABLE category (
	id_category integer,
	category text)
	
CREATE TABLE clicks (
	datetime_session timestamp,
	id_user varchar(255),
	id_product integer,
	event_category text,
	event_action text,
	event_label text)
	
CREATE TABLE listings (
	id_ integer,
	id_customer varchar(255),
	id_brand integer,
	id_category integer,
	date_created timestamp,
	date_completed timestamp,
	date_sold timestamp)

-- DATA ANALYSIS --
-- Top 10 Brands with the most completed listings
SELECT b.brand, COUNT(l.id_brand) AS completed_listings
FROM brands b
JOIN listings l
ON b.id_brand = l.id_brand
AND l.date_completed IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

/* Per customer, show number of total listings started, 
listings completed and listings sold; order by listings started descending? */
SELECT id_customer,
		COUNT(date_created) strt,
		COUNT(date_completed) copm,
		COUNT(date_sold) sold
FROM listings
GROUP BY 1
ORDER BY 2 DESC;

--- Per customer, if True or False they listed items in Clothing, Bags, Shoes and Accessories categories? ---
SELECT id_customer,
		id_category,
		CASE WHEN id_category >=2 AND id_category <=6 THEN True
		ELSE False END AS cbsa_category
FROM listings
GROUP BY 1,2;
	
/* Per seller: date of their first listing, date of their last listing, 
date of last sale and name of last action (completed list/sale)? */
SELECT id_,
		MIN(date_created) AS first_listn, 
		MAX(date_completed) AS last_listn,
		MAX(date_sold) AS last_sales,
		CASE WHEN MIN(date_completed) IS NOT NULL AND MAX(date_sold) IS NULL THEN 'completed list'
		WHEN MIN(date_completed) IS NOT NULL AND MAX(date_sold) IS NOT NULL THEN 'sale'
		ELSE NULL END AS last_action
FROM listings
GROUP BY 1;	

-- Median number of clicks made on listing form for submitted products? --------
WITH CTE AS (
	SELECT id_product,
		ROW_NUMBER() OVER(ORDER BY c.id_product ASC) AS rn_asc,
		ROW_NUMBER() OVER(ORDER BY c.id_product DESC) AS rn_desc
	FROM clicks c
	JOIN listings l
	ON c.id_product = l.id_
	AND l.date_completed IS NOT NULL)

SELECT ROUND(AVG(rn_asc), 0)
FROM CTE
where abs(rn_asc - rn_desc) <=1;

-- Per product that was not submitted : last seller's action on listing form? ----
WITH t1 AS (
	SELECT c.id_product prod, c.event_action last_action, c.datetime_session time_of_action
	FROM clicks c
	JOIN listings l
	ON c.id_product = l.id_
	AND l.date_completed IS NULL
	ORDER BY 1),
t2 AS (
	SELECT prod, MAX(time_of_action) last_time_of_action
	FROM t1
	GROUP BY 1)
	
SELECT t2.prod, t1.last_action
FROM t1
JOIN t2
ON t1.prod = t2.prod
AND t1.time_of_action = t2.last_time_of_action;