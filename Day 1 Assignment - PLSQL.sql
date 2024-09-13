---------------------------------- PL/SQL Assignment day 1 -------------------------------------

1) Write PL/SQL Program for user entered employee number(Dynamic Input) then display name of the employee and his salary from employee table.


declare 
	v_empname emp.ename%type;
	v_salary emp.sal%type;
begin;
	select ename,sal into v_empname,v_salary from emp
	where empno = :empno;
	dbms_output.put_line('name of the employee is'||v_empname);
	dbms_output.put_line('salary of an employee is'||v_salary);
end;
	
2)Find the value of C using pl/sql code.
   a = 17 , b = 11 , c is sum of a and b.
  
declare 
    a number := 17;
    b number := 11;
    c number;
begin
    c := a+b;
    DBMS_OUTPUT.PUT_LINE('The value of C is'||' = '||c);
end;
  
3) Write PL/SQL program to find the maximum salary from employee table and store it into PL/SQL variable and dispaly max salary.

declare 
--    v_ename emp.ename%type;
    v_maxsalary emp.sal%type;
begin
    select round(max(sal),0) 
    into v_maxsalary from emp;
    
    DBMS_OUTPUT.PUT_LINE('Maximum Salary is '||' '||v_maxsalary);
end;

4) Write PL/SQL Program for user entered  employee number (Dynamic Input) then display name of the employee and his department name and his salary from employee table and department table using %type.

declare 
    v_empno emp.empno%type;
    v_empname emp.ename%type;
    v_deptname dept.dname%type;
    v_salary emp.sal%type;
begin
    select e.empno, e.ename,e.sal, d.dname
    into v_empno,v_empname,v_salary,v_deptname
    from emp e, dept d
    where e.deptno = d.deptno
    and e.empno = :n;
    dbms_output.put_line('Employee Name is '||' '|| v_empname);
    dbms_output.put_line('Employee department name is '||' '|| v_deptname);  
    dbms_output.put_line('Employee salary is '||' '|| v_salary);
end;
    
5) Write PL/SQL Program for user entered student number (Dynamic Input) then display name of the student and his department code from student table using %rowtype.

declare 
    v_student_name students%rowtype;
begin
    select st_name,dept_id 
    into v_student_name.st_name,v_student_name.dept_id 
    from students
    where st_id = :a;
    dbms_output.put_line ('Name of the student is '|| v_student_name.st_name);
    dbms_output.put_line('Dept number of the student '||v_student_name.dept_id );
end;
6) Print all Employee info using plsql .

7) Print employee info with DEPT and Annual sal.

declare 
    v_empno emp.empno%type; 
    v_empname emp.ename%type;
    v_jobname emp.job%type;
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
begin
    select e.empno,e.ename,e.job,e.deptno,d.dname 
    into v_empno,v_empname,v_jobname,v_deptno,v_dname
    from emp e , dept d
    where 
    e.deptno = d.deptno
    and e.empno = :n;    
    dbms_output.put_line('Emp No'||' '||v_empno);
    dbms_output.put_line('emp name is'||' '||v_empname);
    dbms_output.put_line('employee job name is'||' '||v_jobname);
    dbms_output.put_line('deptno is'||' '||v_deptno);
    dbms_output.put_line('dept name is'||' '||v_dname);
end;
------------------------------------------- PL/SQL Assignment -----------------------------

1) print a message if a given alphabet is present in English vowels (A, E, I, O, U)(Note : Use dynamic input).
declare 
    v_input varchar2(20):= :n;
begin
    
    if v_input in ('A','E','I','O','U') then 
    dbms_output.put_line('Hello you entred a vowel letter');
    end if;    
end;
2) print the grade based on the given marks with else condition (mark >= 70 Grade A, mark >=40 and mark<70 Grade B, mark >=35 and mark<40 Grade C, else ‘No Grade’)(Note : Use dynamic input).

declare 
    v_mark number := :nom;
begin
    if v_mark >=70 then
    dbms_output.put_line('Grade A');
    elsif (v_mark <=70) and (v_mark >=40)then
    dbms_output.put_line('Grade B');
    elsif (v_mark <=40) and (v_mark >=35) then
    dbms_output.put_line('Grade C');
    else
    dbms_output.put_line('No grade');
    end if;
end;

3) print the greatest of three numbers (i.e Number= 10,15 and 20 and the maximum number will be fetched).
declare 
    a number := 10;
    b number := 15;
    c number := 20;
begin
    if a>b and a>c then
    dbms_output.put_line('The greatest number is '||a);
    elsif b>a and b>c then
    dbms_output.put_line('The greatest number is '||b);
    else
    dbms_output.put_line('The greatest number is '||c);
    end if;
end;


4) Print employee name and increment his salary follow by below pattern
     Job = Manger ---> Increment salary 58%
     Job = Analyst ---> Increment salary 35%
     Job = Clerk---> Increment salary 10%
(Dont use Insert or update statements ).

begin
    dbms_output.put_line('empno'||' '||'empname'||' '||'increment_salary');
    for i in (select * from emp)
    loop
    if i.job = 'MANAGER' then
    dbms_output.put_line(i.empno||' '||i.ename||'   '||i.sal*0.53);
    elsif i.job = 'ANALYST' then 
    dbms_output.put_line(i.empno||' '||i.ename||'   '||i.sal*0.35);
    elsif i.job = 'CLERK' then
    dbms_output.put_line(i.empno||' '||i.ename||'    '||i.sal*0.10);
    end if;
    end loop;
end;



5) Print department id follow by below pattern
    deptid = 10 then print 'Ten' 
    deptid = 20 then print 'Twenty' 
    deptid = 30  or other values print ' Others'(Note : Use dynamic input).
	
declare
    v_deptid number:= :n;
begin
    if v_deptid = 10 then
    dbms_output.put_line('Ten');
    elsif v_deptid = 20 then
    dbms_output.put_line('Twenty');
    else
    dbms_output.put_line('Others');
    end if;
end;