insert into staging.kunde (kunde_id, vorname, nachname, anrede, geschlecht, geburtsdatum, wohnort, quelle)
  values (171894, 'Max', 'Duerr', 'Herr', 'männlich', to_date('20.03.2002', 'DD.MM.YYYY'), 1, 'CRM');

insert into staging.fahrzeug (fin, kunde_id, baujahr, modell, quelle)
  values ('WOL000051T2123456', 171894, 2007, 'Insignia 2.0', 'Fahrzeug DB');

insert into staging.kfzzuordnung (fin, kfz_kennzeichen, quelle)
  values ('WOL000051T2123456', 'JC-AK 234', 'Fahrzeug DB');