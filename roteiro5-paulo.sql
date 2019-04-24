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

-- Q8
SELECT p.pnumber, AVG(e.salary)
