create or replace package emp_details_pkg 
is 
procedure emp_operation(p_emp_id number , 
                        p_emp_name varchar2 default null, 
                        p_dob date default null, 
                        p_job varchar2 default null, 
                        p_dept_no number default null, 
                        P_salary number default null,
                        p_hire_date date default null,
                        p_end_date date default null,
                        p_mode varchar2);
                            
procedure dept_operaton (p_deptno number default null
                       , p_dname varchar2 default null
                       , p_mode varchar2 );

procedure job_operaton (p_dept_no number default null, 
						p_job_id number default null, 
						p_job_name varchar2 default null, 
						p_mode varchar2);
						
						
procedure asg_insert(p_emp_id number);


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
      
end emp_details_pkg
;



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
            
procedure emp_operation (p_emp_id number , 
                        p_emp_name varchar2 default null, 
                        p_dob date default null, 
                        p_job varchar2 default null, 
                        p_dept_no number default null, 
                        P_salary number default null,
                        p_hire_date date default null,
                        p_end_date date default null,
                        p_mode varchar2 )
    is 
    begin
        if p_mode = 'Insert' then        
            if emp_id_check(p_emp_id) = 0 then
                if emp_name_check(p_emp_name) = true then
                    if age_check(p_dob) = true then
                        if job_check(p_job) = true then
                            if hire_date_check(p_hire_date) = true then
                                insert into emp2 (emp_id,emp_name,Dob,job, dept_no, salary, hire_date, end_date) values
                                (p_emp_id, p_emp_name, p_dob, p_job, p_dept_no, P_salary, p_hire_date ,p_end_date);
								
								commit;
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
        end if;

if p_mode = 'Update' THEN
if emp_id_check(p_emp_id) >0 then	
	update emp2 set emp_name = nvl(p_emp_name,emp_name)
                ,Dob = nvl(p_dob,dob)
				,job = nvl(p_job,job)
				,dept_no = nvl(p_dept_no,dept_no)
				,salary = nvl(P_salary,salary)
				,hire_date = nvl(p_hire_date,hire_date)
				,end_date = nvl(p_end_date,end_date)
		where emp_id = p_emp_id	;
commit;		  
 
 end if;
 end if;
if p_mode = 'Delete' THEN
	if emp_id_check(p_emp_id) > 0 then	
		delete from emp2 where emp_id = nvl(p_emp_id,0);
		commit;
	end if;
end if; 
 /*
 if emp_id_check(p_emp_id) > 0 then 
	 BEGIN
		asg_insert(p_emp_id);
	 end;
 end if; */ 
end emp_operation;
        
    
procedure dept_operaton (p_deptno number default null
                       , p_dname varchar2 default null
                       , p_mode varchar2)
    is
    begin
    if p_mode = 'Insert' then
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
    end if;
        exception 
        when others then
            dbms_output.put_line(sqlerrm);
			
	if p_mode = 'Update' THEN

		if dept_no_check(p_deptno) > 0 then	
			update dept set dname = nvl(p_dname,dname)
				where 1 = 1
				and dept_no = p_deptno;
		commit;	
		end if;	 
	end if;
	
	
	if p_mode = 'Delete' THEN
	if dept_no_check(p_deptno) > 0 then	
		delete from dept where dept_no = nvl(p_deptno,0);
		commit;
	end if;
end if;

    end dept_operaton;
    
    
procedure job_operaton (p_dept_no number default null, 
						p_job_id number default null, 
						p_job_name varchar2 default null, 
						p_mode varchar2)
    is 
    begin
    if p_mode = 'Insert' then
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
    end if;
        exception 
            when others then
                dbms_output.put_line(sqlerrm);
				
				
	if p_mode = 'Update' THEN

		if job_id_check(p_job_id) > 0 then	
			update job set  dept_no = nvl(p_dept_no,dept_no)
							,job_id = nvl(p_job_id,job_id)
							,job_name = nvl(p_job_name,job_name)
				where 1 = 1
				and job_id = p_job_id;
		commit;	
		end if;	 
	end if;
	
	if p_mode = 'Delete' THEN
	if job_id_check(p_job_id) > 0 then	
		delete from job where job_id = nvl(p_job_id,0);
		commit;
	end if;
    
end if;
end job_operaton;
 
procedure asg_insert(p_emp_id number)
is 
v_emp_id number;
v_dept_id number;
v_job_id number;
v_jobname varchar2(200);
	begin
		begin
			select emp_id, dept_no,job into v_emp_id,v_dept_id,v_jobname from emp2 where emp_id = p_emp_id;
		end;
		
		begin
			select job_id into v_job_id from job where job_name = v_jobname;
		end;
		
		if emp_id_check(v_emp_id) >= 1 then
			if dept_no_check(v_dept_id) >= 1 then
				if job_id_check(v_job_id) >= 1 then
				
					insert into emp_assignment (assig_id,emp_id, dept_no, job_id, start_date, end_date) values
					(asg_seq.nextval, v_emp_id, v_dept_id, v_job_id, sysdate, null);   
					commit;		    
					
				elsif job_id_check(v_job_id) = 0 then
					job_operaton(20,113,'sr dev','Insert');
				else 
					dbms_output.put_line('Job is not exists');
				end if; 
				
			elsif dept_no_check(v_dept_id) = 0 then
				dept_operaton(40,'Finance','Insert');
			else 
				dbms_output.put_line('department not exists');
			end if;
			
		elsif  emp_id_check(v_emp_id) = 0 then
			emp_operation(13,'Prudhvi','20-02-1996','Cleark',20,29000,'15-05-2020',null,'Insert');
		else
			dbms_output.put_line('employye not exists.');
		end if;
	
end asg_insert;
end emp_details_pkg;

******************************
******************************




create sequence asg_seq
	start with 1000
	increment by 1
	minvalue 0
	maxvalue 1100
	no cycle;
	
	
begin
emp_details_pkg.asg_insert(1);
end;

/  

select * from emp_assignment;