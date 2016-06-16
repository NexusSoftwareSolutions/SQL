-- gets proc info from routines system table
select * from NexusTest.information_schema.routines 
where routine_type = 'PROCEDURE'
order by SPECIFIC_NAME;

-- gets table names, col names and is nullable for all tables
SELECT Adjustments, COLUMN_NAME, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY Adjustments;

-- get all distinct tablenames
SELECT DISTINCT Adjustments FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY Adjustments;

-- gets proc names, parameter names, and datatypes for all procs
select o.name as 'Proc Name', p.name as 'Parameter Name', t.name as 'DataType' from sys.parameters p
join sys.objects o on o.object_id = p.object_id
join sys.types t on t.system_type_id = p.system_type_id
where o.type = 'P'
order by o.name;

-- gets all proc names only but does not include procs without parameters (lookup procs)
select distinct o.name as 'Proc Name', p.name as 'Parameter Name', isc.COLUMN_NAME, isc.IS_NULLABLE from sys.parameters p
join sys.objects o on o.object_id = p.object_id
join sys.types t on t.system_type_id = p.system_type_id
join INFORMATION_SCHEMA.COLUMNS isc on isc.COLUMN_NAME = SUBSTRING(p.name, 2, LEN(p.name))
where o.type = 'P'
order by o.name;

-- returns the last updated time on a table in a specific database - local db only
SELECT OBJECT_NAME(OBJECT_ID) AS DatabaseName, last_user_update,*
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID('NexusTest')
AND OBJECT_ID=OBJECT_ID('Customers')


-- returns all SQL_STORED_PROCEDURE in the system objects
select * from sys.objects
where type = 'TR';

select * from INFORMATION_SCHEMA.COLUMNS
select * from sys.parameters
select * from sys.objects
select * from sys.types


SELECT Adjustments, COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE IS_NULLABLE = 'YES'
ORDER BY Adjustments;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE IS_NULLABLE = 'YES'
AND DATA_TYPE = 'datetime';


/*	-- Test data for Leads
SELECT * FROM LU_LeadTypes;
SELECT * FROM Customers;
SELECT * FROM Addresses;

DECLARE @new_id int;

execute proc_AddLead 1, 2, 2, '2016-4-10', null, @new_id OUTPUT;
print @new_id;
execute proc_AddLead 2, 3, 3, '2016-4-11', null, @new_id OUTPUT;
print @new_id;
execute proc_AddLead 3, 4, 4, '2016-4-4', 2, @new_id OUTPUT;
print @new_id;

SELECT * FROM Leads;

	-- Test data for CalendarData
--
SELECT * FROM LU_AppointmentTypes;
SELECT * FROM CalendarData;
SELECT * FROM Employees;
SELECT * FROM Claims;

DECLARE @new_id int;

--execute proc_AddCalendarData 2, 2, '2016-5-8', '2016-5-8', null, 2, 'some more notes', @new_id OUTPUT;
--print @new_id;
--execute proc_AddCalendarData 2, 2, '2016-5-3', '2016-5-3', 2, null, 'notes are here', @new_id OUTPUT;
--print @new_id;
execute proc_AddCalendarData 2, 2, '2016-5-10', '2016-5-10', null, null, 'more notes', @new_id OUTPUT;
print @new_id;

SELECT * FROM CalendarData;

*/

/*	-- Test data for Customers
DECLARE @new_id int;

execute proc_AddCustomer 'Marcy', 'Laura', 'Thomas', null, '678-445-1356', null, 'marcy@gmail.com', 0, @new_id OUTPUT;
print @new_id;
execute proc_AddCustomer 'Bob', 'Mark', 'Jones', 'Sr.', '678-124-2134', null, 'bobo@gmail.com', 0, @new_id OUTPUT;
print @new_id;
execute proc_AddCustomer 'Helen', 'Lucy', 'Williams', null, '770-333-6346', '770-444-1212', 'helen@gmail.com', 1, @new_id OUTPUT;
print @new_id;

SELECT * FROM Customers;
*/


