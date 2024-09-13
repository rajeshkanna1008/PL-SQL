set SERVEROUTPUT on;

DECLARE
    x number:= 8; -- Global Variable
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('x value is:'||x);
        DECLARE
            y number:= 3; -- Local Variable
            z number:=0; -- Local Variable
        BEGIN
            DBMS_OUTPUT.PUT_LINE('y value is:'||y);
            z := x+y;
            DBMS_OUTPUT.PUT_LINE('z value is :'||z);
        END;
END;
/
--===================================================================
select * from department;
select * from students;
select * from project;
select * from student_project_assignment;
    

declare 
    v_Student_name students.st_name%type;
    v_DoB students.dob%type;
    v_Project_id project.project_id%type;
    v_Project_Name project.project_name%type;
    v_Project_duration project.duration%type;
    v_Project_fee project.fees%type;
    v_dept_id department.dept_id%type;
    v_dept_name department.dept_name%type;
    v_Complete_intime student_project_assignment.completion_intime%type;
    v_age number;
    
begin
    select s.st_name,s.dob,
        sp.project_id,sp.project_name,sp.duration,sp.fees,
        d.dept_id,d.dept_name,
        spa.completion_intime ,trunc((sysdate-dob)/365.5)     
        into
        v_Student_name,v_DoB,v_Project_id,v_Project_Name,v_Project_duration,
        v_Project_fee,v_dept_id,v_dept_name,v_Complete_intime,v_age        
        from department d, students s, project sp, student_project_assignment spa
        where d.dept_id = s.dept_id
        and s.st_id = spa.st_id
        and sp.project_id = spa.project_id
        and s.st_id = :k;
        
        dbms_output.put_line('Student name is '||' '||v_Student_name);
        dbms_output.put_line('Student Date Of Birth '||' '||v_DoB);
        dbms_output.put_line('Student Project Id'||' '||v_Project_id);
        dbms_output.put_line('Project Name'||' '||v_Project_Name);
        dbms_output.put_line('Project Fees'||' '||v_Project_fee);
        dbms_output.put_line('Dept Id'||' '||v_dept_id);
        dbms_output.put_line('Dept Name'||' '||v_dept_name);
        dbms_output.put_line('Completion In Time'||' '||v_Complete_intime);
        dbms_output.put_line('Date'||' '||sysdate);
        dbms_output.put_line('Age is '||' '||v_age);
end;
/
--==================================================

declare 
    v_st_id students.st_id%type;
begin
    select st_id into v_st_id from students
    where st_id = :n;
    
    dbms_output.put_line(v_st_id);
    exception
        when no_data_found then
        dbms_output.put_line('There is no data for your selection');
        when too_many_rows then
        dbms_output.put_line('The Query you written is returning more then one row');
        when others then
        dbms_output.put_line(SQLERRM);       
end;
/
--=====================================================
declare 
    l_string varchar2(200) := 'Hello';
    l_new_string varchar2(200) ;
begin
    l_new_string := replace (l_string,'Hello','Hi');
    dbms_output.put_line(l_new_string);
end;

/
--============================================================
declare 
    today_date varchar2(30);
    today_name varchar2(30);
    this_month varchar2(30);
    this_year varchar2(30);
begin
    select to_char(sysdate,'DD') into today_date from dual;
    dbms_output.put_line('Today day is '||' '||today_date);
    select to_char(sysdate,'day') into today_name from dual;
    dbms_output.put_line('Today Name is'||' '||today_name);
    select to_char(sysdate,'Month') into this_month from dual;
    dbms_output.put_line('This Month name is '||' '||this_month);
    select to_char(sysdate,'YYYY') into this_year from dual;
    dbms_output.put_line('This year is'||' '||this_year);
end;
/
--===================================================================

declare 
v_ename emp.ename%type;
v_sal emp.sal%type;
v_tno emp.deptno%type;
begin
 select ename,sal,deptno into v_ename,v_sal,v_tno from emp where deptno=&deptno;
 
 dbms_output.put_line(v_ename);
 dbms_output.put_line(v_sal);
 dbms_output.put_line(v_tno);
 end;
 /
--======================================================================
select * from emp;

declare
    v_empno emp.empno%type;
    v_empname emp.ename%type;
    v_expreience number;
begin
    select empno,
           ename,
           trunc((sysdate-hiredate)/365.5) 
    into v_empno,
         v_empname,
         v_expreience 
    from emp
    where empno = :no;
    
    if v_expreience >= 60 then
    DBMS_OUTPUT.put_line(v_empname||' '||'is an CEO');
    elsif v_expreience <= 40 then
    DBMS_OUTPUT.put_line(v_empname||' '||'is an Manager');
    elsif v_expreience <=20 then
    DBMS_OUTPUT.put_line(v_empname||' '||'is an Assit- Manager');
    end if;
    DBMS_OUTPUT.put_line('Retired');    
end;


