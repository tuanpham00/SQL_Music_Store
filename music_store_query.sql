-- Question 1: Who is the senior most employee based on job title?

SELECT * 
FROM 
	music_store.employee
ORDER BY 
	levels DESC
LIMIT 1
-- Answer 1: Adams Andew with level 6


-- Question 2: Which contries have the most Invoices?
SELECT 
	count(total) AS c, 
    billing_country
FROM 
	music_store.invoice
GROUP BY 
	billing_country
ORDER BY 
	c DESC 
-- Answer 2: USA with total invoice = 131


-- Question 3: What are top 3 values of total invoice?
SELECT 
	total
FROM 
	music_store.invoice
ORDER BY 
	total DESC
LIMIT 3 
-- Answer 3: 23.759; 19.8 and 19.8

-- Question 4: Which country has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.
SELECT 
	sum(total) AS total_invoice, 
    billing_city
FROM 
	music_store.invoice
GROUP BY 
	billing_city
ORDER BY 
	total_invoice DESC
-- Answer 4: Prague with total invoice = 273,24


-- Question 5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    SUM(invoice.total) AS total
FROM 
	music_store.customer
JOIN 
	music_store.invoice 
ON 
	customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
ORDER BY 
	total DESC
LIMIT 1
-- Answer 5: FrantiÅ¡ek	WichterlovÃ¡ with 144.54


-- Question 6: Write query to return the email, first name, last name, & genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A.
SELECT DISTINCT
	customer.email, 
    customer.first_name, 
    customer.last_name
FROM 
	music_store.customer
JOIN 
	music_store.invoice ON customer.customer_id = invoice.customer_id
JOIN 
	music_store.invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE 
	track_id IN (
		SELECT track_id FROM music_store.track
		JOIN music_store.genre ON track.genre_id = genre.genre_id
		WHERE genre.name LIKE 'Rock')
ORDER BY 
	email;

-- Question 7: Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT 
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS number_of_song
FROM 
    music_store.track
JOIN 
    music_store.album2 ON album2.album_id = track.album_id
JOIN 
    music_store.artist ON artist.artist_id = album2.artist_id
JOIN 
    music_store.genre ON genre.genre_id = track.genre_id
WHERE 
    genre.name LIKE 'Rock'
GROUP BY 
    artist.artist_id, 
    artist.name
ORDER BY 
    number_of_song DESC
LIMIT 10;

-- Question 8: Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

-- First, I found the average song length using AVG
SELECT 
	AVG(milliseconds) AS avg_track_lengths
FROM 
	music_store.track

-- The average song length is 25117.7431; therefore, I set up a condition to return all song names with longer song length using WHERE
SELECT
	track.name,
    track.milliseconds
FROM 
	music_store.track
WHERE
	milliseconds > 251177.7431
ORDER BY 
	milliseconds DESC;

 