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
