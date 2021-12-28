CREATE OR REPLACE VIEW moje_knizky AS

SELECT knihy_id id, knihyx.nazev, knihyx.autor,

CASE WHEN knihyx.jazyky_id = '' THEN 'Neni uvedeno' ELSE jazyky.nazev END jazyk,

CASE WHEN knihyx.druhy_id = '' THEN 'Neni uvedeno' ELSE druhy.nazev END druh,

nakladetel, editace, vydani, misto_vydani, rok_vydani, pocet_stran, isbn

FROM knihyx 

JOIN jazyky ON jazyky.jazyky_id = knihyx.jazyky_id

JOIN druhy ON druhy.druhy_id = knihyx.druhy_id

WHERE (rok_vydani >= 1990) AND (rok_vydani <= 2007) AND (pocet_stran <= 530)

WITH CHECK OPTION CONSTRAINT moje_knizky_cnst
