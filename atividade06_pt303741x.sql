--atividade 1 --
-- INSTRUCTOR (sem a coluna salary)
GRANT SELECT (ID, name, dept_name)
ON dbo.instructor
TO User_B;

-- TAKES (sem a coluna grade)
GRANT SELECT (ID, course_id, sec_id, semester, year)
ON dbo.takes
TO User_B;

--atividade 2 --
-- Permitir SELECT apenas nas colunas específicas
GRANT SELECT (course_id, sec_id, semester, year)
ON dbo.section
TO User_C;

-- Permitir UPDATE apenas nessas mesmas colunas
GRANT UPDATE (course_id, sec_id, semester, year)
ON dbo.section
TO User_C;


--atividade 3 --

-- Permitir SELECT em todas as colunas de INSTRUCTOR
GRANT SELECT
ON dbo.instructor
TO User_D;

-- Permitir SELECT em todas as colunas de STUDENT
GRANT SELECT
ON dbo.student
TO User_D;

-- Permitir SELECT na view grade_points
GRANT SELECT
ON dbo.grade_points
TO User_D;

-- atividade 4 --

-- Criar a VIEW filtrando apenas Civil Eng.
CREATE VIEW dbo.student_civil AS
SELECT *
FROM dbo.student
WHERE dept_name = 'Civil Eng.';

-- Conceder permissão ao User_E
GRANT SELECT
ON dbo.student_civil
TO User_E;

--atividade 5 --

REVOKE SELECT
ON dbo.student_civil
FROM User_E;

--atividade 6 --

SELECT 
    dp.name AS Usuario,
    dp.type_desc AS Tipo_Usuario,
    perm.permission_name AS Permissao,
    perm.state_desc AS Estado,
    OBJECT_NAME(perm.major_id) AS Objeto,
    col.name AS Coluna
FROM sys.database_permissions perm
JOIN sys.database_principals dp 
    ON perm.grantee_principal_id = dp.principal_id
LEFT JOIN sys.columns col 
    ON col.object_id = perm.major_id 
    AND col.column_id = perm.minor_id
WHERE dp.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E')
ORDER BY dp.name, Objeto, Permissao;

