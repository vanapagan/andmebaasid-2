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
$$ LANGUAGE plpgsql SECURITY DEFINER VOLATILE
SET search_path = public, pg_temp;