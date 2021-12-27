-- FUNCTION
-- Рахує кількість людей, що курять

CREATE OR REPLACE FUNCTION smoker_count() RETURNS int AS
    $$
        DECLARE
            res integer;
        BEGIN
            SELECT COUNT(*) INTO res
            FROM smokers
            WHERE isSmoker = 'YES';
            
            RETURN res;
        END;
    $$ LANGUAGE 'plpgsql';

SELECT * FROM smoker_count();


-- PROCEDURE
-- Виводить виплату для людини, ім'я якої передається аргументом в процедуру

CREATE OR REPLACE PROCEDURE charge_by_name(humName text)
LANGUAGE plpgsql AS
$$
	DECLARE
		humName_rec record;
	BEGIN
		FOR humName_rec IN
			SELECT insuranse.ins_charge
			FROM insuranse
 			INNER JOIN humans ON humans.hum_id = insuranse.hum_id
			WHERE humans.hum_name = humName
		LOOP
			RAISE INFO 'human charge =  %', humName_rec.ins_charge;
		END LOOP;
	END;
$$

CALL charge_by_name('STELLA');


-- TRIGGER
-- Додає слово "Mr." до імені людини, при додаванні нової

CREATE OR REPLACE FUNCTION Concat_Mr_To_HumanName() RETURNS TRIGGER AS
$$
	BEGIN
		UPDATE humans
        SET hum_name = 'Mr.' || NEW.hum_name
		WHERE humans.hum_id = NEW.hum_id;
		RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER  Concat_Mr_To_HumanName_Trigger
AFTER INSERT ON humans
FOR EACH ROW
EXECUTE FUNCTION Concat_Mr_To_HumanName()

SELECT * FROM humans;
INSERT INTO humans (hum_age,hum_name,hum_sex,child_id)
	VALUES (25,'VOLODYMYR','MALE',6);
SELECT * FROM humans;
