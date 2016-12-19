--Kui käivitatakse Lõpeta toode (st toote_seisundi_liik_kood muudetakse väärtuseks 4), 
--siis kontrollitakse, et toode oleks olekus 2 või 3.

CREATE OR REPLACE FUNCTION f_valideeri_lopetamine() RETURNS trigger AS $$
BEGIN
RAISE EXCEPTION 'Ei saa lõpetada toodet, mis ei ole seisundis 2 (aktiivne) või 3 (mitteaktiivne)';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION f_valideeri_lopetamine() IS 'See trigeri funktsioon aitab jõustada ärireegli: Ei
saa lõpetada toodet, kui toode ei ole seisundis 2 (aktiivne) või 3 (mitteaktiivne).';

--old saab kasutada ainult update puhul. kui INSERT siis ainult new.
CREATE TRIGGER trig_valideeri_lopetamine 
BEFORE UPDATE OF toote_seisundi_liik_kood ON toode FOR EACH ROW 
WHEN (
(NOT (OLD.toote_seisundi_liik_kood=NEW.toote_seisundi_liik_kood OR OLD.toote_seisundi_liik_kood IN (2,3))) AND NEW.toote_seisundi_liik_kood=4)
EXECUTE PROCEDURE f_valideeri_lopetamine();