/*	-- Test data for Inspections
SELECT * FROM Customers;
SELECT * FROM Claims;
SELECT * FROM Inspections;

DECLARE @new_id int;

execute proc_AddInspection 3, 2, '2016-5-10', 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 'major', 'minor', 'comments are good', @new_id OUTPUT;
print @new_id;
execute proc_AddInspection 4, 4, '2016-5-12', 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 'lots of damage', 'major damage', 'some notes', @new_id OUTPUT;
print @new_id;
execute proc_AddInspection 2, 3, '2016-5-7', 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 'none', 'extreme damage', 'notes are here', @new_id OUTPUT;
print @new_id;

SELECT * FROM Inspections;
*/

	
/*	-- Test data for InsuranceCompanies
DECLARE @new_id int;
execute proc_AddInsuranceCompany 'TestCompany', '555 Smith Road', '30046', '800-555-1212', '678-151-1444', null, null, null, 'insurance@gmail.com', 1, @new_id OUTPUT;
print @new_id;
execute proc_AddInsuranceCompany 'State Farm', '555 Apple Road', '30047', '800-555-2242', '678-151-1444', null, null, null, 'statefarm@gmail.com', 0, @new_id OUTPUT;
print @new_id;
execute proc_AddInsuranceCompany 'AllState', '555 State Road NE', '30043', '800-555-2242', '678-151-1444', null, null, null, 'allstate@gmail.com', 0, @new_id OUTPUT;
print @new_id;

SELECT * FROM InsuranceCompanies;
*/

/*	-- Test data for Claims
SELECT * FROM InsuranceCompanies;
SELECT * FROM Inspections;
SELECT * FROM Customers;

DECLARE @new_id int;
execute proc_AddClaim 2, 'hail', '2016-5-6', 'Wells Fargo', null, 1, 'SF_JONES_1212', @new_id OUTPUT;
print @new_id;
execute proc_AddClaim 3, 'wind', '2016-5-9', 'Wells Fargo', null, 1, 'ALLST_THOMPSON_1212', @new_id OUTPUT;
print @new_id;
execute proc_AddClaim 4, 'fire', '2016-5-10', 'Wells Fargo', null, 1, 'ALLST_WILLIAMS_1212', @new_id OUTPUT;
print @new_id;
execute proc_AddClaim 4, 'water', '2016-5-10', 'Wells Fargo', null, 1, null, @new_id OUTPUT;
print @new_id;

SELECT * FROM Claims;
*/

/*
DECLARE @new_id int;

execute proc_AddPlane 234.3, 13.5, 89.1, 1, @new_id OUTPUT
print @new_id;
execute proc_AddPlane 23.3, 24.5, 42.7, 3, @new_id OUTPUT
print @new_id;
execute proc_AddPlane 256.3, 24.5, 135.2, 2, @new_id OUTPUT
print @new_id;

SELECT * FROM Planes;
*/


/*	-- Test data for RoofMeasurements
SELECT * FROM Claims;
SELECT * FROM Planes;

DECLARE @new_id int;
execute proc_AddRoofMeasurement 2, 1, 1.5, 1.7, 4.5, 3.4, 8.6, 3.4, 2.3, 3.4, 6.6, 2, @new_id OUTPUT;
print @new_id;
execute proc_AddRoofMeasurement 3, 2, 1.5, 1.7, 4.5, 2.4, 7.6, 2.4, 2.3, 3.4, 4.6, 5, @new_id OUTPUT;
print @new_id;
execute proc_AddRoofMeasurement 4, 3, 2.5, 1.7, 6.5, 3.4, 7.6, 3.4, 5.3, 5.4, 9.6, 3, @new_id OUTPUT;
print @new_id;

SELECT * FROM RoofMeasurements;
*/

	-- testing for the get most recent date from ClaimStatuses
/*
-- working! this is just an example
SELECT (SELECT MAX(LastUpdateDate) FROM (VALUES (Date1), (Date2), (Date3), (Date4), (Date5))
		AS UpdateDate(LastUpdateDate))
	AS LastUpdateDate
FROM DateTest
WHERE DateID = 1;
-- working! this is just an example

insert into ClaimStatuses (ClaimID, ContractSigned, InspectionDate, RoofMeasurementsReceived, AdjustmentDate, OriginalScopeReceived)
values (2, '2015-1-22', GETDATE(), 2017-5-2, GETDATE(), '2016-3-4');
insert into ClaimStatuses (ClaimID, ContractSigned, InspectionDate, RoofMeasurementsReceived, AdjustmentDate, OriginalScopeReceived)
values (3, '2016-1-22', GETDATE(), null, GETDATE(), '2014-3-4');
insert into ClaimStatuses (ClaimID, ContractSigned, InspectionDate, RoofMeasurementsReceived, AdjustmentDate, OriginalScopeReceived)
values (4, '2014-1-22', GETDATE(), null, GETDATE(), '2013-3-4');
select * from ClaimStatuses;
*/


