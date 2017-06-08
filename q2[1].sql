DROP TABLE IF EXISTS users; 
CREATE TABLE users (name VARCHAR(250));
INSERT INTO users (name) VALUES ("UNITED states Of AmERIca");
INSERT INTO users (name) VALUES ("JoHn SmITH");
INSERT INTO users (name) VALUES ("JamEs HoWLetT");
INSERT INTO users (name) VALUES ("NeYMar Da SiLVA         JUniOr");
INSERT INTO users (name) VALUES ("AlIsE De-BruNo");
INSERT INTO users (name) VALUES ("AlIsE MiLk_WhiTE");
INSERT INTO users (name) VALUES ("KevIN-PrINCe BoatENG");

DROP FUNCTION IF EXISTS capitalize_word;

DELIMITER $$

CREATE FUNCTION capitalize_word(user_name VARCHAR(250))
RETURNS VARCHAR(250) 
deterministic

BEGIN
	DECLARE first_char VARCHAR(250);
	DECLARE next_char VARCHAR(250);
	DECLARE result_string VARCHAR(250);
	DECLARE string_length INT;
	DECLARE counter_word INT;  
	DECLARE flag BIT(1);
	
	SET counter_word = 1;
	
	-- get first char and remove a whitespace if it exists at the beginning of a row
	SET first_char = SUBSTRING(TRIM(user_name), 1, 1);
 	
	 -- first letter is upper case
	SET result_string	= UPPER(first_char);
   
   -- get string length 
	SET string_length = LENGTH(user_name);
	
	SET flag = 0;
	
	
 	WHILE(counter_word < string_length)
		DO
		
		SET counter_word = counter_word + 1;
		
		SET next_char = SUBSTRING(user_name, counter_word, 1); 
	
			IF flag = 1  THEN
				SET result_string = CONCAT(result_string,UPPER(next_char));
				SET flag = 0;
		   ELSE
		      SET result_string = CONCAT(result_string,LOWER(next_char));
			END IF;
		
		-- If the character is a space - set the flag is true and execute upper case character in the next step 
			IF next_char = " " OR next_char = "-" OR next_char = "_" THEN
			    SET flag = 1;
		   END IF;
		   
		
	END WHILE;

  RETURN result_string;
  
END;
$$
DELIMITER ;

SELECT capitalize_word(name)
FROM users;