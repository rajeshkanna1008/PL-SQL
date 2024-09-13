create table emp_assignment(
                            assig_id number,
                            emp_id number,
                            dept_no number,
                            job_id number,
                            start_date date,
                            end_date date);
                 
				 
    
create or replace package emp_assignment_pkg
is
    procedure insert_assign(v_assig_id number,
                            v_emp_id number,
                            v_dept_no number,
                            v_job_id number,
                            v_start_date date,
                            v_end_date date);
                            
    function emp_id_check (v_emp_id number)
        return number;
    
    function dept_no_check (v_dept_no number)
        return number;
        
    function job_id_check (v_job_id number)
            return number;
    
end emp_assignment_pkg;
    
    
	

create or replace package body emp_assignment_pkg
is
     function emp_id_check (v_emp_id number)
        return number
        is
        v_empid number;
        begin 
            select count(*) into v_empid from emp2 where emp_id = v_emp_id;
           return v_empid;
        end;
    
     function dept_no_check(v_dept_no number)
        return number
        is
        v_deptno number;
        begin 
            select count(*) into v_deptno from dept where dept_no = v_dept_no;
           return v_deptno;
        end;
        
    function job_id_check (v_job_id number)
        return number
        is
        v_job number;
        begin 
            select count(*) into v_job from job where job_id = v_job_id;
           return v_job;
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