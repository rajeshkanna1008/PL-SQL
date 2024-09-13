create or replace package student_insert is
    procedure insert_std (v_stu_id number, v_stu_name varchar2, v_DoB date, v_address varchar2, v_dept_id number);
    
    function std_name_check (v_stu_name varchar2)
    return boolean;
    
    function dob_check(v_Dob date)
    return boolean;
    
    function address_check (v_address varchar2)
    return boolean;

end student_insert;


create or replace package body student_insert is
    
    function std_name_check (v_stu_name varchar2)
    return boolean
    is 
    v_std number;
    begin
        select length(v_stu_name) into v_std from dual;
        if v_std >=3 then
            return true;
        else
            return false;
        end if;
    end;
    
    function dob_check(v_Dob date)
    return boolean
    is
    v_age number;
    begin
    select trunc(months_between(to_date(to_char(sysdate,'dd-mm-yyyy'),'DD-MM-YYYY'),
                    (to_date(v_dob,'DD-MM-YYYY')))/12) into v_age from dual;
    if v_age >=19 then
        return true;
    else
        return false;
    end if;
    end;
    
    function address_check (v_address varchar2)
    return boolean
    is
    v_add number;
    begin
        select length(v_address) into v_add from dual;
        if v_add >=5 then
            return true;
        else 
            return false;
        end if;
    end;
    
    
    procedure insert_std (v_stu_id number, v_stu_name varchar2, v_DoB date, v_address varchar2, v_dept_id number) is 
    l_id number;
    dept_id number;
    begin
    l_id := std_seq.nextval;
    dept_id := insert_data_pkg.v_dept_id_check(v_dept_id);
    
        if std_name_check(v_stu_name) = true then
            if dob_check(v_DoB) = true then
                if address_check(v_address) = true then
                    if dept_id(v_dept_id) = true then
                        insert into std_tbl (student_id, student_name, Dob, address, dept_id) values
                        (l_id, v_stu_name, v_DoB, v_address, v_dept_id);
                        else
                            dbms_output.put_line('Dept must be same as in dept table');
                        end if;
                    else
                        dbms_output.put_line('address must be more then 5 characters');
                    end if;
                else
                    dbms_output.put_line('Student age must be greater then or equals to 19 years');
                end if;
            else
                dbms_output.put_line('Student name must be more then 3 characters');
            end if;
    end;
end student_insert;                    
/

    