CREATE OR REPLACE PROCEDURE uprav_knihu (p_id_knihy NUMBER, p_sloupce VARCHAR2, p_hodnota VARCHAR2) 

IS



CURSOR stlpce IS

SELECT column_name FROM user_tab_columns WHERE table_name = 'KNIHYX';

zaznam_stlpce stlpce%ROWTYPE;



id_neex NUMBER;

sloupec_neex NUMBER;

update_prikaz VARCHAR2(200);

BEGIN

SELECT COUNT(knihy_id) INTO id_neex FROM knihyx WHERE knihy_id = p_id_knihy;

IF id_neex = 0 THEN raise_application_error(-20578, 'Kniha s timto id neexistuje'); 



ELSE

  SELECT COUNT(*) INTO sloupec_neex FROM user_tab_columns WHERE table_name = 'KNIHYX' AND column_name = p_sloupce;

  IF sloupec_neex = 0 THEN 

     dbms_output.put_line ('Takovyto sloupec neexistuje');



     OPEN stlpce;

     LOOP

     FETCH stlpce INTO zaznam_stlpce;

     EXIT WHEN stlpce%NOTFOUND;

     dbms_output.put_line(zaznam_stlpce.column_name);

     END LOOP;

     CLOSE stlpce;

  ELSE 

     update_prikaz := 'UPDATE knihyx SET '||p_sloupce||' = '''||p_hodnota||''' WHERE knihy_id = '||p_id_knihy;

    EXECUTE IMMEDIATE update_prikaz;

  END IF;

END IF;

END;
