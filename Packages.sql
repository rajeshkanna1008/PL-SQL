--=====================================================================
set serveroutput on;

create or replace package insert_data_pkg 
is
 --Procedure creation for insert_dept details
     procedure insert_dept (v_dept_id number, v_dept_name varchar2, v_start_date date, v_end_date date);

        function v_dept_name_check(v_dept_name varchar2)
        return boolean;
        
        function v_start_date_check (v_start_date date)
        return boolean;
        
        function v_end_date_check(v_end_date date)
        return boolean;

end insert_data_pkg;  
/
-- Package body. implement what ever we declare in the specification.
create or replace package body insert_data_pkg
is 
    function v_dept_name_check(v_dept_name varchar2)
        return boolean
        is 
        v_dept number;
    begin
	
        select length(v_dept_name) 
		into v_dept 
		from dual;
		
        if v_dept >=2 then
            return true;
        else
            return false;
        end if;
    end ;
    
    function v_start_date_check (v_start_date date)
        return boolean
        is
        v_date varchar2(50);
        begin
		
             select to_char(v_start_date,'FMDAY') 
			 into v_date 
			 from dual;
			 
                if v_date = 'SUNDAY' then
                    return false;
                else
                    return true;
                end if;
        end;
    
    function v_end_date_check(v_end_date date)
        return boolean
        is
        v_date varchar2(50);
        begin
		
            select to_char(v_end_date,'FMDAY') 
			into v_date 
			from dual;
			
                if v_date = 'SUNDAY' then
                     return false;
                else
                    return true;
                end if;
        end;
    
    procedure insert_dept (v_dept_id number, v_dept_name varchar2, v_start_date date, v_end_date date) is
    begin
            if v_dept_name_check(v_dept_name) = true then
                if v_start_date_check(v_start_date) = true then
                    if v_end_date_check(v_end_date) = true then
                        insert into dept2_tbl(dept_id, dept_name, start_date, end_date) values
                        (dept_seq.nextval, v_dept_name, v_start_date, v_end_date);
                    else
                        dbms_output.put_line('Invalid date, end date not be an sunday');
                    end if;
                else
                    dbms_output.put_line('Invalid date, start date not be an sunday');
                end if;
            else
                dbms_output.put_line('dept_name is must more then 3 characters');
            end if;      
    end;
end insert_data_pkg;
/



set serveroutput on;
/
begin
insert_data_pkg.insert_dept(20,'CSC','01-01-2000','02-01-2023');
insert_data_pkg.insert_dept(30,'ECE','01-01-2000','02-01-2023');
insert_data_pkg.insert_dept(40,'MECH','01-01-2000','02-01-2023');
end;
/
select * from dept2_tbl;


**********************************************
**********************************************
**********************************************
create or replace package insert_data_pkg 
is
 --Procedure creation for insert_dept details
    procedure insert_dept (v_dept_id number, v_dept_name varchar2, v_start_date date, v_end_date date);
    procedure update_dept (v_dept_id number default null, v_dept_name varchar2 default null, v_id number);
    procedure delete_dept (v_dept_id number default null, v_dept_name varchar2 default null, v_id number default null);   
    
        function v_dept_name_check(v_dept_name varchar2)
        return number;
        
        function v_start_date_check (v_start_date date)
        return boolean;
        
        function v_end_date_check(v_end_date date)
        return boolean;
        
        function v_dept_id_check (v_dept_id number)
        return number;
    
end insert_data_pkg;  
/
-- Package body. implement what ever we declare in the specification.
create or replace package body insert_data_pkg
is 
    function v_dept_name_check(v_dept_name varchar2)
        return number
        is 
        v_count_name number;
		
    begin
	
        select count(*) 
		into v_count_name 
		from dept2_tbl 
		where dept_name = v_dept_name;
        return v_count_name;
		
    end ;
    
    function v_start_date_check (v_start_date date)
        return boolean
        is
        v_date varchar2(50);
        begin
             select to_char(v_start_date,'FMDAY') 
			 into v_date 
			 from dual;
                if v_date = 'SUNDAY' then
                    return false;
                else
                    return true;
                end if;
        end;
    
    function v_end_date_check(v_end_date date)
        return boolean
        is
        v_date varchar2(50);
        begin
		
            select to_char(v_end_date,'FMDAY') 
			into v_date 
			from dual;
			
                if v_date = 'SUNDAY' then
                     return false;
                else
                    return true;
                end if;
        end;
    
    function v_dept_id_check (v_dept_id number)
        return number
        is
        s_dept number;
        begin
            select count(*) into s_dept from dept2_tbl where dept_id = v_dept_id;
            return s_dept;
        end;
    
    procedure insert_dept (v_dept_id number, v_dept_name varchar2, v_start_date date, v_end_date date) is
    begin
            if v_dept_name_check(v_dept_name) = 0 then
                if v_start_date_check(v_start_date) = true then
                    if v_end_date_check(v_end_date) = true then
                        insert into dept2_tbl(dept_id, dept_name, start_date, end_date) values
                        (v_dept_id, v_dept_name, v_start_date, v_end_date);
                    else
                        dbms_output.put_line('Invalid date, end date not be an sunday');
                    end if;
                else
                    dbms_output.put_line('Invalid date, start date not be an sunday');
                end if;
            else
                dbms_output.put_line('dept_name is must more then 3 characters');
            end if;
        exception 
            when others then
            dbms_output.put_line(sqlerrm);
    end;
    
    procedure update_dept (v_dept_id number default null, v_dept_name varchar2 default null, v_id number)
    is
    begin
        if v_dept_id_check(v_id)>0 
		then
		
            update dept2_tbl 
			set dept_id = nvl(v_dept_id,dept_id), 
			    dept_name = nvl(v_dept_name,dept_name)
            where dept_id = v_id;
			
            dbms_output.put_line('Record updated.');
        else
            dbms_output.put_line(sqlerrm);
        end if;
        exception 
            when others then
            dbms_output.put_line(sqlerrm);
    end;
    
     procedure delete_dept (v_dept_id number default null, v_dept_name varchar2 default null, v_id number default null)
     is 
     begin
        if v_dept_id_check(v_id) > 0 then
            delete from dept2_tbl where dept_id = v_id;
            dbms_output.put_line('Record deleted.');
        elsif v_dept_name_check(v_dept_name) > 0 then
            delete from dept2_tbl where dept_name = v_dept_name;
            dbms_output.put_line('Record deleted.');
        else
            dbms_output.put_line('Invalid data');
        end if;
        exception 
            when others then
            dbms_output.put_line(sqlerrm);
    end;
end insert_data_pkg;
/

