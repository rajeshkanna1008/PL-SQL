XXX_EBSUSER_INTG_PKG:-

DBMS_LOB = DBMS_LOB can read and modify BLOBs and CLOBs;
it provides read-only operations for BFILEs. The bulk of the LOB operations are provided by this package.


BLOD = Binary large Object.

CLOB = Character large object.

UTL_RAW_CAST_TO_VARCHAR2 = Convert raw binary data to varchar2 string.

DBMS_LOB_WRITEAPPEND = Append a data to large object (CLOB) column in a table.

DBMS_LOB_CREATETEMPORARY = It is used to create a temporary LOB (Large Object) in Oracle.
Temporary LOBs are typically used to store large amounts of data temporarily, 
such as when performing operations on LOBs without persisting the data to the database.

APEX_JSON.GET_COUNT = is used to count the number of elements in a JSON document(objects, arrays).

APEX_JSON.GET_VARCHAR2 = function is used to extract a VARCHAR2 value from a JSON document. 
It allows you to retrieve a specific string value from a JSON object or array. 

APEX_JSON.WRITE = it is used to build a JSON document by adding JSON elements and values. 
It allows you to construct a JSON structure dynamically.

	apex_json.write('name', 'john');
	apex_json.write('age', '30');
	apex_json.write('city', 'new york');
	
APEX_JSON.PARSE = Parse a json string and convert into pl/sql object.

***************************************************************************************


Hierarchical query(Application Developer):

	
SET SERVEROUTPUT ON;

DECLARE
    l_menu_id              NUMBER;
    l_responsibility_name  VARCHAR2(200);
    l_sub_menu_id          NUMBER;
BEGIN
    l_responsibility_name := 'Application Developer';
    dbms_output.put_line(l_responsibility_name);
    SELECT
        menu_id
    INTO l_menu_id
    FROM
        fnd_responsibility_vl
    WHERE
        responsibility_name = l_responsibility_name;

    FOR i IN (
        SELECT
            prompt
        FROM
            fnd_menu_entries_vl
        WHERE
            menu_id = l_menu_id
    ) LOOP
        IF i.prompt IS NOT NULL THEN
            dbms_output.put_line(chr(9)
                                 || ':'
                                 || i.prompt);
        END IF;

        FOR j IN (
            SELECT
                sub_menu_id
            FROM
                fnd_menu_entries_vl
            WHERE
                    menu_id = l_menu_id
                AND prompt = i.prompt
        ) LOOP
            FOR k IN (
                SELECT
                    prompt
                FROM
                    fnd_menu_entries_vl
                WHERE
                    menu_id = j.sub_menu_id
            ) LOOP
                IF k.prompt IS NOT NULL THEN
                    dbms_output.put_line(chr(9)
                                         || chr(9)
                                         || chr(9)
                                         || ':'
                                         || k.prompt);
                END IF;

                FOR l IN (
                    SELECT
                        sub_menu_id
                    FROM
                        fnd_menu_entries_vl
                    WHERE
                            menu_id = j.sub_menu_id
                        AND prompt = k.prompt
                ) LOOP
                    FOR m IN (
                        SELECT
                            prompt
                        FROM
                            fnd_menu_entries_vl
                        WHERE
                            menu_id = l.sub_menu_id
                    ) LOOP
                        IF m.prompt IS NOT NULL THEN
                            dbms_output.put_line(chr(9)
                                                 || chr(9)
                                                 || chr(9)
                                                 || chr(9)
                                                 || chr(9)
                                                 || ':'
                                                 || m.prompt);

                        END IF;
                    END LOOP;
                END LOOP;

            END LOOP;
        END LOOP;

    END LOOP;

END;
/