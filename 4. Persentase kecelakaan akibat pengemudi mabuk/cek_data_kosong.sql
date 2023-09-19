WITH cte_cek_number_of_drunk_kosong AS(
	SELECT consecutive_number,
	CASE 
		WHEN number_of_drunk_drivers IS NULL THEN 'data kosong' 
		ELSE CAST(number_of_drunk_drivers AS VARCHAR)
	END AS kosong
	FROM crash
	)
SELECT *
FROM cte_cek_number_of_drunk_kosong
WHERE kosong ='data kosong'