CREATE OR REPLACE FUNCTION LONGTRIP(DLNUM numeric)
RETURNS integer AS $$
DECLARE
    longest_length integer;
BEGIN
    SELECT COALESCE(MAX(leg_count), 0) INTO longest_length
    FROM (
        SELECT t.tnum, COUNT(tl.legnum) AS leg_count
        FROM trip t
        JOIN tripleg tl ON t.tnum = tl.tnum
        WHERE t.lnum = DLNUM
        GROUP BY t.tnum
    ) AS trip_lengths;

    RETURN longest_length;
END;
$$ LANGUAGE plpgsql;
