DROP TABLE IF EXISTS sometbl;
 
CREATE TABLE sometbl (ID INT, NAME VARCHAR(50));
INSERT INTO sometbl VALUES
 (1, 'Smith'),
 (2, 'Julio|Jones|Falcons'),
 (3, 'White|Snow'), 
 (4, 'Paint|It|Red'),
 (5, 'Green|Lantern'),
 (6, 'Brown|bag');
  

DROP PROCEDURE IF EXISTS delimiter_rows;

DELIMITER $$

CREATE PROCEDURE delimiter_rows(delimiter_char VARCHAR(250))

BEGIN 

	DECLARE counter_id INT;  	
	DECLARE count_rows INT;  
	DECLARE string_length INT;
	DECLARE counter_letter INT;  
	DECLARE row_current VARCHAR(250);
	DECLARE result_string VARCHAR(250);
	DECLARE next_char VARCHAR(1);
	
	-- create new table for result set	
	DROP TABLE IF EXISTS result_table;
	CREATE TABLE result_table (ID INT, NAME VARCHAR(50));
	
	-- get number of rows	
	SET count_rows = (SELECT COUNT(ID) FROM sometbl);  -- 6 

	-- get amount count id
	SET counter_id = 1;
	
	-- for amount letter in row
	SET counter_letter = 1;
	
	WHILE(count_rows > 0)
	DO
		-- get current row
		SET row_current = (SELECT NAME FROM sometbl WHERE ID = counter_id); 

		-- get length current row
		SET string_length = LENGTH(row_current);
			
		-- initialize the variable in the first step and to null the variable at each step
		SET result_string = ""; 
		
				
				WHILE(string_length >= counter_letter) 
				DO
					SET next_char = SUBSTRING(row_current, counter_letter, 1); 
					
					IF next_char = delimiter_char THEN 
						 INSERT INTO result_table VALUES(counter_id, result_string);	
						 SET result_string = ""; 
				-- if delimiter does not exist insert all rows		 
					ELSEIF string_length = counter_letter THEN
						 SET result_string = CONCAT(result_string, next_char);	
						INSERT INTO result_table VALUES(counter_id, result_string);
					ELSE
						  SET result_string = CONCAT(result_string, next_char);	
					END IF;
				
			  	SET counter_letter = counter_letter + 1;
			   END WHILE;
			   
		 SET counter_letter = 1;
	  	 SET count_rows = count_rows - 1;	
		 SET counter_id = counter_id + 1; 
		
	END WHILE;
	SELECT * FROM result_table;

END;
$$
DELIMITER ;

CALL delimiter_rows('|');