CREATE OR REPLACE TRIGGER zmazanie
INSTEAD OF DELETE ON moje_knizky
BEGIN 
   DELETE FROM knihyx WHERE knihy_id = :new.id;   
END;
