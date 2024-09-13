set serveroutput on;
--Numbers 1 to 10
declare 
    n number(10):=10;
begin
    for i in 1..n
    loop
        dbms_output.put_line(i);
    end loop;
end;

--==================================== table
declare
    a number (20):= 2;
begin
    for b in 1..10
    loop
        dbms_output.put_line(a||'*'||b||'='||a*b);
    end loop;
end;

--============================================ Basic loop=============
-- Factorial of an number
declare 
    a number (20) := :nm;
    x number (20) := 1;
    i number(20);
begin
    for i in 1..a
    loop
        x:=x*i;
    end loop;
    dbms_output.put_line('Factorial of '||a||' is '||x);
end;

--=============================== Prime number
declare 
    num number := :enter_a_number_to_check_prime_or_not;
    i number := 2;
    r number := 1;
begin
    for i in 2..num
    loop
        if mod(num,i)=0
        then
        r := 0;
        exit;
        end if;
    end loop;
if r = 1 then
dbms_output.put_line(num||'is a prime number');
else
dbms_output.put_line(num||'is not a prime number');
end if;
end;
    
--===============================================

declare
    v_empname emp.ename%type;
    --v_increment_salary emp.sal%type;
    
begin
    select ename into v_empname from emp where empno = :empno;
    if job = 'MANAGER' then
    dbms_output.put_line(v_empname||' '||'The increment salary is '||sal+sal*58/100);
    elsif job = 'ANALYST' then
    dbms_output.put_line(v_empname||' '||'The increment salary is '|| sal+sal*35/100);
    elsif job = 'CLERK' then
    dbms_output.put_line(v_empname||' '||'The increment salary is'|| sal+sal*10/100);
end;


--Fibonacci Series
declare 
    a number := 0; --starting number
    b number :=1; -- second nunber
    c number; -- to store a addition of a,b values
    n number := :n; -- To Give the range for fibonacci
begin
dbms_output.put_line('first 10 fibonacci numbers');
dbms_output.put_line(a);
dbms_output.put_line(b);
    for i in 3..n
    loop
        c:=a+b;
        dbms_output.put_line(c);
        a := b;
        b := c;
    end loop;        
end;

--polindrome number or not
declare
	num number := :n;
	rev_num number;
	temp number:=0;
	rem number;
begin
	rev_num := num; --121, 12, 1, 0
	while num>0
	loop
		rem:=mod(num,10); -- mod(121,10)=1, mod(21,10) = 2, mod(1,10)= 1
		temp:=(temp*10)+rem; -- 0*10+1=1, 1*10+2 = 12, 12*10+1 = 121
		num:=trunc(num/10); -- 121/10 =12, 12/10=1, 1/10 = 0
	end loop; 
	if rev_num = temp then
		dbms_output.put_line(temp||' is a polindrome');
	else
		dbms_output.put_line(temp||' is not a polindrome');
	end if;
end;


-- Reverse a number
declare
    num number := :n;
    rev_num number := 0;
begin
    while num>0
    loop
        rev_num := (rev_num *10) + mod(num,10);
        num := trunc(num/10);
    end loop;
    dbms_output.put_line('Reverse of the number is '||rev_num);
end;

--Reverse a string
declare
    str varchar2(300):=:s;
    rev_str varchar2(300);
begin
    for i in reverse 1..length(str)
    loop
        rev_str :=rev_str || substr(str,i,1);
    end loop;
    dbms_output.put_line('Reversed string is: '||rev_str);
end;
/


-- Armstrong Number

declare
    n number := :n; --153
    s number :=0;
    r number ;
    len number; --3
    m number; -- 153
begin
    m:= n; --153
    len := length(n); --3
    
    while n>0 --153, 15, 1, 0 = false loop over
    loop
        r := mod(n,10); -- mod(153,10) = 3 & mod(15,10) = 5, mod(1,10) = 1 
        s := s + power(r,len); -- 0+ pow(3,3)=27, 27 +pow(5,3)=152, 152+poe(1,3)= 153 s = 153
        n := trunc(n / 10); --153/10=15, 15/10=1 , 1/10 = 0
    end loop;
    if m = s -- m = 153 and s = 153
    then
        dbms_output.put_line(m ||' is a armstrong number');
    else
        dbms_output.put_line(m ||' is not a armstrong number');
    end if;
end;
/

-- Sum of digits is equal to gievn number, here number = 25
declare
    n number;
    m number;
    s number := 0;
begin
    for i in 1..999
    loop
        n := i;
        while n>0
        loop
            m := mod(n,10);
            s := s + m;
            n := trunc(n/10);
         end loop;
         if s = 25 then
            dbms_output.put_line(i);
        end if;
    s:=0;
    end loop;
end;

-- sum of digits in given number
declare 
    n number := :num;
    total_sum number :=0;
    rem number;
    num number;
begin
    num := n;
    while num <> 0
    loop
        rem := mod(num,10);
        total_sum := total_sum + rem;
        num := trunc(num/10);
    end loop;
    dbms_output.put_line('the sum of digits in ' ||n|| ' is '||total_sum);
end;

-- Perfect Number or not
declare 
    num number:= :n; 
    sum_of_divisors number :=0;
