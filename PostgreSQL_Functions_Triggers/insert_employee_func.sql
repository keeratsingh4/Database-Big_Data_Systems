\set ECHO all
/* ====================================================== * 
 * Assignment 2                                  *
 * Student number: 8334572                               *
 * Name: Gurkeeratjit Singh Togar                                    *
 * ====================================================== */
--
-- Task 1
--
\set ECHO none

CREATE OR REPLACE FUNCTION insert_employee(
    emp_enum NUMERIC(12,0),
    emp_name TEXT,
    emp_dob DATE,
    emp_address TEXT,
    emp_hiredate DATE,
    emp_lnum NUMERIC(8,0),
    emp_status TEXT,
    emp_experience TEXT,
    is_mechanic BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    IF is_mechanic THEN
        IF EXISTS (SELECT 1 FROM driver WHERE enum = emp_enum OR lnum = emp_lnum) THEN
            RAISE EXCEPTION 'Employee with enum % or lnum % already exists in DRIVER table', emp_enum, emp_lnum;
        END IF;
        INSERT INTO trkemployee (enum, name, dob, address, hiredate) VALUES (emp_enum, emp_name, emp_dob, emp_address, emp_hiredate);
        INSERT INTO mechanic (enum, lnum, status, experience) VALUES (emp_enum, emp_lnum, emp_status, emp_experience);
    ELSE
        IF EXISTS (SELECT 1 FROM mechanic WHERE enum = emp_enum OR lnum = emp_lnum) THEN
            RAISE EXCEPTION 'Employee with enum % or lnum % already exists in MECHANIC table', emp_enum, emp_lnum;
        END IF;
        INSERT INTO trkemployee (enum, name, dob, address, hiredate) VALUES (emp_enum, emp_name, emp_dob, emp_address, emp_hiredate);
        INSERT INTO driver (enum, lnum, status) VALUES (emp_enum, emp_lnum, emp_status);
    END IF;
END;
$$ LANGUAGE plpgsql;


