SELECT
    STR_TO_DATE(ds, '%m/%d/%Y') AS Date,
    COUNT(job_id) AS jobs_reviewed,
    SUM(time_spent) AS total_time_spent,
    COUNT(job_id) / SUM(time_spent) AS jobs_per_hour
FROM job_data
WHERE STR_TO_DATE(ds, '%m/%d/%Y') BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY Date
ORDER BY Date;



SELECT
    date,
    AVG(throughput) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS seven_day_rolling_average
FROM (
    SELECT
        date,
        COUNT(job_id) AS throughput
    FROM (
        SELECT
            DATE(time_spent) AS date,
            job_id
        FROM job_data
    ) AS subquery
    GROUP BY date
) AS subquery2
ORDER BY date;

SELECT
    language,
    COUNT(*) AS total_jobs,
    COUNT(*) / SUM(COUNT(*)) OVER () * 100 AS percentage_share
FROM job_data
WHERE STR_TO_DATE(ds, '%m/%d/%Y') >= DATE(NOW()) - INTERVAL 30 DAY
GROUP BY language
ORDER BY percentage_share DESC;

select distinct(ds)
from job_data;


