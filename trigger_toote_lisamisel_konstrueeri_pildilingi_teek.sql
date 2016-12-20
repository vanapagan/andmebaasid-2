--Toote lisamisel saab tema pildilingi väärtuseks img teek, mille src sisaldab selle toote pildi hüperlinki, juhul kui pildilink on eelnevalt määramata või on tühi string

CREATE OR REPLACE FUNCTION f_toote_lisamisel_konstrueeri_pildilingi_teek() RETURNS trigger AS $$
BEGIN
	IF NEW.pildilink IS NULL OR
		NEW.pildilink = '''' THEN
		NEW.pildilink = CONCAT('<img src="http://www.demon.ee/AB2Pics/', NEW.toode_id::text, '.jpg" style="max-width:75px;max-height:75px;">');
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION f_toote_lisamisel_konstrueeri_pildilingi_teek() 
IS 'See trigeri funktsioon aitab jõustada ärireegli: Toote lisamisel saab tema pildilingi väärtuseks img teek, mille src sisaldab selle toote pildi hüperlinki, juhul kui pildilink on määramata või on tühi string';

--old saab kasutada ainult update puhul. kui INSERT siis ainult new.
CREATE TRIGGER f_toote_lisamisel_konstrueeri_pildilingi_teek
BEFORE INSERT ON toode 
FOR EACH ROW 
EXECUTE PROCEDURE f_toote_lisamisel_konstrueeri_pildilingi_teek();