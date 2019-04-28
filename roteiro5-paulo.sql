-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND address LIKE '%TX';

-- Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY qtd_supervisionados;

-- Q4
SELECT e.fname AS nome_supervisor, COUNT(e.ssn) AS qtd_supervisionados FROM employee e INNER JOIN employee s ON e.ssn = s.superssn GROUP BY e.ssn ORDER BY qtd_supervisionados;

-- Q5
SELECT e.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM employee e RIGHT OUTER JOIN employee s ON e.ssn = s.superssn GROUP BY nome_supervisor ORDER BY qtd_supervisionados;

-- Q6
SELECT MIN(h.count) AS qtd FROM (SELECT pno, count(*) FROM works_on group by pno) AS h;

-- Q7
select pnumber, min(c.count) AS qtd FROM (select pnumber,count(pnumber = pno) from project AS p INNER JOIN works_on AS w ON(p.pnumber = w.pno) GROUP BY pnumber) AS c GROUP BY pnumber having min(c.count) = (select min(x.count) AS qtd FROM (select pnumber,count(pnumber = pno) from project AS p INNER JOIN works_on AS w ON(p.pnumber = w.pno) GROUP BY pnumber) AS x);

-- Q8
SELECT p.pnumber AS num_proj, AVG(e.salary) FROM project p INNER JOIN works_on w ON (p.pnumber = w.pno) INNER JOIN employee e ON (e.ssn = w.essn) GROUP BY num_proj;

-- Q9
SELECT p.pnumber AS num_proj, p.pname, AVG(e.salary) FROM project p INNER JOIN works_on w ON (p.pnumber = w.pno) INNER JOIN employee e ON (e.ssn = w.essn) GROUP BY num_proj;

-- Q10
SELECT e.fname, e.salary FROM employee e WHERE e.salary > ALL (SELECT e.salary FROM works_on w INNER JOIN employee e ON e.ssn = w.essn WHERE w.pno = 92);

-- Q11
SELECT e.ssn, COUNT(*) AS qtd_proj FROM employee e FULL OUTER JOIN works_on w ON e.ssn = w.essn GROUP BY e.ssn ORDER BY qtd_proj;

-- Q12
SELECT p.pnumber AS num_proj, count(*) AS qtd_func FROM project AS p INNER JOIN works_on AS w ON(p.pnumber = w.pno) RIGHT JOIN employee AS e ON (e.ssn = w.essn) GROUP BY num_proj HAVING count(*) < 5 ORDER BY qtd_func; 

--Q13
SELECT e.fname FROM employee AS e, project AS p, works_on AS w WHERE (e.ssn = w.essn) AND (p.pnumber = w.pno) AND p.plocation = 'Sugarland' AND EXISTS(SELECT pname FROM dependent AS d WHERE d.essn = e.ssn); 

-- Q13
SELECT e.fname FROM employee AS e WHERE e.ssn IN (SELECT e.ssn FROM works_on AS w WHERE(e.ssn = w.essn) AND w.pno IN (SELECT w.pno FROM project AS p WHERE (p.pnumber = w.pno) AND p.pname IN (SELECT p.pname FROM project AS p WHERE (p.plocation = 'Sugarland') AND EXISTS(SELECT pname FROM dependent AS d WHERE d.essn = e.ssn))));


--Q14
SELECT d.dname FROM department AS d WHERE NOT EXISTS(SELECT * FROM project AS p WHERE p.dnum = dnumber);




