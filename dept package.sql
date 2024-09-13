create or replace package dept_details
is 
procedure insert_dept (p_deptno number, p_dname varchar2);

    function dept_no_check (v_dept_no number)
        return number;
    
    function dept_name_check(v_dept_name varchar2)
        return boolean;
end dept_details;



create or replace package body dept_details is

    function dept_no_check(v_dept_no number)
        return number
        is
        v_deptno number;
        begin 
            select count(*) into v_deptno from dept where dept_no = v_dept_no;
           return v_deptno;
        end;
    
    function dept_name_check(v_dept_name varchar2)
        return boolean
        is
        begin
            if length(v_dept_name) >= 2 then  
                return true;
            else
                return false;
            end if;
    end;
        
procedure insert_dept (p_deptno number, p_dname varchar2)
    is
    begin
        if dept_no_check(p_deptno) = 0 then
            if job_name_check(p_dname) = 0 then
                insert into dept(dept_no, dname) values
                (p_deptno, p_dname);
            else
                dbms_output.put_line('Department Name is already exist.');
            end if;
        else
            dbms_output.put_line('Department Number is already exist.');
        end if;
        exception 
        when others then
            dbms_output.put_line(sqlerrm);
    end;
end dept_details;