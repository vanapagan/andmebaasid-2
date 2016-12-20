--Kui käivitatakse Lõpeta toode (st toote_seisundi_liik_kood muudetakse väärtuseks 2), 
--siis kontrollitakse, et toode oleks olekus 1 või 3.

CREATE OR REPLACE FUNCTION f_valideeri_aktiveerimine() RETURNS trigger AS $$
BEGIN
RAISE EXCEPTION 'Ei saa aktiveerida toodet, mis ei ole seisundis 1 (ootel) või 3 (mitteaktiivne)';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION f_valideeri_aktiveerimine() IS 'See trigeri funktsioon aitab jõustada ärireegli: Ei
saa aktiveerida toodet, kui toode ei ole seisundis 1 (ootel) või 3 (mitteaktiivne).';


--old saab kasutada ainult update puhul. kui INSERT siis ainult new.
CREATE TRIGGER trig_valideeri_aktiveerimine 
BEFORE UPDATE OF toote_seisundi_liik_kood ON toode FOR EACH ROW 
WHEN (
(NOT (OLD.toote_seisundi_liik_kood=NEW.toote_seisundi_liik_kood OR OLD.toote_seisundi_liik_kood IN (1,3))) AND NEW.toote_seisundi_liik_kood=2)
EXECUTE PROCEDURE f_valideeri_aktiveerimine();