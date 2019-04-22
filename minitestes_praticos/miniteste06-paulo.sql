SELECT d.dname FROM employee e, department d WHERE e.ssn = d.mgrssn AND mgrssn LIKE '%5555';
