DROP TABLE IF EXISTS bugs;
CREATE TABLE bugs (
  id INT,
  severity INT,
  open_date DATE,
  close_date DATE
);

INSERT INTO bugs VALUES
 (1, 1, STR_TO_DATE('2012-01-01', '%Y-%m-%d'), STR_TO_DATE('2012-01-04', '%Y-%m-%d')),
 (2, 1, STR_TO_DATE('2012-01-01', '%Y-%m-%d'), STR_TO_DATE('2012-01-02', '%Y-%m-%d')),
 (3, 1, STR_TO_DATE('2012-01-02', '%Y-%m-%d'), STR_TO_DATE('2012-01-03', '%Y-%m-%d')),
 (4, 1, STR_TO_DATE('2012-01-03', '%Y-%m-%d'), STR_TO_DATE('2012-01-03', '%Y-%m-%d')),
 (5, 1, STR_TO_DATE('2012-01-04', '%Y-%m-%d'), STR_TO_DATE('2012-01-05', '%Y-%m-%d')),
 (6, 1, STR_TO_DATE('2012-01-01', '%Y-%m-%d'), STR_TO_DATE('2012-01-01', '%Y-%m-%d')),
 (7, 1, STR_TO_DATE('2012-01-15', '%Y-%m-%d'), null);



DROP PROCEDURE IF EXISTS search_bugs;
DELIMITER $$

CREATE PROCEDURE search_bugs (start_date DATE, end_date DATE)
BEGIN

SELECT asd.dates , 
(select count(*) FROM bugs WHERE open_date<=asd.dates AND (close_date >= asd.dates or close_date is null)) as number_of_bus from (
SELECT ADDDATE(start_date, INTERVAL @i:=@i+1 DAY) AS dates
FROM (
SELECT a.a
FROM (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
) a
JOIN (SELECT @i := -1) r1
WHERE 
@i < DATEDIFF(end_date, start_date)) asd;
 
END;

$$

DELIMITER ;
CALL search_bugs(STR_TO_DATE('2012-01-01', '%Y-%m-%d'), STR_TO_DATE('2012-04-01', '%Y-%m-%d'));