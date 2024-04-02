/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

/* First get daily averages from multiple transactions/rows per day.
   Then use the daily averages table to compute the 3-day-rolling average
   from the current day/row average and the average of the previous 2 days/rows.
*/
WITH daily_averages AS (
    SELECT 
  		date_trunc('day', transaction_time) AS transaction_date,
        AVG(transaction_amount) AS daily_avg
    FROM 
        transactions
    GROUP BY 
        date_trunc('day', transaction_time)
),
rolling_averages AS (
    SELECT 
        d1.transaction_date,
        AVG(d2.daily_avg) AS rolling_3_day_avg
    FROM 
        daily_averages d1
    JOIN 
        daily_averages d2 
    ON 
        d2.transaction_date BETWEEN d1.transaction_date - INTERVAL '2 day' AND d1.transaction_date
    GROUP BY 
        d1.transaction_date
)
SELECT 
    transaction_date,
    rolling_3_day_avg
FROM 
    rolling_averages
ORDER BY 
    transaction_date;