/*	-- Test data for Installers
DECLARE @new_id int;

execute proc_AddInstaller 'Home Depot', '123456-GA', 'Randy', 'Mills', null, '1305 Home Depot Lane', '30046', '678-555-1212', '800-555-1414', '678-515-4141',  'randy@homedepot.com', null, 1, '2016-9-9', 'url', 'url', @new_id OUTPUT;
print @new_id;
execute proc_AddInstaller 'Lowes', '425652-GA', 'Bobby', 'Anderson', null, '555 Lowes Rd', '30043', '770-545-2154', '800-456-1414', '770-156-1941',  'bobby@lowes.com', null, 1, '2016-5-9', 'url', 'url', @new_id OUTPUT;
print @new_id;
execute proc_AddInstaller 'TestCompany', '245362-GA', 'Mark', 'Lewis', null, '4512 Rock Lane', '30047', '404-456-1424', '888-800-4154', '678-412-1515',  'marklewis@test.com', null, 1, '2017-12-1', 'url', 'url', @new_id OUTPUT;
print @new_id;

SELECT * FROM Installers;
*/

/*	-- Test data for Referrers
DECLARE @new_id int;

execute proc_AddReferrer 'Jason', 'Smith', null, '146 Abby Lane', '30045', 'jasonsmith@gmail.com', '770-513-4141', @new_id OUTPUT;
print @new_id;
execute proc_AddReferrer 'John', 'Jones', null, '4141 Lakewood Lane', '30047', 'johnj@gmail.com', '678-513-4141', @new_id OUTPUT;
print @new_id;
execute proc_AddReferrer 'Sandy', 'Holt', null, '8584 Lookout Road', '30024', 'sandyholt@gmail.com', '770-415-4141', @new_id OUTPUT;
print @new_id;

SELECT * FROM Referrers;
*/

/*	-- Test data for Addresses
DECLARE @new_id int;

execute proc_AddAddress  2, '555 Smith Town Road', 30043, @new_id OUTPUT;
print @new_id;
execute proc_AddAddress 3, '1453 Lake Lane', 30046, @new_id OUTPUT;
print @new_id;
execute proc_AddAddress 4, '6247 Peachtree Road', 30024, @new_id OUTPUT;
print @new_id;


SELECT * FROM Customers;
SELECT * FROM Addresses;
*/

/*
SELECT * FROM Employees; 
SELECT * FROM LU_KnockResponseTypes
SELECT * FROM Leads;

DECLARE @new_id int;

execute proc_AddKnockerResponse  2, 1, 1, '568 Lucy Lane', '30045', null, null, @new_id OUTPUT;
print @new_id;
execute proc_AddKnockerResponse  2, 3, 2, '1400 Marshall Street', '30509', null, null, @new_id OUTPUT;
print @new_id;
execute proc_AddKnockerResponse  2, 4, 3, '890 Wally Way', '30043', null, null, @new_id OUTPUT;
print @new_id;

SELECT * FROM KnockerResponses;
*/

/*	-- Test data for Adjuster and Adjustment
SELECT * FROM Adjusters;
SELECT * FROM Adjustments;
SELECT * FROM InsuranceCompanies;

DECLARE @new_id int;

execute proc_AddAdjuster 'John', 'Smith', null, '770-555-1212', '5464', 'john.smith@statefarm.com', 3, 'comments', @new_id OUTPUT
print @new_id;
execute proc_AddAdjuster 'Jerry', 'Watkins', null, '770-451-1212', null, 'jerrywatkins@allstate.com', 4, 'comments', @new_id OUTPUT
print @new_id;
execute proc_AddAdjuster 'Bob', 'Williams', null, '770-412-1456', '35', 'bob.williams@allstate.com', 4, 'comments', @new_id OUTPUT
print @new_id;

SELECT * FROM Adjusters;
SELECT * FROM Claims;
SELECT * FROM LU_AdjustmentResults;

DECLARE @new_id int;

execute proc_AddAdjustment 1, 2, 0, 0, 0, 1, '2015-4-12', 'comment', @new_id OUTPUT
print @new_id;
execute proc_AddAdjustment 2, 3, 0, 0, 0, 2, '2015-4-8', 'comment', @new_id OUTPUT
print @new_id;
execute proc_AddAdjustment 3, 6, 0, 0, 0, 3, '2015-4-3', 'comment', @new_id OUTPUT
print @new_id;

SELECT * FROM Adjustments;
*/

