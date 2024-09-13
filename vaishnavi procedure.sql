create table employee_1(
	emp_id number(20),
	ename varchar2(200),
	dob date,
	commision number(20),
	joining_date date,
	sal number(10),
	end_date date,
	phone_num number(15)
);

create or replace function emp_id_f(f_id number)
return number
is 
l_count number;
begin
    select count(*) into l_count from employee_1 
    where emp_id=f_id;
    return l_count;
end;
/

create or replace function emp_name_f(f_name varchar2)
return boolean
is 

begin
    if length(f_name)>3
        then return true;
    else 
    return false;
   end if; 
end;
/

create or replace function emp_dob_f(f_dob date)
return boolean
is 

begin
     if trunc(months_between(sysdate,f_dob)/12) >21
         then return true;
    else 
    return false;
   end if; 
end;
/
create or replace function emp_joining_f(f_jd date)
return boolean
is 

begin
     if to_char(f_jd,'FMDAY')<> 'SUNDAY'
         then return true;
    else 
    return false;
   end if; 
end;
/



create or replace function emp_sal_f(f_sal number)
return boolean
is 

begin
    if f_sal>5000
        then return true;
    else
        return false;
    end if;    
end;
/

create or replace function emp_no_f(f_no number)
return boolean
is 

begin
    if length(f_no)=10
        then return true;
    else
        return false;
    end if;    
end;
/





select * from employee_1;
--============================================================


create or replace procedure emp_p(p_id number,p_name varchar2,p_dob date,
              p_comm number,p_join varchar2,p_sal number,p_end_date date,p_phoneno number)
is 
p_id1 number;
p_ename boolean;
p_edob boolean;
p_ejd boolean;
p_esal boolean;
p_pno boolean;
begin
     p_id1:=emp_id_f(p_id);
     p_ename:=emp_name_f(p_name);
     p_edob:=emp_dob_f(p_dob);
     p_ejd:=emp_joining_f(p_join);
     p_esal:=emp_sal_f(p_sal);
     p_pno:=emp_no_f(p_phoneno);
     
     if p_id1=0 then
        if p_ename=true then
           if  p_edob=true then
            if p_ejd=true then
            if p_esal=true then
                if p_pno=true then
                    insert into employee_1 values(p_id,p_name,p_dob,p_comm,p_join,p_sal,p_end_date,p_phoneno);
                else
                    dbms_output.put_line('Enter valid phone number');
                end if;    
             else
                dbms_output.put_line('Enter valid salary');
             end if;
             else
                dbms_output.put_line('Day cannot be Sunday');
             end if;
             else
                dbms_output.put_line('Enter valid dob');
             end if;
             else
             dbms_output.put_line('Enter valid name');
             end if;
             else
             dbms_output.put_line('Enter valid emp_id');
            end if; 
end;
/
declare
    
begin
    
    emp_p(104,'vaishnavi','20-08-1998',200,'29-02-2024',20000,'12-07-2022',9876543210);

end;
/

select to_char(to_date('02-01-2022'),'FMDAY') from dual;

select * from employee_1;

--=====************************************

create or replace procedure prime_number(n1 number, n2 number)
is 
v_count number;
begin
    for i in n1..n2
    loop
        v_count := 0;
        for j in 1..i
        loop
            if mod(i,j) = 0 then
                v_count := v_count + 1;
            end if;
        end loop;
    if v_count = 2 then 
        dbms_output.put_line(i||',');
    end if;
    end loop;
    dbms_output.put_line('');
end;
/



--=======================================

begin
emp_details (3,'Raja','21-07-1998','Asst_Manager',10,12000,'20-02-2021','05-12-2022');
emp_details (4,'Ramesh','25-06-1997','Senior_HR ',20,20000,'20-02-2020','26-05-2023');
emp_details (5,'Naveen','23-04-1998','IT_Recuter',30,30000,'20-01-2023','01-05-2023');
emp_details (6,'Sathya','29-11-1998','Junior_devploer',40,40000,'05-02-2017','01-01-2023');
emp_details (7,'Siddu','30-03-1996','Manager',10,50000,'27-05-2014','01-01-2023');
emp_details (8,'Srinivas','21-05-1995','Developer',50,12000,'20-02-2019','01-01-2023');
emp_details (9,'Janu','02-10-1995','Sales',40,12000,'23-08-2021','01-05-2023');
emp_details (10,'James','09-11-1996','Junior_HR',20,12000,'20-02-2022','01-01-2023');
end;
/