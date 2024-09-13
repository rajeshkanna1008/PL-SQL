create or replace package emp_detail_pkg
is 
    procedure insert_emp2 ( p_emp_id number, 
                            p_emp_name varchar2, 
                            p_dob date, 
                            p_job varchar2, 
                            p_dept_no number, 
                            P_salary number,
                            p_hire_date date,
                            p_end_date date);

function emp_id_check (v_emp_id number)
        return number;
        
    function emp_name_check (v_emp_name varchar2)
        return boolean;
    
    function age_check (v_dob date)
        return boolean;
    
    function job_check (v_job varchar2)
        return boolean;
    
    function hire_date_check (v_hire_date date)
        return boolean;
end emp_detail_pkg;

/
create or replace package body emp_detail_pkg
is 
    function emp_id_check (v_emp_id number)
        return number
        is
        v_empid number;
        begin 
            select count(*) into v_empid from emp2 where emp_id = v_emp_id;
           return v_empid;
        end;
    
    function emp_name_check (v_emp_name varchar2)
        return boolean
        is
        begin
            if length(v_emp_name) >= 3 then  
                return true;
            else
                return false;
            end if;
        end;
        
    function age_check (v_dob date)
        return boolean
        is
        v_age number;
        begin
            select trunc(months_between(to_date(to_char(sysdate,'dd-mm-yyyy'),'DD-MM-YYYY'),
                            (to_date(v_dob,'DD-MM-YYYY')))/12) into v_age from dual;
                            
            if v_age >21 then
                return true;
            else
                return false;
            end if;
        end;
        
    
    function job_check (v_job varchar2)
        return boolean
        is
        job_len number;
        begin
            select length(v_job) into job_len from dual;-- where job = v_job;
            if job_len >= 3 then
                return true;
            else
                return false;
            end if;
        end;
        
    function hire_date_check (v_hire_date date)
        return boolean
        is 
        v_date varchar2(50);
        begin
            select to_char(v_hire_date,'FMDAY') into v_date from dual;-- where hire_date = v_hire_date;
            if v_date = 'SUNDAY' then
                return false;
            else
                return true;
            end if;
        end;

procedure insert_emp2 ( p_emp_id number, 
                        p_emp_name varchar2, 
                        p_dob date, 
                        p_job varchar2, 
                        p_dept_no number, 
                        P_salary number,
                        p_hire_date date,
                        p_end_date date)
    is 
    begin
        if emp_id_check(p_emp_id) = 0 then
            if emp_name_check(p_emp_name) = true then
                if age_check(p_dob) = true then
                    if job_check(p_job) = true then
                        if hire_date_check(p_hire_date) = true then
                            insert into emp2 (emp_id,emp_name,Dob,job, dept_no, salary, hire_date, end_date) values
                            (p_emp_id, p_emp_name, p_dob, p_job, p_dept_no, P_salary, p_hire_date ,p_end_date);
                        else
                            dbms_output.put_line('Invalid date, Start date is not an sunday');
                        end if;
                    else
                        dbms_output.put_line('Invalid job_name, Job Name must be 3 characters.');
                    end if;
                else
                    dbms_output.put_line('Employee age is must be more then 21 years.');
                end if;
            else
                dbms_output.put_line('Employye Name must be 3 characters.');
            end if;
        else
            dbms_output.put_line('Employee already exist.');
        end if;
        exception
            when others then
            dbms_output.put_line(sqlerrm);
    end;
end emp_detail_pkg;