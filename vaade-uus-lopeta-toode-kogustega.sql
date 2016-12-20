SELECT ... tooted_kogused.kogus_kokku ...
FROM ... LEFT JOIN tooted_kogused ON toode.toode_id=tooted_kogused.toode_id ...

CREATE OR REPLACE VIEW Lopeta_toode2 WITH (security_barrier) AS  
SELECT Toode.toode_id, Toode.nimetus, Toote_seisundi_liik.nimetus AS seisund, Toode.kirjeldus, Toode.hind, Toode.pilt, Toode.pildilink, date(Toode.reg_aeg) AS reg_kp, tooted_kogused.kogus_kokku
FROM Toote_tyyp INNER JOIN (Toote_seisundi_liik INNER JOIN Toode ON Toote_seisundi_liik.toote_seisundi_liik_kood = Toode.toote_seisundi_liik_kood) 
ON Toote_tyyp.toote_tyyp_kood = Toode.toote_tyyp_kood
WHERE (((Toode.toote_seisundi_liik_kood) In (2,3)))
ORDER BY Toote_seisundi_liik.nimetus, Toode.nimetus;

COMMENT ON VIEW Lopeta_toode IS 'Lõpeta toode, kui toode on seda lubavas seisundis';


 SELECT toode.toode_id,
    toote_seisundi_liik.nimetus AS seisund,
    toode.nimetus,
    toode.kirjeldus,
    toode.hind,
    tooted_kogused.kogus_kokku,
    toode.pildilink,
    date(toode.reg_aeg) AS reg_kp
   FROM toote_seisundi_liik
     JOIN toode ON toote_seisundi_liik.toote_seisundi_liik_kood = toode.toote_seisundi_liik_kood
     LEFT JOIN tooted_kogused ON toode.toode_id = tooted_kogused.toode_id
  ORDER BY toode.nimetus;
  
  CREATE OR REPLACE VIEW Lopeta_toode2 WITH (security_barrier) AS  
  SELECT toode.toode_id,
    toode.nimetus,
    toote_seisundi_liik.nimetus AS seisund,
    toode.kirjeldus,
    toode.hind,
    toode.pilt,
    toode.pildilink,
    date(toode.reg_aeg) AS reg_kp
   FROM toote_tyyp
     JOIN (toote_seisundi_liik
     JOIN toode ON toote_seisundi_liik.toote_seisundi_liik_kood = toode.toote_seisundi_liik_kood) ON toote_tyyp.toote_tyyp_kood = toode.toote_tyyp_kood
  WHERE toode.toote_seisundi_liik_kood = ANY (ARRAY[2, 3])
  ORDER BY toote_seisundi_liik.nimetus, toode.nimetus;