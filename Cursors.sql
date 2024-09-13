-- Explict cursor or Static cursor
declare
    cursor c_emp is select ename,sal,job from emp;
    v_emp_name varchar2(200);
    v_salary number;
    v_job varchar2(200);
begin
    open c_emp;
    fetch c_emp into v_emp_name, v_salary, v_job;
    dbms_output.put_line(v_emp_name||' '||v_salary||' '||v_job);
    fetch c_emp into v_emp_name, v_salary, v_job;
    dbms_output.put_line(v_emp_name||' '||v_salary||' '||v_job);
    fetch c_emp into v_emp_name, v_salary, v_job;
    dbms_output.put_line(v_emp_name||' '||v_salary||' '||v_job);
end;

-- %notfound example
declare
    cursor c_emp is select ename,sal,job from emp;
    v_emp_name varchar2(200);
    v_salary number;
    v_job varchar2(200);
begin
    open c_emp;
    dbms_output.put_line('Emp_Name'||chr(9)||'Salary'||chr(9)||'job_Name');
    loop
        fetch c_emp into v_emp_name, v_salary, v_job;
        exit when c_emp%notfound;
        dbms_output.put_line(v_emp_name||chr(9)||chr(9)||v_salary||chr(9)||v_job);
    end loop;
    close c_emp;
end;
/
--2
declare 
    cursor c_emp is select empno,ename from emp;
    v_empno number;
    v_empname varchar2(100);
begin
    open c_emp;
    loop
    fetch c_emp into v_empno, v_empname;
    exit when c_emp%notfound;
    dbms_output.put_line(v_empno||chr(9)||v_empname);   
    end loop;
    close c_emp;
end;
/

-- Parameterised cursor
declare 
    cursor c_emp(pdeptno number) is select * from emp where deptno = pdeptno;
    v_empno number := :p;
    v_empname varchar2(100);
begin
 for i in c_emp(v_empno) 
 loop
 dbms_output.put_line(i.empno||chr(9)||i.ename);
 end loop;
end;
/

-- Retrive emp details from table using cursors
declare
    cursor v_emp is select * from emp;
begin
    for i in v_emp 
    loop
    if i.deptno = 10 then 
        dbms_output.put_line(i.empno||chr(9)||i.ename||chr(9)||i.sal);
    end if;
    end loop;
end;

-- update using cursor
declare
    cursor v_emp is select * from emp;
begin
    for i in v_emp 
    loop
    if i.deptno = 10 then
        update emp set sal = sal + (sal*20/100) where empno = 7900;
    end if;
    end loop;
end;
/

CREATE TABLE st_project_assignment (
    assign_id       NUMBER(20),
    st_id           NUMBER(20),
    pro_id          NUMBER(20),
    start_date      DATE,
    end_date        DATE,
    submisson_date  DATE,
    comments        VARCHAR(200),
    result          VARCHAR(200)
);


insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (1,1,123,'12-09-2020','31-12-2020','26-11-2020');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (2,2,124,'15-05-2022','31-08-2022','01-09-2022');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (3,3,125,'12-09-2021','30-12-2021','26-12-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (4,4,126,'25-08-2019','25-08-2019','23-08-2019');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (5,5,127,'01-01-2023','26-03-2023','');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (6,1,123,'12-09-2020','31-12-2020','16-12-2020');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (7,2,124,'15-05-2022','30-08-2022','15-08-2022');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (8,3,125,'12-09-2021','31-12-2021','10-12-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (9,4,126,'25-08-2019','30-11-2019','25-12-2019');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (10,5,123,'29-11-2020','29-02-2021','15-03-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (11,1,124,'15-05-2022','10-08-2022','11-07-2022');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (12,2,125,'12-09-2021','10-12-2021','12-11-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (13,3,126,'25-08-2019','25-11-2019','20-12-2019');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (14,4,123,'26-09-2020','26-12-2020','15-11-2020');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (15,1,124,'15-05-2022','15-08-2022','18-07-2022');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (16,2,125,'12-09-2021','12-12-2021','14-12-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (17,3,126,'25-08-2019','25-11-2019','29-12-2019');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (18,4,123,'12-09-2020','12-12-2020','12-12-2020');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (19,1,124,'15-05-2022','15-08-2022','');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (20,2,125,'12-09-2021','12-12-2021','11-12-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (21,3,126,'25-08-2019','25-11-2019','26-11-2019');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (22,4,127,'01-05-2019','25-08-2019','');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (23,1,123,'12-09-2020','12-12-2020','18-12-2020');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (24,2,124,'15-05-2022','15-08-2022','10-07-2022');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (25,3,125,'12-09-2021','12-12-2021','12-11-2021');
insert into st_project_assignment (assign_id,st_id,pro_id,start_date,end_date,submisson_date) VALUES (26,3,125,'01-09-2023','12-12-2023','');


select * from st_project_assignment;

set serveroutput on;

declare 
    cursor c_project is select * from st_project_assignment;
--    v_assign_id st_project_assignment.assign_id%type;
--    v_st_id st_project_assignment.st_id%type;
--    v_pro_id st_project_assignment.pro_id % type;
--    v_start_date st_project_assignment.start_date%type;
--    v_end_date st_project_assignment.end_date%type;
--    v_submisson_date st_project_assignment.submisson_date%type;
--    v_comment st_project_assignment.comments%type;
--    v_result st_project_assignment.result%type;
    
begin
    for i in c_project 
    loop
        if i.submisson_date = i.end_date then
            update st_project_assignment set comments = 'Submitted',result = 'Pass' where end_date = submisson_date;
            
        elsif i.submisson_date is null then
            update st_project_assignment set comments = 'Not Submitted' ,result = 'Fail'where  submisson_date is null;
               
        elsif i.submisson_date > i.end_date then
            update st_project_assignment set comments = 'Submitted',result = 'Fail' where submisson_date > end_date;
            
        elsif i.end_date > i.submisson_date then
            update st_project_assignment set comments = 'Submitted',result = 'Pass' where end_date > submisson_date;
         end if; 
    end loop;
    commit;
end;
/

select * from st_project_assignment;

/

set serveroutput on
declare 
    cursor c_project is select * from st_project_assignment;
    
begin
    for i in c_project 
    loop       
        if i.submisson_date > i.end_date then
            update st_project_assignment set comments = 'Submitted',result = 'Fail' where submisson_date > end_date;
            
        elsif i.end_date >= i.submisson_date then
            update st_project_assignment set comments = 'Submitted',result = 'Pass' where end_date > submisson_date;
            
        elsif  i.start_date > sysdate and i.submisson_date is null    then
            update st_project_assignment set comments = 'Awited', result = 'null' where start_date > sysdate
                                                                                  and submisson_date is null;      
        elsif  i.submisson_date is null then
            update st_project_assignment set comments = 'Not Submitted' ,result = 'Fail'where  submisson_date is null;             
        end if; 
    end loop;
    commit;
end;
/
select * from st_project_assignment;


-- Reverse String in words

declare
    v_str varchar2(100):='my name is rajesh';
    v_str2 varchar2(100):='';
    cursor c1 is
        select regexp_substr(v_str, '[^ ]+' , 1, level) as substr
        from dual connect by regexp_substr(v_str, '[^ ]+', 1, level) is not null
        order by rownum desc;
begin
    for i in c1
    loop
        v_str2:=v_str2||i.substr||' ';
    end loop;
    dbms_output.put_line(l_str2);
end;

--display empno,empname,job name,salary from emp table using cursor
declare
    cursor c_emp is
    (select empno,ename,job,sal from emp where deptno = 10);
begin
    dbms_output.put_line('Row'||chr(9)||
                        'Empno'||chr(9)||
                        'Emp Name'||chr(9)||
                        'Job Name'||chr(9)||chr(9)||
                        'Salary');
    for i in c_emp
    loop
        dbms_output.put_line(to_char(c_emp%rowcount)||chr(9)||
                            i.empno||chr(9)||
                            i.ename||chr(9)||chr(9)||
                            i.job||chr(9)||chr(9)||chr(9)||
                            i.sal);
    end loop;
end;


set serveroutput on;
set serveroutput on;

-- Reverse a string using functions 
create or replace function reverse_str (str1 varchar2)
    return varchar2 
    as
    reverse_str1 varchar2(200);
begin
    for i in reverse 1..length(str1)
    loop
        reverse_str1 := reverse_str1 || substr(str1,i,1);
    end loop;
    return reverse_str1;
end;
/

declare
    str1 varchar2(200):= :str;
    rev_str1 varchar2(200);
begin
    rev_str1 := reverse_str(str1);
    dbms_output.put_line('Old string is : '||str1);
    dbms_output.put_line('New String is : '||rev_str1);
end;
/
/* insert data using function, If the data is already exist, 
then raise an error, otherwise insert data */
declare
    v_deptno number;
    v_dname varchar2(220);
    v_loc varchar2(200);
    l_counter number;
    function insert_data(dname  varchar2)
    return number
    is 
    v_counter number;
    begin
        select count(dname) into v_counter from dept where dname = v_dname;
        return v_counter;
    end;
begin 
    v_deptno := &n;
    v_dname:= upper('&string');
    v_loc := '&loc';
    l_counter := insert_data(v_dname);
    if l_counter > 0 then
    dbms_output.put_line('The data is already existing');
    else
        insert into dept values(v_deptno,v_dname,v_loc);
    end if;
end;
/
select * from dept;
















set serveroutput on;
/
declare 
    cursor emp_details is 
    select e.emp_id,e.emp_name,e.dob,e.hiredate,e.salary,
            d.dept_id, d.dept_name,
            j.job_id,j.job_name,
            a.assignment_id,a.start_date,a.end_date
    from emp e, dept d, job j, emp_assignment a
    where e.emp_id = a.emp_id
    and d.dept_id = j.dept_id
    and a.job_id = j.job_id;
begin
    for i in emp_details
    loop
        dbms_output.put_line(i.emp_id||chr(9)||
                            i.emp_name||chr(9)||
                            i.dob||chr(9)||
                            i.hiredate||chr(9)||
                            i.salary||chr(9)||
                            i.dept_id||chr(9)||
                            i.dept_name||chr(9)||
                            i.job_id||chr(9)||
                            i.job_name||chr(9)||
                            i.assignment_id||chr(9)||
                            i.start_date||chr(9)||
                            i.end_date);
    end loop;
end;
/
select * from emp;
select * from dept;
select * from job;
select * from emp_assignment;

declare
    emp_record emp_details%rowtype;
begin
    for j in emp_details
    loop
        fetch emp_details into emp_record;
        exit when emp_details%notfound;

        insert into emp1 (emp_id, emp_name, DoB, hiredate, salary) values 
        (j.emp_id, j.emp_name, j.DoB, j.hiredate, j.salary);
    end loop;
end;
     
=====================================================
create table emp1 (
    emp_id number,
    emp_name varchar2(200),
    DoB date,
    hiredate date,
    salary number);
    
create table dept1(
    dept_id number,
    dept_name varchar2(200));

create table job1(
    job_id number,
    job_name varchar2(200),
    dept_id number);

=====================================================

dbms_output.put_line(i.emp_id||chr(9)||
                            i.emp_name||chr(9)||
                            i.dob||chr(9)||
                            i.hiredate||chr(9)||
                            i.salary||chr(9)||
                            i.dept_id||chr(9)||
                            i.dept_name||chr(9)||
                            i.job_id||chr(9)||
                            i.job_name||chr(9)||
                            i.assignment_id||chr(9)||
                            i.start_date||chr(9)||
                            i.end_date);
							

==================================

