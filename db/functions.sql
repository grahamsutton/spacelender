/*
This is the functions.sql file used by Squirm-Rails. Define your Postgres stored
procedures in this file and they will be loaded at the end of any calls to the
db:schema:load Rake task.
*/

CREATE OR REPLACE FUNCTION search_listings(varchar) RETURNS varchar AS $$
  DECLARE
  	_term ALIAS FOR $1;
  BEGIN
    RETURN _term;
  END;
$$ LANGUAGE plpgsql;
