\set ECHO all
/* ====================================================== * 
 * Assignment 2                                  *
 * Student number: 8334572                               *
 * Name: Gurkeeratjit Singh Togar                                    *
 * ====================================================== */
--
-- Task 2
--
\set ECHO none

CREATE OR REPLACE FUNCTION update_total_trip_made_func() 
RETURNS TRIGGER AS $$
BEGIN
    UPDATE driver
    SET totaltripmade = COALESCE(totaltripmade, 0) + 1
    WHERE lnum = NEW.lnum;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_total_trip_made
AFTER INSERT ON trip
FOR EACH ROW
EXECUTE FUNCTION update_total_trip_made_func();
