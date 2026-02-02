SELECT * FROM trade_data LIMIT 5;

-- Top Export Commodity Year-Wise
SELECT year, commodity, SUM(value) AS total_export
FROM trade_data
WHERE trade_type = 'Export'
GROUP BY year, commodity
ORDER BY year, total_export DESC;

-- Top 1 Export Commodity Per Year
SELECT year, commodity, total_export
FROM (
    SELECT year,
           commodity,
           SUM(value) AS total_export,
           RANK() OVER(PARTITION BY year ORDER BY SUM(value) DESC) AS rnk
    FROM trade_data
    WHERE trade_type = 'Export'
    GROUP BY year, commodity
) ranked
WHERE rnk = 1;

-- Top 10 Commodities Overall
SELECT commodity, SUM(value) AS total_trade
FROM trade_data
GROUP BY commodity
ORDER BY total_trade DESC
LIMIT 10;

-- Year-wise Export and Import Totals
SELECT year,
       trade_type,
       SUM(value) AS total_value
FROM trade_data
GROUP BY year, trade_type
ORDER BY year;

-- Trade Balance Per Year (Export - Import)
SELECT year,
       SUM(CASE WHEN trade_type = 'Export' THEN value ELSE 0 END) -
       SUM(CASE WHEN trade_type = 'Import' THEN value ELSE 0 END) AS trade_balance
FROM trade_data
GROUP BY year
ORDER BY year;

-- Top 10 Trade Partner Countries
SELECT country, SUM(value) AS total_trade
FROM trade_data
GROUP BY country
ORDER BY total_trade DESC
LIMIT 10;

-- Top Export Destinations
SELECT country, SUM(value) AS total_exports
FROM trade_data
WHERE trade_type = 'Export'
GROUP BY country
ORDER BY total_exports DESC
LIMIT 10;

-- Top Import Source Countries
SELECT country, SUM(value) AS total_imports
FROM trade_data
WHERE trade_type = 'Import'
GROUP BY country
ORDER BY total_imports DESC
LIMIT 10;

-- Top 5 Export Commodities of India
SELECT commodity, SUM(value) AS total_export
FROM trade_data
WHERE trade_type = 'Export'
GROUP BY commodity
ORDER BY total_export DESC
LIMIT 5;

-- Top 5 Import Commodities of India
SELECT commodity, SUM(value) AS total_import
FROM trade_data
WHERE trade_type = 'Import'
GROUP BY commodity
ORDER BY total_import DESC
LIMIT 5;

-- Yearly Trade Summary
CREATE VIEW yearly_trade_summary AS
SELECT year,
       trade_type,
       SUM(value) AS total_value
FROM trade_data
GROUP BY year, trade_type;

-- Top Commodities
CREATE VIEW commodity_summary AS
SELECT commodity,
       SUM(value) AS total_trade
FROM trade_data
GROUP BY commodity;


-- Country Trade Summary
CREATE VIEW country_summary AS
SELECT country,
       SUM(value) AS total_trade
FROM trade_data
GROUP BY country;