/*	-- Test data for Employees
SELECT * FROM LU_EmployeeTypes;

DECLARE @new_id int;

execute proc_AddEmployee 1, 'James', 'Hewatt', null, 'jhewatt@gmail.com', '678-555-1212', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 11, 'Alyssa', 'Harvey', null, 'aharvey@gmail.com', '678-555-1214', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 3, 'Scott', 'Padgett', null, 'spadgett@gmail.com', '678-456-1214', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 7, 'John', 'Mealer', null, 'jmealer@gmail.com', '678-525-1333', @new_id OUTPUT
print @new_id;

execute proc_AddEmployee 13, 'Bob', 'Smith', null, 'bsmith@gmail.com', '678-555-5678', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 13, 'Randall', 'Jones', null, 'rjones@gmail.com', '678-555-1342', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 14, 'Mark', 'Owens', null, 'mowens@gmail.com', '678-876-1453', @new_id OUTPUT
print @new_id;
execute proc_AddEmployee 14, 'Jeffrey', 'Wallace', null, 'jwallace@gmail.com', '678-365-3643', @new_id OUTPUT
print @new_id;

SELECT * FROM Employees;
*/

/*	-- Test data for ClaimContacts
SELECT * FROM Claims;
SELECT * FROM Leads;
SELECT * FROM Employees;
SELECT * FROM Addresses;
SELECT * FROM Customers;
SELECT * FROM Installers;
SELECT * FROM Adjusters;

DECLARE @new_id int;

execute proc_AddClaimContact 2, 1, 3, 2, 2, null, 1, 2, 2, @new_id OUTPUT
print @new_id;
execute proc_AddClaimContact 3, 2, 3, 3, 3, null, 2, 3, 3, @new_id OUTPUT
print @new_id;
execute proc_AddClaimContact 4, 3, 3, 4, 4, null, 3, 4, 4, @new_id OUTPUT
print @new_id;

SELECT * FROM ClaimContacts;
*/

/*	-- Test data for Scopes
SELECT * FROM LU_ScopeTypes;
SELECT * FROM Claims;

DECLARE @new_id int;

execute proc_AddScope 1, 2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, @new_id OUTPUT
print @new_id;
execute proc_AddScope 2, 3, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, @new_id OUTPUT
print @new_id;
execute proc_AddScope 3, 4, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, @new_id OUTPUT
print @new_id;

SELECT * FROM Scopes; 
*/

/*	-- add test data for ClaimContacts

INSERT INTO [InfoTech].[ClaimContacts]
           ([ClaimID]
           ,[CustomerID]
           ,[KnockerID]
           ,[SalesPersonID]
           ,[SupervisorID]
           ,[InteriorInstallerID]
           ,[ExteriorInstallerID]
           ,[GutterInstallerID]
           ,[RoofInstallerID]
           ,[AdjusterID])
     VALUES
           (ClaimID,
           CustomerID,
           KnockerID,
           SalesPersonID,
           SupervisorID,
           InteriorInstallerID,
           ExteriorInstallerID,
           GutterInstallerID,
           RoofInstallerID,
           AdjusterID)
*/

DECLARE @new_id int;

execute proc_AddPlane 5, 5, 5, 5;
PRINT @new_id;
select * from Planes;
execute proc_AddPlane 5, 5, 5, 5;
PRINT @new_id;
select * from Planes;


SELECT * FROM CalendarData

update CalendarData
set EndTime = '2016-06-02 00:03:00.000'
WHERE EntryID = 2;
SELECT * FROM CalendarData

SELECT * FROM leads;

UPDATE CalendarData
SET LeadID = 2
WHERE EntryID = 8;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE IS_NULLABLE = 'YES'
AND DATA_TYPE = 'datetime';



