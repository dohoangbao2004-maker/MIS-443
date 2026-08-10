-- =============================================================================
-- MIS 443 - 04_analysis_queries_exercise.sql   
-- Database : mis443_chinook
-- Schema   : new_chinook
-- Tables   : artist, album, genre, media_type, playlist, playlist_track,
--            track, employee, customer, invoice, invoice_line
-- =============================================================================

SET search_path TO new_chinook;


-- -----------------------------------------------------------------------------
-- Q1. QUESTION: Is the store growing, flat, or shrinking over time?
-- TODO: write your query here
SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    SUM(total) AS total_revenue
FROM invoice
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY month;
-- -----------------------------------------------------------------------------
-- Q2. QUESTION: Which countries generate the most revenue, and is a country
--     valuable because it has many customers or because each one spends more?
-- TODO: write your query here
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(i.total) AS total_revenue,
    ROUND(
        SUM(i.total) / COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_revenue_per_customer
FROM customer c
JOIN invoice i
    ON i.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q3. QUESTION: Which genres earn the most, and does catalog size match demand?
-- TODO: write your query here
SELECT
    g.genre_id,
    g.name AS genre,
    COUNT(DISTINCT t.track_id) AS catalog_size,
    SUM(il.quantity * il.unit_price) AS total_revenue
FROM genre g
JOIN track t
    ON t.genre_id = g.genre_id
LEFT JOIN invoice_line il
    ON il.track_id = t.track_id
GROUP BY
    g.genre_id,
    g.name
ORDER BY total_revenue DESC;
/* Rock generates the highest revenue but also has by far the largest catalog, 
Rock music generates the highest revenue and also boasts the most extensive catalog; 
other genres similarly demonstrate a correlation between revenue and catalog size, 
where lower revenue tends to correspond with a smaller catalog. */

-- -----------------------------------------------------------------------------
-- Q4. QUESTION: How much of the catalog has never sold a single unit?
-- TODO: write your query here
SELECT
    COUNT(*) AS unsold_tracks,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM track),
        2
    ) AS unsold_percentage
FROM track t
LEFT JOIN invoice_line il
    ON il.track_id = t.track_id
WHERE il.track_id IS NULL;

--     Q4b. Same anti-join, broken down by genre: where does the dead catalog sit?
-- TODO: write your query here
SELECT
    g.name AS genre,
    COUNT(t.track_id) AS unsold_tracks
FROM genre g
JOIN track t
    ON t.genre_id = g.genre_id
LEFT JOIN invoice_line il
    ON il.track_id = t.track_id
WHERE il.track_id IS NULL
GROUP BY
    g.genre_id,
    g.name
ORDER BY unsold_tracks DESC;
/* The tracks with the largest catalog sizes and highest revenues 
are also the ones with the highest number of unsold units; 
this indicates that higher revenue and catalog size correlate 
with the existence of tracks that fail to sell even a single copy. */

-- -----------------------------------------------------------------------------
-- Q5. QUESTION: Do sales agents differ in ability, or only in how many
--     customers they were assigned?
-- TODO: write your query here
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT i.invoice_id) AS invoice_count,
    COALESCE(SUM(i.total), 0) AS total_revenue,
    ROUND(
        COALESCE(SUM(i.total), 0) /
        NULLIF(COUNT(DISTINCT c.customer_id), 0),
        2
    ) AS revenue_per_customer
FROM employee e
LEFT JOIN customer c
    ON c.support_rep_id = e.employee_id
LEFT JOIN invoice i
    ON i.customer_id = c.customer_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name
HAVING COUNT(DISTINCT c.customer_id) > 0
ORDER BY total_revenue DESC;

-- -----------------------------------------------------------------------------
-- Q6. QUESTION: How did revenue accumulate over time, and how long did it take
--     to reach the first $1,000?
-- Q6a. Total sales over time (running total by day)
SELECT
    invoice_date::DATE AS revenue_date,
    SUM(SUM(total)) OVER (ORDER BY invoice_date::DATE) AS cumulative_revenue
FROM invoice
GROUP BY invoice_date::DATE
ORDER BY revenue_date;


-- Q6b. The date sales reached $1,000, and the days since the first sale
WITH cumulative AS (
    SELECT
        invoice_date::DATE AS revenue_date,
        SUM(SUM(total)) OVER (ORDER BY invoice_date::DATE) AS cumulative_revenue
    FROM invoice
    GROUP BY invoice_date::DATE
)
SELECT
    revenue_date AS date_reached_1000,
    cumulative_revenue,
	-- Subtract the first invoice date (2021-01-01)
    revenue_date - '2021-01-01'::DATE AS days_since_first_invoice
FROM cumulative
WHERE cumulative_revenue >= 1000
ORDER BY revenue_date
LIMIT 1;


-- =============================================================================
-- WHEN YOU ARE DONE
--
-- 1. Check each result against the EXPECTED note for that question.
--
-- 2. For every query, write one or two sentences answering the business
--    question. Do not describe the numbers - draw a conclusion. For example:
--
--       NO:  "Rock has 1297 tracks and 826.65 in revenue."
--       YES: "Rock is the largest genre but the lowest-yielding per track.
--             The store is over-invested in Rock."
--
-- 3. Screenshot the results of Q1, Q2, Q3, Q4 and Q5 for the report.
-- =============================================================================
