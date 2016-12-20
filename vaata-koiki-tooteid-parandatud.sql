/*Vaata kõiki tooteid*/
CREATE OR REPLACE VIEW Vaata_koiki_tooteid WITH (security_barrier) AS SELECT Toode.toode_id, Toote_seisundi_liik.nimetus AS seisund, 
Toode.nimetus, Toode.kirjeldus, Toode.hind, tooted_kogused.kogus_kokku, Toode.pildilink, date(Toode.reg_aeg) AS reg_kp
FROM (Toote_seisundi_liik INNER JOIN Toode ON Toote_seisundi_liik.toote_seisundi_liik_kood = Toode.toote_seisundi_liik_kood)
LEFT JOIN tooted_kogused ON toode.toode_id=tooted_kogused.toode_id
ORDER BY Toode.nimetus;

COMMENT ON VIEW Vaata_koiki_tooteid IS 'Vaade kuvab kõikide toodete infot';