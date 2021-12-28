CREATE OR REPLACE PROCEDURE odd_informace
IS

CURSOR aa IS
SELECT akt.nazev, akt.id_oddeleni,
(SELECT COUNT(*) FROM exemplare WHERE oddeleni_id = akt.id_oddeleni) pocet
FROM oddeleni  akt;


CURSOR bb(idd IN NUMBER) IS
SELECT DISTINCT(exem.knihy_id),  knihyx.nazev naz,
(SELECT COUNT(*) FROM exemplare WHERE knihy_id = exem.knihy_id AND oddeleni_id = idd) pocet,
 knihyx.nazev, exem.exemplare_id FROM exemplare exem JOIN knihyx ON exem.knihy_id = knihyx.knihy_id WHERE exem.oddeleni_id = idd;

riadok aa%ROWTYPE;
vysledok bb%ROWTYPE;

BEGIN

OPEN aa;

LOOP
FETCH aa INTO riadok;
EXIT WHEN aa%NOTFOUND;
dbms_output.put_line(' ');
dbms_output.put_line(' ');
dbms_output.put_line(riadok.nazev||' - '||riadok.pocet);
dbms_output.put_line('========');

OPEN bb(riadok.id_oddeleni);
LOOP
FETCH bb INTO vysledok;
EXIT WHEN bb%NOTFOUND;
dbms_output.put_line(vysledok.naz);
END LOOP;
CLOSE BB;
END LOOP;

CLOSE aa;

END;

