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
