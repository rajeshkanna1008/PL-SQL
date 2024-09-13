set serveroutput on;
-- Factorial number using function
create or replace function xx_factorial_number(num number)
return number
is 
fact number := 1;
begin
    if num = 0 then -- factorial of 0 is 1
        return 1;
    else
        for i in 1..num
        loop
            fact := fact*i;
        end loop;
        return fact;
    end if;
end;
/

declare 
    num number:= :num;
    fact number;
begin
    fact := xx_factorial_number(num);
    dbms_output.put_line('The factorial of '||num||' is '||fact);
end;


set serveroutput on;

-- maximum number among 3 numbers
create or replace function xx_maximum_number(a number,b number,c number)
return number
is 
max_number number;
begin
    max_number := a; 
    
    if b > max_number then
        max_number := b;
    end if;
    if c > max_number then
        max_number := c;
    end if;
    return max_number;
end;
/
declare
    n1 number := :n1;
    n2 number := :n2;
    n3 number := :n3;
    max_num number;
begin
    max_num := xx_maximum_number(n1, n1, n3);
    dbms_output.put_line('the maximum number is '||max_num);
end;

-- Power of an number using function
create or replace function xx_power(a number, b number)
return number 
is 
power_of_num number := 1;
begin   
        power_of_num := power(a,b);
    return power_of_num;
end;
/
declare
    n1 number := :n1;
    n2 number := :n2;
    power_of_nums number;
begin
    power_of_nums := xx_power(n1,n2);
    dbms_output.put_line('The power of '||n1||' is '||power_of_nums);
end;

--Sum in select statement and declare 

set serveroutput on;
create table test2(
x number,
y number,
z number);


create or replace function sum_of(x number, y number,z number)
return number
is 
s number;
begin
insert into test2 values(x,y,z);
s:=x+y+z;
return s;
end;
/

select sum_of(2,5,7) from dual;
/
declare
    s number(3);
begin
    s:=sum_of(2,5,7);
    dbms_output.put_line(s);
end;
/


-- Reverse words in a sentance
set serveroutput on;

ccreate or replace function xx_reverse_words(str_1 varchar2)
return varchar2
is 
str_2 varchar2(200);
cursor C1 is
        select REGEXP_SUBSTR(str_1, '[^ ]+' , 1, level) AS values1
        from dual connect by REGEXP_SUBSTR(str_1, '[^ ]+', 1, level) IS NOT NULL
        order by rownum desc;
begin
    for i in c1
    loop
        str_2:=str_2||i.values1||' ';
    end loop;
return str_2;
end;
/
declare
    str_1 varchar2(200):= :str;
    str_2 varchar2(200):='';   
begin
    str_2:=xx_reverse_words(str_1);
    dbms_output.put_line(str_2);
end;
/


set serverout on;
declare
    coun number:= 1;  
    str varchar2(300):= 'My name is rajesh im from knr';
    counte number:=0;
begin
    counte := REGEXP_COUNT(str,' ');
    counte := counte + 1;
    dbms_output.put_line(counte);
end;
/