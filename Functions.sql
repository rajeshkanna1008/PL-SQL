--1. Create a function with already existing name using replace

create function f1 (a number, b number)
return number
is
v_c number;
begin
    v_c:= a+b;
    return v_c;
end;
/
declare
    c number;
begin
    c:=f1(10,20);
    dbms_output.put_line(c);
end;

--2Create a function with already existing name using replace
create or replace function f1 (a number, b number)
return number
is
v_c number;
begin
    v_c:= a+b;
    return v_c;
end;
/
declare
    c number;
begin
    c:=f1(10,20);
    dbms_output.put_line(c);
end;

======================

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

SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE(emp_find(7566));
END;

