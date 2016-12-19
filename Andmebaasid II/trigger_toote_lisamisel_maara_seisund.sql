--Toote lisamisel saab tema seisundi vaikimisi väärtuseks 1 (ootel), kui see juba ei ole 1 (ootel)

CREATE OR REPLACE FUNCTION f_toote_lisamisel_maara_vaikimisi_seisund() RETURNS trigger AS $$
BEGIN
	IF NEW.toote_seisundi_liik_kood IS NULL OR
		NOT (NEW.toote_seisundi_liik_kood = 1) THEN
		NEW.toote_seisundi_liik_kood = 1;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION f_toote_lisamisel_maara_vaikimisi_seisund() IS 'See trigeri funktsioon aitab jõustada ärireegli: Toote lisamisel saab tema seisundi vaikimisi väärtuseks 1 (ootel)';

--old saab kasutada ainult update puhul. kui INSERT siis ainult new.
CREATE TRIGGER trig_toote_lisamisel_maara_seisund
BEFORE INSERT ON toode 
FOR EACH ROW 
EXECUTE PROCEDURE f_toote_lisamisel_maara_vaikimisi_seisund();