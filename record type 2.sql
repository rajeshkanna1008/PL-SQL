-- Insert data using record type.
-- Package Specification
create or replace package job_pkg is

    type job_rec is record(
        job_id number,
        job_name varchar2(200),
        dept_id number);
        
    type emp_rec is record (
        emp_id number,
        emp_name varchar2(200),
        DoB date,
        HireDate date,
        salary number);
    
    type dept_rec is record(
        dept_id number,
        dept_name varchar2(200));
   
    function job_id_check(p_job number)
        return number;
   
    function job_name_check(p_job varchar2)
        return number;
    
    function emp_id_check (v_emp_id number)
        return number;
   
    function emp_name_check (v_emp_name varchar2)
        return boolean;

    function age_check (v_dob date)
        return boolean;

    function hire_date_check (v_hire_date date)
        return boolean;
        
    function dept_no_check (v_dept_no number)
        return number;
    
    function dept_name_check(v_dept_name varchar2)
        return number;

    procedure job_insert(p_job job_rec);
    procedure emp_insert(p_emp emp_rec);
    procedure dept_insert(p_dept dept_rec);
    
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
    
    function hire_date_check (v_hire_date date)
        return boolean
        is 
        v_date varchar2(50);
        begin
            select to_char(v_hire_date,'FMDAY') into v_date from dual;
            if v_date = 'SUNDAY' then
                return false;
            else
                return true;
            end if;
        end;
        
    function dept_no_check (v_dept_no number)
        return number
        is
        v_deptno number;
        begin 
            select count(*) into v_deptno from dept1 where dept_id = v_dept_no;
           return v_deptno;
        end;
    
    function dept_name_check(v_dept_name varchar2)
        return number
        is
        v_dept number;
        begin
            select count(*) into v_dept from dept1 where dept_name = v_dept_name;
                return v_dept;
        end;
        
        
        
procedure job_insert(p_job job_rec)
is
s_job number;
begin
s_job := seq_job.nextval;
        if job_name_check(p_job.job_name) = 0 then
            insert into job1 values (p_job.s_job,
                                    p_job.job_name,
                                    p_job.dept_id);
        else
            dbms_output.put_line('Job name already exists.');
        end if;    
end job_insert;

procedure dept_insert(p_dept dept_rec)
is
s_dept number ;
begin
s_dept := seq_dept.nextval;
        if dept_name_check(p_dept.dept_name) = 0 then
            insert into dept1 values (p_dept.s_dept,
                                      p_dept.dept_name);
        else
            dbms_output.put_line('Dept name already exists.');
        end if;
end dept_insert;

procedure emp_insert(p_emp emp_rec)
is
s_emp number;
begin
s_emp  := seq_emp.nextval;
    if emp_name_check(p_emp.emp_name) = true then
        if age_check(p_emp.DoB) = true then
            if hire_date_check(p_emp.Hiredate) = true then
                insert into emp1 values(p_emp.s_emp,
                                        p_emp.emp_name,
                                        p_emp.DoB,
                                        p_emp.Hiredate,
                                        p_emp.salary);
            else
                dbms_output.put_line('Hire Date is not an sunday, Please change the date.');
            end if;
        else
            dbms_output.put_line('Employye age is must be 21 years above.');
        end if;
    else
        dbms_output.put_line('Employye name must be more then 3 characters.');
    end if;
end emp_insert;

end job_pkg;

--====================================================
declare
    v_dept job_pkg.dept_rec;
begin
    v_dept.dept_name := 'Testing';
    job_pkg.dept_insert(v_dept);
    v_dept.dept_name := 'Sales';
    job_pkg.dept_insert(v_dept);
    v_dept.dept_name := 'Markting';
    job_pkg.dept_insert(v_dept);
    v_dept.dept_name := 'Digital Markting';
    job_pkg.dept_insert(v_dept);
    v_dept.dept_name := 'Accounting'; 
    job_pkg.dept_insert(v_dept);
end;
/
select * from dept1;


declare
    v_job job_pkg.job_rec;
    
begin
    v_job.job_name := 'SQL Developer';
    v_job.dept_id := 10;
    job_pkg.job_insert(v_job);   
    v_job.job_name := 'PL/SQL Developer';
    v_job.dept_id := 10;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'EBS Developer';
    v_job.dept_id := 10;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'Cloud Developer';
    v_job.dept_id := 10;
    job_pkg.job_insert(v_job);    
    v_job.job_name := 'APEX Developer';
    v_job.dept_id := 10;
    job_pkg.job_insert(v_job);   
    v_job.job_name := 'Accounting';
    v_job.dept_id := 20;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'Cleark';
    v_job.dept_id := 20;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'QA Testing';
    v_job.dept_id := 30;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'Manual Tester';
    v_job.dept_id := 30;
    job_pkg.job_insert(v_job);
    v_job.job_name := 'Assit_Manager';
    v_job.dept_id := 40;
    job_pkg.job_insert(v_job);   
end;
/

declare
    v_emp job_pkg.emp_rec;
begin
    v_emp.emp_name := 'Rajesh';
    v_emp.DoB := '11-10-1999';
    v_emp.hiredate := '05-06-2023';
    v_emp.salary := 25000;  
    job_pkg.emp_insert(v_emp);
    
    v_emp.emp_name := 'Naveen';
    v_emp.DoB := '28-02-1998';
    v_emp.hiredate := '01-02-2021';
    v_emp.salary := 20000;  
    job_pkg.emp_insert(v_emp);
    
    v_emp.emp_name := 'Janu';
    v_emp.DoB := '05-07-1999';
    v_emp.hiredate := '20-05-2021';
    v_emp.salary := 35000;  
    job_pkg.emp_insert(v_emp);
    
    v_emp.emp_name := 'Anwar';
    v_emp.DoB := '30-06-1999';
    v_emp.hiredate := '06-12-2023';
    v_emp.salary := 20000;  
    job_pkg.emp_insert(v_emp);
end;
/
--===================================================

create sequence seq_emp 
    start with 1
    increment by 1
    minvalue 0
    maxvalue 100
    nocycle;
    
create sequence seq_dept
    start with 10
    increment by 10
    minvalue 0
    maxvalue 100
    nocycle;
    
create sequence seq_job
    start with 100
    increment by 1
    minvalue 0
    maxvalue 200
    nocycle;
--==============================================
--function for display emp names according to their manager id.

-- function creating
set serveroutput on;

create or replace function emp_find (p_emp_id number)
    return varchar2
is
    emp_name varchar2(200);
begin
    select listagg(b.ename, ',') 
    into emp_name 
    from emp a,emp b 
    where a.empno = b.mgr
    and a.job = 'MANAGER'
    and a.empno = p_emp_id;
    return emp_name;
end;
/
--function calling
set serveroutput on
declare 
    p_no number :=&no;
    emp_n varchar2(200);
begin
    emp_n := emp_find(p_no);
    dbms_output.put_line(emp_n);
end;
/