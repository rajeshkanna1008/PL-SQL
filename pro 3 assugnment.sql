create or replace package emp_details_pkg 
is 
    procedure insert_emp2 ( p_emp_id number, 
                            p_emp_name varchar2, 
                            p_dob date, 
                            p_job varchar2, 
                            p_dept_no number, 
                            P_salary number,
                            p_hire_date date,
                            p_end_date date);
   
    procedure insert_dept (p_deptno number, p_dname varchar2);
    
procedure insert_job(p_dept_no number,
                     p_job_id number,
                     p_job_name varchar2);
					 
					 
procedure insert_assign(v_assig_id number,
                            v_emp_id number,
                            v_dept_no number,
                            v_job_id number,
                            v_start_date date,
                            v_end_date date);
                            
    
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
        
    function dept_no_check (v_dept_no number)
        return number;
    
    function dept_name_check(v_dept_name varchar2)
        return boolean;
        
    function job_id_check (v_job_id number)
        return number;
    
    function job_name_check(v_job_name varchar2)
        return number;
      
end emp_details_pkg;
/

 



create or replace package body emp_details_pkg
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
                            --where dob = v_dob;
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
        
    function dept_no_check (v_dept_no number)
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
	
	
	
	procedure insert_assign(v_assig_id number,
                            v_emp_id number,
                            v_dept_no number,
                            v_job_id number,
                            v_start_date date,
                            v_end_date date)

	is 
	begin
		if emp_id_check(v_emp_id) >= 1 then
			if dept_no_check(v_dept_no) >= 1 then
				if job_id_check(v_job_id) >= 1 then
					insert into emp_assignment (assig_id,emp_id, dept_no, job_id, start_date, end_date) values
					(v_assig_id, v_emp_id, v_dept_no, v_job_id, v_start_date, v_end_date);               
				else 
					dbms_output.put_line('Job is not exists');
				end if;           
			else 
				dbms_output.put_line('department not exists');
			end if;       
		else
			dbms_output.put_line('employye not exists.');
		end if;
	end;
end emp_assignment_pkg;
end emp_details_pkg;


/*Inserting data*/

begin
emp_details_pkg.insert_emp2(1,'Rajesh','11-10-1999','Developer',10,12000,'05-06-2023','');
emp_details_pkg.insert_emp2(2,'Naveen','28-02-1999','Tester',20,18000,'04-08-2022','01-01-2023');
emp_details_pkg.insert_emp2(3,'Janu','05-07-1999','App Dev',30,22000,'01-05-2020','01-05-2023');
emp_details_pkg.insert_emp2(4,'Siddu','07-04-2000','Web dev',40,15000,'05-02-2009','01-06-2023');
emp_details_pkg.insert_emp2(5,'Sravanthi','16-12-1999','ios dev',10,36000,'26-06-2023','');
emp_details_pkg.insert_emp2(6,'Radhika','18-06-1999','Oracle dev',20,15000,'14-05-2021','01-03-2023');
emp_details_pkg.insert_emp2(7,'Akash','24-05-1999','apex dev',40,16000,'05-12-2023','');
emp_details_pkg.insert_emp2(8,'Kamal','11-10-1998','ebs dev',30,15600,'01-02-2019','01-02-2023');
emp_details_pkg.insert_emp2(9,'Anwar','30-06-2000','Manager',10,500000,'12-03-2021','01-07-2023');
emp_details_pkg.insert_emp2(10,'Kumar','11-06-1998','Developer',40,10000,'05-02-2022','');
end;
/
select * from emp2;

begin
emp_details_pkg.insert_dept(10,'Development');
emp_details_pkg.insert_dept(20,'Testing');
emp_details_pkg.insert_dept(30,'Management');
emp_details_pkg.insert_dept(40,'Sales/Markting');
end;
/
select * from dept;

begin
emp_details_pkg.insert_job(10,101,'Developer');
emp_details_pkg.insert_job(10,102,'ios dev');
emp_details_pkg.insert_job(20,111,'Tester');
emp_details_pkg.insert_job(20,112,'Oracle dev');
emp_details_pkg.insert_job(30,120,'App dev');
emp_details_pkg.insert_job(30,121,'ebs dev');
emp_details_pkg.insert_job(40,130,'apex dev');
emp_details_pkg.insert_job(40,131,'sql dev');
end;
/
select * from job;
