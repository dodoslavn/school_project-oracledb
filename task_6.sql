
RETURN VARCHAR2



AS



CURSOR zaznam IS

SELECT * FROM knihyx WHERE knihy_id = p_id_knihy;

vystup zaznam%ROWTYPE;



BEGIN



OPEN zaznam;

FETCH zaznam INTO vystup;

CLOSE zaznam;



IF vystup.knihy_id IS NULL THEN RETURN '';

ELSE 

   IF vystup.pocet_stran < 50 THEN RETURN vystup.nazev||';'||vystup.autor||'.';

   ELSIF vystup.pocet_stran < 400 THEN RETURN vystup.nazev||';'||vystup.autor||';'||vystup.nakladetel||';'||vystup.rok_vydani||'.';

   ELSE RETURN vystup.nazev||';'||vystup.autor||';'||vystup.nakladetel||';'||vystup.rok_vydani||';'||vystup.misto_vydani||';'||vystup.pocet_stran||';'||vystup.isbn||'.';

   END IF;

END IF;

END;