select * from INFORMATION_SCHEMA.COLUMNS
select * from sys.parameters

 select * from sys.types

 select * from sys.parameters
 where object_id = object_id('InfoTech.proc_AddClaim');

 select * from sys.objects
 where name like 'proc_%' 
 order by object_id

  select * from sys.objects
 where name like 'PK_%' 
 order by object_id


sp_columns Inspections;

ELSE
		BEGIN
			BEGIN TRY
				THROW 51000, 'No employees match the parameters.', 16;
			END TRY
			BEGIN CATCH
				THROW;
			END CATCH
		END

DECLARE @firstname varchar(50) = (SELECT FirstName FROM Employees
WHERE EmployeeID = 3);
DECLARE @lastname varchar(50) = (SELECT LastName FROM Employees
WHERE EmployeeID = 3);
PRINT @firstname;
PRINT @lastname;

DECLARE @TEST varchar(100) = CONCAT(@firstname, ' middle name ', @lastname);
PRINT @TEST;

DECLARE @incremented_id int = (SELECT ClaimID = ClaimID + 1 FROM Claims (TABLOCKX));
PRINT @incremented_id;

SELECT * FROM Employees;
SELECT * FROM CalendarData;
SELECT * FROM Claims;

SELECT e.EmployeeID FROM Employees e
JOIN CalendarData cd ON e.EmployeeID = cd.EmployeeID
WHERE ClaimID = 2;

--

DECLARE @new_id int;

execute proc_GetUser 'aharvey0812@gmail.com', @new_id OUTPUT;
PRINT @new_id;

select * from users;

select * from ClaimSuppliers

declare @new_id varchar(20);

declare @output_ClaimID int;
declare @output_SupplierID int;

execute proc_AddClaimSupplier 93, 4, @output_ClaimID OUTPUT, @output_SupplierID OUTPUT;
print @output_ClaimID;
print @output_SupplierID;


select * from claims
select * from suppliers

select * from inspections 2*, 3, 11
select * from planes 3, 6*, 7, 9


declare @output_InspectionID int;
declare @output_PlaneID int;

execute proc_AddInspectionPlane 3, 9, @output_InspectionID OUTPUT, @output_PlaneID OUTPUT;
print @output_InspectionID;
print @output_PlaneID;

select * from inspectionplanes

--

select * from lu_leadtypes --1: knocker; 2: referral
select * from knockerresponses --1, 2, 3, 11, 16, 17
select * from employees --  (12, 13 knockers); (10, 11 salesperson)
--select * from lu_employeetypes --14: knocker; 13: salesperson
select * from customers --2, 3, 4
select * from addresses -- 2, 3, 4
select * from referrers -- 2, 3, 4, 9

declare @new_id int;
exec proc_AddLead 1, 2, 10, 2, 2, '2016-05-11', 13, @new_id output;
print @new_id;
select * from Leads


declare @success int;
exec proc_UpdateLead 27, 3, 3, 1, 3, @success output;
print @success;
select * from Leads
















------------------------------
--if there is a firstcheck date and not a warrantysent date OR mostrecentdate is less than 10 days old

select distinct c.claimid from claims c
join claimstatuses cs on c.claimid = cs.claimid
where cs.claimstatustypeid = 7

select c.claimid from claims c
join claimstatuses cs on c.claimid = cs.claimid
where cs.claimstatustypeid != 23
order by c.claimid

select distinct claimid from claimstatuses
order by claimid

--where EXISTS ( select cs.claimstatustypeid from claimstatuses cs right join claims c on cs.claimid = c.claimid where cs.claimstatustypeid = 7 AND cs.claimstatusdate is not null )

--AND NOT EXISTS ( select cs.claimstatustypeid from claimstatuses cs join claims c on cs.claimid = c.claimid where cs.claimstatustypeid = 23 )

--join claimstatuses cs on c.claimid = cs.claimid
--join lu_claimstatustypes cst on cs.claimstatustypeid = cst.claimstatustypeid
--cst.claimstatustypeid, cst.claimstatustype, cs.claimstatusdate
--, c.customerid, c.leadid, c.billingid, c.propertyid, c.insurancecompanyid, c.insuranceclaimnumber, c.mrnnumber, c.lossdate, c.mortgagecompany, c.mortgageaccount
--


