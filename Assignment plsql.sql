set serveroutput on;
/* Write a pl sql program using cursor to fetch all employee details,
and load them into a temp table(only unique values)
*/
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
    e_counter number;
    d_counter number;
    j_counter number;
begin
    for i in emp_details
    loop
        
        select count(*) into e_counter from emp1 where emp_id = i.emp_id;
        if e_counter = 0 then
            insert into emp1 (emp_id, emp_name, DoB, hiredate, salary) values 
            (i.emp_id, i.emp_name, i.DoB, i.hiredate, i.salary);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
        
        select count(*) into d_counter from dept1 where dept_id = i.dept_id;
        if d_counter = 0 then
            insert into dept1 (dept_id,dept_name) values
            (i.dept_id, i.dept_name);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
        select count(*) into j_counter from job1 where job_id = i.job_id;
        if j_counter = 0 then
            insert into job1 (job_id,job_name,dept_id) values
            (i.job_id, i.job_name, i.dept_id);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
    end loop;
end;
/
select * from emp1;
select * from dept1;
select * from job1;

truncate table emp1;
truncate table dept1;
truncate table job1;

set serveroutput on;


/* Write a pl sql program using cursor and functions to fetch all employee details,
and load them into a temp table(only unique values)
*/

-- Creating functions
create or replace function emp_count(a number)
return number
is emp_counter number;
begin
    select count(*) into emp_counter from emp1 where emp_id = a;
    return emp_counter;
end;
/
create or replace function dept_count(b number)
return number
is dept_counter number;
begin
    select count(*) into dept_counter from dept1 where dept_id = b;
    return dept_counter;
end;
/
create or replace function job_count(c number)
return number
is job_counter number;
begin
    select count(*) into job_counter from job1 where job_id = c;
    return job_counter;
end;
/

-- Using Functions
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
        if emp_count(i.emp_id) = 0 then
            insert into emp1 (emp_id, emp_name, DoB, hiredate, salary) values 
                (i.emp_id, i.emp_name, i.DoB, i.hiredate, i.salary);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
        
        if dept_count(i.dept_id) = 0 then
             insert into dept1 (dept_id,dept_name) values
            (i.dept_id, i.dept_name);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
        
        if job_count(i.job_id) = 0 then
             insert into job1 (job_id,job_name,dept_id) values
            (i.job_id, i.job_name, i.dept_id);
        else
            dbms_output.put_line('Data Allready Exist in the table');
        end if;
    end loop;
end;
/
select * from emp1;
select * from dept1;
select * from job1;

truncate table emp1;
truncate table dept1;
truncate table job1;


--2. Write a pl sql program to accept the user input and insert the data into the temp table 
--and delete from the base table.
set serveroutput on
declare 
    cursor emp_details2 is 
    select e.emp_id,e.emp_name,e.dob,e.hiredate,e.salary,
            d.dept_id, d.dept_name,
            j.job_id,j.job_name,
            a.assignment_id,a.start_date,a.end_date
    from emp e, dept d, job j, emp_assignment a
    where e.emp_id = a.emp_id
    and d.dept_id = j.dept_id
    and a.job_id = j.job_id
    and e.emp_id=:emp_id;
    
    cursor emp_details3 is 
    select e.emp_id,e.emp_name,e.dob,e.hiredate,e.salary,
            d.dept_id, d.dept_name,
            j.job_id,j.job_name,
            a.assignment_id,a.start_date,a.end_date
    from emp e, dept d, job j, emp_assignment a
    where e.emp_id = a.emp_id
    and d.dept_id = j.dept_id
    and a.job_id = j.job_id
    and d.dept_id =:dept_id;
    
    e_counter number;
    d_counter number;
begin
    for i in emp_details2
    loop
        select count(*) into e_counter from emp2 where emp_id = i.emp_id;
        if e_counter = 0 then
            insert into emp2 (emp_id,emp_name,dob,hiredate,salary)
            values(i.emp_id,i.emp_name,i.dob,i.hiredate,i.salary);
            delete from emp where emp_id = i.emp_id;
        elsif e_counter > 0 then
            dbms_output.put_line('Date already exist in the table');
        end if;
    end loop;
    
    for j in emp_details3
        loop
            select count(*) into d_counter from dept2 where dept_id = j.dept_id;
        if d_counter = 0 then
            insert into dept2 (dept_id,dept_name) values (j.dept_id, j.dept_name);
            delete from dept where dept_id = j.dept_id;
        else
            dbms_output.put_line('Date already exist in the table');
        end if;
    end loop;
end;   
/
select * from emp2;
select * from emp;
select * from dept2;
    
    