CREATE OR REPLACE PROCEDURE statistika_vlastnika (p_osoby_id IN NUMBER) 

IS



CURSOR vypis_osoby IS



SELECT prijmeni, jmeno FROM osoby WHERE id_osoby = p_osoby_id;

zaznam_osoba vypis_osoby%ROWTYPE;



CURSOR pocet_exem IS

SELECT COUNT(*) pocet FROM exemplare WHERE osoby_id = p_osoby_id;

zaznam_pocet_exem pocet_exem%ROWTYPE;



CURSOR pocet_knih IS

SELECT COUNT(*) pocet FROM exemplare  exem WHERE osoby_id = p_osoby_id AND 1 < (SELECT COUNT(*) FROM exemplare WHERE (osoby_id = exem.osoby_id) AND (knihy_id = exem.knihy_id) ) GROUP BY knihy_id;

zaznam_pocet_knih pocet_knih%ROWTYPE;



CURSOR pocet_vypuj IS

SELECT COUNT(*) pocet FROM exemplare WHERE osoby_id = p_osoby_id;

zaznam_pocet_vypuj pocet_vypuj%ROWTYPE;



vynimka NUMBER;



BEGIN

SELECT id_osoby INTO vynimka FROM osoby WHERE id_osoby = p_osoby_id;





OPEN vypis_osoby;

FETCH vypis_osoby INTO zaznam_osoba;

CLOSE vypis_osoby;

dbms_output.put_line (UPPER(zaznam_osoba.jmeno)||' '||UPPER(zaznam_osoba.prijmeni));



OPEN pocet_exem;

FETCH pocet_exem INTO zaznam_pocet_exem;

CLOSE pocet_exem;

dbms_output.put_line (' - pocet exemplaru: '||zaznam_pocet_exem.pocet);



OPEN pocet_knih;

FETCH pocet_knih INTO zaznam_pocet_knih;

CLOSE pocet_knih;

dbms_output.put_line (' - pocet knih drzenych ve vice exemplarich: '||zaznam_pocet_knih.pocet);



OPEN pocet_vypuj;

FETCH pocet_vypuj INTO zaznam_pocet_vypuj;

CLOSE pocet_vypuj;

dbms_output.put_line (' - pocet vypujceni: '||zaznam_pocet_vypuj.pocet);





EXCEPTION 

  WHEN NO_DATA_FOUND THEN

  dbms_output.put_line ('Osobu se nepodarilo najit.');



END;
