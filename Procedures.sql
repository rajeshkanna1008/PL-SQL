create table emp2 (
        emp_id number,
        emp_name varchar2(200),
        DoB date,
        Job varchar2(200),
        dept_no number,
        Salary number,
        hire_date date,
        end_date date);
        
select * from emp2;

create or replace function emp_id_check (v_emp_id number)
return number
is
v_empid number;
begin 
    select count(*) into v_empid from emp2 where emp_id = v_emp_id;
   return v_empid;
end;
/
create or replace function emp_name_check (v_emp_name varchar2)
return boolean
is
v_name
begin
    if length(v_emp_name) >=2 then  
        return true;
    else
        return false;
    end if;
end;
/     

create or replace function age_check (v_dob date)
return boolean
is
v_age number;
begin
    select trunc(months_between(to_date(to_char(sysdate,'dd-mm-yyyy'),'DD-MM-YYYY'),
                    (to_date(v_dob,'DD-MM-YYYY')))/12) into v_age from dual;
                    --where dob = v_dob;
    if v_age >21 then
        return true;
    else
        return false;
    end if;
end;
/
create or replace function job_check (v_job varchar2)
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
/
create or replace function dept_no_check (v_dept_no number)
return boolean
is
v_dept number;
begin
    select count(v_dept_no) into v_dept from dual;-- where dept_no = v_dept_no;
    if v_dept <= 5 then
        return true;
    else
        return false;
    end if;
end;
/
create or replace function salary_check(v_salary number)
return boolean
is
v_sal number;
begin
    select v_salary into v_sal from dual;-- where salary = v_salary;
    if v_sal >=10000 and v_sal <=100000 then
        return true;
    else
        return false;
    end if;
end;
/
create or replace function hire_date_check (v_hire_date date)
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
/
create or replace function end_date_check (v_end_date date)
return boolean
is
v_day varchar2(50);
begin
    select to_char(v_end_date,'DAY') into v_day from dual;-- where end_date = v_end_date;
    if v_day = 'SUNDAY' then
        return false;
    else
        return true;
    end if;
end;
/



--================================================

set serveroutput on;
create or replace procedure emp_details (v_emp_id number,
                                        v_emp_name varchar2,
                                        v_dob date,
                                        v_job varchar2,
                                        v_dept_no number,
                                        v_salary number,
                                        v_hire_date date,
                                        v_end_date date)
                                        
is 

begin

    if emp_id_check(v_emp_id) = 0 then
        if emp_name_check(v_emp_name) = true then
            if age_check(v_dob) = true then
                if job_check(v_job) = true then
                    if dept_no_check(v_dept_no) = true then
                        if salary_check(v_salary) = true then
                            if hire_date_check(v_hire_date) = true then
                                if end_date_check(v_end_date) = true then
    insert into emp2 (emp_id,emp_name,dob,job,dept_no,salary,hire_date,end_date) values 
    (v_emp_id,v_emp_name,v_dob,v_job,v_dept_no,v_salary,v_hire_date,v_end_date);    
    commit;                     else
                                    dbms_output.put_line('enddate should not be an sunday');
                                end if;
                            else
                                dbms_output.put_line('Hiredate should not be an sunday');
                             end if;
                        else
                             dbms_output.put_line('Salary in between 10000 and 100000');
                        end if;
                    else
                        dbms_output.put_line('Department is full');
                    end if;
                else
                    dbms_output.put_line('Job name must be morethen 3 letters');
                end if;
            else
                dbms_output.put_line('The employee age must be 21 years');
            end if;
        else
            dbms_output.put_line('Employye name must should be morethen 3 letters');
        end if;
    else
        dbms_output.put_line('Employye Already exist');
    end if;
end;
/


--==========================================================
begin
emp_details (3,'Raja','21-07-1998','Asst_Manager',10,12000,'20-02-2021','05-12-2024');
emp_details (4,'Ramesh','25-06-1997','HR',20,20000,'20-02-2020','26-05-2023');
emp_details (5,'Naveen','23-04-2000','IT_Recuter',30,30000,'20-01-2023','01-05-2023');
emp_details (6,'Sathya','29-11-1998','Junior_devploer',40,40000,'05-02-2017','01-01-2023');
emp_details (7,'Siddu','30-03-1996','Manager',10,50000,'27-05-2014','01-01-2023');
emp_details (8,'Srinivas','21-05-2001','Developer',50,12000,'20-02-2019','01-01-2023');
emp_details (9,'Janu','02-10-1995','Sales',40,12000,'23-08-2021','01-05-2023');
emp_details (10,'James','09-11-2000','HR',20,12000,'20-02-2022','01-01-2023');
end;
/


--(emp_id,emp_name,dob,job,dept_no,salary,hire_date,end_date)
select * from emp2;

truncate table emp2;

select sysdate from dual;


--============================================

set serveroutput on;


DECLARE
  V_EMP_ID NUMBER;
  V_EMP_NAME VARCHAR2(200);
  V_DOB DATE;
  V_JOB VARCHAR2(200);
  V_DEPT_NO NUMBER;
  V_SALARY NUMBER;
  V_HIRE_DATE DATE;
  V_END_DATE DATE;
BEGIN
  V_EMP_ID := 1;
  V_EMP_NAME := 'Rajesh';
  V_DOB := '11-10-1999';
  V_JOB := 'Developer';
  V_DEPT_NO := 10;
  V_SALARY := 12000;
  V_HIRE_DATE := '20-03-1999';
  V_END_DATE := '01-01-2009';

  EMP_DETAILS(
    V_EMP_ID => V_EMP_ID,
    V_EMP_NAME => V_EMP_NAME,
    V_DOB => V_DOB,
    V_JOB => V_JOB,
    V_DEPT_NO => V_DEPT_NO,
    V_SALARY => V_SALARY,
    V_HIRE_DATE => V_HIRE_DATE,
    V_END_DATE => V_END_DATE
  );
--rollback; 
END;


--===================================

