---TOOTE AKTIVEERIMINE---
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

---TOOTE LISAMISEL SAAB SEISUND VAIKIMISI VÄÄRTSUSE 1 (OOTEL)---
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

---TOOTE LÕPETAMINE---
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

---TOOTE LÕPETAMISE FUNKTSIOON, MIDA KASUTAB KASUTAJALIIDES---
--funktsioon peab olema VOLATILE!
CREATE OR REPLACE FUNCTION f_lopeta_toode(p_id int) 
RETURNS boolean  AS $$
BEGIN
UPDATE toode SET toote_seisundi_liik_kood = 4 WHERE toode_id = p_id;
IF FOUND THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;