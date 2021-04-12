-- Questão 01: Retornar todos os elementos da tabela department
SELECT * FROM DEPARTMENT;

-- Questão 02: Retornar todos os elementos da tabela dependent
SELECT * FROM DEPENDENT;

-- Questão 03: Retornar todos os elementos da tabela dept_locations
SELECT * FROM DEPT_LOCATIONS;

-- Questão 04: Retornar todos os elementos da tabela employee
SELECT * FROM EMPLOYEE;

-- Questão 05: Retornar todos os elementos da tabela project
SELECT * FROM PROJECT;

-- Questão 06: Retornar todos os elementos da tabela works_on
SELECT * FROM WORKS_ON;

-- Questão 07: Retornar os nomes dos funcionários homens
SELECT (fname, lname) FROM EMPLOYEE where (sex = 'M');

-- Questão 08: Retornar os nomes dos funcionários homens que não possuem supervisor
SELECT (fname) FROM EMPLOYEE where (sex = 'M' and superssn IS NULL);

-- Questão 09: Retornar os nomes dos funcionários e o nome do seu supervisor, apenas para os funcionários que possuem supervisor
SELECT (E.fname, S.fname) FROM EMPLOYEE AS E, EMPLOYEE AS S WHERE (S.ssn = E.superssn and E.superssn IS NOT NULL);

-- Questão 10: Retornar os nomes dos funcionários supervisionados por Franklin;

SELECT (E.fname) FROM EMPLOYEE AS E, EMPLOYEE AS S WHERE (S.ssn = E.superssn and S.fname = 'Franklin');

-- Questão 11: Retornar os nomes dos departamentos e suas localizações
SELECT (D.dname, L.dlocation) FROM DEPARTMENT AS D, DEPT_LOCATIONS AS L WHERE (D.dnumber = L.dnumber);

-- Questão 12: Retornar os nomes dos departamentos localizados em cidades que começam com a letra 'S'
SELECT (D.dname) FROM DEPARTMENT AS D, DEPT_LOCATIONS AS L WHERE (D.dnumber = L.dnumber and L.dlocation LIKE 'S%');

-- Questão 13: Retornar os nomes (primeiro e último) dos funcionários e seus dependentes (apenas aqueles que possuem dependentes);
SELECT (E.fname, E.lname, D.dependent_name, E.lname) FROM EMPLOYEE AS E, DEPENDENT AS D WHERE (E.ssn = D.essn);

-- Questão 14: Retornar o nome completo dos funcionários que possuem salário maior do que 50 mil. A relação de retorno deve ter apenas duas colunas: "full_name" e "salary". O nome completo deve ser formado pela concatenaçao dos valores das 3 colunas dados sobre nome. Use o operados || para concatenar Strings.

SELECT (fname || ' '|| minit || '. '|| lname ) AS full_name, salary FROM EMPLOYEE WHERE (salary > 50000);

-- Questão 15: Retornar os projetos (nome) e os departamentos responsáveis(nome)
SELECT (P.pname, D.dname) FROM PROJECT AS P, DEPARTMENT AS D WHERE (P.dnum = D.dnumber);

-- Questão 16: Retornar os projetos (nome) e os gerentes dos departamentos responsáveis (primeiro nome). Retornar resultados apenas para os projetos com código maior do que 30
SELECT (P.pname, E.fname) From PROJECT AS P, EMPLOYEE AS E, DEPARTMENT AS D WHERE (P.dnum = D.dnumber and E.ssn = D.mgrssn and P.pnumber > 30);

-- Questão 17: Retornar os projetos (nome) e os funcionários que trabalham neles (primeiro nome);
SELECT (P.pname, E.fname) FROM PROJECT AS P, EMPLOYEE AS E, WORKS_ON AS W WHERE (P.pnumber = W.pno and E.ssn = W.essn);

-- Questão 18: Retornar os nomes do dependentes dos funcionários que trabalham no projeto 91. Retornar também o nome (primeiro) do funcionário eo relacionamento entre eles.
SELECT (E.fname, D.dependent_name, D.relationship) FROM EMPLOYEE AS E, WORKS_ON AS W, DEPENDENT AS D WHERE (E.ssn = W.essn and W.pno = '91' and D.essn = E.ssn);

