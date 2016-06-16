-- TRUNCATE TABLE Inspections



/* Customers Inserts */

--INSERT INTO Customers(FirstName, MiddleName, LastName, Suffix, PrimaryNumber, SecondaryNumber,
--					  Email, MailPromos)
--VALUES('Elizabeth', 'Catherine', 'Hawkins', NULL, '678-123-4567', NULL, NULL, 1),
--('Marcy', 'Laura', 'Thomas',	NULL, '678-445-1356', NULL,	'marcy@gmail.com', 0),
--('Bob', 'Mark', 'Jones', 'Sr.', '678-124-2134', NULL, 'bobo@gmail.com',	0),
--('Helen', 'Lucy', 'Williams', NULL, '770-333-6346', '770-444-1212', 'helen@gmail.com', 1),
--('Ana', NULL, 'Steele', NULL, '770-524-9673', '770-524-9655', 'a.steele@gmail.com', 1)


/* Addresses Inserts */

--INSERT INTO Addresses(CustomerID, Address, Zip)
--VALUES (1, '2022 Scottland Way', '30088'),
--(2, '555 Smith Town Road', '30043'),
--(3, '1453 Lake Lane', '30046'),
--(4, '6247 Peachtree Road', '30024'),
--(1, '2625 Windstream Way', '30044'),
--(5, '242 Ashford Bunwoody Rd.', '30044')


/* KnockerResponse Inserts */

--INSERT INTO KnockerResponses(KnockerID, KnockResponseTypeID, Address, Zip, Lat, Long)
--VALUES(12, 1, '123 No Answer Rd.', '30088', 0, 0),
--(13, 2, '123 Appointment Set Rd.', '30088', 0, 0),
--(13, 3, '123 Come Back Rd.', '30088', 0, 0),
--(12, 4, '123 Not Interested Rd.', '30088', 0, 0),
--(12, 2, NULL, NULL, 0, 0)


/* Leads Inserts */

--INSERT INTO Leads(LeadTypeID, KnockerResponseID, SalesPersonID, CustomerID, AddressID, 
--				  LeadDate, Success, CreditToID, Temperature)
--VALUES(1, 2, 3, 1, 5, '2016-06-01 11:25:14.833', 0, 13, 'H'),
--(1, 5, 3, 2, 2, '2016-06-01 11:26:27.117', 0, 12, 'W'),
--(2, NULL, 3, 3, 3, '2016-06-01 11:27:47.650', 0, 4, 'C'),
--(3, NULL, 3, 4, 4, '2016-06-01 11:30:05.310', 0, NULL, 'W')


/* Claims Inserts */

--DECLARE @new_id int;
--DECLARE @date datetime = getDate();
--EXECUTE proc_AddClaim 1, 1, 1, 5, 194, null, @date, null, null, @new_id OUTPUT;
--PRINT @new_id;
--EXECUTE proc_AddClaim 3, 3, 3, 3, 194, '1234567890', @date, 'MRN Mortgage Co.', '0987654321', @new_id OUTPUT;
--PRINT @new_id;


/* ClaimContacts Inserts */

--INSERT INTO ClaimContacts(ClaimID, CustomerID, KnockerID, SalesPersonID, SupervisorID, SalesManagerID, AdjsuterID)
--VALUES(1, 3, null, 3, null, 23, null),
--(2,1,13, 3, null, 23, null)


/* CalendarData Insert */

--INSERT INTO CalendarData(AppointmentTypeID, EmployeeID, StartTime, EndTime, ClaimID, LeadID, Note)
--VALUES(1, 3, '2016-06-02 11:30:00.000', '2016-06-02 12:30:00.000', null, 1, 'Note: New Inspection...'),
--(1, 3, '2016-06-02 01:30:00.000', '2016-06-02 03:30:00.000', null, 2, 'Note: New Inspection...'),
--(2, 3, '2016-06-07 01:30:00.000', '2016-06-07 03:30:00.000', 1, 3, 'Note: New Adjustment...')


/* Inspetion Inserts */

--INSERT INTO Inspections(ClaimID, RidgeMaterialTypeID, ShingleTypeID, InspectionDate, 
--						SkyLights, Leaks, GutterDamage, DrivewayDamage, MagneticRollers,
--						IceWaterShield, EmergencyRepair, EmergencyRepairAmount, QualityControl,
--						ProtectLandscaping, RemoveTrash, FurnishPermit, CoverPool,
--						InteriorDamage, ExteriorDamage, LightningProtection, TearOff,
--						Satellite, SolarPanels, RoofAge, Comments)
--VALUES(1, 1, 3, '2016-06-01 11:40:00.000', 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 8, 'Comments Go Here')


/* ClaimStatuses Inserts */

--INSERT INTO ClaimStatuses(ClaimID, ClaimStatusTypeID, ClaimStatusDate)
--VALUES(1, 2, '2016-06-01 11:40:00.000'),
--(2, 2, '2016-06-02 09:21:57.740')

--SELECT * FROM Addresses
--SELECT * FROM Customers
--SELECT * FROM Inspections
--SELECT * FROM Planes
--SELECT * FROM ClaimStatuses
--SELECT * FROM ClaimContacts
--SELECT * FROM Claims
--SELECT * FROM KnockerResponses
--SELECT * FROM Leads
--SELECT * FROM CalendarData
--SELECT * FROM Scopes
--SELECT * FROM lu_appointmenttypes

--select cl.ClaimID, cl.MRNNumber, 
--	   c.FirstName + ' ' + c.LastName AS 'Customer Name',
--	   a.Address + ', ' + a.Zip AS 'Address',
--	   lt.LeadType AS 'Lead Type'

--FROM Claims cl 
--JOIN Leads l ON cl.LeadId = l.LeadId
--JOIN LU_LeadTypes lt ON l.LeadTypeID = lt.LeadTypeID
--JOIN Customers c ON cl.CustomerID = c.CustomerID
--JOIN Addresses a ON cl.PropertyID = a.AddressID