select * from lu_claimstatustypes --firstcheck is 7, warrantysent is 23
select distinct claimid from claimstatuses
order by claimid

--11	Roof Scheduled
--12	Roof Complete
--13	Gutters Scheduled
--14	Interior Scheduled
--15	Exterior Scheduled

insert into claimstatuses (claimid, claimstatustypeid, claimstatusdate)
values (24, 13, '2016-05-02')

select claimstatustypeid from claimstatuses
where claimstatustypeid != 7

-- how to compare two records in one table that have common col
select t.claimid, t.total from
(select claimid, total from scopes
where scopetypeid = 3) as t
where t.total >= (select total from scopes 
				where claimid = t.claimid 
				and scopetypeid = 1)
and t.total != 0


select distinct s.claimid from scopes s
join claimstatuses cs on s.claimid = cs.claimid
where s.interior > 0 or s.exterior > 0 or s.gutter > 0 or s.roofamount > 0
and cs.claimstatustypeid != 11 or cs.claimstatustypeid != 13
order by s.claimid


select * from claimstatuses
where claimid = 2 or claimid = 24
order by claimid
select * from scopes
where claimid = 2 or claimid = 24
order by claimid

where claimstatustypeid = 11 OR claimstatustypeid = 13 OR claimstatustypeid = 14 OR claimstatustypeid = 15
--cs.claimstatustypeid != 11 OR cs.claimstatustypeid != 13 OR cs.claimstatustypeid != 14 OR cs.claimstatustypeid != 15


DECLARE @Max_Date datetime = (SELECT MAX(ClaimStatusDate) FROM ClaimStatuses
		WHERE ClaimID = 24);
PRINT @Max_Date;

IF (@Max_Date < dateadd(day,-10, getdate()))
	PRINT 'true';
ELSE
	PRINT 'false';


------------

SELECT * FROM LU_ClaimStatusTypes

SELECT DISTINCT ClaimID FROM ClaimStatuses cs
JOIN LU_ClaimStatusTypes cst ON cs.ClaimStatusTypeID = cst.ClaimStatusTypeID
WHERE cs.ClaimStatusTypeID != 11

---------------------------------------

select * from scopes
select * from claimstatuses


SELECT  c.ClaimID,
		c.CustomerID,
		c.LeadID,
		c.BillingID,
		c.PropertyID,
		c.InsuranceCompanyID,
		c.InsuranceClaimNumber,
		c.MRNNumber,
		c.LossDate,
		c.MortgageCompany,
		c.MortgageAccount,
		c.IsOpen FROM Claims c
JOIN Scopes s ON c.ClaimID = s.ClaimID
WHERE s.Accepted = 1
AND c.IsOpen = 1;

select * from scopes
where roofamount > 0


update scopes
set accepted = 0
where scopeid = 44

insert into scopes (ScopeTypeID, ClaimID, Interior, Exterior, Gutter, RoofAmount, Tax, Deductible, Total, OandP, Accepted)
values (2, 30, 1525, 19245, 1562, 15000, 524, 1000, 37856, 600, 1)

select * from claims
where claimid = 30


select * from claimstatuses

select distinct cs.claimid, cst.claimstatustype, cs.claimstatusdate from claimstatuses cs
join lu_claimstatustypes cst on cs.claimstatustypeid = cst.claimstatustypeid
join scopes s on cs.claimid = s.claimid
where cs.claimstatustypeid = 11


