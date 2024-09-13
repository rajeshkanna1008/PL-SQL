What is PL/SQL:

PL/SQL is a block structured language. The programs of PL/SQL are logical blocks that can contain any number of nested sub-blocks. 
Pl/SQL stands for "Procedural Language extension of SQL" that is used in Oracle. PL/SQL is integrated with Oracle database (since version 7). 
The functionalities of PL/SQL usually extended after each release of Oracle database. 
Although PL/SQL is closely integrated with SQL language, yet it adds some programming constraints that are not available in SQL.

*************************
PL/SQL Functionalities:
*************************
With PL/SQL, you can use SQL statements to manipulate Oracle data and flow of control statements to process the data.

The PL/SQL is known for its combination of data manipulating power of SQL with data processing power of procedural languages. 
It inherits the robustness, security, and portability of the Oracle Database.

PL/SQL is not case sensitive so you are free to use lower case letters or upper case letters except within string and character literals. 
A line of PL/SQL text contains groups of characters known as lexical units. It can be classified as follows:

Delimeters
Identifiers
Literals
Comments

*****************
PL/SQL Variables:
*****************

It is nothing except a name given to a storage area. 
Each variable in the PL/SQL has a specific data type which defines the size and layout of the variables memory.
***********
syntax:
variable_name [CONSTANT] datatype [NOT NULL] [:= | DEFAULT initial_value]  
***************
Example:
Radius Number := 5;
Date_of_birth date;
****************
In PL/SQL while declaring the variable some restrictions hold.

Forward references are not allowed i.e. you must declare a constant or variable before referencing it in another statement even if it is a declarative statement.
val number := Total - 200;
Total number := 1000;

The first declaration is illegal because the TOTAL variable must be declared before using it in an assignment expression.

Variables belonging to the same datatype cannot be declared in the same statement.
N1, N2, N3 Number; =It is an illegal declaration.

***********************************
Initializing Variables in PL/SQL:
***********************************

The DEFAULT keyword
The assignment operator (:=)
*************************
a number(10) := 0;  
greetings varchar2(20) DEFAULT 'Hello Rajesh';    

Example:
DECLARE  
   a integer := 30;  
   b integer := 40;  
   c integer;   
BEGIN  
   c := a + b;  
   dbms_output.put_line('Value of c: ' || c);  
END;  

here:
dbms_output = Package name
put_line = Procedure Name

********************
Types of Variables:*
********************
Global Variable: Global variables are declared in outermost block.
Local Variable: Local variables are the inner block variables which are not accessible to outer blocks.

Ex:
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
******
%type: It is used to assign the datatype of the column of an existing table to the new variables.
syntax:
	variable_name table_name.column_name%type;
example:
	v_Student_name students.st_name%type;
	
	here v_Student_name = variable name
	students = table name
	st_name = one column of a students TABLE
	%type = assign the datatype of the st_name to v_Student_name;
	
*****
%ROWTYPE:
The %ROWTYPE attribute is used to declare a record type that represents a row in a table. 
The record can store an entire row or some specific data selected from the table.

Syntax:
<var_name> <tab_name>%rowtype;  

Example:
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
======================================================
Condition Statements:
These type of statements will work on the conditions.
	PL SQL support various types of condition statements,
they are
1. IF = It return the data when conditon is true. If we mention multiple if conditions it will
 check all the conditions.
2. IF ELSIF  = by using IF ELSIF we can mention multiple conditions, but here if the condition 
is true then the checking conditions will stop and it will retuen the statement of an satisfied condition.
3. IF ELSE = it will return the statement, if the condition is true, otherwise it will return the else block statement.

examples:

If ;

--print a message if a given alphabet is present in English vowels (A, E, I, O, U)(Note : Use dynamic input).
declare 
    v_input varchar2(20):= :n;
begin
    
    if v_input in ('A','E','I','O','U') then 
    dbms_output.put_line('Hello you entred a vowel letter');
    end if;    
end;

IF ELSE:

/*Print department id follow by below pattern
    deptid = 10 then print 'Ten' 
    deptid = 20 then print 'Twenty' 
    deptid = 30  or other values print ' Others'(Note : Use dynamic input).*/
	
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
    
if ELSIF:
/* print the grade based on the given marks with else condition 
(mark >= 70 Grade A, mark >=40 and mark<70 Grade B, mark >=35 and mark<40 Grade C, else ‘No Grade’)
(Note : Use dynamic input).*/

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

-- Iterative statements in PL SQL
this statements will used to repeat the execution of one or more statements for specific number of times.
1. simple LOOP
2. while LOOP
3. for LOOP

Simple loop:
	A simple loop is used when a set of statements is to be executed at least ones before the loop terminates.
ex:
declare 
	
* initilize a variable before the loop BODY
* increment the variable in the loop
* exit when statement is used to exit from the loop , if we use only EXIT statement without WHEN the loop will
execute only ones.






-- Cursors
When an SQL statement is processed, Oracle creates a memory area known as context area. 
A cursor is a pointer to this context area.
A cursor contains information on a select statement and the rows of data accessed by it.

There are two types of cursors:

Implicit Cursors : 

These are created by default to process the statements when 
DML statements like INSERT, UPDATE, DELETE etc. are executed.

Types of implicit Cursors:
1. % found : It returns the true if the DML sql%found or select into statement will return atleast one row.
otherwise it will return false.

2. %notfound : It returns the true if the DML sql%notfound or select into statement will not effect any row.
otherwise it will return true(if dml or select into statements will return atleast one row) 

3. %rowcount : it return the number of row returned or affected by the DML operations sql%rowcount  

4. %isopen : check whether the cursor is open or not , it return boolean values .

Explicit Cursors :
The Explicit cursors are defined by the programmers to gain more control over the context area. 
These cursors should be defined in the declaration section of the PL/SQL block. 
It is created on a SELECT statement which returns more than one row.

You must follow these steps while working with an explicit cursor.

1. Declare the cursor to initialize in the memory.
CURSOR name IS SELECT statement;
2. Open the cursor to allocate memory.
OPEN cursor_name; 
3. Fetch the cursor to retrieve data.
FETCH cursor_name INTO variable_list;
4. Close the cursor to release allocated memory.
Close cursor_name;  

***********************************************************
***********************************************************

-- find the length of the string without length function.
set serveroutput on;

declare
   p_count   INTEGER := 0;
   p_text varchar2(200) ;
BEGIN
   WHILE SUBSTR (:p_text, p_count + 1, 1) IS NOT NULL
   LOOP
      p_count := p_count + 1;
   END LOOP;
   DBMS_OUTPUT.put_line (p_count);
END;