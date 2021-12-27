CREATE OR REPLACE FUNCTION Concat_Mr_To_HumanName() RETURNS TRIGGER AS
$$
	BEGIN
		UPDATE humans
        SET hum_name = 'Mr.' || NEW.hum_name;
		RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER  Concat_Mr_To_HumanName_Trigger
AFTER INSERT ON humans
FOR EACH ROW
EXECUTE FUNCTION Concat_Mr_To_HumanName()
