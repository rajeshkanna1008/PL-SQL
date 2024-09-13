create or replace package job_details is 

    procedure insert_job(p_dept_no number,
                         p_job_id number,
                         p_job_name varchar2);
    
    function job_id_check (v_job_id number)
            return number;
        
    function job_name_check(v_job_name varchar2)
            return number;

end job_details;

create or replace package body job_details is

function job_id_check (v_job_id number)
        return number
        is
        v_job number;
        begin 
            select count(*) into v_job from job where job_id = v_job_id;
           return v_job;
        end;
    
    function job_name_check(v_job_name varchar2)
        return number
        is
        v_job_n number;
        begin 
            select count(*) into v_job_n from job where job_name = v_job_name;
           return v_job_n;
        end;
            
procedure insert_job (p_dept_no number, p_job_id number, p_job_name varchar2)
    is 
    begin
        if job_id_check(p_job_id) = 0 then
            if job_name_check(p_job_name) = 0 then 
                insert into job (dept_no,job_id, job_name) values
                (p_dept_no, p_job_id, p_job_name);
            else
                dbms_output.put_line('Job name already exist.');
            end if;
        else
            dbms_output.put_line('Job Id already exist.');
        end if;
        exception 
            when others then
                dbms_output.put_line(sqlerrm);
    end;
end job_details;