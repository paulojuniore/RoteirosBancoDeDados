--Q1
SELECT * FROM department;

--Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname, lname FROM employee WHERE sex = 'M';

--Q8
SELECT fname FROM employee WHERE superssn IS NULL;

--Q9
SELECT e.fname, s.fname FROM employee e, employee s WHERE e.superssn = s.ssn;

--Q10
SELECT e1.fname FROM employee e1, employee e2 WHERE e1.superssn = e2.ssn AND e2.fname = 'Franklin';

--Q11
SELECT dept.dname AS department, location.dlocation AS location FROM department dept, dept_locations location WHERE dept.dnumber = location.dnumber;

--Q12
SELECT dept.dname AS department FROM department dept, dept_locations location WHERE dept.dnumber = location.dnumber AND location.dlocation LIKE 'S%';

--Q13
SELECT e.fname, e.lname, d.dependent_name FROM employee e, dependent d WHERE d.essn = e.ssn; 

--Q14
SELECT fname || ' ' || minit || ' ' || lname AS full_name, salary FROM employee WHERE salary > 50000;

--Q15
SELECT p.pname, d.dname FROM project p, department d WHERE p.dnum = d.dnumber;

--Q16
SELECT p.pname, e.fname FROM project p, department d, employee e WHERE p.dnum = d.dnumber AND d.mgrssn = e.ssn AND p.pnumber > 30;

--Q17
SELECT p.pname, e.fname FROM project p, employee e, works_on w WHERE e.ssn = w.essn AND p.pnumber = w.pno;

--Q18
SELECT e.fname, d.dependent_name, d.relationship FROM employee e, dependent d, project p, department dept WHERE e.ssn = d.essn AND e.dno = dept.dnumber AND dept.dnumber = p.dnum AND p.pnumber = 91;
