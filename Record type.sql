-- Insert data using record type.
-- Package Specification
create or replace package job_pkg is
    type job_rec is record(
        job_id number,
        job_name varchar2(200),
        dept_id number);
   
    function job_id_check(p_job number)
    return number;
   
    function job_name_check(p_job varchar2)
    return number;
   
    procedure job_insert(p_job job_rec);    
end job_pkg;
    

-- Package body	
set serveroutput on;
create or replace package body job_pkg
is 

function job_id_check(p_job number)
   return number
   is 
   v_id number;
   begin
        select count(*) into v_id from job where job_id = p_job;
        return v_id;
    end;
   
function job_name_check(p_job varchar2)
   return number
   is
   v_job varchar2(200);
   begin
        select count(*) into v_job from job where job_name = p_job;
        return v_job;
    end;
   
procedure job_insert(p_job job_rec)
is
begin
    if job_id_check(p_job.job_id) = 0 then
        if job_name_check(p_job.job_name) = 0 then
insert into job values (p_job.job_id,
                        p_job.job_name,
                        p_job.dept_id);
        else
            dbms_output.put_line('Job name already exists.');
        end if;
    else
        dbms_output.put_line('Job id already exists.');
    end if;
end;
end job_pkg;


--Package calling
set serveroutput on;
declare
    l_job job_pkg.job_rec;
    
begin
    l_job.job_id := 107;
    l_job.job_name := 'HR';
    l_job.dept_id := 10;
    
    job_pkg.job_insert(l_job);
end;
/
select * from job;


select * from emp;

select e.empno, e.ename emp_name, e.sal, m.mgr, m.ename emp_name, m.sal from emp e , emp m
where 
e.mgr = m.empno
and e.sal > m.sal;