SELECT  c.ClaimID,
			c.CustomerID,
			c.LeadID,
			c.BillingID,
			c.PropertyID,
			c.InsuranceCompanyID,
			c.InsuranceClaimNumber,
			c.MRNNumber,
			c.LossDate,
			c.MortgageCompany,
			c.MortgageAccount,
			c.IsOpen 
	FROM Claims c
	JOIN Scopes s ON c.ClaimID = s.ClaimID
	WHERE c.ClaimID NOT IN (SELECT DISTINCT cs.ClaimID FROM ClaimStatuses cs
							JOIN Claims c on c.ClaimID = cs.ClaimID
							JOIN LU_ClaimStatusTypes cst on cs.ClaimStatusTypeID = cst.ClaimStatusTypeID
							JOIN Scopes s ON c.ClaimID = s.ClaimID
							WHERE (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
							AND s.Accepted = 1
							AND c.IsOpen = 1
							AND (cs.ClaimStatusTypeID = 13 OR cs.ClaimStatusTypeID = 14 OR cs.ClaimStatusTypeID = 15))
	AND c.IsOpen = 1
	AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
	AND s.Accepted = 1
	AND (s.Interior > 0 OR s.Exterior > 0 OR s.Gutter > 0);



select * from lu_claimstatustypes
where ClaimStatusTypeID IN (13, 14, 15)

select * from scopes
where claimid IN (4, 30)
and scopetypeid IN (2, 3)

update scopes
set gutter = 1533,
	exterior = 550,
	interior = 100
where scopeid = 3

select * from claims
where claimid IN (4, 30)

select * from claimstatuses
where claimid IN (4, 30)

select * from claimstatuses
where claimid = 2

select * from lu_claimstatustypes

delete from claimstatuses
where claimstatusid = 28



/*

SELECT s.ScopeID, 
		s.ScopeTypeID, 
		s.ClaimID, 
		s.Interior, 
		s.Exterior, 
		s.Gutter,
		s.RoofAmount,
		s.Tax,
		s.Deductible,
		s.Total,
		s.OandP,
		s.Accepted FROM Scopes s
JOIN Claims c ON c.ClaimID = S.ClaimID
WHERE (s.RoofAMount > 0 OR s.Interior > 0 OR s.Exterior > 0 OR s.Gutter > 0)
AND s.Accepted = 1
AND (s.ScopeTypeID = 2 OR s.ScopeTypeID = 3)
AND c.IsOpen = 1
ORDER BY c.ClaimID

2 needs 11
4, 24, 30 needs 11, 13, 14, 15

2 has 11
30 has 11
24 has 13
30 has 15

SELECT * FROM ClaimStatuses
WHERE ClaimID in (2, 4, 24, 30)
AND ClaimStatusTypeID BETWEEN 11 AND 15
ORDER BY ClaimStatusTypeID




SELECT	distinct c.ClaimID,
			c.CustomerID,
			c.LeadID,
			c.BillingID,
			c.PropertyID,
			c.InsuranceCompanyID,
			c.InsuranceClaimNumber,
			c.MRNNumber,
			c.LossDate,
			c.MortgageCompany,
			c.MortgageAccount,
			c.IsOpen,
			c.ContractSigned,
			case when cs.claimstatustypeid = 1 then cs.claimstatusdate end,
			case when cs.claimstatustypeid = 5 then cs.claimstatusdate end
		FROM Claims c
		JOIN ClaimContacts cc ON c.ClaimID = cc.ClaimID
		JOIN ClaimStatuses cs on c.ClaimID = cs.ClaimID
		JOIN lu_claimstatustypes cst on cs.claimstatustypeid = cst.claimstatustypeid
		WHERE c.IsOpen = 1
		AND cc.SalesPersonID = 3;

select cs.claimstatusid, cs.claimid, cst.claimstatustype, case when cs.claimstatustypeid = 1 then cs.claimstatusdate end from claimstatuses cs
join lu_claimstatustypes cst on cs.claimstatustypeid = cst.claimstatustypeid
WHERE cs.claimid = 30

select * from claimstatuses
where claimid = 30



select * from lu_claimstatustypes

SELECT cs.ClaimStatusDate FROM ClaimStatuses cs
WHERE cs.ClaimStatusTypeID = 1
AND cs.ClaimID = 30

execute proc_GetClaimStatusDateByTypeIDAndClaimID 11, 2
select * from claimstatuses where claimid = 2

execute proc_GetScopesByClaimID 30
select * from payments
select * from lu_paymentdescriptions

*/


CREATE TABLE _ChangeLog
(
TableName varchar(100),
LastModified datetime
);



-- Insert and Update triggers for Table_Name
CREATE TRIGGER trgAfterInsertTable_Name ON Table_Name
FOR INSERT
AS
	UPDATE _ChangeLog
	SET LastModified = GETDATE()
	WHERE TableName = 'Table_Name';
GO

CREATE TRIGGER trgAfterUpdateTable_Name ON Table_Name
FOR UPDATE
AS
	IF UPDATE() 
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
		OR UPDATE()
			BEGIN
				UPDATE _ChangeLog
				SET LastModified = GETDATE()
				WHERE TableName = 'Table_Name';
			END
GO
----------------------------------------------------------------------------
