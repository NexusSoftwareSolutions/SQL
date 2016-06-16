SELECT EmployeeID FROM Users WHERE UserName = 'Test';

INSERT INTO Users (EmployeeID, Username, Pass, PermissionID)
VALUES (2, 'test@gmail.com', 'testpass', 1);
SELECT * FROM Users;

SELECT * FROM Employees;

INSERT INTO Employees (EmployeeTypeID, FirstName, LastName, Suffix, Email, CellPhone)
VALUES (1, 'TestEmployee', 'TestLastName', 'Sr.', 'test@gmail.com', '678-555-1212');

SELECT * FROM LU_EmployeeTypes;

INSERT INTO LU_EmployeeTypes
VALUES ('Manager');

SELECT EmployeeID FROM Users WHERE UserName = 'test@gmail.com';

execute proc_GetUser 'test@gmail.com'

execute proc_GetCalendarDataByEmployeeID 2

INSERT INTO CalendarData 
VALUES ('2', '2016-5-6', '2016-5-7', 1, 'none');
SELECT * FROM CalendarData;


SELECT * FROM Customers;

DECLARE @new_id int

execute proc_AddCustomer 'Robby', 'Scotty', 'Williams', null, null, '30046', '678-555-1212', null, 'robby@gmail.com', 0, @new_id OUTPUT;

PRINT @new_id;


DECLARE @new_id int
SET @new_id = IDENT_CURRENT('Customers')
PRINT @new_id
DECLARE @newID int;
execute proc_AddInsuranceCompany 'AllState', '555 State Road NE', '30043', '800-555-2242', '678-151-1444', null, null, null, 'allstate@gmail.com', 1, @newID OUTPUT;
PRINT @newID;

SELECT * FROM Customers;
SELECT * FROM InsuranceCompanies;
SELECT * FROM Inspections;



execute proc_AddClaim 