begin
    for i in 1..num/2
    loop
        if num mod i = 0 then
            sum_of_divisors := sum_of_divisors + i;
        end if;
    end loop;
    if sum_of_divisors = num then
        dbms_output.put_line(num|| ' is a perfect number');
    else
        dbms_output.put_line(num|| ' is not a perfect number');
    end if;
end;

-- first 20 even numbers

declare 
    num number := 1;
    counter number :=0;
begin
    while counter < 20 
    loop
        if mod(num,2)=0 then        
            dbms_output.put_line(num);
            counter := counter + 1;
        end if;
        num := num+1;
    end loop;
end;;

-- first 20 odd numbers
declare 
    num number := 1;
    counter number :=0;
begin
    while counter < 20 
    loop
        if mod(num,2)<>0 then        
            dbms_output.put_line(num);
            counter := counter + 1;
        end if;
        num := num+1;
    end loop;
end;

--11.	Retrieve all employee details using for loop
begin
 dbms_output.put_line('emp_no' ||chr(9)|| 'Emp_name'||chr(9)||'Job Nmae'||chr(9)
 ||'Manager_Id'||chr(9)||'Salary'||chr(9)||'Commision'||chr(9)|| 'deptno');
    for i in (select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp)
    loop

    dbms_output.put_line(i.empno||chr(9)||
                        i.ename||chr(9)||
                        i.job ||chr(9)||chr(9)||chr(9)||
                        i.mgr||chr(9)||
                        i.sal||chr(9)||chr(9)||chr(9)||
                        i.comm||chr(9)||chr(9)||chr(9)||
                        i.deptno||chr(9)||chr(9));
    end loop;
end;
/


-- 12. Triangle Pattern
declare 
    num number := :n;
    i number ;
    j number ;
begin
    for i in 1..num
    loop
        for j in 1..i
        loop
            dbms_output.put('*');
        end loop;
    dbms_output.new_line;
    end loop;
end;

--13. Triangle patteren in reverse

declare 
    num number := :n;
    i number ;
    j number ;
begin
    for i in reverse 1..num
    loop
        for j in 1..i
        loop
            dbms_output.put('*');
        end loop;
    dbms_output.new_line;
    end loop;
end;

-- sum of salary as per deptno.
begin
    for i in (select deptno,sum(sal) as total_sal from emp group by deptno)
    loop
        if i.deptno =10 then
            dbms_output.put_line('Total salary of deptno 10 is :'|| i.total_sal);
        elsif i.deptno = 20 then
            dbms_output.put_line('Total salary of deptno 20 is :'|| i.total_sal);
        else
            dbms_output.put_line('Total salary of deptno 30 is :'|| i.total_sal);
        end if;
    end loop;
end;

-- sum of salary and avg salary in dept wise
begin
    for i in (select deptno,
                sum(sal) as total_sal, 
                round(avg(sal)) as average_salary 
                from emp group by deptno order by deptno)
    loop
        if i.deptno = 10 then
            dbms_output.put_line('Total salary and average salary of deptno 10  :'|| i.total_sal 
            ||' and avg sal is :'||i.average_salary);
        elsif i.deptno = 20 then
            dbms_output.put_line('Total salary and average salary of deptno 20  :'
            || i.total_sal||' and avg sal is :'||i.average_salary);
        elsif i.deptno = 30 then
            dbms_output.put_line('Total salary and average salary of deptno 30  :'
            || i.total_sal||' and avg sal is :'||i.average_salary);
        end if;
    end loop;
end;
/
-- sum of salary and avg salary by job wise.

begin
    for i in (select job, 
            sum(sal) as total_salary, 
            round(avg(sal)) as avg_sal 
            from emp group by job)
    loop
        if i.job = 'ANALYST' then
            dbms_output.put_line('The total salary of '||i.job||' is '|| i.total_salary ||
            ' and average salary of '|| i.job ||' is '|| i.avg_sal);
        elsif i.job = 'CLERK' then
            dbms_output.put_line('The total salary of '||i.job||' is '|| i.total_salary ||
            ' and average salary of '|| i.job ||' is '|| i.avg_sal);
        elsif i.job = 'MANAGER' then 
            dbms_output.put_line('The total salary of '||i.job||' is '|| i.total_salary ||
            ' and average salary of '|| i.job ||' is '|| i.avg_sal);
        elsif i.job = 'SALESMAN' then
            dbms_output.put_line('The total salary of '||i.job||' is '|| i.total_salary ||
            ' and average salary of '|| i.job ||' is '|| i.avg_sal);
        else
            dbms_output.put_line('The total salary of '||i.job||' is '|| i.total_salary ||
            ' and average salary of '|| i.job ||' is '|| i.avg_sal);
        end if;
    end loop;   
end;
/

-- 1,4,7,10,13,16,19,22,25,28

declare 
    num number := 1;
begin
    loop
        dbms_output.put(num||',');
        num := num +3;
        exit when num >30;
    end loop;
    dbms_output.put_line('');
end;

set serveroutput on;

--my name is Rajesh to Rajesh is name my.

declare
    l_str varchar2(100):='my name is rajesh';
    l_str2 varchar2(100):='';
    cursor c1 is
        select regexp_substr(l_str, '[^ ]+' , 1, level) as parts
        from dual connect by regexp_substr(l_str, '[^ ]+', 1, level) is not null
        order by rownum desc;
begin
    for i in c1
    loop
        l_str2:=l_str2||i.parts||' ';
    end loop;
    dbms_output.put_line(l_str2);
end;

